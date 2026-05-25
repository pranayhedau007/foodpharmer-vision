"""Build clean final OCR V2 presentation outputs.

This script assembles prior Tesseract and FieldConfidenceNet-Lite results,
the bounded TrOCR benchmark, and the small vision quality model into one
presentation-oriented output directory. U-Net is documented only in an archive
note and is excluded from main tables/charts.
"""

from __future__ import annotations

import argparse
import json
import shutil
from pathlib import Path
from typing import Any

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd


COLOR_TESS = "#2B7A3D"
COLOR_OPENCV = "#C26A2E"
COLOR_TROCR_FULL = "#2F6F9F"
COLOR_TROCR_LINE = "#6A4C93"
COLOR_GRAY = "#666666"
COLOR_ACCENT = "#B21E4B"


def _pct(value: Any, digits: int = 1) -> str:
    try:
        if pd.isna(value):
            return "n/a"
        return f"{100 * float(value):.{digits}f}%"
    except Exception:
        return "n/a"


def _seconds(value: Any) -> str:
    try:
        if pd.isna(value):
            return "n/a"
        return f"{float(value):.3f}s"
    except Exception:
        return "n/a"


def _read_json(path: Path) -> dict[str, Any]:
    if not path.exists():
        return {}
    return json.loads(path.read_text(encoding="utf-8"))


def _ensure_dirs(out_dir: Path) -> None:
    for subdir in [
        "",
        "archive",
        "trocr_raw_outputs",
        "trocr_line_crops_examples",
        "small_vision_quality",
    ]:
        (out_dir / subdir).mkdir(parents=True, exist_ok=True)


def _copy_small_vision_outputs(out_dir: Path) -> tuple[dict[str, Any], pd.DataFrame]:
    small_dir = out_dir / "small_vision_quality"
    metrics = _read_json(small_dir / "small_vision_quality_metrics.json")
    sweep_path = small_dir / "small_vision_quality_threshold_sweep.csv"
    predictions_path = small_dir / "small_vision_quality_predictions.csv"

    if metrics:
        (out_dir / "small_vision_quality_metrics.json").write_text(
            json.dumps(metrics, indent=2),
            encoding="utf-8",
        )
    if sweep_path.exists():
        shutil.copyfile(sweep_path, out_dir / "small_vision_quality_threshold_sweep.csv")
    if predictions_path.exists():
        shutil.copyfile(predictions_path, out_dir / "small_vision_quality_predictions.csv")

    sweep = pd.read_csv(sweep_path) if sweep_path.exists() else pd.DataFrame()
    return metrics, sweep


