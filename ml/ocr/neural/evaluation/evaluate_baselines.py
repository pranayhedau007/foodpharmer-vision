"""
Evaluate Tesseract OCR baselines on synthetic nutrition labels.

Pipelines compared:
    A. clean image -> Tesseract
    B. corrupted image -> Tesseract
    C. corrupted image -> existing OpenCV preprocessing -> Tesseract

Usage:
    python -m ml.ocr.neural.evaluation.evaluate_baselines \
        --data data/synthetic_ocr \
        --out ml/ocr/neural/outputs/baseline_metrics.csv

    # Compare PSM modes on clean labels only
    python -m ml.ocr.neural.evaluation.evaluate_baselines \
        --data data/synthetic_ocr --out /dev/null --compare-psm
"""

from __future__ import annotations

import argparse
import csv
import json
import logging
import os
import time
from pathlib import Path

import cv2
import numpy as np
import pytesseract
from PIL import Image

from ..fields import NUTRITION_FIELDS
from ..parse_synthetic_ocr import parse_synthetic_ocr
from .metrics import field_extraction_accuracy, per_field_accuracy

logger = logging.getLogger(__name__)

_TESS_CONFIG = "--oem 3 --psm 11"


def _ocr(img: np.ndarray, config: str = _TESS_CONFIG) -> str:
    if len(img.shape) == 3:
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    else:
        gray = img
    return pytesseract.image_to_string(Image.fromarray(gray), config=config)


def _opencv_preprocess(img: np.ndarray) -> np.ndarray:
    """Replicates the existing repo's OCR preprocessing (ml/ocr/preprocessor.py)."""
    if len(img.shape) == 3:
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    else:
        gray = img.copy()

    clahe = cv2.createCLAHE(clipLimit=2.0, tileGridSize=(8, 8))
    enhanced = clahe.apply(gray)

    h, w = enhanced.shape
    if w < 1000:
        scale = 1000 / w
        enhanced = cv2.resize(enhanced, (1000, int(h * scale)),
                              interpolation=cv2.INTER_CUBIC)

    binary = cv2.adaptiveThreshold(
        enhanced, 255,
        cv2.ADAPTIVE_THRESH_GAUSSIAN_C,
        cv2.THRESH_BINARY,
        blockSize=51,
        C=15,
    )
    return binary


# ── PSM comparison ───────────────────────────────────────────────────────────

def compare_psm_modes(data_dir: str, max_images: int = 0) -> None:
    """Compare Tesseract page segmentation modes on clean labels."""
    meta_dir = os.path.join(data_dir, "metadata")
    clean_dir = os.path.join(data_dir, "clean")

    gt_cache: dict[str, dict] = {}
    for p in Path(meta_dir).glob("label_*.json"):
        with open(p) as f:
            gt_cache[p.stem] = json.load(f)

    clean_paths = sorted(Path(clean_dir).glob("*.png"))
    if max_images > 0:
        clean_paths = clean_paths[:max_images]

    psm_modes = [4, 6, 11]
    logger.info("Comparing PSM modes %s on %d clean labels", psm_modes, len(clean_paths))

    for psm in psm_modes:
        config = f"--oem 3 --psm {psm}"
        total_acc = 0.0
        count = 0
        per_field_parsed: list[dict] = []
        per_field_gt: list[dict] = []

        for p in clean_paths:
            gt_meta = gt_cache.get(p.stem)
            if gt_meta is None:
                continue
            img = cv2.imread(str(p))
            if img is None:
                continue
            text = _ocr(img, config=config)
            parsed = parse_synthetic_ocr(text)
            _, _, acc = field_extraction_accuracy(parsed, gt_meta["fields"])
            total_acc += acc
            count += 1
            per_field_parsed.append(parsed)
            per_field_gt.append(gt_meta["fields"])

        mean_acc = total_acc / count if count else 0.0
        logger.info("  PSM %d: mean_accuracy=%.4f (n=%d)", psm, mean_acc, count)

        # Per-field breakdown for this PSM mode
        pf = per_field_accuracy(per_field_parsed, per_field_gt)
        for field in NUTRITION_FIELDS:
            s = pf.get(field, {})
            if s.get("total", 0) > 0:
                facc = s["correct"] / s["total"]
                if facc < 1.0:
                    logger.info("    %s: %.2f (%d/%d)",
                                field, facc, s["correct"], s["total"])


# ── Main evaluation ──────────────────────────────────────────────────────────

