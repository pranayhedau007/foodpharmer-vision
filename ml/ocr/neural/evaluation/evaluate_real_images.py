"""
Evaluate the OCR pipeline on real nutrition-label photographs.

Pipelines:
    A_full_tesseract:       full image -> Tesseract
    B_crop_tesseract:       OpenCV crop -> Tesseract
    C_crop_neural_tesseract: OpenCV crop -> neural preprocessor -> Tesseract
    D_crop_neural_gate:     OpenCV crop -> neural -> quality gate -> Tesseract

Usage:
    python -m ml.ocr.neural.evaluation.evaluate_real_images \
        --images "C:/Users/sherw/OneDrive/Desktop/CS274/Nutrition-Labels" \
        --ground-truth "C:/Users/sherw/OneDrive/Desktop/CS274/Nutrition-Labels/real_ground_truth_001_030.json" \
        --preprocessor ml/ocr/neural/weights/ocr_preprocessor_unet.pt \
        --predictor ml/ocr/neural/weights/ocr_quality_cnn.pt \
        --img-size 128 \
        --out ml/ocr/neural/outputs/real_eval
"""

from __future__ import annotations

import argparse
import csv
import json
import logging
import os
import re
import time
from pathlib import Path

import cv2
import numpy as np
import pytesseract
import torch
from PIL import Image

from .. import get_device, load_checkpoint
from ..fields import NUTRITION_FIELDS
from ..models.ocr_quality_cnn import OCRQualityCNN
from ..models.tiny_unet import TinyUNet
from ..parse_synthetic_ocr import parse_synthetic_ocr

logger = logging.getLogger(__name__)

_TESS_CONFIG = "--oem 3 --psm 11"


# ---------------------------------------------------------------------------
# Tolerant value matching for real labels
# ---------------------------------------------------------------------------

def _normalize_value(val: str) -> str:
    """Normalize a nutrition value for tolerant comparison."""
    v = val.strip().lower()
    # "less than 1g" -> "<1g"
    v = re.sub(r"less\s+than\s+", "<", v)
    # Remove spaces around units and <
    v = re.sub(r"\s+(?=g\b|mg\b|mcg\b|%)", "", v)
    v = re.sub(r"<\s+", "<", v)
    # Remove commas
    v = v.replace(",", "")
    return v.strip()


def _extract_number(val: str) -> float | None:
    """Pull out a numeric value, ignoring units and <."""
    cleaned = re.sub(r"[^\d.]", "", val)
    if not cleaned:
        return None
    try:
        return float(cleaned)
    except ValueError:
        return None


def _tolerant_field_match(pred_val: str | None, gt_val: str) -> bool:
    """Tolerant matching for real-image field values."""
    if pred_val is None:
        return False

    norm_p = _normalize_value(pred_val)
    norm_g = _normalize_value(gt_val)

    # Exact match after normalization
    if norm_p == norm_g:
        return True

    # Numeric comparison (ignore units — handles mg vs % mismatch)
    pn = _extract_number(norm_p)
    gn = _extract_number(norm_g)
    if pn is not None and gn is not None:
        if pn == gn:
            return True
        # Tolerance of 1 for integer-ish values
        if abs(pn - gn) <= 1:
            return True

    return False


def _real_field_accuracy(parsed: dict, gt_fields: dict,
                         score_fields: list[str] | None = None,
                         ) -> tuple[int, int, float]:
    """Field accuracy using tolerant matching, only scoring non-null GT."""
    correct = 0
    total = 0
    for field, gt_val in gt_fields.items():
        if gt_val is None:
            continue
        if score_fields and field not in score_fields:
            continue
        total += 1
        if _tolerant_field_match(parsed.get(field), gt_val):
            correct += 1
    return correct, total, correct / total if total > 0 else 0.0


# ---------------------------------------------------------------------------
# Simple OpenCV nutrition-label cropper
# ---------------------------------------------------------------------------