def _summarize_field_confidence(previous_dir: Path, out_dir: Path) -> tuple[dict[str, Any], pd.DataFrame]:
    metrics_path = previous_dir / "field_confidence_lite" / "field_confidence_metrics.json"
    if not metrics_path.exists():
        metrics_path = previous_dir / "field_confidence_metrics.json"
    metrics = _read_json(metrics_path)

    sweep_path = previous_dir / "field_confidence_lite" / "field_confidence_threshold_sweep.csv"
    if not sweep_path.exists():
        sweep_path = previous_dir / "field_confidence_threshold_sweep.csv"
    sweep = pd.read_csv(sweep_path) if sweep_path.exists() else pd.DataFrame()

    real_metrics = _read_json(
        previous_dir / "field_confidence_lite" / "real_eval" / "real_field_confidence_metrics.json"
    )

    threshold_95: dict[str, Any] = {}
    if not sweep.empty:
        t95 = sweep[np.isclose(pd.to_numeric(sweep["threshold"], errors="coerce"), 0.95)]
        if not t95.empty:
            row = t95.iloc[0]
            threshold_95 = {
                "coverage_percent": float(row.get("coverage_percent", np.nan)),
                "accepted_accuracy": float(row.get("accepted_accuracy", np.nan)),
                "n_accepted": int(row.get("n_accepted", 0)),
                "n_rejected": int(row.get("n_rejected", 0)),
            }

    test = metrics.get("test", {}) if metrics else {}
    summary = {
        "source_metrics": str(metrics_path),
        "test_auroc": test.get("auroc"),
        "test_auprc": test.get("auprc"),
        "test_ece": test.get("ece"),
        "threshold_0_95": threshold_95,
        "real_photo_auroc": real_metrics.get("auroc"),
        "real_photo_auprc": real_metrics.get("auprc"),
        "real_photo_n_fields": real_metrics.get("n_fields", real_metrics.get("n")),
        "readout": (
            "FieldConfidenceNet-Lite remains the strongest trained model: "
            "it predicts per-field correctness after OCR and supports accept/verify decisions."
        ),
    }
    (out_dir / "field_confidence_lite_summary.json").write_text(
        json.dumps(summary, indent=2),
        encoding="utf-8",
    )

    slide_thresholds_path = previous_dir / "slide_ready_field_confidence_thresholds.csv"
    if slide_thresholds_path.exists():
        slide = pd.read_csv(slide_thresholds_path)
    elif not sweep.empty:
        slide = sweep[sweep["threshold"].isin([0.50, 0.70, 0.85, 0.95])].copy()
        notes = {
            0.50: "Default classifier threshold; high coverage.",
            0.70: "Balanced verify threshold.",
            0.85: "App accept threshold.",
            0.95: "Headline result: high correctness among accepted fields.",
        }
        slide["presentation_note"] = slide["threshold"].map(notes)
    else:
        slide = pd.DataFrame()
    slide.to_csv(out_dir / "field_confidence_lite_slide_thresholds.csv", index=False)
    return summary, slide


def _build_clean_ocr_table(previous_dir: Path, out_dir: Path) -> pd.DataFrame:
    rows: list[dict[str, Any]] = []

    previous_strategy = previous_dir / "ocr_strategy_comparison.csv"
    if previous_strategy.exists():
        prev = pd.read_csv(previous_strategy)
        prev["method_str"] = prev["method"].astype(str)
        keep = prev["method_str"].str.contains("Tesseract|OpenCV", case=False, na=False)
        exclude = prev["method_str"].str.contains("U-Net|EasyOCR|negative ablation", case=False, na=False)
        prev = prev[keep & ~exclude].copy()
        for row in prev.to_dict("records"):
            rows.append(
                {
                    "method": row.get("method"),
                    "dataset": row.get("dataset"),
                    "mean_field_accuracy": row.get("mean_field_accuracy"),
                    "mean_latency_s": row.get("mean_latency_s"),
                    "mean_trocr_forward_latency_s": np.nan,
                    "n_images": row.get("n_images"),
                    "n_fields_evaluated": row.get("n_fields_evaluated"),
                    "n_forward_passes": np.nan,
                    "n_line_crops_processed": 0,
                    "partial_results": False,
                    "failure_notes": row.get("failure_notes", ""),
                    "source": "previous final OCR comparison",
                }
            )

    trocr_path = out_dir / "trocr_benchmark_results.csv"
    if trocr_path.exists():
        trocr = pd.read_csv(trocr_path)
        for row in trocr.to_dict("records"):
            rows.append(
                {
                    "method": row.get("method"),
                    "dataset": row.get("dataset"),
                    "mean_field_accuracy": row.get("mean_field_accuracy"),
                    "mean_latency_s": row.get("mean_latency_s"),
                    "mean_trocr_forward_latency_s": row.get("mean_trocr_forward_latency_s"),
                    "n_images": row.get("n_images"),
                    "n_fields_evaluated": row.get("n_fields_evaluated"),
                    "n_forward_passes": row.get("n_forward_passes"),
                    "n_line_crops_processed": row.get("n_line_crops_processed"),
                    "partial_results": row.get("partial_results"),
                    "failure_notes": row.get("failure_notes", ""),
                    "source": "bounded TrOCR benchmark",
                }
            )

    df = pd.DataFrame(rows)
    if df.empty:
        df = pd.DataFrame(
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
                "source",
            ]
        )
    df.to_csv(out_dir / "ocr_accuracy_latency_clean.csv", index=False)

    slide_rows: list[dict[str, Any]] = []
    dataset_labels = {
        "clean_synthetic": "clean synthetic medium sample",
        "corrupted_synthetic": "corrupted synthetic medium sample",
        "real_photos": "real 30 photos",
    }
    for row in df.to_dict("records"):
        method = str(row.get("method", ""))
        dataset = str(row.get("dataset", ""))
        note = ""
        if method == "Tesseract" and dataset == "corrupted_synthetic":
            note = "Best practical OCR engine on corrupted synthetic labels."
        elif method == "Tesseract" and dataset == "real_photos":
            note = "Best prior real-photo OCR baseline in the final comparison."
        elif "OpenCV" in method:
            note = "Classical preprocessing/cropping baseline."
        elif "TrOCR" in method:
            note = "Official transformer OCR baseline, bounded sample."
        slide_rows.append(
            {
                "method": method,
                "dataset_label": dataset_labels.get(dataset, dataset),
                "field_accuracy": _pct(row.get("mean_field_accuracy")),
                "mean_latency_s": _seconds(row.get("mean_latency_s")),
                "n_images": row.get("n_images", ""),
                "slide_note": note,
            }
        )
    pd.DataFrame(slide_rows).to_csv(out_dir / "slide_ready_results_table.csv", index=False)
    return df


