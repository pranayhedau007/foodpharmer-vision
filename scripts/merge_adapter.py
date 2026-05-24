"""
Merges the LoRA adapter into the base Llama 3.2-3B-Instruct weights and saves
a standalone HuggingFace model to outputs/merged_model/.

Run from the repo root:
    .venv/bin/python scripts/merge_adapter.py
"""
import time
from pathlib import Path
import torch
from transformers import AutoModelForCausalLM, AutoTokenizer
from peft import PeftModel

BASE_MODEL  = "meta-llama/Llama-3.2-3B-Instruct"
ADAPTER_DIR = Path("outputs/llama_health_lora")
OUTPUT_DIR  = Path("outputs/merged_model")

print(f"[1/4] Loading base model: {BASE_MODEL}")
t = time.time()
base = AutoModelForCausalLM.from_pretrained(
    BASE_MODEL,
    torch_dtype=torch.float16,
    low_cpu_mem_usage=True,
)
print(f"      Done in {time.time()-t:.0f}s")

print(f"[2/4] Applying LoRA adapter from: {ADAPTER_DIR}")
t = time.time()
peft_model = PeftModel.from_pretrained(base, str(ADAPTER_DIR))
print(f"      Done in {time.time()-t:.0f}s")

print("[3/4] Merging adapter weights into base model ...")
t = time.time()
merged = peft_model.merge_and_unload()
print(f"      Done in {time.time()-t:.0f}s")

print(f"[4/4] Saving merged model to: {OUTPUT_DIR}")
t = time.time()
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
merged.save_pretrained(OUTPUT_DIR, safe_serialization=True)
tokenizer = AutoTokenizer.from_pretrained(BASE_MODEL)
tokenizer.save_pretrained(OUTPUT_DIR)
print(f"      Done in {time.time()-t:.0f}s")

print(f"\nMerged model saved to {OUTPUT_DIR}/")
print("Files:", [f.name for f in OUTPUT_DIR.iterdir()])