def _crop_nutrition_label(img: np.ndarray,
                          debug_dir: str | None = None,
                          image_name: str = "") -> tuple[np.ndarray, bool]:
    """
    Try to find and crop the nutrition facts panel from a product photo.

    Returns (cropped_image, crop_success).
    Falls back to the full image if detection fails.
    """
    h_orig, w_orig = img.shape[:2]

    # Work on a manageable size
    max_dim = 1200
    scale = min(max_dim / max(h_orig, w_orig), 1.0)
    if scale < 1.0:
        work = cv2.resize(img, (int(w_orig * scale), int(h_orig * scale)))
    else:
        work = img.copy()

    gray = cv2.cvtColor(work, cv2.COLOR_BGR2GRAY) if len(work.shape) == 3 else work.copy()
    h_w, w_w = gray.shape

    # Edge detection + morphology to find text-dense rectangular regions
    blurred = cv2.GaussianBlur(gray, (5, 5), 0)
    edges = cv2.Canny(blurred, 50, 150)

    # Dilate to connect text regions
    kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (15, 5))
    dilated = cv2.dilate(edges, kernel, iterations=3)

    # Close gaps
    kernel2 = cv2.getStructuringElement(cv2.MORPH_RECT, (5, 15))
    closed = cv2.morphologyEx(dilated, cv2.MORPH_CLOSE, kernel2, iterations=2)

    contours, _ = cv2.findContours(closed, cv2.RETR_EXTERNAL,
                                   cv2.CHAIN_APPROX_SIMPLE)

    # Filter candidates by area and aspect ratio
    min_area = h_w * w_w * 0.02   # at least 2% of image
    max_area = h_w * w_w * 0.95   # not basically the whole image
    candidates: list[tuple[int, int, int, int, float]] = []

    for cnt in contours:
        x, y, bw, bh = cv2.boundingRect(cnt)
        area = bw * bh
        if area < min_area or area > max_area:
            continue
        aspect = bw / bh if bh > 0 else 0
        # Nutrition panels are typically taller than wide or roughly square
        if aspect > 3.0:
            continue
        candidates.append((x, y, bw, bh, area))

    if not candidates:
        logger.debug("No crop candidates for %s, using full image", image_name)
        return img, False

    # Sort by area (largest first) — try biggest candidates first
    candidates.sort(key=lambda c: c[4], reverse=True)

    # Check candidates for "Nutrition" text
    best_crop = None
    best_score = -1

    for x, y, bw, bh, area in candidates[:8]:
        # Expand margins
        margin = int(max(bw, bh) * 0.05)
        x1 = max(0, x - margin)
        y1 = max(0, y - margin)
        x2 = min(w_w, x + bw + margin)
        y2 = min(h_w, y + bh + margin)

        crop_region = gray[y1:y2, x1:x2]
        if crop_region.size == 0:
            continue

        # Quick Tesseract check for "Nutrition"
        try:
            quick_text = pytesseract.image_to_string(
                Image.fromarray(crop_region),
                config="--oem 3 --psm 6",
            ).lower()
        except Exception:
            quick_text = ""

        score = 0
        if "nutrition" in quick_text:
            score += 100
        if "facts" in quick_text:
            score += 50
        if "calories" in quick_text:
            score += 30
        if "total fat" in quick_text or "total_fat" in quick_text:
            score += 20
        if "sodium" in quick_text:
            score += 10
        # Also score by text density (more chars = better)
        score += min(len(quick_text), 50)

        if score > best_score:
            best_score = score
            # Map back to original image coordinates
            ox1 = int(x1 / scale)
            oy1 = int(y1 / scale)
            ox2 = int(x2 / scale)
            oy2 = int(y2 / scale)
            best_crop = (ox1, oy1, ox2, oy2)

    if best_crop is None or best_score < 10:
        logger.debug("No good crop for %s (best_score=%d), using full image",
                     image_name, best_score)
        return img, False

    ox1, oy1, ox2, oy2 = best_crop
    cropped = img[oy1:oy2, ox1:ox2]

    # Save debug crop image
    if debug_dir:
        os.makedirs(debug_dir, exist_ok=True)
        debug_img = work.copy()
        sx1, sy1 = int(ox1 * scale), int(oy1 * scale)
        sx2, sy2 = int(ox2 * scale), int(oy2 * scale)
        cv2.rectangle(debug_img, (sx1, sy1), (sx2, sy2), (0, 255, 0), 2)
        cv2.imwrite(os.path.join(debug_dir, f"{image_name}_crop_debug.jpg"),
                    debug_img)
        cv2.imwrite(os.path.join(debug_dir, f"{image_name}_cropped.jpg"),
                    cropped)

    return cropped, True