def _make_ocr_strategy_chart(df: pd.DataFrame, out_dir: Path) -> None:
    if df.empty:
        return
    plot_df = df.copy()
    plot_df["mean_field_accuracy"] = pd.to_numeric(plot_df["mean_field_accuracy"], errors="coerce")
    plot_df["mean_latency_s"] = pd.to_numeric(plot_df["mean_latency_s"], errors="coerce")
    plot_df = plot_df[
        plot_df["mean_field_accuracy"].notna()
        & plot_df["mean_latency_s"].notna()
        & ~plot_df["method"].astype(str).str.contains("U-Net|EasyOCR", case=False, na=False)
    ].copy()
    if plot_df.empty:
        return
    plot_df["acc_pct"] = 100 * plot_df["mean_field_accuracy"]
    plot_df = plot_df.sort_values(["method", "dataset"]).reset_index(drop=True)
    plot_df["marker_num"] = np.arange(1, len(plot_df) + 1)

    def color_for(method: str) -> str:
        method_l = method.lower()
        if "trocr line" in method_l:
            return COLOR_TROCR_LINE
        if "trocr" in method_l:
            return COLOR_TROCR_FULL
        if "opencv" in method_l:
            return COLOR_OPENCV
        return COLOR_TESS

    fig = plt.figure(figsize=(12.5, 6.5))
    gs = fig.add_gridspec(1, 2, width_ratios=[1.55, 1.0], wspace=0.05)
    ax = fig.add_subplot(gs[0, 0])
    ax_table = fig.add_subplot(gs[0, 1])

    for _, row in plot_df.iterrows():
        ax.scatter(
            row["mean_latency_s"],
            row["acc_pct"],
            s=300,
            color=color_for(str(row["method"])),
            edgecolor="white",
            linewidth=2.0,
            zorder=3,
        )
        ax.text(
            row["mean_latency_s"],
            row["acc_pct"],
            str(int(row["marker_num"])),
            ha="center",
            va="center",
            color="white",
            fontweight="bold",
            fontsize=10,
            zorder=4,
        )

    ax.set_title("OCR Strategy Comparison: Accuracy vs Latency", loc="left", fontweight="bold")
    ax.set_xlabel("Mean latency per image (seconds)")
    ax.set_ylabel("Field extraction accuracy (%)")
    ax.set_ylim(-5, 105)
    ax.set_xlim(max(0, plot_df["mean_latency_s"].min() - 0.1), plot_df["mean_latency_s"].max() + 0.35)
    ax.grid(True, alpha=0.25)

    ax_table.axis("off")
    ax_table.set_xlim(0, 1)
    ax_table.set_ylim(0, 1)
    ax_table.text(0.03, 0.98, "Legend", va="top", fontweight="bold", fontsize=12)
    y = 0.90
    step = min(0.075, 0.78 / max(len(plot_df), 1))
    for _, row in plot_df.iterrows():
        method = str(row["method"])
        dataset = str(row["dataset"]).replace("_", " ")
        color = color_for(method)
        ax_table.scatter(0.06, y, s=220, color=color, edgecolor="white", linewidth=1.5)
        ax_table.text(0.06, y, str(int(row["marker_num"])), ha="center", va="center", color="white", fontweight="bold", fontsize=8)
        ax_table.text(0.13, y, method, va="center", fontsize=9)
        ax_table.text(0.66, y, dataset, va="center", fontsize=9, color=COLOR_GRAY)
        y -= step

    fig.savefig(out_dir / "ocr_strategy_accuracy_latency_clean.png", bbox_inches="tight", facecolor="white", dpi=200)
    plt.close(fig)


