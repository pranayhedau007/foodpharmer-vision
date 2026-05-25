"""Train FieldConfidenceNet-Lite.

The default feature path is TF-IDF text features plus lightweight engineered
field features. It is intentionally small and fast enough for the project
deadline while still producing a real trained neural classifier.
"""

from __future__ import annotations

import argparse
import json
import logging
import pickle
import shutil
from pathlib import Path
from typing import Any

import numpy as np
import pandas as pd
import torch
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics import (
    accuracy_score,
    average_precision_score,
    f1_score,
    precision_recall_fscore_support,
    roc_auc_score,
)

from ..field_confidence_lite import (
    FieldConfidenceMLP,
    build_engineered_features,
    default_field_names,
)

logger = logging.getLogger(__name__)


def _text_inputs(df: pd.DataFrame) -> pd.Series:
    return (
        df["raw_ocr_text"].fillna("").astype(str)
        + "\nFIELD="
        + df["field_name"].fillna("").astype(str)
        + "\nVALUE="
        + df["extracted_value"].fillna("").astype(str)
    )


def _split_by_clean_id(df: pd.DataFrame, seed: int = 274) -> tuple[pd.DataFrame, pd.DataFrame, pd.DataFrame]:
    clean_ids = np.array(sorted(df["clean_id"].fillna(df["image_id"]).astype(str).unique()))
    rng = np.random.default_rng(seed)
    rng.shuffle(clean_ids)

    n = len(clean_ids)
    n_train = max(1, int(0.8 * n))
    n_val = max(1, int(0.1 * n))
    if n_train + n_val >= n:
        n_train = max(1, n - 2)
        n_val = 1

    train_ids = set(clean_ids[:n_train])
    val_ids = set(clean_ids[n_train : n_train + n_val])
    test_ids = set(clean_ids[n_train + n_val :])

    train_df = df[df["clean_id"].astype(str).isin(train_ids)].reset_index(drop=True)
    val_df = df[df["clean_id"].astype(str).isin(val_ids)].reset_index(drop=True)
    test_df = df[df["clean_id"].astype(str).isin(test_ids)].reset_index(drop=True)
    return train_df, val_df, test_df


def _fit_features(
    train_df: pd.DataFrame,
    val_df: pd.DataFrame,
    test_df: pd.DataFrame,
    field_names: list[str],
    max_text_features: int,
) -> tuple[np.ndarray, np.ndarray, np.ndarray, TfidfVectorizer]:
    vectorizer = TfidfVectorizer(
        max_features=max_text_features,
        ngram_range=(1, 2),
        min_df=2,
        lowercase=True,
        strip_accents="unicode",
    )
    train_text = vectorizer.fit_transform(_text_inputs(train_df)).toarray().astype(np.float32)
    val_text = vectorizer.transform(_text_inputs(val_df)).toarray().astype(np.float32)
    test_text = vectorizer.transform(_text_inputs(test_df)).toarray().astype(np.float32)

    train_eng = build_engineered_features(train_df, field_names)
    val_eng = build_engineered_features(val_df, field_names)
    test_eng = build_engineered_features(test_df, field_names)

    return (
        np.hstack([train_text, train_eng]).astype(np.float32),
        np.hstack([val_text, val_eng]).astype(np.float32),
        np.hstack([test_text, test_eng]).astype(np.float32),
        vectorizer,
    )


def _ece(y_true: np.ndarray, y_prob: np.ndarray, bins: int = 10) -> float:
    if len(y_true) == 0:
        return float("nan")
    edges = np.linspace(0.0, 1.0, bins + 1)
    total = len(y_true)
    ece = 0.0
    for low, high in zip(edges[:-1], edges[1:]):
        if high == 1.0:
            mask = (y_prob >= low) & (y_prob <= high)
        else:
            mask = (y_prob >= low) & (y_prob < high)
        if not np.any(mask):
            continue
        conf = float(np.mean(y_prob[mask]))
        acc = float(np.mean(y_true[mask]))
        ece += (np.sum(mask) / total) * abs(acc - conf)
    return float(ece)


def _classification_metrics(y_true: np.ndarray, y_prob: np.ndarray) -> dict[str, Any]:
    y_pred = (y_prob >= 0.5).astype(int)
    unique = np.unique(y_true)
    precision, recall, f1, _ = precision_recall_fscore_support(
        y_true, y_pred, average="binary", zero_division=0
    )
    metrics: dict[str, Any] = {
        "accuracy": float(accuracy_score(y_true, y_pred)),
        "precision": float(precision),
        "recall": float(recall),
        "f1": float(f1),
        "ece": _ece(y_true, y_prob),
        "positive_rate": float(np.mean(y_true)),
        "mean_probability": float(np.mean(y_prob)),
        "n": int(len(y_true)),
    }
    if len(unique) > 1:
        metrics["auroc"] = float(roc_auc_score(y_true, y_prob))
        metrics["auprc"] = float(average_precision_score(y_true, y_prob))
    else:
        metrics["auroc"] = None
        metrics["auprc"] = None
    return metrics