# ---------------------------------------------------------------------------
# Neural preprocessing (same logic as evaluate_neural_pipeline)
# ---------------------------------------------------------------------------

def _apply_neural_output_mode(logits: torch.Tensor, mode: str) -> torch.Tensor:
    if mode == "soft":
        return torch.sigmoid(logits).clamp(0, 1)
    elif mode == "threshold":
        return (torch.sigmoid(logits) > 0.5).float()
    elif mode == "inverted-threshold":
        return 1.0 - (torch.sigmoid(logits) > 0.5).float()
    elif mode == "raw-clamp":
        return logits.clamp(0, 1)
    elif mode == "inverted-soft":
        return 1.0 - torch.sigmoid(logits).clamp(0, 1)
    else:
        raise ValueError(f"Unknown neural output mode: {mode}")


def _neural_preprocess(img: np.ndarray, model: TinyUNet,
                       device: torch.device, img_size: int = 128,
                       output_mode: str = "soft") -> np.ndarray:
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) if len(img.shape) == 3 else img
    h, w = gray.shape

    resized = cv2.resize(gray, (img_size, img_size))
    tensor = (torch.from_numpy(resized).float().unsqueeze(0).unsqueeze(0)
              / 255.0).to(device)

    with torch.no_grad():
        logits = model(tensor)
        processed = _apply_neural_output_mode(logits, output_mode)

    result = (processed[0, 0].cpu().numpy() * 255).astype(np.uint8)
    return cv2.resize(result, (w, h))


def _ocr(img: np.ndarray) -> str:
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) if len(img.shape) == 3 else img
    return pytesseract.image_to_string(Image.fromarray(gray), config=_TESS_CONFIG)


# ---------------------------------------------------------------------------
# Main evaluation
# ---------------------------------------------------------------------------

