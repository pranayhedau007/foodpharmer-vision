"""Bounded TrOCR benchmark for final OCR V2 presentation artifacts.

The benchmark intentionally keeps sample sizes and line-crop counts small.
It evaluates the official ``microsoft/trocr-base-printed`` model in two modes:

* full panel: one forward pass for the nutrition panel image
* line segmented: simple OpenCV row segmentation, then TrOCR per line

Outputs are written under the requested clean final directory.
"""

from __future__ import annotations

import argparse
import json
import logging
import re
import time
from dataclasses import dataclass
from pathlib import Path
from typing import Any

import cv2
import numpy as np
import pandas as pd
from PIL import Image

from ..field_confidence_lite import tolerant_value_match
from ..fields import NUTRITION_FIELDS
from ..parse_synthetic_ocr import parse_synthetic_ocr
from .evaluate_real_images import _crop_nutrition_label

logger = logging.getLogger(__name__)


@dataclass(frozen=True)
class EvalItem:
    dataset: str
    image_id: str
    path: Path
    ground_truth: dict[str, Any]
    is_real: bool = False


@dataclass
class LineBudget:
    max_total: int
    used: int = 0
    limit_reached: bool = False

    @property
    def remaining(self) -> int:
        return max(self.max_total - self.used, 0)


def _safe_name(value: str) -> str:
    return re.sub(r"[^A-Za-z0-9_.-]+", "_", str(value))


def _read_image(path: Path) -> np.ndarray | None:
    img = cv2.imread(str(path))
    if img is None:
        logger.warning("Could not read image: %s", path)
    return img


def _to_pil_rgb(img: np.ndarray) -> Image.Image:
    if len(img.shape) == 2:
        return Image.fromarray(img).convert("RGB")
    return Image.fromarray(cv2.cvtColor(img, cv2.COLOR_BGR2RGB)).convert("RGB")


def _load_synthetic_items(
    root: Path,
    clean_sample: int,
    corrupted_sample: int,
) -> list[EvalItem]:
    meta_dir = root / "metadata"
    gt_cache: dict[str, dict[str, Any]] = {}
    for path in sorted(meta_dir.glob("label_*.json")):
        with path.open("r", encoding="utf-8") as fh:
            meta = json.load(fh)
        gt_cache[path.stem] = meta.get("fields", {})

    items: list[EvalItem] = []
    for path in sorted((root / "clean").glob("*.png"))[:clean_sample]:
        gt = gt_cache.get(path.stem)
        if gt:
            items.append(EvalItem("clean_synthetic", path.stem, path, gt))

    for path in sorted((root / "corrupted").glob("*.png"))[:corrupted_sample]:
        clean_id = path.stem.split("__")[0]
        gt = gt_cache.get(clean_id)
        if gt:
            items.append(EvalItem("corrupted_synthetic", path.stem, path, gt))

    return items


def _load_real_items(images_dir: Path, gt_path: Path, sample: int) -> list[EvalItem]:
    with gt_path.open("r", encoding="utf-8") as fh:
        entries = json.load(fh)

    items: list[EvalItem] = []
    for entry in entries[:sample]:
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


