"""Final OCR strategy comparison report writer."""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any

import pandas as pd


def _fmt_pct(value: Any) -> str:
    if value is None or value == "":
        return "n/a"
    try:
        if pd.isna(value):
            return "n/a"
        return f"{100 * float(value):.1f}%"
    except (TypeError, ValueError):
        return "n/a"


def _fmt_latency(value: Any) -> str:
    if value is None or value == "":
        return "n/a"
    try:
        if pd.isna(value):
            return "n/a"
        return f"{float(value):.3f}s"
    except (TypeError, ValueError):
        return "n/a"


def _load_csv(path: Path) -> pd.DataFrame:
    if not path.exists():
        return pd.DataFrame()
    return pd.read_csv(path)


def _load_metrics(out_dir: Path) -> dict[str, Any] | None:
    candidates = [
        out_dir / "field_confidence_metrics.json",
        out_dir / "field_confidence_lite" / "field_confidence_metrics.json",
    ]
    for path in candidates:
        if path.exists():
            with path.open("r", encoding="utf-8") as fh:
                return json.load(fh)
    return None


def _best_threshold_line(sweep: pd.DataFrame) -> str:
    if sweep.empty or "accepted_accuracy" not in sweep:
        return "Threshold sweep not available yet."
    scored = sweep.copy()
    scored["accepted_accuracy"] = pd.to_numeric(scored["accepted_accuracy"], errors="coerce")
    scored["coverage_percent"] = pd.to_numeric(scored["coverage_percent"], errors="coerce")
    scored = scored.dropna(subset=["accepted_accuracy", "coverage_percent"])
    if scored.empty:
        return "Threshold sweep did not contain valid accepted-field accuracy."
    practical = scored[scored["coverage_percent"] >= 10]
    if practical.empty:
        practical = scored
    row = practical.sort_values(["accepted_accuracy", "coverage_percent"], ascending=False).iloc[0]
    rejected = _fmt_pct(row.get("rejected_accuracy"))
    return (
        f"At threshold {row['threshold']:.2f}, the model accepts "
        f"{row['coverage_percent']:.1f}% of fields; accepted fields are "
        f"{_fmt_pct(row['accepted_accuracy'])} correct and rejected fields are "
        f"{rejected} correct."
    )