def _make_field_confidence_chart(slide_thresholds: pd.DataFrame, out_dir: Path) -> None:
    if slide_thresholds.empty:
        return
    sweep = slide_thresholds.copy()
    sweep["threshold"] = pd.to_numeric(sweep["threshold"], errors="coerce")
    sweep["coverage_percent"] = pd.to_numeric(sweep["coverage_percent"], errors="coerce")
    sweep["accepted_accuracy"] = pd.to_numeric(sweep["accepted_accuracy"], errors="coerce")
    sweep = sweep.dropna(subset=["threshold", "coverage_percent", "accepted_accuracy"])
    if sweep.empty:
        return

    fig, ax1 = plt.subplots(figsize=(8.5, 5.4))
    ax1.plot(sweep["threshold"], sweep["coverage_percent"], marker="o", color=COLOR_TROCR_FULL, linewidth=2.2, label="Coverage")
    ax1.set_xlabel("Confidence threshold")
    ax1.set_ylabel("Accepted fields (%)", color=COLOR_TROCR_FULL)
    ax1.tick_params(axis="y", labelcolor=COLOR_TROCR_FULL)
    ax1.set_ylim(0, 105)
    ax1.grid(True, alpha=0.25)

    ax2 = ax1.twinx()
    ax2.plot(sweep["threshold"], 100 * sweep["accepted_accuracy"], marker="s", color=COLOR_TESS, linewidth=2.2, label="Accepted correctness")
    ax2.set_ylabel("Correctness among accepted fields (%)", color=COLOR_TESS)
    ax2.tick_params(axis="y", labelcolor=COLOR_TESS)
    ax2.set_ylim(0, 105)

    t95 = sweep[np.isclose(sweep["threshold"], 0.95)]
    if not t95.empty:
        row = t95.iloc[0]
        ax1.axvline(0.95, linestyle=":", color=COLOR_ACCENT, linewidth=1.5)
        ax1.annotate(
            f"0.95 threshold\n{row['coverage_percent']:.1f}% coverage\n{100 * row['accepted_accuracy']:.1f}% correct",
            xy=(0.95, row["coverage_percent"]),
            xytext=(0.54, 24),
            textcoords="data",
            color=COLOR_ACCENT,
            fontweight="bold",
            arrowprops={"arrowstyle": "->", "color": COLOR_ACCENT},
            bbox={"boxstyle": "round,pad=0.4", "facecolor": "white", "edgecolor": COLOR_ACCENT},
        )
    ax1.set_title("FieldConfidenceNet-Lite Threshold Sweep", loc="left", fontweight="bold")
    fig.tight_layout()
    fig.savefig(out_dir / "field_confidence_threshold_sweep_clean.png", bbox_inches="tight", facecolor="white", dpi=200)
    plt.close(fig)


