"""
Inspect OCR failures on clean synthetic labels.

For each failed clean image, saves:
  - original image
  - raw Tesseract OCR text
  - ground truth JSON
  - parsed output JSON
  - list of missed/wrong fields
  - side-by-side HTML report

Usage:
    python -m ml.ocr.neural.evaluation.inspect_ocr_failures \
        --data data/synthetic_ocr_medium \
        --out ml/ocr/neural/outputs/failure_inspection \
        --max-failures 50
"""

from __future__ import annotations

import argparse
import json
import logging
import os
import shutil
from pathlib import Path

import cv2
import numpy as np
import pytesseract
from PIL import Image

from ..fields import NUTRITION_FIELDS
from ..parse_synthetic_ocr import parse_synthetic_ocr
from .metrics import field_extraction_accuracy, field_match

logger = logging.getLogger(__name__)

_PSM_MODES = [4, 6, 11]


def inspect_failures(data_dir: str, out_dir: str,
                     max_failures: int = 50,
                     psm: int = 4) -> None:
    """Inspect OCR failures on clean synthetic labels."""
    meta_dir = os.path.join(data_dir, "metadata")
    clean_dir = os.path.join(data_dir, "clean")

    os.makedirs(out_dir, exist_ok=True)

    gt_cache: dict[str, dict] = {}
    for p in Path(meta_dir).glob("label_*.json"):
        with open(p) as f:
            gt_cache[p.stem] = json.load(f)

    clean_paths = sorted(Path(clean_dir).glob("*.png"))
    tess_config = f"--oem 3 --psm {psm}"

    failures: list[dict] = []
    total_evaluated = 0
    total_correct = 0
    total_fields_all = 0
    per_field_correct: dict[str, int] = {f: 0 for f in NUTRITION_FIELDS}
    per_field_total: dict[str, int] = {f: 0 for f in NUTRITION_FIELDS}

    for p in clean_paths:
        gt_meta = gt_cache.get(p.stem)
        if gt_meta is None:
            continue
        gt_fields = gt_meta["fields"]

        img = cv2.imread(str(p))
        if img is None:
            continue

        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        raw_text = pytesseract.image_to_string(Image.fromarray(gray), config=tess_config)
        parsed = parse_synthetic_ocr(raw_text)

        correct, total, acc = field_extraction_accuracy(parsed, gt_fields)
        total_evaluated += 1
        total_correct += correct
        total_fields_all += total

        # Per-field tracking
        missed_fields: list[dict] = []
        for field in NUTRITION_FIELDS:
            gt_val = gt_fields.get(field)
            if gt_val is None:
                continue
            per_field_total[field] += 1
            pred_val = parsed.get(field)
            if field_match(pred_val, gt_val, field):
                per_field_correct[field] += 1
            else:
                missed_fields.append({
                    "field": field,
                    "parsed": pred_val,
                    "ground_truth": gt_val,
                })

        if acc < 1.0 and len(failures) < max_failures:
            failures.append({
                "image_id": p.stem,
                "image_path": str(p),
                "accuracy": round(acc, 4),
                "correct": correct,
                "total": total,
                "missed_fields": missed_fields,
                "raw_ocr_text": raw_text,
                "parsed": {k: v for k, v in parsed.items() if v is not None},
                "ground_truth": gt_fields,
                "image_size": f"{img.shape[1]}x{img.shape[0]}",
            })

    logger.info("Evaluated %d clean labels, found %d with failures",
                total_evaluated, len(failures))

    # ── Save individual failure details ──
    failures_dir = os.path.join(out_dir, "failures")
    os.makedirs(failures_dir, exist_ok=True)

    for fail in failures:
        fdir = os.path.join(failures_dir, fail["image_id"])
        os.makedirs(fdir, exist_ok=True)

        # Copy original image
        shutil.copy2(fail["image_path"], os.path.join(fdir, "original.png"))

        # Save raw OCR text
        with open(os.path.join(fdir, "raw_ocr_text.txt"), "w") as f:
            f.write(fail["raw_ocr_text"])

        # Save ground truth
        with open(os.path.join(fdir, "ground_truth.json"), "w") as f:
            json.dump(fail["ground_truth"], f, indent=2)

        # Save parsed output
        with open(os.path.join(fdir, "parsed_output.json"), "w") as f:
            json.dump(fail["parsed"], f, indent=2)

        # Save missed fields
        with open(os.path.join(fdir, "missed_fields.json"), "w") as f:
            json.dump(fail["missed_fields"], f, indent=2)

    # ── Per-field accuracy summary ──
    pf_summary: list[dict] = []
    for field in NUTRITION_FIELDS:
        t = per_field_total[field]
        c = per_field_correct[field]
        pf_summary.append({
            "field": field,
            "correct": c,
            "total": t,
            "accuracy": round(c / t, 4) if t > 0 else 0.0,
        })

    pf_path = os.path.join(out_dir, "per_field_accuracy.json")
    with open(pf_path, "w") as f:
        json.dump(pf_summary, f, indent=2)

    # ── Failure frequency by field ──
    field_fail_count: dict[str, int] = {f: 0 for f in NUTRITION_FIELDS}
    for fail in failures:
        for mf in fail["missed_fields"]:
            field_fail_count[mf["field"]] += 1

    # ── HTML report ──
    overall_acc = total_correct / total_fields_all if total_fields_all > 0 else 0.0
    html_path = os.path.join(out_dir, "failure_report.html")
    with open(html_path, "w") as f:
        f.write("<!DOCTYPE html><html><head>\n")
        f.write("<style>\n")
        f.write("body { font-family: monospace; max-width: 1200px; margin: auto; }\n")
        f.write("table { border-collapse: collapse; margin: 16px 0; }\n")
        f.write("th, td { border: 1px solid #ccc; padding: 6px 12px; text-align: left; }\n")
        f.write("th { background: #f0f0f0; }\n")
        f.write(".miss { color: red; } .hit { color: green; }\n")
        f.write(".fail-block { border: 2px solid #ddd; margin: 24px 0; padding: 16px; }\n")
        f.write("img { max-width: 400px; border: 1px solid #ccc; }\n")
        f.write("pre { background: #f9f9f9; padding: 10px; overflow-x: auto; }\n")
        f.write("</style>\n")
        f.write(f"<title>OCR Failure Inspection</title></head><body>\n")
        f.write(f"<h1>OCR Failure Inspection Report</h1>\n")
        f.write(f"<p>PSM mode: {psm} | Evaluated: {total_evaluated} clean labels | "
                f"Overall accuracy: {overall_acc:.4f}</p>\n")

        # Per-field accuracy table
        f.write("<h2>Per-Field Accuracy</h2>\n<table>\n")
        f.write("<tr><th>Field</th><th>Accuracy</th><th>Correct</th><th>Total</th>"
                "<th>Failures</th></tr>\n")
        for pfs in pf_summary:
            if pfs["total"] == 0:
                continue
            color = "hit" if pfs["accuracy"] >= 0.95 else "miss"
            f.write(f"<tr><td>{pfs['field']}</td>"
                    f"<td class='{color}'>{pfs['accuracy']:.2%}</td>"
                    f"<td>{pfs['correct']}</td><td>{pfs['total']}</td>"
                    f"<td>{field_fail_count.get(pfs['field'], 0)}</td></tr>\n")
        f.write("</table>\n")

        # Individual failures
        f.write(f"<h2>Failures ({len(failures)} shown, max {max_failures})</h2>\n")
        for fail in failures:
            f.write(f"<div class='fail-block'>\n")
            f.write(f"<h3>{fail['image_id']} (acc={fail['accuracy']:.2f}, "
                    f"{fail['correct']}/{fail['total']}, "
                    f"size={fail['image_size']})</h3>\n")

            # Side by side: image + OCR text
            rel_img = f"failures/{fail['image_id']}/original.png"
            f.write(f"<div style='display:flex; gap:20px;'>\n")
            f.write(f"<img src='{rel_img}' alt='label'>\n")
            f.write(f"<pre>{_html_escape(fail['raw_ocr_text'][:800])}</pre>\n")
            f.write(f"</div>\n")

            # Missed fields table
            if fail["missed_fields"]:
                f.write("<table><tr><th>Field</th><th>Parsed</th><th>Ground Truth</th></tr>\n")
                for mf in fail["missed_fields"]:
                    f.write(f"<tr class='miss'><td>{mf['field']}</td>"
                            f"<td>{mf['parsed']}</td><td>{mf['ground_truth']}</td></tr>\n")
                f.write("</table>\n")

            f.write("</div>\n")

        f.write("</body></html>\n")

    logger.info("HTML report: %s", html_path)
    logger.info("Per-field accuracy: %s", pf_path)

    # Console summary
    logger.info("Overall clean accuracy: %.4f (%d/%d)", overall_acc,
                total_correct, total_fields_all)
    logger.info("Per-field accuracy:")
    for pfs in pf_summary:
        if pfs["total"] > 0:
            marker = "" if pfs["accuracy"] >= 0.95 else "  <--"
            logger.info("  %-25s %.2f (%d/%d)%s",
                        pfs["field"], pfs["accuracy"],
                        pfs["correct"], pfs["total"], marker)


def _html_escape(text: str) -> str:
    return text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")


# ── CLI ───────────────────────────────────────────────────────────────────────

def main() -> None:
    parser = argparse.ArgumentParser(description="Inspect OCR failures on clean labels")
    parser.add_argument("--data", required=True, help="Root synthetic data dir")
    parser.add_argument("--out", required=True, help="Output directory")
    parser.add_argument("--max-failures", type=int, default=50,
                        help="Max failures to save details for")
    parser.add_argument("--psm", type=int, default=4,
                        choices=[4, 6, 11],
                        help="Tesseract PSM mode (default: 4)")
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
    inspect_failures(args.data, args.out,
                     max_failures=args.max_failures, psm=args.psm)


if __name__ == "__main__":
    main()
