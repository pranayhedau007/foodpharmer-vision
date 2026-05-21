from __future__ import annotations

import argparse
import json
import math
import os
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Optional

import numpy as np
import pandas as pd
import torch
from sklearn.model_selection import train_test_split
from sklearn.metrics import (
    accuracy_score,
    f1_score,
    mean_absolute_error,
    mean_squared_error,
    r2_score,
)
from transformers import (
    AutoTokenizer,
    AutoModelForSequenceClassification,
    Trainer,
    TrainingArguments,
    set_seed,
)


@dataclass(frozen=True)
class TaskConfig:
    task: str  # "regression" | "classification"
    num_labels: int
    label2id: Optional[dict[str, int]] = None
    id2label: Optional[dict[int, str]] = None


class _CSVDataset(torch.utils.data.Dataset):
    def __init__(
        self,
        texts: list[str],
        labels: list[Any],
        tokenizer,
        max_length: int,
        task: str,
    ) -> None:
        self.texts = texts
        self.labels = labels
        self.tokenizer = tokenizer
        self.max_length = max_length
        self.task = task

    def __len__(self) -> int:
        return len(self.texts)

    def __getitem__(self, idx: int) -> dict[str, torch.Tensor]:
        text = self.texts[idx]
        enc = self.tokenizer(
            text,
            truncation=True,
            padding="max_length",
            max_length=self.max_length,
            return_tensors="pt",
        )
        item = {k: v.squeeze(0) for k, v in enc.items()}
        if self.task == "regression":
            item["labels"] = torch.tensor(float(self.labels[idx]), dtype=torch.float32)
        else:
            item["labels"] = torch.tensor(int(self.labels[idx]), dtype=torch.long)
        return item


def _load_csv(path: str, text_col: str, label_col: str) -> pd.DataFrame:
    df = pd.read_csv(path)
    if text_col not in df.columns:
        raise ValueError(f"Missing text column '{text_col}' in {path}. Columns: {list(df.columns)}")
    if label_col not in df.columns:
        raise ValueError(f"Missing label column '{label_col}' in {path}. Columns: {list(df.columns)}")
    df = df[[text_col, label_col]].dropna()
    df[text_col] = df[text_col].astype(str)
    return df


def _bin_scores(scores: np.ndarray, bins: list[float]) -> np.ndarray:
    # bins are boundaries, e.g. [20, 40, 60, 80] => 5 classes (0..4)
    bins_arr = np.array(bins, dtype=float)
    return np.digitize(scores, bins_arr, right=False).astype(int)


def _task_config_from_labels(
    task: str,
    y_train: np.ndarray,
    classification_from: str,
    bins: Optional[list[float]],
) -> TaskConfig:
    task = task.lower().strip()
    if task not in {"regression", "classification"}:
        raise ValueError("--task must be 'regression' or 'classification'")

    if task == "regression":
        return TaskConfig(task="regression", num_labels=1)

    # classification
    if classification_from == "bins":
        if not bins:
            raise ValueError("--bins is required when --classification_from=bins")
        num_labels = len(bins) + 1
        id2label = {i: f"bin_{i}" for i in range(num_labels)}
        label2id = {v: k for k, v in id2label.items()}
        return TaskConfig(task="classification", num_labels=num_labels, label2id=label2id, id2label=id2label)

    # classification_from=labels (string/int labels)
    uniques = sorted({str(v) for v in y_train.tolist()})
    label2id = {name: i for i, name in enumerate(uniques)}
    id2label = {i: name for name, i in label2id.items()}
    return TaskConfig(task="classification", num_labels=len(uniques), label2id=label2id, id2label=id2label)


def _compute_metrics_builder(task_cfg: TaskConfig):
    if task_cfg.task == "regression":
        def compute_metrics(eval_pred):
            preds, labels = eval_pred
            preds = np.array(preds).reshape(-1)
            labels = np.array(labels).reshape(-1)
            mse = mean_squared_error(labels, preds)
            rmse = math.sqrt(mse)
            mae = mean_absolute_error(labels, preds)
            r2 = r2_score(labels, preds)
            return {"mse": mse, "rmse": rmse, "mae": mae, "r2": r2}
        return compute_metrics

    def compute_metrics(eval_pred):
        logits, labels = eval_pred
        preds = np.argmax(logits, axis=-1)
        acc = accuracy_score(labels, preds)
        f1 = f1_score(labels, preds, average="macro")
        return {"accuracy": acc, "f1_macro": f1}

    return compute_metrics