def _segment_text_lines(
    img: np.ndarray,
    max_lines: int,
) -> list[tuple[np.ndarray, tuple[int, int, int, int]]]:
    """Segment likely text rows with simple morphology."""
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) if len(img.shape) == 3 else img.copy()
    h0, w0 = gray.shape
    scale = 1.0
    if w0 < 1000:
        scale = 1000 / max(w0, 1)
        gray = cv2.resize(gray, (1000, int(h0 * scale)), interpolation=cv2.INTER_CUBIC)

    blur = cv2.GaussianBlur(gray, (3, 3), 0)
    _, otsu = cv2.threshold(blur, 0, 255, cv2.THRESH_BINARY_INV | cv2.THRESH_OTSU)
    adaptive = cv2.adaptiveThreshold(
        blur,
        255,
        cv2.ADAPTIVE_THRESH_GAUSSIAN_C,
        cv2.THRESH_BINARY_INV,
        blockSize=35,
        C=15,
    )
    thresh = cv2.bitwise_or(otsu, adaptive)

    kernel_w = max(20, gray.shape[1] // 24)
    kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (kernel_w, 3))
    connected = cv2.dilate(thresh, kernel, iterations=1)
    connected = cv2.morphologyEx(connected, cv2.MORPH_CLOSE, kernel, iterations=1)
    contours, _ = cv2.findContours(connected, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    boxes: list[tuple[int, int, int, int]] = []
    img_area = gray.shape[0] * gray.shape[1]
    for contour in contours:
        x, y, w, h = cv2.boundingRect(contour)
        area = w * h
        if area < max(90, img_area * 0.00008):
            continue
        if w < 25 or h < 8:
            continue
        if h > gray.shape[0] * 0.25:
            continue
        boxes.append((x, y, w, h))

    boxes.sort(key=lambda b: (b[1], b[0]))
    crops: list[tuple[np.ndarray, tuple[int, int, int, int]]] = []
    for x, y, w, h in boxes[:max_lines]:
        pad_y = max(4, int(h * 0.35))
        pad_x = max(8, int(w * 0.02))
        x1 = max(0, x - pad_x)
        y1 = max(0, y - pad_y)
        x2 = min(gray.shape[1], x + w + pad_x)
        y2 = min(gray.shape[0], y + h + pad_y)
        crop = gray[y1:y2, x1:x2]
        if crop.size:
            crops.append((crop, (x1, y1, x2, y2)))
    return crops


class TrOCREngine:
    def __init__(self, model_name: str, device_name: str) -> None:
        import torch
        from transformers import TrOCRProcessor, VisionEncoderDecoderModel

        if device_name == "auto":
            resolved = "cuda" if torch.cuda.is_available() else "cpu"
        elif device_name == "cuda" and not torch.cuda.is_available():
            logger.warning("CUDA requested but unavailable; falling back to CPU")
            resolved = "cpu"
        else:
            resolved = device_name

        self.torch = torch
        self.device = torch.device(resolved)
        logger.info("Loading %s on %s", model_name, self.device)
        self.processor = TrOCRProcessor.from_pretrained(model_name)
        self.model = VisionEncoderDecoderModel.from_pretrained(model_name).to(self.device)
        self.model.eval()

    def read(self, img: np.ndarray, max_new_tokens: int) -> tuple[str, float]:
        pil = _to_pil_rgb(img)
        pixel_values = self.processor(images=pil, return_tensors="pt").pixel_values.to(self.device)
        t0 = time.perf_counter()
        with self.torch.no_grad():
            generated_ids = self.model.generate(pixel_values, max_new_tokens=max_new_tokens)
        latency = time.perf_counter() - t0
        text = self.processor.batch_decode(generated_ids, skip_special_tokens=True)[0]
        return text.strip(), latency


def _score(parsed: dict[str, Any], gt: dict[str, Any]) -> tuple[int, int, float, dict[str, int]]:
    correct = 0
    total = 0
    field_hits: dict[str, int] = {}
    for field in NUTRITION_FIELDS:
        gt_val = gt.get(field)
        if gt_val is None:
            continue
        total += 1
        hit = int(tolerant_value_match(parsed.get(field), gt_val, field))
        field_hits[field] = hit
        correct += hit
    return correct, total, correct / total if total else 0.0, field_hits


def _write_raw_text(out_dir: Path, method: str, dataset: str, image_id: str, text: str) -> str:
    raw_dir = out_dir / "trocr_raw_outputs" / _safe_name(method) / _safe_name(dataset)
    raw_dir.mkdir(parents=True, exist_ok=True)
    path = raw_dir / f"{_safe_name(image_id)}.txt"
    path.write_text(text or "", encoding="utf-8")
    return str(path)


def _prepare_eval_image(item: EvalItem, img: np.ndarray, out_dir: Path) -> tuple[np.ndarray, bool | str]:
    if not item.is_real:
        return img, ""
    cropped, ok = _crop_nutrition_label(
        img,
        debug_dir=str(out_dir / "trocr_real_crops"),
        image_name=item.image_id,
    )
    return cropped, ok


def _evaluate_full(
    engine: TrOCREngine,
    items: list[EvalItem],
    out_dir: Path,
) -> tuple[list[dict[str, Any]], list[dict[str, Any]]]:
    rows: list[dict[str, Any]] = []
    per_field_rows: list[dict[str, Any]] = []

    for idx, item in enumerate(items, start=1):
        img = _read_image(item.path)
        if img is None:
            continue
        eval_img, crop_success = _prepare_eval_image(item, img, out_dir)
        t0 = time.perf_counter()
        try:
            text, forward_latency = engine.read(eval_img, max_new_tokens=128)
            note = ""
        except Exception as exc:
            text = ""
            forward_latency = 0.0
            note = f"runtime error: {exc}"
            logger.warning("TrOCR full failed on %s: %s", item.image_id, exc)
        image_latency = time.perf_counter() - t0
        parsed = parse_synthetic_ocr(text)
        correct, total, acc, field_hits = _score(parsed, item.ground_truth)
        raw_path = _write_raw_text(out_dir, "TrOCR full panel", item.dataset, item.image_id, text)

        rows.append(
            {
                "method": "TrOCR full panel",
                "dataset": item.dataset,
                "image_id": item.image_id,
                "correct_fields": correct,
                "total_fields": total,
                "field_accuracy": acc,
                "latency_s": image_latency,
                "trocr_forward_latency_s": forward_latency,
                "n_forward_passes": 1 if text or not note else 0,
                "n_line_crops_processed": 0,
                "line_segmentation_success": "",
                "partial_due_to_crop_limit": False,
                "crop_success": crop_success,
                "raw_text_path": raw_path,
                "failure_notes": note,
            }
        )
        for field, hit in field_hits.items():
            per_field_rows.append(
                {
                    "method": "TrOCR full panel",
                    "dataset": item.dataset,
                    "image_id": item.image_id,
                    "field": field,
                    "correct": hit,
                    "total": 1,
                }
            )
        if idx % 10 == 0:
            logger.info("TrOCR full: %d/%d images", idx, len(items))

    return rows, per_field_rows


def _evaluate_line_segmented(
    engine: TrOCREngine,
    items: list[EvalItem],
    out_dir: Path,
    max_lines_per_image: int,
    budget: LineBudget,
) -> tuple[list[dict[str, Any]], list[dict[str, Any]]]:
    rows: list[dict[str, Any]] = []
    per_field_rows: list[dict[str, Any]] = []
    line_examples_dir = out_dir / "trocr_line_crops_examples"
    saved_examples = 0

    for idx, item in enumerate(items, start=1):
        if budget.remaining <= 0:
            budget.limit_reached = True
            logger.warning("Line-crop cap reached before %s; stopping line mode", item.image_id)
            break

        img = _read_image(item.path)
        if img is None:
            continue
        eval_img, crop_success = _prepare_eval_image(item, img, out_dir)
        crops = _segment_text_lines(eval_img, max_lines=max_lines_per_image)
        segmentation_success = bool(crops)
        partial = False

        if crops:
            if len(crops) > budget.remaining:
                crops = crops[: budget.remaining]
                partial = True
                budget.limit_reached = True
            budget.used += len(crops)
            line_images = [crop for crop, _box in crops]
        else:
            line_images = [eval_img]

        lines: list[str] = []
        forward_latencies: list[float] = []
        t0 = time.perf_counter()
        note = ""
        for line_idx, line_img in enumerate(line_images):
            if segmentation_success and saved_examples < 80:
                crop_dir = line_examples_dir / _safe_name(item.dataset)
                crop_dir.mkdir(parents=True, exist_ok=True)
                cv2.imwrite(
                    str(crop_dir / f"{_safe_name(item.image_id)}_line_{line_idx:02d}.png"),
                    line_img,
                )
                saved_examples += 1
            try:
                text, forward_latency = engine.read(line_img, max_new_tokens=64)
                forward_latencies.append(forward_latency)
                if text:
                    lines.append(text)
            except Exception as exc:
                note = f"runtime error on line {line_idx}: {exc}"
                logger.warning("TrOCR line failed on %s line %d: %s", item.image_id, line_idx, exc)
        image_latency = time.perf_counter() - t0

        if partial:
            note = (note + "; " if note else "") + "max-total-line-crops reached; partial image lines"
        if not segmentation_success:
            note = (note + "; " if note else "") + "line segmentation failed; used full image fallback"

        text = "\n".join(lines)
        parsed = parse_synthetic_ocr(text)
        correct, total, acc, field_hits = _score(parsed, item.ground_truth)
        raw_path = _write_raw_text(out_dir, "TrOCR line segmented", item.dataset, item.image_id, text)

        rows.append(
            {
                "method": "TrOCR line segmented",
                "dataset": item.dataset,
                "image_id": item.image_id,
                "correct_fields": correct,
                "total_fields": total,
                "field_accuracy": acc,
                "latency_s": image_latency,
                "trocr_forward_latency_s": float(np.mean(forward_latencies)) if forward_latencies else 0.0,
                "n_forward_passes": len(line_images),
                "n_line_crops_processed": len(crops) if segmentation_success else 0,
                "line_segmentation_success": segmentation_success,
                "partial_due_to_crop_limit": partial,
                "crop_success": crop_success,
                "raw_text_path": raw_path,
                "failure_notes": note,
            }
        )
        for field, hit in field_hits.items():
            per_field_rows.append(
                {
                    "method": "TrOCR line segmented",
                    "dataset": item.dataset,
                    "image_id": item.image_id,
                    "field": field,
                    "correct": hit,
                    "total": 1,
                }
            )

        if idx % 5 == 0:
            logger.info(
                "TrOCR line: %d/%d images, %d/%d line crops",
                idx,
                len(items),
                budget.used,
                budget.max_total,
            )
        if budget.limit_reached:
            break

    return rows, per_field_rows


def _summarize_images(rows: list[dict[str, Any]]) -> pd.DataFrame:
    if not rows:
        return pd.DataFrame(
            columns=[
                "method",
                "dataset",
                "mean_field_accuracy",
                "mean_latency_s",
                "mean_trocr_forward_latency_s",
                "n_images",
                "n_fields_evaluated",
                "n_forward_passes",
                "n_line_crops_processed",
                "partial_results",
                "failure_notes",
                "example_raw_text",
            ]
        )
    df = pd.DataFrame(rows)
    grouped = (
        df.groupby(["method", "dataset"], dropna=False)
        .agg(
            mean_field_accuracy=("field_accuracy", "mean"),
            mean_latency_s=("latency_s", "mean"),
            mean_trocr_forward_latency_s=("trocr_forward_latency_s", "mean"),
            n_images=("image_id", "count"),
            n_fields_evaluated=("total_fields", "sum"),
            n_forward_passes=("n_forward_passes", "sum"),
            n_line_crops_processed=("n_line_crops_processed", "sum"),
            partial_results=("partial_due_to_crop_limit", "max"),
            failure_notes=(
                "failure_notes",
                lambda values: "; ".join(sorted({str(v) for v in values if str(v)})),
            ),
            example_raw_text=("raw_text_path", "first"),
        )
        .reset_index()
    )
    return grouped


def _summarize_fields(rows: list[dict[str, Any]]) -> pd.DataFrame:
    if not rows:
        return pd.DataFrame(columns=["method", "dataset", "field", "correct", "total", "accuracy"])
    df = pd.DataFrame(rows)
    grouped = (
        df.groupby(["method", "dataset", "field"], dropna=False)
        .agg(correct=("correct", "sum"), total=("total", "sum"))
        .reset_index()
    )
    grouped["accuracy"] = grouped["correct"] / grouped["total"].clip(lower=1)
    return grouped


def run(args: argparse.Namespace) -> None:
    out_dir = Path(args.out)
    for subdir in [
        "trocr_raw_outputs",
        "trocr_line_crops_examples",
        "trocr_real_crops",
    ]:
        (out_dir / subdir).mkdir(parents=True, exist_ok=True)

    items = _load_synthetic_items(Path(args.synthetic), args.clean_sample, args.corrupted_sample)
    items.extend(_load_real_items(Path(args.real_images), Path(args.real_ground_truth), args.real_sample))
    logger.info("Loaded %d total benchmark images", len(items))

    engine = TrOCREngine(args.model, args.device)

    image_rows: list[dict[str, Any]] = []
    per_field_rows: list[dict[str, Any]] = []

    if args.mode in {"full", "both"}:
        rows, fields = _evaluate_full(engine, items, out_dir)
        image_rows.extend(rows)
        per_field_rows.extend(fields)

    if args.mode in {"line", "both"}:
        budget = LineBudget(max_total=args.max_total_line_crops)
        rows, fields = _evaluate_line_segmented(
            engine,
            items,
            out_dir,
            max_lines_per_image=args.max_lines_per_image,
            budget=budget,
        )
        image_rows.extend(rows)
        per_field_rows.extend(fields)
        if budget.limit_reached:
            logger.warning(
                "Line benchmark stopped at %d/%d line crops; results are partial",
                budget.used,
                budget.max_total,
            )

    per_image_df = pd.DataFrame(image_rows)
    per_field_df = _summarize_fields(per_field_rows)
    summary_df = _summarize_images(image_rows)

    per_image_df.to_csv(out_dir / "trocr_per_image_results.csv", index=False)
    per_field_df.to_csv(out_dir / "trocr_per_field_results.csv", index=False)
    summary_df.to_csv(out_dir / "trocr_benchmark_results.csv", index=False)

    run_meta = {
        "model": args.model,
        "mode": args.mode,
        "clean_sample": args.clean_sample,
        "corrupted_sample": args.corrupted_sample,
        "real_sample": args.real_sample,
        "max_lines_per_image": args.max_lines_per_image,
        "max_total_line_crops": args.max_total_line_crops,
        "device": args.device,
        "n_images_loaded": len(items),
        "n_images_evaluated": int(len(per_image_df)),
    }
    (out_dir / "trocr_run_metadata.json").write_text(
        json.dumps(run_meta, indent=2),
        encoding="utf-8",
    )
    logger.info("Wrote TrOCR benchmark artifacts to %s", out_dir)


def main() -> None:
    parser = argparse.ArgumentParser(description="Limited TrOCR benchmark")
    parser.add_argument("--synthetic", required=True, help="Synthetic OCR data root")
    parser.add_argument("--real-images", required=True, help="Directory containing NL*.jpg")
    parser.add_argument("--real-ground-truth", required=True, help="Real-image ground-truth JSON")
    parser.add_argument("--out", required=True, help="Clean final output directory")
    parser.add_argument("--clean-sample", type=int, default=25)
    parser.add_argument("--corrupted-sample", type=int, default=50)
    parser.add_argument("--real-sample", type=int, default=30)
    parser.add_argument("--mode", choices=["full", "line", "both"], default="both")
    parser.add_argument("--max-lines-per-image", type=int, default=15)
    parser.add_argument("--max-total-line-crops", type=int, default=300)
    parser.add_argument("--device", choices=["auto", "cpu", "cuda"], default="cpu")
    parser.add_argument("--model", default="microsoft/trocr-base-printed")
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
    run(args)


if __name__ == "__main__":
    main()