def evaluate_real(
    images_dir: str,
    gt_path: str,
    preprocessor_path: str,
    predictor_path: str | None,
    out_dir: str,
    img_size: int = 128,
    neural_output_mode: str = "soft",
) -> None:
    device = get_device()
    logger.info("Device: %s", device)
    logger.info("Image size: %d | Neural output mode: %s", img_size,
                neural_output_mode)

    # Load ground truth
    with open(gt_path) as f:
        gt_list = json.load(f)
    logger.info("Loaded %d ground-truth entries", len(gt_list))

    # Load models
    unet = TinyUNet()
    load_checkpoint(unet, preprocessor_path)
    unet.to(device).eval()

    predictor = None
    if predictor_path and os.path.exists(predictor_path):
        predictor = OCRQualityCNN()
        load_checkpoint(predictor, predictor_path)
        predictor.to(device).eval()
        logger.info("Loaded quality predictor")

    # Create output dirs
    os.makedirs(out_dir, exist_ok=True)
    crops_dir = os.path.join(out_dir, "crops")
    raw_ocr_dir = os.path.join(out_dir, "raw_ocr")
    side_by_side_dir = os.path.join(out_dir, "side_by_side")
    for d in (crops_dir, raw_ocr_dir, side_by_side_dir):
        os.makedirs(d, exist_ok=True)

    # Pipelines
    pipeline_names = ["A_full_tesseract", "B_crop_tesseract",
                      "C_crop_neural_tesseract", "D_crop_neural_gate"]
    rows: list[dict] = []
    per_image_rows: list[dict] = []
    per_field_counts: dict[str, dict[str, dict]] = {
        p: {} for p in pipeline_names
    }

    for entry in gt_list:
        image_file = entry["image"]
        image_name = Path(image_file).stem
        gt_fields = entry["fields"]

        img_path = os.path.join(images_dir, image_file)
        img = cv2.imread(img_path)
        if img is None:
            logger.warning("Cannot read %s", img_path)
            continue

        logger.info("Processing %s (%s)", image_file,
                     entry.get("product_hint", ""))

        # ── Crop ──
        cropped, crop_success = _crop_nutrition_label(
            img, debug_dir=crops_dir, image_name=image_name)

        # ── Pipeline A: full image -> Tesseract ──
        t0 = time.time()
        text_a = _ocr(img)
        lat_a = time.time() - t0
        parsed_a = parse_synthetic_ocr(text_a)

        # ── Pipeline B: crop -> Tesseract ──
        t0 = time.time()
        text_b = _ocr(cropped)
        lat_b = time.time() - t0
        parsed_b = parse_synthetic_ocr(text_b)

        # ── Pipeline C: crop -> neural -> Tesseract ──
        t0 = time.time()
        neural_pre = _neural_preprocess(cropped, unet, device,
                                        img_size, neural_output_mode)
        text_c = _ocr(neural_pre)
        lat_c = time.time() - t0
        parsed_c = parse_synthetic_ocr(text_c)

        # ── Pipeline D: crop -> neural -> gate -> Tesseract ──
        conf = -1.0
        decision = "no_predictor"
        rejected = False
        parsed_d = parsed_c  # Same neural output

        if predictor is not None:
            conf = _predict_quality_real(neural_pre, predictor, device)
            if conf >= 0.70:
                decision = "high_confidence"
            elif conf >= 0.40:
                decision = "medium_confidence"
            else:
                decision = "low_confidence"
                rejected = True
                parsed_d = {}

        lat_d = lat_c  # Same preprocessing time

        # Save raw OCR text
        for tag, txt in [("A_full", text_a), ("B_crop", text_b),
                         ("C_neural", text_c)]:
            with open(os.path.join(raw_ocr_dir,
                                   f"{image_name}_{tag}.txt"), "w") as fh:
                fh.write(txt)

        # Score each pipeline against ground truth (tolerant matching)
        for pname, parsed, lat in [
            ("A_full_tesseract", parsed_a, lat_a),
            ("B_crop_tesseract", parsed_b, lat_b),
            ("C_crop_neural_tesseract", parsed_c, lat_c),
            ("D_crop_neural_gate", parsed_d, lat_d),
        ]:
            c, t, acc = _real_field_accuracy(parsed, gt_fields,
                                             score_fields=NUTRITION_FIELDS)
            rows.append({
                "pipeline": pname,
                "image": image_file,
                "correct_fields": c,
                "total_fields": t,
                "accuracy": round(acc, 4),
                "latency_s": round(lat, 4),
                "crop_success": crop_success,
                "confidence": round(conf, 4) if conf >= 0 else "",
                "decision": decision if pname == "D_crop_neural_gate" else "",
                "rejected": rejected if pname == "D_crop_neural_gate" else "",
            })

            # Per-field tracking
            for field in NUTRITION_FIELDS:
                gt_val = gt_fields.get(field)
                if gt_val is None:
                    continue
                if field not in per_field_counts[pname]:
                    per_field_counts[pname][field] = {"correct": 0, "total": 0}
                per_field_counts[pname][field]["total"] += 1
                if _tolerant_field_match(parsed.get(field), gt_val):
                    per_field_counts[pname][field]["correct"] += 1

        # Per-image summary
        per_image_rows.append({
            "image": image_file,
            "product": entry.get("product_hint", ""),
            "crop_success": crop_success,
            "acc_A_full": round(_real_field_accuracy(
                parsed_a, gt_fields, NUTRITION_FIELDS)[2], 4),
            "acc_B_crop": round(_real_field_accuracy(
                parsed_b, gt_fields, NUTRITION_FIELDS)[2], 4),
            "acc_C_neural": round(_real_field_accuracy(
                parsed_c, gt_fields, NUTRITION_FIELDS)[2], 4),
            "acc_D_gated": round(_real_field_accuracy(
                parsed_d, gt_fields, NUTRITION_FIELDS)[2], 4),
            "gate_conf": round(conf, 4) if conf >= 0 else "",
            "gate_rejected": rejected,
        })

        # Side-by-side visualization
        _save_side_by_side(side_by_side_dir, image_name, img, cropped,
                           neural_pre, parsed_a, parsed_b, parsed_c,
                           gt_fields, conf)

    # ── Write outputs ──

    # 1. Main metrics CSV
    metrics_csv = os.path.join(out_dir, "real_eval_metrics.csv")
    with open(metrics_csv, "w", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=[
            "pipeline", "image", "correct_fields", "total_fields",
            "accuracy", "latency_s", "crop_success", "confidence",
            "decision", "rejected"])
        w.writeheader()
        w.writerows(rows)

    # 2. Per-image CSV
    pi_csv = os.path.join(out_dir, "real_eval_per_image.csv")
    with open(pi_csv, "w", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=[
            "image", "product", "crop_success",
            "acc_A_full", "acc_B_crop", "acc_C_neural", "acc_D_gated",
            "gate_conf", "gate_rejected"])
        w.writeheader()
        w.writerows(per_image_rows)

    # 3. Per-field CSV
    pf_csv = os.path.join(out_dir, "real_eval_per_field.csv")
    pf_rows: list[dict] = []
    for pname in pipeline_names:
        for field in NUTRITION_FIELDS:
            data = per_field_counts[pname].get(field, {"correct": 0, "total": 0})
            t = data["total"]
            pf_rows.append({
                "pipeline": pname,
                "field": field,
                "correct": data["correct"],
                "total": t,
                "accuracy": round(data["correct"] / t, 4) if t > 0 else "",
            })
    with open(pf_csv, "w", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=[
            "pipeline", "field", "correct", "total", "accuracy"])
        w.writeheader()
        w.writerows(pf_rows)

    # 4. Summary markdown
    summary_path = os.path.join(out_dir, "real_eval_summary.md")
    _write_summary(summary_path, rows, per_image_rows, pipeline_names,
                   img_size, neural_output_mode)

    logger.info("Real-image evaluation complete.  Results in %s", out_dir)


