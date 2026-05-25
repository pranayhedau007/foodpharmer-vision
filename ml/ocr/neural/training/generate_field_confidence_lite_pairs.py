"""Generate FieldConfidenceNet-Lite training pairs.

Each output row represents one (image, nutrition field) pair. The label is 1
when the parsed Tesseract value matches ground truth under tolerant matching.
"""

from __future__ import annotations

import argparse
import csv
import json
import logging
import time
from pathlib import Path
from typing import Any

import cv2
import pytesseract
from PIL import Image

from ..field_confidence_lite import make_field_confidence_row
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


def _ocr(img_path: Path) -> tuple[str, float]:
    img = cv2.imread(str(img_path))
    if img is None:
        raise ValueError(f"Could not read image: {img_path}")
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) if len(img.shape) == 3 else img
    t0 = time.perf_counter()
    text = pytesseract.image_to_string(Image.fromarray(gray), config=TESS_CONFIG)
    return text, time.perf_counter() - t0


def _load_ground_truth(data_dir: Path) -> dict[str, dict[str, Any]]:
    gt: dict[str, dict[str, Any]] = {}
    for path in sorted((data_dir / "metadata").glob("label_*.json")):
        with path.open("r", encoding="utf-8") as fh:
            meta = json.load(fh)
        gt[path.stem] = meta.get("fields", {})
    return gt


def generate_pairs(data_dir: Path, out_csv: Path, max_images: int = 5000) -> None:
    gt_cache = _load_ground_truth(data_dir)
    image_paths = sorted((data_dir / "corrupted").glob("*.png"))
    if max_images > 0:
        image_paths = image_paths[:max_images]

    out_csv.parent.mkdir(parents=True, exist_ok=True)
    raw_dir = out_csv.parent / "field_confidence_raw_tesseract"
    raw_dir.mkdir(parents=True, exist_ok=True)

    rows: list[dict[str, Any]] = []
    latencies: list[dict[str, Any]] = []
    for idx, img_path in enumerate(image_paths, start=1):
        clean_id = img_path.stem.split("__")[0]
        gt_fields = gt_cache.get(clean_id)
        if not gt_fields:
            continue

        try:
            text, latency = _ocr(img_path)
        except Exception as exc:
            logger.warning("OCR failed for %s: %s", img_path.name, exc)
            text = ""
            latency = 0.0

        (raw_dir / f"{img_path.stem}.txt").write_text(text, encoding="utf-8")
        parsed = parse_synthetic_ocr(text)
        latencies.append(
            {
                "image_id": img_path.stem,
                "latency_s": round(latency, 6),
                "raw_text_path": str(raw_dir / f"{img_path.stem}.txt"),
            }
        )

        for field in NUTRITION_FIELDS:
            row = make_field_confidence_row(
                image_id=img_path.stem,
                field_name=field,
                raw_ocr_text=text,
                parsed_fields=parsed,
                ground_truth_fields=gt_fields,
                dataset="corrupted_synthetic",
            )
            if row is not None:
                rows.append(row)

        if idx % 100 == 0:
            logger.info("Processed %d/%d corrupted images", idx, len(image_paths))

    if not rows:
        raise RuntimeError(f"No training pairs generated from {data_dir}")

    fieldnames = list(rows[0].keys())
    with out_csv.open("w", newline="", encoding="utf-8") as fh:
        writer = csv.DictWriter(fh, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    latency_path = out_csv.with_name("field_confidence_pair_generation_latency.csv")
    with latency_path.open("w", newline="", encoding="utf-8") as fh:
        writer = csv.DictWriter(fh, fieldnames=["image_id", "latency_s", "raw_text_path"])
        writer.writeheader()
        writer.writerows(latencies)

    labels = [int(row["label_correct"]) for row in rows]
    positives = sum(labels)
    logger.info(
        "Wrote %d pairs from %d images to %s (positive rate %.3f)",
        len(rows),
        len(image_paths),
        out_csv,
        positives / max(len(labels), 1),
    )


def main() -> None:
    parser = argparse.ArgumentParser(description="Generate FieldConfidenceNet-Lite pairs")
    parser.add_argument("--data", required=True, help="Synthetic OCR data root")
    parser.add_argument("--out", required=True, help="Output CSV path")
    parser.add_argument("--max-images", type=int, default=5000)
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
    _configure_tesseract()
    generate_pairs(Path(args.data), Path(args.out), max_images=args.max_images)


if __name__ == "__main__":
    main()
