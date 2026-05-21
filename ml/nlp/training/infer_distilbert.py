from __future__ import annotations

import argparse
import json
from pathlib import Path

import numpy as np
import torch
from transformers import AutoTokenizer, AutoModelForSequenceClassification


def main() -> None:
    parser = argparse.ArgumentParser(description="Run inference with a trained DistilBERT health model.")
    parser.add_argument("--model_dir", default="ml/models/distilbert_health", help="Path to saved model dir.")
    parser.add_argument("--text", required=True, help="Input text (OCR output / ingredients + nutrition).")
    parser.add_argument("--max_length", type=int, default=256)
    args = parser.parse_args()

    model_dir = Path(args.model_dir)
    tokenizer = AutoTokenizer.from_pretrained(str(model_dir))
    model = AutoModelForSequenceClassification.from_pretrained(str(model_dir))
    model.eval()

    enc = tokenizer(
        args.text,
        truncation=True,
        padding="max_length",
        max_length=args.max_length,
        return_tensors="pt",
    )
    with torch.no_grad():
        out = model(**enc)

    logits = out.logits.detach().cpu().numpy()

    if model.config.problem_type == "regression" or model.config.num_labels == 1:
        score = float(logits.reshape(-1)[0])
        score = float(np.clip(score, 0.0, 100.0))
        print(json.dumps({"score": score}, indent=2))
        return

    pred_id = int(np.argmax(logits, axis=-1)[0])
    label = model.config.id2label.get(pred_id, str(pred_id))
    probs = torch.softmax(torch.tensor(logits[0]), dim=-1).tolist()
    print(json.dumps({"class_id": pred_id, "label": label, "probs": probs}, indent=2))


if __name__ == "__main__":
    main()