def main() -> None:
    parser = argparse.ArgumentParser(description="Train a DistilBERT health score model from CSV.")
    parser.add_argument("--train_csv", required=True, help="Path to CSV with training data.")
    parser.add_argument("--eval_csv", default=None, help="Optional CSV for evaluation; if omitted, splits train.")
    parser.add_argument("--text_col", default="text", help="Name of text column in CSV.")
    parser.add_argument("--label_col", default="score", help="Name of label column in CSV.")
    parser.add_argument("--model_name", default="distilbert-base-uncased", help="HF model checkpoint.")
    parser.add_argument("--output_dir", default="ml/models/distilbert_health", help="Where to save the model.")
    parser.add_argument("--task", default="regression", choices=["regression", "classification"])
    parser.add_argument("--classification_from", default="bins", choices=["bins", "labels"])
    parser.add_argument("--bins", default="20,40,60,80", help="Comma-separated score bins for classification.")
    parser.add_argument("--max_length", type=int, default=256)
    parser.add_argument("--eval_split", type=float, default=0.1)
    parser.add_argument("--seed", type=int, default=42)
    parser.add_argument("--epochs", type=float, default=3.0)
    parser.add_argument("--batch_size", type=int, default=8)
    parser.add_argument("--lr", type=float, default=5e-5)
    parser.add_argument("--weight_decay", type=float, default=0.01)
    parser.add_argument("--fp16", action="store_true", help="Enable mixed precision (if supported).")
    args = parser.parse_args()

    set_seed(args.seed)

    train_df = _load_csv(args.train_csv, args.text_col, args.label_col)
    if args.eval_csv:
        eval_df = _load_csv(args.eval_csv, args.text_col, args.label_col)
    else:
        train_df, eval_df = train_test_split(train_df, test_size=args.eval_split, random_state=args.seed)

    # Prepare labels
    y_train_raw = train_df[args.label_col].to_numpy()
    y_eval_raw = eval_df[args.label_col].to_numpy()

    bins: Optional[list[float]] = None
    if args.task == "classification":
        if args.classification_from == "bins":
            bins = [float(x.strip()) for x in str(args.bins).split(",") if x.strip()]
            y_train = _bin_scores(y_train_raw.astype(float), bins=bins)
            y_eval = _bin_scores(y_eval_raw.astype(float), bins=bins)
        else:
            # treat as categorical label strings
            y_train = y_train_raw.astype(str)
            y_eval = y_eval_raw.astype(str)
    else:
        y_train = y_train_raw.astype(float)
        y_eval = y_eval_raw.astype(float)

    task_cfg = _task_config_from_labels(
        task=args.task,
        y_train=np.array(y_train),
        classification_from=args.classification_from,
        bins=bins,
    )

    tokenizer = AutoTokenizer.from_pretrained(args.model_name)
    model_kwargs: dict[str, Any] = {
        "num_labels": task_cfg.num_labels,
        "problem_type": "regression" if task_cfg.task == "regression" else "single_label_classification",
    }
    if task_cfg.label2id is not None:
        model_kwargs["label2id"] = task_cfg.label2id
    if task_cfg.id2label is not None:
        model_kwargs["id2label"] = task_cfg.id2label

    model = AutoModelForSequenceClassification.from_pretrained(args.model_name, **model_kwargs)

    if task_cfg.task == "classification" and args.classification_from == "labels":
        y_train = np.array([task_cfg.label2id[str(v)] for v in y_train.tolist()], dtype=int)
        y_eval = np.array([task_cfg.label2id[str(v)] for v in y_eval.tolist()], dtype=int)

    train_ds = _CSVDataset(
        texts=train_df[args.text_col].astype(str).tolist(),
        labels=y_train.tolist(),
        tokenizer=tokenizer,
        max_length=args.max_length,
        task=task_cfg.task,
    )
    eval_ds = _CSVDataset(
        texts=eval_df[args.text_col].astype(str).tolist(),
        labels=y_eval.tolist(),
        tokenizer=tokenizer,
        max_length=args.max_length,
        task=task_cfg.task,
    )

    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    training_args = TrainingArguments(
        output_dir=str(output_dir),
        learning_rate=args.lr,
        weight_decay=args.weight_decay,
        num_train_epochs=args.epochs,
        per_device_train_batch_size=args.batch_size,
        per_device_eval_batch_size=args.batch_size,
        eval_strategy="epoch",
        save_strategy="epoch",
        save_total_limit=2,
        load_best_model_at_end=True,
        metric_for_best_model="rmse" if task_cfg.task == "regression" else "f1_macro",
        greater_is_better=False if task_cfg.task == "regression" else True,
        logging_steps=25,
        report_to="none",
        fp16=args.fp16,
    )

    trainer = Trainer(
        model=model,
        args=training_args,
        train_dataset=train_ds,
        eval_dataset=eval_ds,
        processing_class=tokenizer,
        compute_metrics=_compute_metrics_builder(task_cfg),
    )

    trainer.train()
    metrics = trainer.evaluate()
    (output_dir / "final_metrics.json").write_text(json.dumps(metrics, indent=2))

    trainer.save_model(str(output_dir))
    tokenizer.save_pretrained(str(output_dir))

    meta = {
        "task": task_cfg.task,
        "model_name": args.model_name,
        "text_col": args.text_col,
        "label_col": args.label_col,
        "classification_from": args.classification_from if task_cfg.task == "classification" else None,
        "bins": bins,
        "seed": args.seed,
        "max_length": args.max_length,
    }
    (output_dir / "training_meta.json").write_text(json.dumps(meta, indent=2))

    print(f"Saved model to: {output_dir}")
    print(f"Eval metrics: {json.dumps(metrics, indent=2)}")


if __name__ == "__main__":
    # Avoid tokenizers parallelism warning spam in some environments
    os.environ.setdefault("TOKENIZERS_PARALLELISM", "false")
    main()