def _predict(model: FieldConfidenceMLP, x: np.ndarray, device: torch.device) -> np.ndarray:
    model.eval()
    probs: list[np.ndarray] = []
    with torch.no_grad():
        for start in range(0, len(x), 2048):
            batch = torch.from_numpy(x[start : start + 2048]).to(device)
            prob = torch.sigmoid(model(batch)).cpu().numpy()
            probs.append(prob)
    return np.concatenate(probs) if probs else np.array([], dtype=np.float32)


def _threshold_sweep(y_true: np.ndarray, y_prob: np.ndarray) -> pd.DataFrame:
    thresholds = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.85, 0.9, 0.95]
    rows: list[dict[str, Any]] = []
    for threshold in thresholds:
        accepted = y_prob >= threshold
        rejected = ~accepted
        n_accepted = int(np.sum(accepted))
        n_rejected = int(np.sum(rejected))
        rows.append(
            {
                "threshold": threshold,
                "coverage_percent": 100.0 * n_accepted / max(len(y_true), 1),
                "accepted_accuracy": float(np.mean(y_true[accepted])) if n_accepted else np.nan,
                "rejected_accuracy": float(np.mean(y_true[rejected])) if n_rejected else np.nan,
                "n_accepted": n_accepted,
                "n_rejected": n_rejected,
            }
        )
    return pd.DataFrame(rows)


def _per_field_metrics(test_df: pd.DataFrame, y_prob: np.ndarray) -> pd.DataFrame:
    rows: list[dict[str, Any]] = []
    work = test_df.copy()
    work["probability_correct"] = y_prob
    for field, group in work.groupby("field_name"):
        y = group["label_correct"].astype(int).to_numpy()
        p = group["probability_correct"].to_numpy()
        row: dict[str, Any] = {
            "field_name": field,
            "n": int(len(group)),
            "actual_correctness_rate": float(np.mean(y)) if len(y) else np.nan,
            "mean_predicted_probability": float(np.mean(p)) if len(p) else np.nan,
        }
        if len(np.unique(y)) > 1:
            row["auroc"] = float(roc_auc_score(y, p))
            row["auprc"] = float(average_precision_score(y, p))
        else:
            row["auroc"] = np.nan
            row["auprc"] = np.nan
        rows.append(row)
    return pd.DataFrame(rows).sort_values("field_name")