def _predict_quality_real(img: np.ndarray, model: OCRQualityCNN,
                          device: torch.device) -> float:
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) if len(img.shape) == 3 else img
    resized = cv2.resize(gray, (256, 256))
    tensor = (torch.from_numpy(resized).float().unsqueeze(0).unsqueeze(0)
              / 255.0).to(device)
    with torch.no_grad():
        return model(tensor).item()


def _save_side_by_side(out_dir: str, name: str, original: np.ndarray,
                       cropped: np.ndarray, neural: np.ndarray,
                       parsed_a: dict, parsed_b: dict, parsed_c: dict,
                       gt_fields: dict, conf: float) -> None:
    """Save a side-by-side comparison image."""
    try:
        import matplotlib
        matplotlib.use("Agg")
        import matplotlib.pyplot as plt
    except ImportError:
        return

    fig, axes = plt.subplots(1, 4, figsize=(20, 6))

    # Original
    axes[0].imshow(cv2.cvtColor(original, cv2.COLOR_BGR2RGB))
    axes[0].set_title("Original")
    axes[0].axis("off")

    # Cropped
    if len(cropped.shape) == 3:
        axes[1].imshow(cv2.cvtColor(cropped, cv2.COLOR_BGR2RGB))
    else:
        axes[1].imshow(cropped, cmap="gray")
    axes[1].set_title("Cropped")
    axes[1].axis("off")

    # Neural preprocessed
    axes[2].imshow(neural, cmap="gray")
    axes[2].set_title(f"Neural (conf={conf:.2f})")
    axes[2].axis("off")

    # Parsed fields comparison
    lines = ["Field | GT | A | B | C"]
    lines.append("-" * 50)
    for field in NUTRITION_FIELDS:
        gt_val = gt_fields.get(field)
        if gt_val is None:
            continue
        a_val = parsed_a.get(field, "-")
        b_val = parsed_b.get(field, "-")
        c_val = parsed_c.get(field, "-")
        if a_val is None:
            a_val = "-"
        if b_val is None:
            b_val = "-"
        if c_val is None:
            c_val = "-"
        short_field = field.replace("total_", "t_").replace("dietary_", "d_")
        lines.append(f"{short_field}: {gt_val} | {a_val} | {b_val} | {c_val}")
    text_block = "\n".join(lines[:20])

    axes[3].text(0.02, 0.98, text_block, transform=axes[3].transAxes,
                 fontsize=6, verticalalignment="top", fontfamily="monospace",
                 bbox=dict(boxstyle="round", facecolor="wheat", alpha=0.5))
    axes[3].set_title("Fields (GT|A|B|C)")
    axes[3].axis("off")

    plt.tight_layout()
    fig.savefig(os.path.join(out_dir, f"{name}_comparison.png"), dpi=120)
    plt.close(fig)