def _make_small_vision_chart(sweep: pd.DataFrame, out_dir: Path) -> None:
    if sweep.empty:
        return
    df = sweep.copy()
    for col in ["threshold", "coverage", "accepted_ocr_accuracy", "rejected_ocr_accuracy"]:
        df[col] = pd.to_numeric(df[col], errors="coerce")
    df = df.dropna(subset=["threshold", "coverage"])
    if df.empty:
        return

    fig, ax1 = plt.subplots(figsize=(8.5, 5.4))
    ax1.plot(df["threshold"], 100 * df["coverage"], marker="o", color=COLOR_TROCR_FULL, linewidth=2.2, label="Coverage")
    ax1.set_xlabel("Predicted-good confidence threshold")
    ax1.set_ylabel("Images accepted (%)", color=COLOR_TROCR_FULL)
    ax1.tick_params(axis="y", labelcolor=COLOR_TROCR_FULL)
    ax1.set_ylim(0, 105)
    ax1.grid(True, alpha=0.25)

    ax2 = ax1.twinx()
    if df["accepted_ocr_accuracy"].notna().any():
        ax2.plot(df["threshold"], 100 * df["accepted_ocr_accuracy"], marker="s", color=COLOR_TESS, linewidth=2.2, label="Accepted OCR accuracy")
    if df["rejected_ocr_accuracy"].notna().any():
        ax2.plot(df["threshold"], 100 * df["rejected_ocr_accuracy"], marker="^", color=COLOR_GRAY, linewidth=1.8, linestyle="--", label="Rejected OCR accuracy")
    ax2.set_ylabel("Mean OCR field accuracy (%)", color=COLOR_TESS)
    ax2.tick_params(axis="y", labelcolor=COLOR_TESS)
    ax2.set_ylim(0, 105)
    ax1.set_title("Small Vision Quality Model Threshold Sweep", loc="left", fontweight="bold")
    fig.tight_layout()
    fig.savefig(out_dir / "small_vision_quality_threshold_sweep.png", bbox_inches="tight", facecolor="white", dpi=200)
    plt.close(fig)


def _write_unet_archive_note(out_dir: Path) -> None:
    text = """# U-Net Negative Ablation Note

A U-Net preprocessor was trained and tested, but it did not improve OCR. It is
excluded from the main comparison because the final story focuses on viable OCR
strategies and reliability models. Existing details remain in older output
folders for backup/Q&A.

Key result:
- best U-Net blend: 54.75%
- raw Tesseract on same sample: 66.88%
"""
    (out_dir / "archive" / "unet_negative_ablation_note.md").write_text(text, encoding="utf-8")


def _write_mermaid(out_dir: Path) -> None:
    text = """# Mermaid Diagrams V2

## Final OCR pipeline

```mermaid
flowchart LR
  A[Product photo] --> B[Image quality model]
  B --> C[Tesseract OCR]
  C --> D[Nutrition parser]
  D --> E[FieldConfidenceNet-Lite]
  E --> F{Accept / verify / retake}
  F --> G[Scoring model]
```

## OCR benchmark

```mermaid
flowchart LR
  A[Same datasets] --> B[Tesseract]
  A --> C[TrOCR full panel]
  A --> D[TrOCR line segmented]
  B --> E[Compare accuracy + latency]
  C --> E
  D --> E
```

## Small vision model

```mermaid
flowchart LR
  A[Corrupted label image] --> B[MobileNetV3-small]
  B --> C[MLP classifier head]
  C --> D[Good / medium / bad OCR quality]
```

## FieldConfidenceNet-Lite

```mermaid
flowchart LR
  A[Tesseract text + field identity + parsed value features] --> B[MLP]
  B --> C[P(field correct)]
```
"""
    (out_dir / "mermaid_diagrams_v2.md").write_text(text, encoding="utf-8")