def train(args: argparse.Namespace) -> None:
    pairs_csv = Path(args.pairs_csv)
    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    df = pd.read_csv(pairs_csv)
    if df.empty:
        raise RuntimeError(f"Pairs CSV is empty: {pairs_csv}")
    df["label_correct"] = df["label_correct"].astype(int)
    field_names = default_field_names(df)

    train_df, val_df, test_df = _split_by_clean_id(df, seed=args.seed)
    logger.info(
        "Split rows by clean_id: train=%d val=%d test=%d",
        len(train_df),
        len(val_df),
        len(test_df),
    )

    x_train, x_val, x_test, vectorizer = _fit_features(
        train_df,
        val_df,
        test_df,
        field_names,
        max_text_features=args.max_text_features,
    )
    y_train = train_df["label_correct"].astype(np.float32).to_numpy()
    y_val = val_df["label_correct"].astype(np.float32).to_numpy()
    y_test = test_df["label_correct"].astype(np.float32).to_numpy()

    device = torch.device("cuda" if torch.cuda.is_available() and not args.cpu else "cpu")
    model = FieldConfidenceMLP(input_dim=x_train.shape[1], hidden_dim=args.hidden_dim, dropout=args.dropout).to(device)

    positives = float(np.sum(y_train))
    negatives = float(len(y_train) - positives)
    pos_weight = torch.tensor([negatives / max(positives, 1.0)], dtype=torch.float32, device=device)
    criterion = torch.nn.BCEWithLogitsLoss(pos_weight=pos_weight)
    optimizer = torch.optim.AdamW(model.parameters(), lr=args.lr, weight_decay=args.weight_decay)

    x_train_t = torch.from_numpy(x_train).to(device)
    y_train_t = torch.from_numpy(y_train).to(device)
    x_val_t = torch.from_numpy(x_val).to(device)
    y_val_t = torch.from_numpy(y_val).to(device)

    best_state: dict[str, torch.Tensor] | None = None
    best_val = float("inf")
    patience_left = args.patience
    history: list[dict[str, Any]] = []
    rng = np.random.default_rng(args.seed)

    for epoch in range(1, args.epochs + 1):
        model.train()
        order = rng.permutation(len(x_train))
        batch_losses: list[float] = []
        for start in range(0, len(order), args.batch_size):
            idx = order[start : start + args.batch_size]
            xb = x_train_t[idx]
            yb = y_train_t[idx]
            optimizer.zero_grad(set_to_none=True)
            logits = model(xb)
            loss = criterion(logits, yb)
            loss.backward()
            optimizer.step()
            batch_losses.append(float(loss.item()))

        model.eval()
        with torch.no_grad():
            val_loss = float(criterion(model(x_val_t), y_val_t).item())
        train_loss = float(np.mean(batch_losses)) if batch_losses else float("nan")
        history.append({"epoch": epoch, "train_loss": train_loss, "val_loss": val_loss})
        logger.info("epoch=%d train_loss=%.4f val_loss=%.4f", epoch, train_loss, val_loss)

        if val_loss < best_val - 1e-5:
            best_val = val_loss
            best_state = {k: v.detach().cpu().clone() for k, v in model.state_dict().items()}
            patience_left = args.patience
        else:
            patience_left -= 1
            if patience_left <= 0:
                logger.info("Early stopping at epoch %d", epoch)
                break

    if best_state is not None:
        model.load_state_dict(best_state)

    train_prob = _predict(model, x_train, device)
    val_prob = _predict(model, x_val, device)
    test_prob = _predict(model, x_test, device)

    metrics: dict[str, Any] = {
        "feature_type": "tfidf_plus_engineered",
        "success_bar": (
            "Useful if test AUROC > 0.70, or high-confidence accepted fields "
            "are at least 10 percentage points more accurate than all extracted "
            "fields, or threshold sweep identifies a practical reject/verify threshold."
        ),
        "split": {
            "train_rows": int(len(train_df)),
            "val_rows": int(len(val_df)),
            "test_rows": int(len(test_df)),
            "train_clean_ids": int(train_df["clean_id"].nunique()),
            "val_clean_ids": int(val_df["clean_id"].nunique()),
            "test_clean_ids": int(test_df["clean_id"].nunique()),
        },
        "train": _classification_metrics(y_train.astype(int), train_prob),
        "val": _classification_metrics(y_val.astype(int), val_prob),
        "test": _classification_metrics(y_test.astype(int), test_prob),
    }

    sweep = _threshold_sweep(y_test.astype(int), test_prob)
    baseline_acc = float(np.mean(y_test)) if len(y_test) else 0.0
    high_conf = sweep[sweep["threshold"] >= 0.85]
    if not high_conf.empty:
        best_high = high_conf.sort_values(["accepted_accuracy", "coverage_percent"], ascending=False).iloc[0]
        metrics["test"]["all_field_accuracy"] = baseline_acc
        metrics["test"]["best_high_confidence_threshold"] = float(best_high["threshold"])
        metrics["test"]["best_high_confidence_accepted_accuracy"] = (
            None if pd.isna(best_high["accepted_accuracy"]) else float(best_high["accepted_accuracy"])
        )
        if not pd.isna(best_high["accepted_accuracy"]):
            metrics["test"]["best_high_confidence_gain_points"] = float(
                best_high["accepted_accuracy"] - baseline_acc
            )

    per_field = _per_field_metrics(test_df, test_prob)

    checkpoint = {
        "state_dict": model.state_dict(),
        "input_dim": x_train.shape[1],
        "field_names": field_names,
        "feature_type": "tfidf_plus_engineered",
        "max_text_features": args.max_text_features,
        "hidden_dim": args.hidden_dim,
        "dropout": args.dropout,
    }
    torch.save(checkpoint, out_dir / "field_confidence_lite.pt")
    with (out_dir / "field_confidence_vectorizer.pkl").open("wb") as fh:
        pickle.dump(vectorizer, fh)
    with (out_dir / "field_confidence_metrics.json").open("w", encoding="utf-8") as fh:
        json.dump(metrics, fh, indent=2)
    sweep.to_csv(out_dir / "field_confidence_threshold_sweep.csv", index=False)
    per_field.to_csv(out_dir / "field_confidence_per_field.csv", index=False)
    pd.DataFrame(history).to_csv(out_dir / "field_confidence_training_history.csv", index=False)

    predictions = test_df[["dataset", "image_id", "clean_id", "field_name", "label_correct"]].copy()
    predictions["probability_correct"] = test_prob
    predictions.to_csv(out_dir / "field_confidence_test_predictions.csv", index=False)

    # Also place the three headline files in the parent final output directory
    # when the model directory is final_ocr_strategy_comparison/field_confidence_lite.
    parent = out_dir.parent
    if out_dir.name == "field_confidence_lite":
        for name in [
            "field_confidence_metrics.json",
            "field_confidence_threshold_sweep.csv",
            "field_confidence_per_field.csv",
        ]:
            shutil.copy2(out_dir / name, parent / name)

    logger.info("Saved FieldConfidenceNet-Lite artifacts to %s", out_dir)


def main() -> None:
    parser = argparse.ArgumentParser(description="Train FieldConfidenceNet-Lite")
    parser.add_argument("--pairs-csv", required=True)
    parser.add_argument("--out-dir", required=True)
    parser.add_argument("--epochs", type=int, default=40)
    parser.add_argument("--patience", type=int, default=6)
    parser.add_argument("--batch-size", type=int, default=256)
    parser.add_argument("--hidden-dim", type=int, default=128)
    parser.add_argument("--dropout", type=float, default=0.15)
    parser.add_argument("--lr", type=float, default=1e-3)
    parser.add_argument("--weight-decay", type=float, default=1e-4)
    parser.add_argument("--max-text-features", type=int, default=768)
    parser.add_argument("--seed", type=int, default=274)
    parser.add_argument("--cpu", action="store_true")
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
    train(args)


if __name__ == "__main__":
    main()