def evaluate_baselines(data_dir: str, out_csv: str, max_images: int = 0) -> None:
    meta_dir = os.path.join(data_dir, "metadata")
    clean_dir = os.path.join(data_dir, "clean")
    corrupted_dir = os.path.join(data_dir, "corrupted")

    # Load ground truth
    gt_cache: dict[str, dict] = {}
    for p in Path(meta_dir).glob("label_*.json"):
        with open(p) as f:
            gt_cache[p.stem] = json.load(f)

    rows: list[dict] = []
    all_parsed_by_pipeline: dict[str, list[dict]] = {"clean": [], "corrupted": [], "opencv": []}
    all_gt_by_pipeline: dict[str, list[dict]] = {"clean": [], "corrupted": [], "opencv": []}

    # ── Pipeline A: clean -> Tesseract ──
    logger.info("Pipeline A: clean -> Tesseract")
    clean_paths = sorted(Path(clean_dir).glob("*.png"))
    if max_images > 0:
        clean_paths = clean_paths[:max_images]

    for p in clean_paths:
        gt_meta = gt_cache.get(p.stem)
        if gt_meta is None:
            continue
        img = cv2.imread(str(p))
        if img is None:
            continue

        t0 = time.time()
        text = _ocr(img)
        latency = time.time() - t0

        parsed = parse_synthetic_ocr(text)
        correct, total, acc = field_extraction_accuracy(parsed, gt_meta["fields"])

        rows.append({
            "pipeline": "A_clean",
            "image_id": p.stem,
            "severity": 0,
            "correct_fields": correct,
            "total_fields": total,
            "accuracy": round(acc, 4),
            "latency_s": round(latency, 3),
        })
        all_parsed_by_pipeline["clean"].append(parsed)
        all_gt_by_pipeline["clean"].append(gt_meta["fields"])

    logger.info("  Evaluated %d clean images", len(clean_paths))

    # ── Pipelines B & C: corrupted -> Tesseract / OpenCV+Tesseract ──
    logger.info("Pipeline B: corrupted -> Tesseract")
    logger.info("Pipeline C: corrupted -> OpenCV -> Tesseract")
    corrupted_paths = sorted(Path(corrupted_dir).glob("*.png"))
    if max_images > 0:
        corrupted_paths = corrupted_paths[:max_images * 5]

    for i, p in enumerate(corrupted_paths):
        clean_id = p.stem.split("__")[0]
        gt_meta = gt_cache.get(clean_id)
        if gt_meta is None:
            continue
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

        # Pipeline B: raw corrupted
        t0 = time.time()
        text_b = _ocr(img)
        lat_b = time.time() - t0
        parsed_b = parse_synthetic_ocr(text_b)
        c_b, t_b, acc_b = field_extraction_accuracy(parsed_b, gt_meta["fields"])

        rows.append({
            "pipeline": "B_corrupted",
            "image_id": p.stem,
            "severity": severity,
            "correct_fields": c_b,
            "total_fields": t_b,
            "accuracy": round(acc_b, 4),
            "latency_s": round(lat_b, 3),
        })
        all_parsed_by_pipeline["corrupted"].append(parsed_b)
        all_gt_by_pipeline["corrupted"].append(gt_meta["fields"])

        # Pipeline C: OpenCV preprocessing
        t0 = time.time()
        prepped = _opencv_preprocess(img)
        text_c = _ocr(prepped)
        lat_c = time.time() - t0
        parsed_c = parse_synthetic_ocr(text_c)
        c_c, t_c, acc_c = field_extraction_accuracy(parsed_c, gt_meta["fields"])

        rows.append({
            "pipeline": "C_opencv",
            "image_id": p.stem,
            "severity": severity,
            "correct_fields": c_c,
            "total_fields": t_c,
            "accuracy": round(acc_c, 4),
            "latency_s": round(lat_c, 3),
        })
        all_parsed_by_pipeline["opencv"].append(parsed_c)
        all_gt_by_pipeline["opencv"].append(gt_meta["fields"])

        if (i + 1) % 200 == 0:
            logger.info("  Processed %d / %d corrupted images", i + 1, len(corrupted_paths))

    # Write per-image CSV
    os.makedirs(os.path.dirname(out_csv) or ".", exist_ok=True)
    fieldnames = ["pipeline", "image_id", "severity", "correct_fields",
                  "total_fields", "accuracy", "latency_s"]
    with open(out_csv, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    logger.info("Wrote %d rows to %s", len(rows), out_csv)

    # ── Per-field accuracy CSV ──
    pf_csv = out_csv.replace(".csv", "_per_field.csv")
    pf_rows: list[dict] = []
    pipe_map = {"A_clean": "clean", "B_corrupted": "corrupted", "C_opencv": "opencv"}
    for pipe_label, pipe_key in pipe_map.items():
        parsed_list = all_parsed_by_pipeline[pipe_key]
        gt_list = all_gt_by_pipeline[pipe_key]
        if not parsed_list:
            continue
        pf = per_field_accuracy(parsed_list, gt_list)
        for field in NUTRITION_FIELDS:
            s = pf.get(field, {"correct": 0, "total": 0, "accuracy": 0.0})
            pf_rows.append({
                "pipeline": pipe_label,
                "field": field,
                "correct": s["correct"],
                "total": s["total"],
                "accuracy": round(s["accuracy"], 4),
            })
    if pf_rows:
        with open(pf_csv, "w", newline="") as f:
            writer = csv.DictWriter(f, fieldnames=["pipeline", "field", "correct",
                                                    "total", "accuracy"])
            writer.writeheader()
            writer.writerows(pf_rows)
        logger.info("Per-field accuracy: %s", pf_csv)

    # Summary
    for pipe in ("A_clean", "B_corrupted", "C_opencv"):
        pipe_rows = [r for r in rows if r["pipeline"] == pipe]
        if pipe_rows:
            avg = sum(r["accuracy"] for r in pipe_rows) / len(pipe_rows)
            avg_lat = sum(r["latency_s"] for r in pipe_rows) / len(pipe_rows)
            logger.info("  %s: mean_accuracy=%.4f  mean_latency=%.3fs  n=%d",
                        pipe, avg, avg_lat, len(pipe_rows))


# ── CLI ───────────────────────────────────────────────────────────────────────

def main() -> None:
    parser = argparse.ArgumentParser(description="Evaluate Tesseract baselines")
    parser.add_argument("--data", required=True, help="Root synthetic data dir")
    parser.add_argument("--out", required=True, help="Output CSV path")
    parser.add_argument("--max-images", type=int, default=0,
                        help="Max clean images to evaluate (0=all)")
    parser.add_argument("--compare-psm", action="store_true",
                        help="Compare PSM 4/6/11 on clean labels and exit")
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")

    if args.compare_psm:
        compare_psm_modes(args.data, max_images=args.max_images)
    else:
        evaluate_baselines(args.data, args.out, max_images=args.max_images)


if __name__ == "__main__":
    main()