def _write_inventory(out_dir: Path) -> None:
    text = """# Code Cleanup Inventory

## 1. Final files to present/use

- `ml/ocr/neural/evaluation/benchmark_trocr_limited.py`
- `ml/ocr/neural/training/train_small_vision_quality.py`
- `ml/ocr/neural/evaluation/build_final_ocr_v2_clean_outputs.py`
- `ml/ocr/neural/field_confidence_lite.py`
- `ml/ocr/neural/outputs/final_ocr_v2_clean/`
- `md/ocr_final_v2_readme.md`

## 2. Historical files to keep as backup

- Prior final comparison outputs under `ml/ocr/neural/outputs/final_ocr_strategy_comparison/`
- Earlier OCR evaluation scripts and debug reports
- Rescue/debug U-Net output folders for Q&A only

## 3. Generated data/results that should not be committed

- `ml/ocr/neural/outputs/`
- trained `.pt` checkpoints under output folders
- raw OCR text dumps and line crop examples
- large synthetic datasets and cached model downloads

## 4. U-Net files to keep but not foreground

- `ml/ocr/neural/models/tiny_unet.py`
- `ml/ocr/neural/training/train_preprocessor.py`
- U-Net checkpoints and rescue/debug output folders

## 5. Recommended .gitignore additions

- `data/synthetic_ocr_medium/`
- `**/small_vision_quality_mobilenet_v3_small.pt`
- `**/trocr_raw_outputs/`
- `**/trocr_line_crops_examples/`

## 6. Recommended future cleanup after deadline

- Consolidate duplicate OCR comparison scripts after the presentation.
- Move private helper functions used across evaluations into a shared utility module.
- Add a small smoke test for parser scoring and line segmentation.
"""
    (out_dir / "code_cleanup_inventory.md").write_text(text, encoding="utf-8")


def _metric_text(value: Any, digits: int = 3) -> str:
    try:
        if value is None or pd.isna(value):
            return "not available"
        return f"{float(value):.{digits}f}"
    except Exception:
        return "not available"


def _best_trocr_rows(ocr_df: pd.DataFrame) -> tuple[str, str]:
    if ocr_df.empty:
        return "TrOCR benchmark has not been run yet.", ""
    trocr = ocr_df[ocr_df["method"].astype(str).str.contains("TrOCR", case=False, na=False)].copy()
    if trocr.empty:
        return "TrOCR benchmark has not been run yet.", ""
    trocr["mean_field_accuracy"] = pd.to_numeric(trocr["mean_field_accuracy"], errors="coerce")
    rows = []
    for _, row in trocr.sort_values(["method", "dataset"]).iterrows():
        rows.append(
            f"- {row['method']} on {str(row['dataset']).replace('_', ' ')}: "
            f"{_pct(row['mean_field_accuracy'])}, latency {_seconds(row.get('mean_latency_s'))}, "
            f"n={row.get('n_images', '')}"
        )
    return "Bounded TrOCR benchmark results:", "\n".join(rows)


