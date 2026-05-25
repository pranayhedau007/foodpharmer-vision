"""Final OCR strategy comparison for the Food Pharmer OCR module.

The script compares practical OCR strategies on small, presentation-sized
samples and writes the final CSV/Markdown artifacts expected by the project
prompt. Slow optional engines are attempted only when explicitly requested.
"""

from __future__ import annotations

import argparse
import csv
import json
import logging
import re
import time
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Callable

import cv2
import numpy as np
import pandas as pd
import pytesseract
from PIL import Image

from ..field_confidence_lite import tolerant_value_match
from ..fields import NUTRITION_FIELDS
from ..parse_synthetic_ocr import parse_synthetic_ocr
from .evaluate_real_images import _crop_nutrition_label
from .final_report import write_final_reports

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


@dataclass
class EvalItem:
    dataset: str
    image_id: str
    path: Path
    ground_truth: dict[str, Any]
    is_real: bool = False


def _read_image(path: Path) -> np.ndarray | None:
    img = cv2.imread(str(path))
    if img is None:
        logger.warning("Could not read image: %s", path)
    return img


def _to_pil_rgb(img: np.ndarray) -> Image.Image:
    if len(img.shape) == 2:
        return Image.fromarray(img).convert("RGB")
    return Image.fromarray(cv2.cvtColor(img, cv2.COLOR_BGR2RGB)).convert("RGB")


def _tesseract_ocr(img: np.ndarray, config: str = TESS_CONFIG) -> str:
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) if len(img.shape) == 3 else img
    return pytesseract.image_to_string(Image.fromarray(gray), config=config)


def _opencv_preprocess(img: np.ndarray) -> np.ndarray:
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) if len(img.shape) == 3 else img.copy()
    clahe = cv2.createCLAHE(clipLimit=2.0, tileGridSize=(8, 8))
    enhanced = clahe.apply(gray)
    h, w = enhanced.shape
    if w < 1000:
        scale = 1000 / w
        enhanced = cv2.resize(
            enhanced, (1000, int(h * scale)), interpolation=cv2.INTER_CUBIC
        )
    return cv2.adaptiveThreshold(
        enhanced,
        255,
        cv2.ADAPTIVE_THRESH_GAUSSIAN_C,
        cv2.THRESH_BINARY,
        blockSize=51,
        C=15,
    )


