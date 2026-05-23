"""
LoRA smoke test — end-to-end pipeline verification.

Uses gpt2 (public, no auth) and 3 synthetic samples to verify:
  1. LoRA wrapping + trainable parameter count
  2. Trainer runs without error
  3. Adapter files are saved correctly
  4. Base model + adapter can be reloaded
  5. Inference produces output

Run:
    python -m training.smoke_test
"""
import sys
import tempfile
from pathlib import Path

import torch
from torch.utils.data import Dataset
from transformers import (
    AutoModelForCausalLM,
    AutoTokenizer,
    Trainer,
    TrainingArguments,
)
from peft import LoraConfig, PeftModel, get_peft_model

# ── config ────────────────────────────────────────────────────────────────────
MODEL_NAME  = "gpt2"
MAX_STEPS   = 3      # just enough to confirm gradients flow
MAX_LENGTH  = 64
LORA_R      = 4
LORA_ALPHA  = 8

# gpt2 uses Conv1D so attention weights live in c_attn (not q_proj/k_proj)
LORA_TARGET_MODULES = ["c_attn"]

# ── device ────────────────────────────────────────────────────────────────────
if torch.cuda.is_available():
    DEVICE = "cuda"
elif getattr(torch.backends, "mps", None) and torch.backends.mps.is_available():
    DEVICE = "mps"
else:
    DEVICE = "cpu"

# ── tiny synthetic dataset ────────────────────────────────────────────────────
_SAMPLES = [
    ("Analyze: Sugar, Red 40, BHT",
     '{"health_score":20,"risk_level":"HIGH","flags":[{"ingredient":"Red 40","reason":"artificial dye"}],"summary":"Highly processed."}'),
    ("Analyze: Whole oats, water, salt",
     '{"health_score":92,"risk_level":"LOW","flags":[],"summary":"Clean ingredients."}'),
    ("Analyze: High fructose corn syrup, palm oil, artificial flavors",
     '{"health_score":15,"risk_level":"HIGH","flags":[{"ingredient":"HFCS","reason":"excess sugar"}],"summary":"Ultra-processed."}'),
]


class TinyDataset(Dataset):
    def __init__(self, tokenizer):
        self.items = []
        for user, assistant in _SAMPLES:
            text = f"User: {user}\nAssistant: {assistant}"
            enc  = tokenizer(
                text,
                truncation=True,
                max_length=MAX_LENGTH,
                padding="max_length",
                return_tensors="pt",
            )
            ids  = enc["input_ids"].squeeze(0)
            self.items.append({
                "input_ids":      ids,
                "attention_mask": enc["attention_mask"].squeeze(0),
                "labels":         ids.clone(),
            })

    def __len__(self):  return len(self.items)
    def __getitem__(self, i): return self.items[i]


# ── helpers ───────────────────────────────────────────────────────────────────
def _ok(msg):  print(f"  ✓ {msg}")
def _run(msg): print(f"\n[{msg}]")
def _fail(msg):
    print(f"\n  ✗ FAILED: {msg}", file=sys.stderr)
    sys.exit(1)


# ── main ──────────────────────────────────────────────────────────────────────
def main():
    print(f"=== LoRA smoke test  |  model={MODEL_NAME}  device={DEVICE} ===\n")

    # ── 1. tokenizer ─────────────────────────────────────────────────────────
    _run("Step 1 — tokenizer")
    tokenizer = AutoTokenizer.from_pretrained(MODEL_NAME)
    tokenizer.pad_token = tokenizer.eos_token
    _ok(f"vocab size {tokenizer.vocab_size:,}")

    # ── 2. base model ─────────────────────────────────────────────────────────
    _run("Step 2 — base model")
    base = AutoModelForCausalLM.from_pretrained(MODEL_NAME, torch_dtype=torch.float32)
    total_params = sum(p.numel() for p in base.parameters())
    _ok(f"loaded  ({total_params/1e6:.1f}M params)")

    # ── 3. LoRA wrapping ──────────────────────────────────────────────────────
    _run("Step 3 — LoRA wrapping")
    lora_cfg = LoraConfig(
        r=LORA_R,
        lora_alpha=LORA_ALPHA,
        lora_dropout=0.0,
        bias="none",
        task_type="CAUSAL_LM",
        target_modules=LORA_TARGET_MODULES,
    )
    model = get_peft_model(base, lora_cfg)
    trainable, total = model.get_nb_trainable_parameters()
    _ok(f"trainable {trainable/1e3:.1f}K / {total/1e6:.1f}M  ({100*trainable/total:.3f}%)")

    # ── 4. training ───────────────────────────────────────────────────────────
    _run("Step 4 — training")
    dataset = TinyDataset(tokenizer)

    with tempfile.TemporaryDirectory() as tmp:
        args = TrainingArguments(
            output_dir=tmp,
            max_steps=MAX_STEPS,
            per_device_train_batch_size=1,
            gradient_accumulation_steps=1,
            learning_rate=2e-4,
            logging_steps=1,
            save_steps=MAX_STEPS,
            bf16=False,
            fp16=False,
            do_eval=False,
            report_to=[],
            dataloader_pin_memory=DEVICE == "cuda",
            use_cpu=DEVICE == "cpu",
        )

        trainer = Trainer(model=model, args=args, train_dataset=dataset)

        result = trainer.train()
        final_loss = result.training_loss
        if final_loss is None or final_loss != final_loss:   # NaN check
            _fail(f"training loss is {final_loss}")
        _ok(f"trained {MAX_STEPS} steps  |  final loss {final_loss:.4f}")

        # ── 5. save adapter ───────────────────────────────────────────────────
        _run("Step 5 — save adapter")
        adapter_dir = Path(tmp) / "lora_adapter"
        model.save_pretrained(adapter_dir)
        tokenizer.save_pretrained(adapter_dir)

        saved = sorted(p.name for p in adapter_dir.iterdir())
        if not any("adapter" in f for f in saved):
            _fail(f"no adapter files found in {adapter_dir}: {saved}")
        _ok(f"files: {saved}")

        # ── 6. reload adapter ─────────────────────────────────────────────────
        _run("Step 6 — reload base + adapter")
        fresh_base = AutoModelForCausalLM.from_pretrained(MODEL_NAME, torch_dtype=torch.float32)
        loaded = PeftModel.from_pretrained(fresh_base, str(adapter_dir))
        loaded.eval()
        _ok("PeftModel loaded from disk")

        # ── 7. inference ──────────────────────────────────────────────────────
        _run("Step 7 — inference")
        if DEVICE != "cpu":
            loaded = loaded.to(DEVICE)

        prompt = "User: Analyze: Sugar, corn syrup, artificial colors\nAssistant:"
        inputs = tokenizer(prompt, return_tensors="pt").to(loaded.device)

        with torch.no_grad():
            out = loaded.generate(
                **inputs,
                max_new_tokens=40,
                do_sample=False,
                pad_token_id=tokenizer.eos_token_id,
            )

        generated = tokenizer.decode(out[0][inputs["input_ids"].shape[1]:], skip_special_tokens=True)
        _ok(f"model output: {repr(generated[:120])}")

    print("\n=== ALL STEPS PASSED — LoRA pipeline is working end-to-end ===")


if __name__ == "__main__":
    main()