def _write_summary(
    out_dir: Path,
    ocr_df: pd.DataFrame,
    field_summary: dict[str, Any],
    small_metrics: dict[str, Any],
) -> None:
    trocr_intro, trocr_rows = _best_trocr_rows(ocr_df)
    small_test = small_metrics.get("test", {}) if small_metrics else {}
    t95 = field_summary.get("threshold_0_95", {})
    t95_coverage = "not available"
    if t95.get("coverage_percent") is not None:
        t95_coverage = f"{float(t95.get('coverage_percent')):.1f}%"
    real_n = field_summary.get("real_photo_n_fields")
    real_suffix = f" over {int(real_n)} fields" if real_n else ""

    text = f"""# Final OCR V2 Summary

## 1. OCR Strategy Selection

We compared Tesseract, OpenCV preprocessing, and official TrOCR. Tesseract
remained the most practical engine for structured nutrition-label extraction:
the prior final comparison reported about 99.1% field accuracy on clean
synthetic labels, 83.9% on corrupted synthetic labels, and 58.9% on 30 real
photos. TrOCR was evaluated as a transformer OCR baseline with bounded samples.

{trocr_intro}
{trocr_rows}

## 2. Small Vision Quality Model

We trained a small MobileNetV3-based vision quality model to predict whether an
input image is likely to produce reliable OCR. It is image-only and operates at
the image quality level, before field-level correction.

- Test classification accuracy: {_metric_text(small_test.get('classification_accuracy'))}
- Test macro F1: {_metric_text(small_test.get('macro_f1'))}
- Good-vs-not-good AUROC: {_metric_text(small_test.get('auroc_good_vs_not_good'))}
- Mean OCR field accuracy on test images: {_pct(small_test.get('all_image_mean_ocr_accuracy'))}
- Readout: {small_metrics.get('success_readout', 'not available') if small_metrics else 'not available'}

## 3. FieldConfidenceNet-Lite

We trained a per-field confidence model that predicts whether each extracted
nutrition field is correct after OCR and parsing.

- Synthetic test AUROC: {_metric_text(field_summary.get('test_auroc'))}
- Synthetic test AUPRC: {_metric_text(field_summary.get('test_auprc'))}
- Synthetic ECE: {_metric_text(field_summary.get('test_ece'))}
- Threshold 0.95 coverage: {t95_coverage}
- Threshold 0.95 accepted correctness: {_pct(t95.get('accepted_accuracy'))}
- Real-photo AUROC: {_metric_text(field_summary.get('real_photo_auroc'))}{real_suffix}

## 4. Final App Logic

1. Optional image-quality model warns if image quality is poor.
2. Tesseract OCR reads the label.
3. Parser extracts nutrition fields.
4. FieldConfidenceNet-Lite labels each field accept / verify / correct.
5. Verified fields are sent to the scoring model.

## 5. Backup U-Net Note

A U-Net preprocessor was tested but excluded from main results because it was
not a viable OCR strategy. The backup note is in
`archive/unet_negative_ablation_note.md`.
"""
    (out_dir / "final_ocr_v2_summary.md").write_text(text, encoding="utf-8")


def _write_slide_bullets(out_dir: Path, field_summary: dict[str, Any], small_metrics: dict[str, Any]) -> None:
    small_test = small_metrics.get("test", {}) if small_metrics else {}
    t95 = field_summary.get("threshold_0_95", {})
    t95_coverage = "not available"
    if t95.get("coverage_percent") is not None:
        t95_coverage = f"{float(t95.get('coverage_percent')):.1f}%"
    real_n = field_summary.get("real_photo_n_fields")
    real_suffix = f" over {int(real_n)} fields" if real_n else " over the saved real-field evaluation"
    text = f"""# Presentation Slide Bullets V2

## Slide 1: OCR Reliability Problem

- Nutrition OCR errors can change downstream health scores.
- The final system needs extracted fields plus uncertainty, not just raw text.
- We evaluated OCR engines and then added neural reliability layers.

## Slide 2: OCR Engine Benchmark - Tesseract vs TrOCR

- Tesseract remained the best practical OCR engine for structured nutrition labels.
- Prior final comparison: 99.1% clean synthetic, 83.9% corrupted synthetic, 58.9% real photos.
- TrOCR was benchmarked as an official transformer OCR baseline with bounded samples.

## Slide 3: Small Vision Quality Model

- MobileNetV3-small predicts bad / medium / good OCR quality from the image.
- Test accuracy: {_metric_text(small_test.get('classification_accuracy'))}; macro F1: {_metric_text(small_test.get('macro_f1'))}.
- Purpose: warn or gate poor image inputs before trusting OCR fields.

## Slide 4: FieldConfidenceNet-Lite Per-Field Confidence

- Predicts whether each parsed field is correct using OCR text and field features.
- Synthetic test AUROC: {_metric_text(field_summary.get('test_auroc'))}; AUPRC: {_metric_text(field_summary.get('test_auprc'))}; ECE: {_metric_text(field_summary.get('test_ece'))}.
- At threshold 0.95, accepts {t95_coverage} of fields at {_pct(t95.get('accepted_accuracy'))} correctness.
- Real-photo AUROC: {_metric_text(field_summary.get('real_photo_auroc'))}{real_suffix}.

## Slide 5: Final App Integration and Results

- Image quality model estimates whether the photo is OCR-ready.
- Tesseract reads the label and the parser extracts nutrition fields.
- FieldConfidenceNet-Lite marks fields as accept, verify, or correct.
- Final result: an uncertainty-aware OCR pipeline instead of blind OCR trust.
"""
    (out_dir / "presentation_slide_bullets_v2.md").write_text(text, encoding="utf-8")