def _segment_text_lines(img: np.ndarray, max_lines: int = 80) -> list[np.ndarray]:
    """Simple OpenCV text-line segmentation for TrOCR line mode."""
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) if len(img.shape) == 3 else img.copy()
    if gray.shape[1] < 1000:
        scale = 1000 / gray.shape[1]
        gray = cv2.resize(gray, (1000, int(gray.shape[0] * scale)), interpolation=cv2.INTER_CUBIC)

    blur = cv2.GaussianBlur(gray, (3, 3), 0)
    thresh = cv2.adaptiveThreshold(
        blur,
        255,
        cv2.ADAPTIVE_THRESH_GAUSSIAN_C,
        cv2.THRESH_BINARY_INV,
        blockSize=35,
        C=15,
    )
    kernel_w = max(20, gray.shape[1] // 25)
    kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (kernel_w, 3))
    connected = cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, kernel, iterations=1)
    contours, _ = cv2.findContours(connected, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    boxes: list[tuple[int, int, int, int]] = []
    img_area = gray.shape[0] * gray.shape[1]
    for contour in contours:
        x, y, w, h = cv2.boundingRect(contour)
        area = w * h
        if area < max(80, img_area * 0.00008):
            continue
        if h < 8 or w < 20:
            continue
        if h > gray.shape[0] * 0.25:
            continue
        boxes.append((x, y, w, h))

    boxes.sort(key=lambda b: (b[1], b[0]))
    if not boxes:
        return [img]

    line_imgs: list[np.ndarray] = []
    for x, y, w, h in boxes[:max_lines]:
        pad_y = max(3, int(h * 0.25))
        pad_x = 8
        y1 = max(0, y - pad_y)
        y2 = min(gray.shape[0], y + h + pad_y)
        x1 = max(0, x - pad_x)
        x2 = min(gray.shape[1], x + w + pad_x)
        crop = gray[y1:y2, x1:x2]
        if crop.size:
            line_imgs.append(crop)
    return line_imgs or [img]


def _safe_filename(value: str) -> str:
    return re.sub(r"[^A-Za-z0-9_.-]+", "_", value)


def _write_raw_text(out_dir: Path, method: str, dataset: str, image_id: str, text: str) -> str:
    raw_dir = out_dir / "raw_text_examples" / _safe_filename(method) / _safe_filename(dataset)
    raw_dir.mkdir(parents=True, exist_ok=True)
    path = raw_dir / f"{_safe_filename(image_id)}.txt"
    path.write_text(text or "", encoding="utf-8")
    return str(path)


def _score(parsed: dict[str, Any], gt: dict[str, Any]) -> tuple[int, int, float, dict[str, bool]]:
    correct = 0
    total = 0
    per_field: dict[str, bool] = {}
    for field in NUTRITION_FIELDS:
        gt_val = gt.get(field)
        if gt_val is None:
            continue
        total += 1
        ok = tolerant_value_match(parsed.get(field), gt_val, field)
        per_field[field] = ok
        if ok:
            correct += 1
    return correct, total, correct / total if total else 0.0, per_field


def _load_synthetic_items(
    root: Path,
    clean_sample: int,
    corrupted_sample: int,
) -> tuple[list[EvalItem], list[EvalItem]]:
    meta_dir = root / "metadata"
    gt_cache: dict[str, dict[str, Any]] = {}
    for path in sorted(meta_dir.glob("label_*.json")):
        with path.open("r", encoding="utf-8") as fh:
            meta = json.load(fh)
        gt_cache[path.stem] = meta.get("fields", {})

    clean_items: list[EvalItem] = []
    for path in sorted((root / "clean").glob("*.png"))[:clean_sample]:
        gt = gt_cache.get(path.stem)
        if gt:
            clean_items.append(EvalItem("clean_synthetic", path.stem, path, gt))

    corrupted_items: list[EvalItem] = []
    for path in sorted((root / "corrupted").glob("*.png"))[:corrupted_sample]:
        clean_id = path.stem.split("__")[0]
        gt = gt_cache.get(clean_id)
        if gt:
            corrupted_items.append(EvalItem("corrupted_synthetic", path.stem, path, gt))

    return clean_items, corrupted_items


def _load_real_items(images_dir: Path, gt_path: Path) -> list[EvalItem]:
    with gt_path.open("r", encoding="utf-8") as fh:
        entries = json.load(fh)

    items: list[EvalItem] = []
    for entry in entries:
        image_name = entry.get("image")
        if not image_name:
            continue
        path = images_dir / image_name
        if path.exists():
            items.append(
                EvalItem(
                    "real_photos",
                    Path(image_name).stem,
                    path,
                    entry.get("fields", {}),
                    is_real=True,
                )
            )
    return items


class TrOCREngine:
    def __init__(self, model_name: str = "microsoft/trocr-base-printed") -> None:
        import torch
        from transformers import TrOCRProcessor, VisionEncoderDecoderModel

        self.torch = torch
        self.device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
        logger.info("Loading TrOCR model %s on %s", model_name, self.device)
        self.processor = TrOCRProcessor.from_pretrained(model_name)
        self.model = VisionEncoderDecoderModel.from_pretrained(model_name).to(self.device)
        self.model.eval()

    def read_image(self, img: np.ndarray, max_new_tokens: int = 96) -> str:
        pil = _to_pil_rgb(img)
        pixel_values = self.processor(images=pil, return_tensors="pt").pixel_values.to(self.device)
        with self.torch.no_grad():
            generated_ids = self.model.generate(pixel_values, max_new_tokens=max_new_tokens)
        return self.processor.batch_decode(generated_ids, skip_special_tokens=True)[0]

    def read_lines(self, img: np.ndarray, line_crop_dir: Path | None = None, image_id: str = "") -> str:
        line_imgs = _segment_text_lines(img)
        lines: list[str] = []
        if line_crop_dir is not None:
            line_crop_dir.mkdir(parents=True, exist_ok=True)
        for idx, line_img in enumerate(line_imgs):
            if line_crop_dir is not None and idx < 20:
                cv2.imwrite(str(line_crop_dir / f"{_safe_filename(image_id)}_line_{idx:02d}.png"), line_img)
            try:
                line = self.read_image(line_img, max_new_tokens=48).strip()
            except Exception as exc:  # pragma: no cover - depends on optional HF runtime
                logger.warning("TrOCR line failed for %s line %d: %s", image_id, idx, exc)
                line = ""
            if line:
                lines.append(line)
        return "\n".join(lines)


class EasyOCREngine:
    def __init__(self) -> None:
        import easyocr

        self.reader = easyocr.Reader(["en"], gpu=False)

    def read_image(self, img: np.ndarray) -> str:
        if len(img.shape) == 2:
            rgb = cv2.cvtColor(img, cv2.COLOR_GRAY2RGB)
        else:
            rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        chunks = self.reader.readtext(rgb, detail=0, paragraph=True)
        return "\n".join(str(chunk) for chunk in chunks)


def _evaluate_method(
    *,
    method: str,
    items: list[EvalItem],
    out_dir: Path,
    ocr_fn: Callable[[np.ndarray, EvalItem], str],
    transform_real: Callable[[np.ndarray, EvalItem], np.ndarray] | None = None,
    failure_notes: str = "",
) -> tuple[list[dict[str, Any]], list[dict[str, Any]]]:
    rows: list[dict[str, Any]] = []
    per_field_rows: list[dict[str, Any]] = []

    for idx, item in enumerate(items, start=1):
        img = _read_image(item.path)
        if img is None:
            continue
        eval_img = img
        crop_success = ""
        if item.is_real and transform_real is not None:
            eval_img = transform_real(img, item)
            crop_success = eval_img is not img

        t0 = time.perf_counter()
        try:
            text = ocr_fn(eval_img, item)
            note = failure_notes
        except Exception as exc:
            text = ""
            note = f"{failure_notes}; runtime error: {exc}".strip("; ")
            logger.warning("%s failed on %s: %s", method, item.image_id, exc)
        latency = time.perf_counter() - t0

        parsed = parse_synthetic_ocr(text)
        correct, total, acc, field_hits = _score(parsed, item.ground_truth)
        raw_path = _write_raw_text(out_dir, method, item.dataset, item.image_id, text)
        rows.append(
            {
                "method": method,
                "dataset": item.dataset,
                "image_id": item.image_id,
                "correct_fields": correct,
                "total_fields": total,
                "field_accuracy": round(acc, 6),
                "latency_s": round(latency, 6),
                "raw_text_path": raw_path,
                "crop_success": crop_success,
                "failure_notes": note,
            }
        )
        for field, ok in field_hits.items():
            per_field_rows.append(
                {
                    "method": method,
                    "dataset": item.dataset,
                    "field": field,
                    "correct": int(ok),
                    "total": 1,
                }
            )

        if idx % 25 == 0:
            logger.info("%s %s: %d/%d images", method, item.dataset, idx, len(items))

    return rows, per_field_rows


def _summarize(rows: list[dict[str, Any]]) -> pd.DataFrame:
    if not rows:
        return pd.DataFrame()
    df = pd.DataFrame(rows)
    grouped = (
        df.groupby(["method", "dataset"], dropna=False)
        .agg(
            mean_field_accuracy=("field_accuracy", "mean"),
            mean_latency_s=("latency_s", "mean"),
            n_images=("image_id", "count"),
            n_fields_evaluated=("total_fields", "sum"),
            failure_notes=("failure_notes", lambda s: "; ".join(sorted({str(x) for x in s if str(x)}))),
            example_raw_text=("raw_text_path", "first"),
        )
        .reset_index()
    )
    return grouped


def _summarize_per_field(rows: list[dict[str, Any]]) -> pd.DataFrame:
    if not rows:
        return pd.DataFrame()
    df = pd.DataFrame(rows)
    grouped = (
        df.groupby(["method", "dataset", "field"], dropna=False)
        .agg(correct=("correct", "sum"), total=("total", "sum"))
        .reset_index()
    )
    grouped["accuracy"] = grouped["correct"] / grouped["total"].clip(lower=1)
    return grouped


def _add_skipped_rows(
    summary_rows: list[dict[str, Any]],
    method: str,
    datasets: list[str],
    reason: str,
) -> None:
    for dataset in datasets:
        summary_rows.append(
            {
                "method": method,
                "dataset": dataset,
                "mean_field_accuracy": np.nan,
                "mean_latency_s": np.nan,
                "n_images": 0,
                "n_fields_evaluated": 0,
                "failure_notes": reason,
                "example_raw_text": "",
            }
        )


def _append_existing_unet_results(summary_rows: list[dict[str, Any]], root: Path) -> None:
    rescue_csv = root / "ml" / "ocr" / "neural" / "outputs_rescue_debug" / "final_ocr_evaluation.csv"
    real_csv = root / "ml" / "ocr" / "neural" / "outputs" / "real_eval" / "real_eval_metrics.csv"

    if rescue_csv.exists():
        df = pd.read_csv(rescue_csv)
        for pipeline in ["D_neural", "E_gated"]:
            sub = df[df["pipeline"] == pipeline]
            if sub.empty:
                continue
            summary_rows.append(
                {
                    "method": f"U-Net negative ablation ({pipeline})",
                    "dataset": "corrupted_synthetic",
                    "mean_field_accuracy": float(sub["accuracy"].mean()),
                    "mean_latency_s": float(sub["latency_s"].mean()) if "latency_s" in sub else np.nan,
                    "n_images": int(len(sub)),
                    "n_fields_evaluated": int(sub["total_fields"].sum()) if "total_fields" in sub else 0,
                    "failure_notes": "Existing saved result only; U-Net was not rerun.",
                    "example_raw_text": "",
                }
            )

    if real_csv.exists():
        df = pd.read_csv(real_csv)
        for pipeline in ["C_crop_neural_tesseract", "D_crop_neural_gate"]:
            sub = df[df["pipeline"] == pipeline]
            if sub.empty:
                continue
            summary_rows.append(
                {
                    "method": f"U-Net negative ablation ({pipeline})",
                    "dataset": "real_photos",
                    "mean_field_accuracy": float(sub["accuracy"].mean()),
                    "mean_latency_s": float(sub["latency_s"].mean()) if "latency_s" in sub else np.nan,
                    "n_images": int(len(sub)),
                    "n_fields_evaluated": int(sub["total_fields"].sum()) if "total_fields" in sub else 0,
                    "failure_notes": "Existing saved result only; U-Net was not rerun.",
                    "example_raw_text": "",
                }
            )


def run(args: argparse.Namespace) -> None:
    out_dir = Path(args.out)
    out_dir.mkdir(parents=True, exist_ok=True)
    (out_dir / "trocr_outputs" / "full_mode_raw_text").mkdir(parents=True, exist_ok=True)
    (out_dir / "trocr_outputs" / "line_mode_raw_text").mkdir(parents=True, exist_ok=True)
    (out_dir / "trocr_outputs" / "line_crops_examples").mkdir(parents=True, exist_ok=True)

    synthetic_root = Path(args.synthetic)
    clean_items, corrupted_items = _load_synthetic_items(
        synthetic_root, args.synthetic_clean_sample, args.synthetic_corrupted_sample
    )
    real_items = _load_real_items(Path(args.real_images), Path(args.real_ground_truth))
    logger.info(
        "Loaded %d clean synthetic, %d corrupted synthetic, %d real images",
        len(clean_items),
        len(corrupted_items),
        len(real_items),
    )

    synthetic_rows: list[dict[str, Any]] = []
    real_rows: list[dict[str, Any]] = []
    per_field_rows: list[dict[str, Any]] = []
    skipped_summary_rows: list[dict[str, Any]] = []

    def raw_tess(img: np.ndarray, _item: EvalItem) -> str:
        return _tesseract_ocr(img)

    def opencv_tess(img: np.ndarray, _item: EvalItem) -> str:
        return _tesseract_ocr(_opencv_preprocess(img))

    def real_crop(img: np.ndarray, item: EvalItem) -> np.ndarray:
        cropped, _ok = _crop_nutrition_label(
            img,
            debug_dir=str(out_dir / "opencv_crops"),
            image_name=item.image_id,
        )
        return cropped

    for items in [clean_items, corrupted_items]:
        rows, pf = _evaluate_method(
            method="Tesseract",
            items=items,
            out_dir=out_dir,
            ocr_fn=raw_tess,
        )
        synthetic_rows.extend(rows)
        per_field_rows.extend(pf)

        rows, pf = _evaluate_method(
            method="OpenCV + Tesseract",
            items=items,
            out_dir=out_dir,
            ocr_fn=opencv_tess,
        )
        synthetic_rows.extend(rows)
        per_field_rows.extend(pf)

    rows, pf = _evaluate_method(
        method="Tesseract",
        items=real_items,
        out_dir=out_dir,
        ocr_fn=raw_tess,
    )
    real_rows.extend(rows)
    per_field_rows.extend(pf)

    rows, pf = _evaluate_method(
        method="OpenCV crop + Tesseract",
        items=real_items,
        out_dir=out_dir,
        ocr_fn=raw_tess,
        transform_real=real_crop,
    )
    real_rows.extend(rows)
    per_field_rows.extend(pf)

    if args.run_trocr:
        try:
            trocr = TrOCREngine()

            def trocr_full(img: np.ndarray, item: EvalItem) -> str:
                text = trocr.read_image(img)
                target = out_dir / "trocr_outputs" / "full_mode_raw_text" / f"{_safe_filename(item.image_id)}.txt"
                target.write_text(text, encoding="utf-8")
                return text

            def trocr_lines(img: np.ndarray, item: EvalItem) -> str:
                line_dir = out_dir / "trocr_outputs" / "line_crops_examples"
                text = trocr.read_lines(img, line_crop_dir=line_dir, image_id=item.image_id)
                target = out_dir / "trocr_outputs" / "line_mode_raw_text" / f"{_safe_filename(item.image_id)}.txt"
                target.write_text(text, encoding="utf-8")
                return text

            for items in [clean_items, corrupted_items]:
                rows, pf = _evaluate_method(
                    method="TrOCR full image",
                    items=items,
                    out_dir=out_dir,
                    ocr_fn=trocr_full,
                )
                synthetic_rows.extend(rows)
                per_field_rows.extend(pf)
                rows, pf = _evaluate_method(
                    method="TrOCR line segmented",
                    items=items,
                    out_dir=out_dir,
                    ocr_fn=trocr_lines,
                )
                synthetic_rows.extend(rows)
                per_field_rows.extend(pf)

            rows, pf = _evaluate_method(
                method="TrOCR full image",
                items=real_items,
                out_dir=out_dir,
                ocr_fn=trocr_full,
                transform_real=real_crop,
            )
            real_rows.extend(rows)
            per_field_rows.extend(pf)
            rows, pf = _evaluate_method(
                method="TrOCR line segmented",
                items=real_items,
                out_dir=out_dir,
                ocr_fn=trocr_lines,
                transform_real=real_crop,
            )
            real_rows.extend(rows)
            per_field_rows.extend(pf)
        except Exception as exc:
            reason = f"TrOCR skipped due to installation/runtime issue: {exc}"
            logger.warning(reason)
            _add_skipped_rows(
                skipped_summary_rows,
                "TrOCR full image",
                ["clean_synthetic", "corrupted_synthetic", "real_photos"],
                reason,
            )
            _add_skipped_rows(
                skipped_summary_rows,
                "TrOCR line segmented",
                ["clean_synthetic", "corrupted_synthetic", "real_photos"],
                reason,
            )
    else:
        reason = "TrOCR not requested in this run."
        _add_skipped_rows(
            skipped_summary_rows,
            "TrOCR full image",
            ["clean_synthetic", "corrupted_synthetic", "real_photos"],
            reason,
        )
        _add_skipped_rows(
            skipped_summary_rows,
            "TrOCR line segmented",
            ["clean_synthetic", "corrupted_synthetic", "real_photos"],
            reason,
        )

    if args.run_easyocr_if_available:
        try:
            easyocr_engine = EasyOCREngine()
            (out_dir / "easyocr_outputs").mkdir(parents=True, exist_ok=True)

            def easyocr_ocr(img: np.ndarray, item: EvalItem) -> str:
                text = easyocr_engine.read_image(img)
                target = out_dir / "easyocr_outputs" / f"{_safe_filename(item.image_id)}.txt"
                target.write_text(text, encoding="utf-8")
                return text

            rows, pf = _evaluate_method(
                method="EasyOCR",
                items=corrupted_items,
                out_dir=out_dir,
                ocr_fn=easyocr_ocr,
            )
            synthetic_rows.extend(rows)
            per_field_rows.extend(pf)
            rows, pf = _evaluate_method(
                method="EasyOCR",
                items=real_items,
                out_dir=out_dir,
                ocr_fn=easyocr_ocr,
                transform_real=real_crop,
            )
            real_rows.extend(rows)
            per_field_rows.extend(pf)
        except Exception as exc:
            reason = f"EasyOCR skipped due to installation/runtime issue: {exc}"
            logger.warning(reason)
            _add_skipped_rows(
                skipped_summary_rows,
                "EasyOCR",
                ["corrupted_synthetic", "real_photos"],
                reason,
            )
    else:
        _add_skipped_rows(
            skipped_summary_rows,
            "EasyOCR",
            ["corrupted_synthetic", "real_photos"],
            "EasyOCR not requested in this run.",
        )

    synthetic_df = pd.DataFrame(synthetic_rows)
    real_df = pd.DataFrame(real_rows)
    synthetic_df.to_csv(out_dir / "synthetic_ocr_comparison.csv", index=False)
    real_df.to_csv(out_dir / "real_ocr_comparison.csv", index=False)

    summary_df = pd.concat(
        [_summarize(synthetic_rows + real_rows), pd.DataFrame(skipped_summary_rows)],
        ignore_index=True,
    )
    summary_rows = summary_df.to_dict("records")
    _append_existing_unet_results(summary_rows, Path.cwd())
    summary_df = pd.DataFrame(summary_rows)
    summary_df.to_csv(out_dir / "ocr_strategy_comparison.csv", index=False)

    latency_cols = ["method", "dataset", "mean_latency_s", "n_images"]
    summary_df[latency_cols].to_csv(out_dir / "latency_summary.csv", index=False)

    per_field_df = _summarize_per_field(per_field_rows)
    per_field_df.to_csv(out_dir / "ocr_strategy_per_field.csv", index=False)

    write_final_reports(out_dir)
    logger.info("Final OCR comparison artifacts written to %s", out_dir)


def main() -> None:
    parser = argparse.ArgumentParser(description="Run final OCR strategy comparison")
    parser.add_argument("--synthetic", required=True, help="Synthetic OCR data root")
    parser.add_argument("--real-images", required=True, help="Directory containing NL*.jpg")
    parser.add_argument("--real-ground-truth", required=True, help="Real-image ground-truth JSON")
    parser.add_argument("--out", required=True, help="Output directory")
    parser.add_argument("--synthetic-clean-sample", type=int, default=100)
    parser.add_argument("--synthetic-corrupted-sample", type=int, default=200)
    parser.add_argument("--run-trocr", action="store_true")
    parser.add_argument("--run-easyocr-if-available", action="store_true")
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
    _configure_tesseract()
    run(args)


if __name__ == "__main__":
    main()