def write_final_reports(out_dir: str | Path) -> None:
    """Write final_ocr_comparison_summary.md and presentation_slide_bullets.md."""
    root = Path(out_dir)
    root.mkdir(parents=True, exist_ok=True)

    summary_csv = root / "ocr_strategy_comparison.csv"
    latency_csv = root / "latency_summary.csv"
    threshold_csv = root / "field_confidence_threshold_sweep.csv"
    per_field_csv = root / "field_confidence_per_field.csv"
    if not threshold_csv.exists():
        threshold_csv = root / "field_confidence_lite" / "field_confidence_threshold_sweep.csv"
    if not per_field_csv.exists():
        per_field_csv = root / "field_confidence_lite" / "field_confidence_per_field.csv"

    strategy = _load_csv(summary_csv)
    latency = _load_csv(latency_csv)
    sweep = _load_csv(threshold_csv)
    per_field = _load_csv(per_field_csv)
    metrics = _load_metrics(root)

    summary_path = root / "final_ocr_comparison_summary.md"
    with summary_path.open("w", encoding="utf-8") as fh:
        fh.write("# Final OCR Strategy Comparison\n\n")
        fh.write("## 1. OCR Strategy Comparison\n\n")
        fh.write("| Method | Dataset | Field Accuracy | Latency | Notes |\n")
        fh.write("|---|---|---:|---:|---|\n")
        if strategy.empty:
            fh.write("| Pending | Pending | n/a | n/a | Run final_ocr_strategy_comparison.py. |\n")
        else:
            for _, row in strategy.iterrows():
                notes = str(row.get("failure_notes", "") or "")
                if not notes or notes == "nan":
                    notes = str(row.get("notes", "") or "")
                fh.write(
                    f"| {row.get('method', '')} | {row.get('dataset', '')} | "
                    f"{_fmt_pct(row.get('mean_field_accuracy'))} | "
                    f"{_fmt_latency(row.get('mean_latency_s'))} | {notes} |\n"
                )

        fh.write("\n## 2. Why Tesseract Was Selected\n\n")
        fh.write(
            "Tesseract was selected because it had the best practical balance of "
            "field accuracy, latency, reliability, and parser compatibility for "
            "structured nutrition labels. Transformer OCR is included as an "
            "official baseline when available, but full nutrition panels are not "
            "TrOCR's native use case without line segmentation.\n\n"
        )
        if not strategy.empty:
            usable = strategy.copy()
            usable["mean_field_accuracy"] = pd.to_numeric(
                usable.get("mean_field_accuracy"), errors="coerce"
            )
            usable["mean_latency_s"] = pd.to_numeric(
                usable.get("mean_latency_s"), errors="coerce"
            )
            usable = usable[
                (~usable["method"].astype(str).str.contains("U-Net", case=False, na=False))
                & (usable["mean_field_accuracy"] > 0)
                & usable["mean_latency_s"].notna()
            ]
            best_latency = usable.sort_values("mean_latency_s", na_position="last").head(3)
            fh.write("Fastest usable non-U-Net rows:\n\n")
            fh.write("| Method | Dataset | Mean Latency |\n")
            fh.write("|---|---|---:|\n")
            for _, row in best_latency.iterrows():
                fh.write(
                    f"| {row.get('method', '')} | {row.get('dataset', '')} | "
                    f"{_fmt_latency(row.get('mean_latency_s'))} |\n"
                )
            fh.write("\n")

        fh.write("## 3. U-Net Negative Result\n\n")
        fh.write(
            "The U-Net preprocessing experiment failed because image reconstruction "
            "loss did not preserve OCR-readable small character shapes. Existing "
            "saved results show the neural preprocessor and gate far below raw "
            "Tesseract; the rescue blend also did not beat raw corrupted "
            "Tesseract. This negative result motivated the confidence-model pivot.\n\n"
        )

        fh.write("## 4. FieldConfidenceNet-Lite\n\n")
        fh.write(
            "FieldConfidenceNet-Lite predicts per-field correctness probability "
            "using raw OCR text features plus engineered field features. It makes "
            "OCR uncertainty-aware instead of blindly trusting extracted values.\n\n"
        )
        fh.write(
            "Success bar: useful if test AUROC > 0.70, or high-confidence accepted "
            "fields are at least 10 percentage points more accurate than all "
            "extracted fields, or the threshold sweep identifies a practical "
            "reject/verify threshold.\n\n"
        )
        if metrics is None:
            fh.write("FieldConfidenceNet-Lite metrics are pending. Run the pair generation and training scripts.\n\n")
        else:
            test_metrics = metrics.get("test", {})
            fh.write("| Metric | Value |\n")
            fh.write("|---|---:|\n")
            for key in ["auroc", "auprc", "accuracy", "f1", "ece", "positive_rate"]:
                value = test_metrics.get(key)
                if value is not None:
                    fh.write(f"| {key.upper()} | {float(value):.4f} |\n")
            fh.write("\n")
            fh.write(_best_threshold_line(sweep) + "\n\n")

        if not sweep.empty:
            fh.write("| Threshold | Coverage | Accepted Accuracy | Rejected Accuracy |\n")
            fh.write("|---:|---:|---:|---:|\n")
            for _, row in sweep.iterrows():
                fh.write(
                    f"| {float(row['threshold']):.2f} | "
                    f"{float(row['coverage_percent']):.1f}% | "
                    f"{_fmt_pct(row.get('accepted_accuracy'))} | "
                    f"{_fmt_pct(row.get('rejected_accuracy'))} |\n"
                )
            fh.write("\n")

        if not per_field.empty:
            fh.write("Per-field confidence results are saved in `field_confidence_per_field.csv`.\n\n")

        fh.write("## 5. App Integration\n\n")
        fh.write(
            "- confidence >= 0.85: accept field\n"
            "- 0.50 <= confidence < 0.85: show field but mark verify\n"
            "- confidence < 0.50: ask user to retake or manually confirm\n\n"
        )

        fh.write("## 6. Slide Bullets\n\n")
        fh.write("See `presentation_slide_bullets.md`.\n")

    slide_path = root / "presentation_slide_bullets.md"
    with slide_path.open("w", encoding="utf-8") as fh:
        fh.write("# Presentation Slide Bullets\n\n")
        fh.write("## Slide 1: OCR Problem and Pipeline\n")
        fh.write("- Product image enters the OCR/CV nutrition-label module.\n")
        fh.write("- OCR extracts structured nutrition fields for downstream health scoring.\n")
        fh.write("- The key risk is field-level extraction error, not just raw text error.\n\n")
        fh.write("## Slide 2: OCR Strategy Comparison\n")
        fh.write("- Compared optimized Tesseract, OpenCV + Tesseract, TrOCR full-image, TrOCR line-segmented, optional EasyOCR, and existing U-Net results.\n")
        fh.write("- Tesseract remained the practical baseline because it is fast, parser-compatible, and reliable on structured labels.\n")
        fh.write("- Latency is reported alongside accuracy because app usage needs timely feedback.\n\n")
        fh.write("## Slide 3: U-Net Experiment and Why It Failed\n")
        fh.write("- U-Net reconstruction improved image-like appearance but destroyed OCR-readable small character shapes.\n")
        fh.write("- The rescue model and blending did not beat raw corrupted Tesseract.\n")
        fh.write("- The failed preprocessor became a negative ablation and motivated reliability prediction.\n\n")
        fh.write("## Slide 4: FieldConfidenceNet-Lite Architecture\n")
        fh.write("- One training sample is one image-field pair.\n")
        fh.write("- Inputs combine raw OCR text features, field identity, extraction flags, numeric value features, units, plausible range, and severity.\n")
        fh.write("- A small MLP outputs the probability that a specific parsed field is correct.\n\n")
        fh.write("## Slide 5: Results and App Integration\n")
        if metrics is None:
            fh.write("- Report FieldConfidenceNet-Lite after running training metrics.\n")
        else:
            test_metrics = metrics.get("test", {})
            auroc = test_metrics.get("auroc")
            ece = test_metrics.get("ece")
            fh.write(f"- Test AUROC: {auroc:.3f}.\n" if auroc is not None else "- Test AUROC unavailable due to single-class split.\n")
            fh.write(f"- Calibration ECE: {ece:.3f}.\n" if ece is not None else "- Calibration ECE unavailable.\n")
            fh.write(f"- {_best_threshold_line(sweep)}\n")
        fh.write("- App behavior: accept high-confidence fields, verify medium-confidence fields, and ask for confirmation on low-confidence fields.\n")