def _write_summary(path: str, rows: list[dict], per_image: list[dict],
                   pipeline_names: list[str],
                   img_size: int, neural_output_mode: str) -> None:
    with open(path, "w") as f:
        f.write("# Real-Image OCR Evaluation Summary\n\n")
        f.write(f"**Settings:** img_size={img_size}, "
                f"neural_output_mode={neural_output_mode}\n")
        f.write(f"**Images evaluated:** {len(per_image)}\n\n")

        # Crop success rate
        crop_ok = sum(1 for r in per_image if r["crop_success"])
        f.write(f"**Crop detection:** {crop_ok}/{len(per_image)} "
                f"({100*crop_ok/max(len(per_image),1):.0f}% success)\n\n")

        # Pipeline summary table
        f.write("| Pipeline | Mean Accuracy | Mean Latency (s) | N |\n")
        f.write("|----------|--------------|-------------------|---|\n")
        for pname in pipeline_names:
            pr = [r for r in rows if r["pipeline"] == pname]
            if not pr:
                continue
            avg_a = sum(r["accuracy"] for r in pr) / len(pr)
            avg_l = sum(r["latency_s"] for r in pr) / len(pr)
            f.write(f"| {pname} | {avg_a:.4f} | {avg_l:.3f} | {len(pr)} |\n")

        # Gate stats for D
        d_rows = [r for r in rows if r["pipeline"] == "D_crop_neural_gate"]
        if d_rows:
            rej = sum(1 for r in d_rows if r.get("rejected"))
            acc_count = len(d_rows) - rej
            f.write(f"\n## Pipeline D (Gated) Details\n\n")
            f.write(f"- Total: {len(d_rows)}\n")
            f.write(f"- Rejected: {rej}\n")
            f.write(f"- Accepted: {acc_count}\n")
            if acc_count == 0:
                f.write("\n**WARNING:** Gate rejected all images.\n")

        # Per-image table
        f.write("\n## Per-Image Results\n\n")
        f.write("| Image | Product | Crop | A_full | B_crop | C_neural "
                "| D_gated |\n")
        f.write("|-------|---------|------|--------|--------|----------"
                "|---------|\n")
        for r in per_image:
            crop = "Y" if r["crop_success"] else "N"
            f.write(f"| {r['image']} | {r['product'][:25]} | {crop} "
                    f"| {r['acc_A_full']:.2f} | {r['acc_B_crop']:.2f} "
                    f"| {r['acc_C_neural']:.2f} | {r['acc_D_gated']:.2f} |\n")


# ── CLI ───────────────────────────────────────────────────────────────────────

def main() -> None:
    parser = argparse.ArgumentParser(
        description="Evaluate OCR pipeline on real nutrition-label photos")
    parser.add_argument("--images", required=True,
                        help="Directory containing NL*.jpg files")
    parser.add_argument("--ground-truth", required=True,
                        help="Path to real_ground_truth JSON file")
    parser.add_argument("--preprocessor", required=True,
                        help="Preprocessor .pt path")
    parser.add_argument("--predictor", default=None,
                        help="Quality predictor .pt path (optional)")
    parser.add_argument("--img-size", type=int, default=128,
                        help="Image size for neural preprocessor "
                             "(must match training)")
    parser.add_argument("--neural-output-mode", default="soft",
                        choices=["soft", "threshold", "inverted-threshold",
                                 "raw-clamp", "inverted-soft"],
                        help="Neural output mode (default: soft)")
    parser.add_argument("--out", required=True, help="Output directory")
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO,
                        format="%(levelname)s: %(message)s")
    evaluate_real(args.images, args.ground_truth,
                  args.preprocessor, args.predictor,
                  args.out, img_size=args.img_size,
                  neural_output_mode=args.neural_output_mode)


if __name__ == "__main__":
    main()