def _write_readme(out_dir: Path, md_dir: Path) -> None:
    md_dir.mkdir(parents=True, exist_ok=True)
    out_rel = "ml/ocr/neural/outputs/final_ocr_v2_clean"
    text = f"""# OCR Final V2 Readme

## Story

The final OCR V2 story is: benchmark OCR engines, keep Tesseract as the most
practical nutrition-label OCR engine, and add two neural reliability layers:
an image-level MobileNetV3 quality model and FieldConfidenceNet-Lite for
per-field correctness.

## Output Directory

Final clean outputs live in:

```text
{out_rel}
```

## Rerun TrOCR Benchmark

```powershell
python -m ml.ocr.neural.evaluation.benchmark_trocr_limited `
  --synthetic data/synthetic_ocr_medium `
  --real-images "C:\\Users\\sherw\\OneDrive\\Desktop\\CS274\\Nutrition-Labels" `
  --real-ground-truth "C:\\Users\\sherw\\OneDrive\\Desktop\\CS274\\Nutrition-Labels\\real_ground_truth_001_030.json" `
  --out {out_rel} `
  --clean-sample 25 `
  --corrupted-sample 50 `
  --real-sample 30 `
  --mode both `
  --max-lines-per-image 15 `
  --max-total-line-crops 300 `
  --device cpu
```

## Train Small Vision Quality Model

```powershell
python -m ml.ocr.neural.training.train_small_vision_quality `
  --data data/synthetic_ocr_medium `
  --out {out_rel}/small_vision_quality `
  --max-images 400 `
  --img-size 224 `
  --epochs 10 `
  --batch-size 16 `
  --backbone mobilenet_v3_small `
  --cpu
```

## Refresh Summary and Charts

```powershell
python -m ml.ocr.neural.evaluation.build_final_ocr_v2_clean_outputs `
  --out {out_rel}
```

## FieldConfidenceNet-Lite

FieldConfidenceNet-Lite results are copied from
`ml/ocr/neural/outputs/final_ocr_strategy_comparison/` into the clean final
directory. Read `field_confidence_lite_summary.json` and
`field_confidence_lite_slide_thresholds.csv` for slide values.
"""
    (md_dir / "ocr_final_v2_readme.md").write_text(text, encoding="utf-8")


def run(args: argparse.Namespace) -> None:
    out_dir = Path(args.out)
    previous_dir = Path(args.previous)
    md_dir = Path(args.md_dir)
    _ensure_dirs(out_dir)

    small_metrics, small_sweep = _copy_small_vision_outputs(out_dir)
    field_summary, field_slide = _summarize_field_confidence(previous_dir, out_dir)
    ocr_df = _build_clean_ocr_table(previous_dir, out_dir)

    _make_ocr_strategy_chart(ocr_df, out_dir)
    _make_field_confidence_chart(field_slide, out_dir)
    _make_small_vision_chart(small_sweep, out_dir)

    _write_unet_archive_note(out_dir)
    _write_mermaid(out_dir)
    _write_inventory(out_dir)
    _write_summary(out_dir, ocr_df, field_summary, small_metrics)
    _write_slide_bullets(out_dir, field_summary, small_metrics)
    _write_readme(out_dir, md_dir)


def main() -> None:
    parser = argparse.ArgumentParser(description="Build clean final OCR V2 outputs")
    parser.add_argument("--out", default="ml/ocr/neural/outputs/final_ocr_v2_clean")
    parser.add_argument(
        "--previous",
        default="ml/ocr/neural/outputs/final_ocr_strategy_comparison",
        help="Existing final OCR comparison output directory",
    )
    parser.add_argument("--md-dir", default="md")
    args = parser.parse_args()
    run(args)


if __name__ == "__main__":
    main()
