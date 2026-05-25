"""Apply FieldConfidenceNet-Lite to the real nutrition-label photos."""

from __future__ import annotations

import argparse
import json
import logging
import pickle
import shutil
import time
from pathlib import Path
from typing import Any

import cv2
import numpy as np
import pandas as pd
import pytesseract
import torch
from PIL import Image
from sklearn.metrics import average_precision_score, roc_auc_score

from ..field_confidence_lite import (
    FieldConfidenceMLP,
    build_engineered_features,
    make_field_confidence_row,
)
from ..fields import NUTRITION_FIELDS
from ..parse_synthetic_ocr import parse_synthetic_ocr

logger = logging.getLogger(__name__)

TESS_CONFIG = "--oem 3 --psm 11"


def _configure_tesseract() -> None:
    candidates = [
        Path(r"C:\Program Files\Tesseract-OCR\tesseract.exe"),
        Path(r"C:\Program Files (x86)\Tesseract-OCR\tesseract.exe"),
    ]
    for candidate in candidates:
        if candidate.exists():
            pytesseract.pytesseract.tesseract_cmd = str(candidate)
            return


def _text_inputs(df: pd.DataFrame) -> pd.Series:
    return (
        df["raw_ocr_text"].fillna("").astype(str)
        + "\nFIELD="
        + df["field_name"].fillna("").astype(str)
        + "\nVALUE="
        + df["extracted_value"].fillna("").astype(str)
    )


def _ocr(path: Path) -> tuple[str, float]:
    img = cv2.imread(str(path))
    if img is None:
        raise ValueError(f"Could not read image: {path}")
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) if len(img.shape) == 3 else img
    t0 = time.perf_counter()
    text = pytesseract.image_to_string(Image.fromarray(gray), config=TESS_CONFIG)
    return text, time.perf_counter() - t0


def _torch_load(path: Path, device: torch.device) -> dict[str, Any]:
    try:
        return torch.load(path, map_location=device, weights_only=False)
    except TypeError:
        return torch.load(path, map_location=device)


def _load_model(model_path: Path, vectorizer_path: Path | None, device: torch.device) -> tuple[FieldConfidenceMLP, Any, list[str]]:
    checkpoint = _torch_load(model_path, device)
    field_names = list(checkpoint["field_names"])
    model = FieldConfidenceMLP(
        input_dim=int(checkpoint["input_dim"]),
        hidden_dim=int(checkpoint.get("hidden_dim", 128)),
        dropout=float(checkpoint.get("dropout", 0.15)),
    ).to(device)
    model.load_state_dict(checkpoint["state_dict"])
    model.eval()

    if vectorizer_path is None:
        vectorizer_path = model_path.with_name("field_confidence_vectorizer.pkl")
    with vectorizer_path.open("rb") as fh:
        vectorizer = pickle.load(fh)
    return model, vectorizer, field_names


def _predict(
    df: pd.DataFrame,
    model: FieldConfidenceMLP,
    vectorizer: Any,
    field_names: list[str],
    device: torch.device,
) -> np.ndarray:
    text_features = vectorizer.transform(_text_inputs(df)).toarray().astype(np.float32)
    engineered = build_engineered_features(df, field_names)
    x = np.hstack([text_features, engineered]).astype(np.float32)
    probs: list[np.ndarray] = []
    with torch.no_grad():
        for start in range(0, len(x), 1024):
            batch = torch.from_numpy(x[start : start + 1024]).to(device)
            probs.append(torch.sigmoid(model(batch)).cpu().numpy())
    return np.concatenate(probs) if probs else np.array([], dtype=np.float32)


def _threshold_sweep(y_true: np.ndarray, y_prob: np.ndarray) -> pd.DataFrame:
    rows: list[dict[str, Any]] = []
    for threshold in [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.85, 0.9, 0.95]:
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


