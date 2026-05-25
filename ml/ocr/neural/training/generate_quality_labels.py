"""
Auto-generate OCR quality labels by running Tesseract on each image
and comparing parsed nutrition fields against ground truth.

Usage:
    python -m ml.ocr.neural.training.generate_quality_labels \
        --data data/synthetic_ocr \
        --preprocessor ml/ocr/neural/weights/ocr_preprocessor_unet.pt \
        --out data/synthetic_ocr/metadata/ocr_quality_labels.csv
"""

from __future__ import annotations

import argparse
import csv
import json
import logging
import os
from pathlib import Path

import cv2
import numpy as np
import pytesseract
from PIL import Image

from ..fields import NUTRITION_FIELDS, FIELD_UNITS
from ..parse_synthetic_ocr import parse_synthetic_ocr

logger = logging.getLogger(__name__)

_TESS_CONFIG = "--oem 3 --psm 11"


def _run_tesseract(img: np.ndarray) -> str:
    """Run Tesseract on a grayscale or BGR image."""
    if len(img.shape) == 3:
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    else:
        gray = img
    pil = Image.fromarray(gray)
    return pytesseract.image_to_string(pil, config=_TESS_CONFIG)


def _strip_unit(value: str) -> str:
    """Remove unit suffix to get bare number string."""
    for suffix in ("mcg", "mg", "g"):
        if value.endswith(suffix):
            return value[:-len(suffix)]
    return value


def _compare_fields(parsed: dict, ground_truth: dict) -> tuple[int, int]:
    """
    Compare parsed OCR fields against ground truth.

    Returns (correct, total).
    """
    correct = 0
    total = 0

    for field in NUTRITION_FIELDS:
        gt_val = ground_truth.get(field)
        if gt_val is None:
            continue
        total += 1

        pred_val = parsed.get(field)
        if pred_val is None:
            continue

        # Strip units and compare numerically
        try:
            gt_num = float(_strip_unit(gt_val))
            pred_num = float(_strip_unit(pred_val))
            unit = FIELD_UNITS.get(field, "")
            if unit == "" or unit == "mg" or unit == "mcg":
                # Integer fields: tolerance of 1
                if abs(pred_num - gt_num) <= 1:
                    correct += 1
            else:
                # Gram fields: tolerance of 0.1
                if abs(pred_num - gt_num) <= 0.1:
                    correct += 1
        except (ValueError, TypeError):
            # If parsing fails, compare as strings
            if _strip_unit(pred_val) == _strip_unit(gt_val):
                correct += 1

    return correct, total


def _preprocess_with_model(img: np.ndarray, model, device,
                           img_size: int = 128) -> np.ndarray:
    """Apply the trained U-Net binarizer to an image."""
    import torch

    if len(img.shape) == 3:
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    else:
        gray = img

    h, w = gray.shape
    resized = cv2.resize(gray, (img_size, img_size))
    tensor = torch.from_numpy(resized).float().unsqueeze(0).unsqueeze(0) / 255.0
    tensor = tensor.to(device)

    with torch.no_grad():
        logits = model(tensor)
        # For L1-trained models, use soft output (sigmoid, no hard threshold)
        # to preserve grayscale detail for Tesseract
        processed = torch.sigmoid(logits).clamp(0, 1)

    out_np = (processed[0, 0].cpu().numpy() * 255).astype(np.uint8)
    # Resize back to original
    out_np = cv2.resize(out_np, (w, h))
    return out_np


def generate_labels(data_dir: str, preprocessor_path: str | None,
                    out_csv: str, img_size: int = 128) -> None:
    """Generate OCR quality labels for all corrupted (and optionally preprocessed) images."""
    import torch
    from .. import get_device, load_checkpoint
    from ..models.tiny_unet import TinyUNet

    device = get_device()

    # Load preprocessor if available
    model = None
    if preprocessor_path and os.path.exists(preprocessor_path):
        model = TinyUNet()
        load_checkpoint(model, preprocessor_path)
        model.to(device).eval()
        logger.info("Loaded preprocessor from %s", preprocessor_path)

    # Load ground truth
    meta_dir = os.path.join(data_dir, "metadata")
    gt_cache: dict[str, dict] = {}
    for p in Path(meta_dir).glob("label_*.json"):
        with open(p) as f:
            gt_cache[p.stem] = json.load(f)

    corrupted_dir = os.path.join(data_dir, "corrupted")
    corrupted_paths = sorted(Path(corrupted_dir).glob("*.png"))

    if not corrupted_paths:
        logger.warning("No corrupted images found in %s", corrupted_dir)
        return

    os.makedirs(os.path.dirname(out_csv) or ".", exist_ok=True)
    rows: list[dict] = []

    for i, p in enumerate(corrupted_paths):
        clean_id = p.stem.split("__")[0]
        gt_meta = gt_cache.get(clean_id)
        if gt_meta is None:
            continue
        gt_fields = gt_meta["fields"]

        # Parse severity from filename
        parts = p.stem.split("__")
        severity = 0
        for part in parts:
            if part.startswith("sev"):
                try:
                    severity = int(part[3:])
                except ValueError:
                    pass

        img = cv2.imread(str(p))
        if img is None:
            continue

        # Raw corrupted -> Tesseract
        raw_text = _run_tesseract(img)
        raw_parsed = parse_synthetic_ocr(raw_text)
        raw_correct, raw_total = _compare_fields(raw_parsed, gt_fields)
        raw_score = raw_correct / raw_total if raw_total > 0 else 0.0

        rows.append({
            "image_path": str(p),
            "clean_id": clean_id,
            "corrupted_id": p.stem,
            "severity": severity,
            "pipeline_source": "raw_corrupted",
            "success_score": round(raw_score, 4),
            "good_label": 1 if raw_score >= 0.60 else 0,
            "correct_fields": raw_correct,
            "total_fields": raw_total,
        })

        # Neural-preprocessed -> Tesseract
        if model is not None:
            preprocessed = _preprocess_with_model(img, model, device, img_size)
            pre_text = _run_tesseract(preprocessed)
            pre_parsed = parse_synthetic_ocr(pre_text)
            pre_correct, pre_total = _compare_fields(pre_parsed, gt_fields)
            pre_score = pre_correct / pre_total if pre_total > 0 else 0.0

            rows.append({
                "image_path": str(p).replace(".png", "__neural.png"),
                "clean_id": clean_id,
                "corrupted_id": p.stem + "__neural",
                "severity": severity,
                "pipeline_source": "neural_preprocessed",
                "success_score": round(pre_score, 4),
                "good_label": 1 if pre_score >= 0.60 else 0,
                "correct_fields": pre_correct,
                "total_fields": pre_total,
            })

            # Save the preprocessed image so the quality predictor can train on it
            pre_out_path = str(p).replace(".png", "__neural.png")
            cv2.imwrite(pre_out_path, preprocessed)

        if (i + 1) % 200 == 0 or (i + 1) == len(corrupted_paths):
            logger.info("Processed %d / %d images", i + 1, len(corrupted_paths))

    # Write CSV
    fieldnames = ["image_path", "clean_id", "corrupted_id", "severity",
                  "pipeline_source", "success_score", "good_label",
                  "correct_fields", "total_fields"]
    with open(out_csv, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    logger.info("Wrote %d rows to %s", len(rows), out_csv)


# ── CLI ───────────────────────────────────────────────────────────────────────

def main() -> None:
    parser = argparse.ArgumentParser(description="Generate OCR quality labels")
    parser.add_argument("--data", required=True, help="Root synthetic data dir")
    parser.add_argument("--preprocessor", default=None,
                        help="Path to trained preprocessor .pt (optional)")
    parser.add_argument("--out", required=True, help="Output CSV path")
    parser.add_argument("--img-size", type=int, default=128,
                        help="Image size for neural preprocessor (must match training)")
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
    generate_labels(args.data, args.preprocessor, args.out,
                    img_size=args.img_size)


if __name__ == "__main__":
    main()