def evaluate(args: argparse.Namespace) -> None:
    model_path = Path(args.model)
    out_dir = Path(args.out)
    out_dir.mkdir(parents=True, exist_ok=True)
    raw_dir = out_dir / "raw_tesseract"
    raw_dir.mkdir(parents=True, exist_ok=True)

    device = torch.device("cuda" if torch.cuda.is_available() and not args.cpu else "cpu")
    model, vectorizer, field_names = _load_model(
        model_path,
        Path(args.vectorizer) if args.vectorizer else None,
        device,
    )

    with Path(args.ground_truth).open("r", encoding="utf-8") as fh:
        entries = json.load(fh)

    rows: list[dict[str, Any]] = []
    image_rows: list[dict[str, Any]] = []
    for entry in entries:
        image_name = entry.get("image")
        if not image_name:
            continue
        image_path = Path(args.images) / image_name
        if not image_path.exists():
            logger.warning("Missing real image: %s", image_path)
            continue

        try:
            text, latency = _ocr(image_path)
        except Exception as exc:
            logger.warning("OCR failed for %s: %s", image_name, exc)
            text = ""
            latency = 0.0

        raw_path = raw_dir / f"{Path(image_name).stem}.txt"
        raw_path.write_text(text, encoding="utf-8")
        parsed = parse_synthetic_ocr(text)
        gt_fields = entry.get("fields", {})
        image_total = 0
        image_correct = 0

        for field in NUTRITION_FIELDS:
            row = make_field_confidence_row(
                image_id=Path(image_name).stem,
                field_name=field,
                raw_ocr_text=text,
                parsed_fields=parsed,
                ground_truth_fields=gt_fields,
                severity=0,
                dataset="real_photos",
            )
            if row is None:
                continue
            row["image"] = image_name
            row["product_hint"] = entry.get("product_hint", "")
            row["ocr_latency_s"] = round(latency, 6)
            row["raw_text_path"] = str(raw_path)
            rows.append(row)
            image_total += 1
            image_correct += int(row["label_correct"])

        image_rows.append(
            {
                "image": image_name,
                "product_hint": entry.get("product_hint", ""),
                "scored_fields": image_total,
                "correct_fields": image_correct,
                "field_accuracy": image_correct / image_total if image_total else np.nan,
                "ocr_latency_s": round(latency, 6),
            }
        )

    if not rows:
        raise RuntimeError("No real field-confidence rows were generated")

    df = pd.DataFrame(rows)
    probs = _predict(df, model, vectorizer, field_names, device)
    df["confidence"] = probs
    df["prediction_accept_085"] = (df["confidence"] >= 0.85).astype(int)

    y_true = df["label_correct"].astype(int).to_numpy()
    metrics: dict[str, Any] = {
        "n_fields": int(len(df)),
        "n_images": int(pd.Series([r["image"] for r in rows]).nunique()),
        "actual_correctness_rate": float(np.mean(y_true)),
        "mean_confidence": float(np.mean(probs)),
        "note": "Real-data confidence evaluation is noisy because it has only 30 photos.",
    }
    if len(np.unique(y_true)) > 1:
        metrics["auroc"] = float(roc_auc_score(y_true, probs))
        metrics["auprc"] = float(average_precision_score(y_true, probs))
    else:
        metrics["auroc"] = None
        metrics["auprc"] = None

    results_path = out_dir / "real_field_confidence_results.csv"
    df.to_csv(results_path, index=False)
    pd.DataFrame(image_rows).to_csv(out_dir / "real_field_confidence_per_image.csv", index=False)
    sweep = _threshold_sweep(y_true, probs)
    sweep.to_csv(out_dir / "real_field_confidence_threshold_sweep.csv", index=False)
    with (out_dir / "real_field_confidence_metrics.json").open("w", encoding="utf-8") as fh:
        json.dump(metrics, fh, indent=2)

    if out_dir.name == "real_eval" and out_dir.parent.name == "field_confidence_lite":
        final_root = out_dir.parent.parent
        shutil.copy2(results_path, final_root / "real_field_confidence_results.csv")

    logger.info("Saved real FieldConfidenceNet-Lite results to %s", out_dir)


def main() -> None:
    parser = argparse.ArgumentParser(description="Evaluate FieldConfidenceNet-Lite on real photos")
    parser.add_argument("--model", required=True)
    parser.add_argument("--vectorizer", default=None)
    parser.add_argument("--images", required=True)
    parser.add_argument("--ground-truth", required=True)
    parser.add_argument("--out", required=True)
    parser.add_argument("--cpu", action="store_true")
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
    _configure_tesseract()
    evaluate(args)


if __name__ == "__main__":
    main()
