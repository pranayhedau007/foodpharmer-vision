"""Create slide-ready visuals for the final OCR V2 presentation section."""

from __future__ import annotations

import argparse
import json
import math
from pathlib import Path
from typing import Any

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.patches as patches
import numpy as np
import pandas as pd


OUT_ROOT = Path("ml/ocr/neural/outputs/final_ocr_v2_clean")
ASSET_DIR = OUT_ROOT / "presentation_assets"

COLORS = {
    "ink": "#1F2933",
    "muted": "#64748B",
    "line": "#CBD5E1",
    "panel": "#F8FAFC",
    "tess": "#2F7D4F",
    "opencv": "#C2762D",
    "trocr_full": "#2B6F9D",
    "trocr_line": "#6F5BA7",
    "quality": "#256D85",
    "field": "#2D6A4F",
    "accent": "#A23E48",
}


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


def _metric(value: Any, digits: int = 3) -> str:
    try:
        if value is None or pd.isna(value):
            return "n/a"
        return f"{float(value):.{digits}f}"
    except Exception:
        return "n/a"


def _write(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf-8")


def _box(
    ax: plt.Axes,
    center: tuple[float, float],
    text: str,
    width: float = 2.6,
    height: float = 0.7,
    facecolor: str = "#FFFFFF",
    edgecolor: str = COLORS["line"],
    fontsize: int = 13,
    fontweight: str = "normal",
) -> None:
    x, y = center
    rect = patches.FancyBboxPatch(
        (x - width / 2, y - height / 2),
        width,
        height,
        boxstyle="round,pad=0.03,rounding_size=0.06",
        linewidth=1.3,
        edgecolor=edgecolor,
        facecolor=facecolor,
    )
    ax.add_patch(rect)
    ax.text(
        x,
        y,
        text,
        ha="center",
        va="center",
        fontsize=fontsize,
        color=COLORS["ink"],
        fontweight=fontweight,
        wrap=True,
    )


def _arrow(ax: plt.Axes, start: tuple[float, float], end: tuple[float, float], color: str = COLORS["muted"]) -> None:
    ax.annotate(
        "",
        xy=end,
        xytext=start,
        arrowprops={
            "arrowstyle": "-|>",
            "lw": 1.8,
            "color": color,
            "shrinkA": 8,
            "shrinkB": 8,
        },
    )


def _init_diagram(width: float = 10, height: float = 6, xmax: float = 10) -> tuple[plt.Figure, plt.Axes]:
    fig, ax = plt.subplots(figsize=(width, height))
    ax.set_xlim(0, xmax)
    ax.set_ylim(0, 6)
    ax.axis("off")
    fig.patch.set_facecolor("white")
    return fig, ax


def create_slide1(out_dir: Path) -> None:
    _write(
        out_dir / "slide1_ocr_pipeline.mmd",
        """flowchart TD
  A[Food package photo] --> B[OCR engine]
  B --> C[Parsed nutrition fields]
  C --> D[Health scoring model]
  C -. risk .-> E[If sodium is misread as 920mg instead of 20mg, the final health score is wrong.]
""",
    )

    fig, ax = _init_diagram(11, 6.2)
    ax.text(0.6, 5.65, "Making Nutrition Label OCR Trustworthy", fontsize=20, fontweight="bold", color=COLORS["ink"])
    nodes = [
        ((2.0, 4.5), "Food package\nphoto", COLORS["panel"]),
        ((4.2, 4.5), "OCR\nengine", "#F0F7F4"),
        ((6.4, 4.5), "Parsed nutrition\nfields", "#EEF4FA"),
        ((8.6, 4.5), "Health scoring\nmodel", "#F7F3EA"),
    ]
    for center, label, color in nodes:
        _box(ax, center, label, width=1.65, height=0.9, facecolor=color, fontsize=12, fontweight="bold")
    for start, end in [((2.85, 4.5), (3.35, 4.5)), ((5.05, 4.5), (5.55, 4.5)), ((7.25, 4.5), (7.75, 4.5))]:
        _arrow(ax, start, end)

    warn = patches.FancyBboxPatch(
        (1.0, 1.15),
        8.0,
        1.25,
        boxstyle="round,pad=0.05,rounding_size=0.06",
        linewidth=1.5,
        edgecolor=COLORS["accent"],
        facecolor="#FFF7ED",
    )
    ax.add_patch(warn)
    ax.text(1.25, 2.03, "Why confidence matters", fontsize=13, fontweight="bold", color=COLORS["accent"], va="center")
    ax.text(
        1.25,
        1.55,
        "If sodium is misread as 920mg instead of 20mg, the final health score is wrong.",
        fontsize=13,
        color=COLORS["ink"],
        va="center",
    )
    fig.savefig(out_dir / "slide1_ocr_pipeline.png", dpi=220, bbox_inches="tight", facecolor="white")
    plt.close(fig)


def _method_color(method: str) -> str:
    method_l = method.lower()
    if "trocr line" in method_l:
        return COLORS["trocr_line"]
    if "trocr" in method_l:
        return COLORS["trocr_full"]
    if "opencv" in method_l:
        return COLORS["opencv"]
    return COLORS["tess"]


def create_slide2(out_dir: Path, root: Path) -> None:
    df = pd.read_csv(root / "ocr_accuracy_latency_clean.csv")
    df = df[~df["method"].astype(str).str.contains("u-net|easyocr|negative", case=False, na=False)].copy()
    df["mean_field_accuracy"] = pd.to_numeric(df["mean_field_accuracy"], errors="coerce")
    df["mean_latency_s"] = pd.to_numeric(df["mean_latency_s"], errors="coerce")
    plot_df = df[df["mean_field_accuracy"].notna() & df["mean_latency_s"].notna()].copy()
    plot_df = plot_df.sort_values(["method", "dataset"]).reset_index(drop=True)
    plot_df["marker_num"] = range(1, len(plot_df) + 1)

    fig = plt.figure(figsize=(13.0, 7.1))
    gs = fig.add_gridspec(1, 2, width_ratios=[1.65, 1.0], wspace=0.05)
    ax = fig.add_subplot(gs[0, 0])
    ax_table = fig.add_subplot(gs[0, 1])

    for _, row in plot_df.iterrows():
        color = _method_color(str(row["method"]))
        ax.scatter(
            row["mean_latency_s"],
            100 * row["mean_field_accuracy"],
            s=320,
            color=color,
            edgecolor="white",
            linewidth=2.0,
            zorder=3,
        )
        ax.text(
            row["mean_latency_s"],
            100 * row["mean_field_accuracy"],
            str(int(row["marker_num"])),
            ha="center",
            va="center",
            fontsize=10,
            fontweight="bold",
            color="white",
            zorder=4,
        )

    ax.set_title(
        "OCR Accuracy vs Latency\nTesseract remained the best practical choice for structured nutrition labels.",
        loc="left",
        fontsize=15,
        fontweight="bold",
        color=COLORS["ink"],
        pad=14,
    )
    ax.set_xlabel("Mean latency per image (seconds)")
    ax.set_ylabel("Field accuracy (%)")
    ax.set_ylim(-5, 105)
    ax.set_xlim(max(0, plot_df["mean_latency_s"].min() - 0.12), plot_df["mean_latency_s"].max() + 0.45)
    ax.grid(True, color="#E5E7EB", linewidth=0.8)
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)

    ax_table.axis("off")
    ax_table.set_xlim(0, 1)
    ax_table.set_ylim(0, 1)
    ax_table.text(0.02, 0.98, "Marker legend", va="top", fontsize=13, fontweight="bold", color=COLORS["ink"])
    y = 0.90
    step = min(0.07, 0.78 / max(len(plot_df), 1))
    for _, row in plot_df.iterrows():
        method = str(row["method"])
        dataset = str(row["dataset"]).replace("_", " ")
        color = _method_color(method)
        ax_table.scatter(0.055, y, s=210, color=color, edgecolor="white", linewidth=1.5)
        ax_table.text(0.055, y, str(int(row["marker_num"])), ha="center", va="center", color="white", fontweight="bold", fontsize=8)
        ax_table.text(0.12, y + 0.012, method, va="center", fontsize=9.5, color=COLORS["ink"])
        ax_table.text(0.12, y - 0.020, dataset, va="center", fontsize=8.5, color=COLORS["muted"])
        y -= step

    fig.savefig(out_dir / "slide2_ocr_accuracy_latency.png", dpi=220, bbox_inches="tight", facecolor="white")
    plt.close(fig)

    takeaways = []
    for row in df.to_dict("records"):
        method = str(row["method"])
        dataset = str(row["dataset"]).replace("_", " ")
        if method == "Tesseract" and row["dataset"] == "corrupted_synthetic":
            takeaway = "Best practical engine on corrupted synthetic labels."
        elif method == "Tesseract" and row["dataset"] == "real_photos":
            takeaway = "Best real-photo baseline in the final comparison."
        elif method == "Tesseract":
            takeaway = "Near-perfect on clean generated labels."
        elif "OpenCV" in method:
            takeaway = "Preprocessing/cropping did not beat raw Tesseract."
        elif "TrOCR line" in method:
            takeaway = "Line segmentation added latency and remained weak."
        elif "TrOCR" in method:
            takeaway = "Full-panel transformer OCR was weak on dense nutrition panels."
        else:
            takeaway = ""
        takeaways.append(
            {
                "Method": method,
                "Dataset": dataset,
                "Field Accuracy": _pct(row.get("mean_field_accuracy")),
                "Mean Latency": _seconds(row.get("mean_latency_s")),
                "Takeaway": takeaway,
            }
        )
    pd.DataFrame(takeaways).to_csv(out_dir / "slide2_ocr_engine_table.csv", index=False)


def create_slide3(out_dir: Path, root: Path) -> None:
    _write(
        out_dir / "slide3_vision_quality_model.mmd",
        """flowchart LR
  A[Nutrition label image] --> B[MobileNetV3-small backbone]
  B --> C[MLP classification head]
  C --> D[good / medium / bad OCR quality]
""",
    )

    fig, ax = _init_diagram(11, 5.4)
    ax.text(0.6, 4.85, "Predicting Bad OCR Before Trusting It", fontsize=20, fontweight="bold", color=COLORS["ink"])
    nodes = [
        ((1.8, 2.9), "Nutrition label\nimage", "#F8FAFC"),
        ((4.0, 2.9), "MobileNetV3-small\nbackbone", "#ECFDF5"),
        ((6.25, 2.9), "MLP classification\nhead", "#EFF6FF"),
        ((8.55, 2.9), "good / medium / bad\nOCR quality", "#FFF7ED"),
    ]
    for center, label, color in nodes:
        _box(ax, center, label, width=1.85, height=0.9, facecolor=color, fontsize=11.5, fontweight="bold")
    for start, end in [((2.72, 2.9), (3.08, 2.9)), ((4.92, 2.9), (5.33, 2.9)), ((7.18, 2.9), (7.63, 2.9))]:
        _arrow(ax, start, end, COLORS["quality"])
    ax.text(
        1.0,
        1.0,
        "Preliminary image-level quality model: useful as a warning/gate, not a text reader.",
        fontsize=12.5,
        color=COLORS["muted"],
    )
    fig.savefig(out_dir / "slide3_vision_quality_model.png", dpi=220, bbox_inches="tight", facecolor="white")
    plt.close(fig)

    sweep = pd.read_csv(root / "small_vision_quality_threshold_sweep.csv")
    for col in ["threshold", "coverage", "accepted_ocr_accuracy", "rejected_ocr_accuracy", "n_accepted", "n_rejected"]:
        sweep[col] = pd.to_numeric(sweep[col], errors="coerce")
    fig, ax1 = plt.subplots(figsize=(9.2, 5.8))
    ax1.plot(sweep["threshold"], 100 * sweep["coverage"], marker="o", linewidth=2.4, color=COLORS["quality"], label="Coverage")
    ax1.set_xlabel("Predicted-good confidence threshold")
    ax1.set_ylabel("Images accepted (%)", color=COLORS["quality"])
    ax1.tick_params(axis="y", labelcolor=COLORS["quality"])
    ax1.set_ylim(0, 105)
    ax1.grid(True, color="#E5E7EB")
    ax1.spines["top"].set_visible(False)

    ax2 = ax1.twinx()
    ax2.plot(
        sweep["threshold"],
        100 * sweep["accepted_ocr_accuracy"],
        marker="s",
        linewidth=2.4,
        color=COLORS["field"],
        label="Accepted OCR accuracy",
    )
    ax2.set_ylabel("Mean OCR field accuracy (%)", color=COLORS["field"])
    ax2.tick_params(axis="y", labelcolor=COLORS["field"])
    ax2.set_ylim(0, 105)
    ax2.spines["top"].set_visible(False)

    highlight = sweep[np.isclose(sweep["threshold"], 0.85)]
    if not highlight.empty:
        row = highlight.iloc[0]
        ax1.axvline(0.85, color=COLORS["accent"], linestyle=":", linewidth=1.6)
        ax2.annotate(
            "0.85 threshold\naccepted 5/60 images\n100% mean OCR accuracy",
            xy=(0.85, 100 * row["accepted_ocr_accuracy"]),
            xytext=(0.46, 72),
            textcoords="data",
            fontsize=10.5,
            color=COLORS["accent"],
            fontweight="bold",
            arrowprops={"arrowstyle": "->", "color": COLORS["accent"]},
            bbox={"boxstyle": "round,pad=0.35", "facecolor": "white", "edgecolor": COLORS["accent"]},
        )
    ax1.set_title(
        "Image-Level Quality Threshold Sweep\nPreliminary model: high threshold accepts fewer images with cleaner OCR.",
        loc="left",
        fontsize=15,
        fontweight="bold",
        color=COLORS["ink"],
        pad=12,
    )
    fig.tight_layout()
    fig.savefig(out_dir / "slide3_vision_quality_threshold_sweep.png", dpi=220, bbox_inches="tight", facecolor="white")
    plt.close(fig)


def create_slide4(out_dir: Path) -> None:
    _write(
        out_dir / "slide4_field_confidence_architecture.mmd",
        """flowchart LR
  A[Raw Tesseract OCR text] --> G[Feature vector]
  B[Field identity] --> G
  C[Was field extracted] --> G
  D[Parsed numeric value] --> G
  E[Unit type] --> G
  F[Plausible range flag] --> G
  G --> H[Small MLP classifier]
  H --> I[P(field is correct)]
""",
    )

    fig, ax = _init_diagram(12.4, 6.4, xmax=11.2)
    ax.text(0.55, 5.85, "Predicting Which Extracted Fields Are Correct", fontsize=19, fontweight="bold", color=COLORS["ink"])
    inputs = [
        ((2.1, 4.7), "Raw Tesseract\nOCR text"),
        ((2.1, 3.85), "Field\nidentity"),
        ((2.1, 3.0), "Was field\nextracted"),
        ((2.1, 2.15), "Parsed numeric\nvalue"),
        ((2.1, 1.3), "Unit type"),
        ((2.1, 0.45), "Plausible\nrange flag"),
    ]
    for center, label in inputs:
        _box(ax, center, label, width=2.05, height=0.58, facecolor="#F8FAFC", fontsize=10.5)
        _arrow(ax, (3.15, center[1]), (4.35, 2.55), COLORS["muted"])
    _box(ax, (5.2, 2.55), "Feature\nvector", width=1.5, height=0.8, facecolor="#EEF6FF", fontsize=12, fontweight="bold")
    _arrow(ax, (5.95, 2.55), (6.8, 2.55), COLORS["field"])
    _box(ax, (7.65, 2.55), "Small MLP\nclassifier", width=1.7, height=0.85, facecolor="#ECFDF5", fontsize=12, fontweight="bold")
    _arrow(ax, (8.5, 2.55), (9.25, 2.55), COLORS["field"])
    _box(ax, (10.05, 2.55), "P(field is\ncorrect)", width=1.8, height=0.85, facecolor="#FFF7ED", fontsize=12, fontweight="bold")
    fig.savefig(out_dir / "slide4_field_confidence_architecture.png", dpi=220, bbox_inches="tight", facecolor="white")
    plt.close(fig)

    pd.DataFrame(
        [
            {"Field": "Calories", "Extracted Value": "120", "Confidence": "0.95", "Action": "Accept"},
            {"Field": "Sodium", "Extracted Value": "920mg", "Confidence": "0.88", "Action": "Accept"},
            {"Field": "Dietary Fiber", "Extracted Value": "2g", "Confidence": "0.41", "Action": "Verify"},
        ]
    ).to_csv(out_dir / "slide4_field_confidence_example.csv", index=False)


def create_slide5(out_dir: Path, root: Path) -> None:
    summary = json.loads((root / "field_confidence_lite_summary.json").read_text(encoding="utf-8"))
    t95 = summary.get("threshold_0_95", {})
    fig, ax = _init_diagram(10.5, 6.3)
    ax.text(0.6, 5.75, "Uncertainty-Aware Nutrition Extraction", fontsize=20, fontweight="bold", color=COLORS["ink"])

    card = patches.FancyBboxPatch(
        (0.8, 0.65),
        8.9,
        4.55,
        boxstyle="round,pad=0.06,rounding_size=0.08",
        linewidth=1.4,
        edgecolor=COLORS["line"],
        facecolor="#FFFFFF",
    )
    ax.add_patch(card)
    ax.text(1.2, 4.82, "FieldConfidenceNet-Lite results", fontsize=16, fontweight="bold", color=COLORS["ink"])
    metrics = [
        ("Synthetic AUROC", _metric(summary.get("test_auroc")), 15),
        ("AUPRC", _metric(summary.get("test_auprc")), 15),
        ("ECE", _metric(summary.get("test_ece")), 15),
        ("Real-photo AUROC", f"{_metric(summary.get('real_photo_auroc'))} over 327 fields", 15),
        (
            "Threshold 0.95",
            f"{float(t95.get('coverage_percent', 0)):.1f}% fields accepted\n{_pct(t95.get('accepted_accuracy'))} correctness",
            13.5,
        ),
    ]
    y = 4.18
    for label, value, value_size in metrics:
        ax.text(1.25, y, label, fontsize=12.5, color=COLORS["muted"], va="center")
        ax.text(4.1, y, value, fontsize=value_size, fontweight="bold", color=COLORS["field"], va="center", linespacing=1.15)
        y -= 0.74 if "\n" not in value else 1.05
    fig.savefig(out_dir / "slide5_field_confidence_results.png", dpi=220, bbox_inches="tight", facecolor="white")
    plt.close(fig)

    _write(
        out_dir / "slide5_app_integration_flow.mmd",
        """flowchart TD
  A[OCR field extracted] --> B[FieldConfidenceNet-Lite confidence]
  B --> C{Confidence band}
  C -->|confidence >= 0.85| D[accept]
  C -->|0.50 <= confidence < 0.85| E[verify]
  C -->|confidence < 0.50| F[retake / manually correct]
  D --> G[verified nutrition fields]
  E --> G
  F --> G
  G --> H[health scoring]
""",
    )

    fig, ax = _init_diagram(11, 6.3)
    ax.text(0.6, 5.75, "App Integration: Accept, Verify, or Correct", fontsize=19, fontweight="bold", color=COLORS["ink"])
    _box(ax, (2.0, 4.55), "OCR field\nextracted", width=1.7, height=0.8, facecolor="#F8FAFC", fontweight="bold")
    _arrow(ax, (2.85, 4.55), (3.55, 4.55), COLORS["field"])
    _box(ax, (4.65, 4.55), "FieldConfidenceNet-Lite\nconfidence", width=2.25, height=0.85, facecolor="#ECFDF5", fontweight="bold", fontsize=11)
    _arrow(ax, (4.65, 4.1), (4.65, 3.45), COLORS["field"])
    _box(ax, (4.65, 3.05), "confidence band", width=1.75, height=0.65, facecolor="#EEF6FF", fontweight="bold", fontsize=11)

    actions = [
        ((2.0, 1.8), ">= 0.85\nAccept", "#ECFDF5"),
        ((4.65, 1.8), "0.50 - 0.85\nVerify", "#FFF7ED"),
        ((7.35, 1.8), "< 0.50\nRetake / correct", "#F8FAFC"),
    ]
    for center, label, color in actions:
        _arrow(ax, (4.65, 2.72), (center[0], 2.25), COLORS["muted"])
        _box(ax, center, label, width=1.8, height=0.78, facecolor=color, fontweight="bold", fontsize=11)
        _arrow(ax, (center[0], 1.38), (8.85, 1.0), COLORS["muted"])
    _box(ax, (9.0, 1.0), "Verified nutrition\nfields -> scoring", width=2.1, height=0.8, facecolor="#F7F3EA", fontweight="bold", fontsize=11)
    fig.savefig(out_dir / "slide5_app_integration_flow.png", dpi=220, bbox_inches="tight", facecolor="white")
    plt.close(fig)


def create_backups(out_dir: Path) -> None:
    _write(
        out_dir / "backup_unet_note.md",
        """# Backup: U-Net Negative Ablation

A U-Net preprocessor was trained and tested, but it did not improve OCR.
It is excluded from the main chart because the final story focuses on viable
OCR strategies and reliability models.

Key result: best U-Net blend 54.75% vs raw Tesseract 66.88% on the same sample.
""",
    )
    _write(
        out_dir / "backup_trocr_limitations.md",
        """# Backup: TrOCR Limitations

TrOCR is powerful for cropped text-line recognition, but nutrition labels are
dense structured documents. Full-panel TrOCR and simple line segmentation
performed poorly in this bounded benchmark.

A stronger layout/region segmentation system would be needed for a fair
production TrOCR pipeline.
""",
    )


def create_readme(out_dir: Path) -> None:
    readme = """# OCR Presentation Assets

These files are slide-ready visuals for a 4-6 minute OCR/CV section. They are
assets to embed in PowerPoint or Google Slides, not a generated slide deck.

## Recommended timing

- Slide 1: 45 sec
- Slide 2: 75 sec
- Slide 3: 50 sec
- Slide 4: 75 sec
- Slide 5: 75 sec

## Slide 1 - Making Nutrition Label OCR Trustworthy

Assets:
- `slide1_ocr_pipeline.mmd`
- `slide1_ocr_pipeline.png`

What it shows: the OCR module sits upstream of nutrition parsing and health
scoring, so OCR mistakes can corrupt the final score.

Talking points:
- My OCR module turns label photos into structured nutrition fields.
- OCR is upstream of scoring, so extraction mistakes corrupt the final score.
- The key problem is not only reading text, but knowing whether the reading is trustworthy.

## Slide 2 - Choosing the Practical OCR Engine

Assets:
- `slide2_ocr_accuracy_latency.png`
- `slide2_ocr_engine_table.csv`

What it shows: accuracy vs latency for Tesseract, OpenCV + Tesseract, and
bounded TrOCR runs. U-Net is intentionally not included in the main chart.

Talking points:
- Tesseract was the best practical OCR engine for structured nutrition fields.
- TrOCR is a transformer OCR model, but it performed poorly on dense full nutrition panels and line segmentation added latency.
- OpenCV preprocessing did not beat raw Tesseract.
- We selected OCR empirically rather than by assumption.

## Slide 3 - Predicting Bad OCR Before Trusting It

Assets:
- `slide3_vision_quality_model.mmd`
- `slide3_vision_quality_model.png`
- `slide3_vision_quality_threshold_sweep.png`

What it shows: a MobileNetV3-small image model predicts whether OCR quality is
likely to be good, medium, or bad. The threshold chart highlights the 0.85
threshold where 5/60 test images were accepted with 100% mean OCR accuracy.

Talking points:
- This model does not read the text.
- It predicts whether the image is likely to produce good OCR.
- MobileNetV3 gave moderate signal: good-vs-not-good AUROC around 0.733.
- This is useful as a pre-OCR warning, but the stronger reliability model is field-level confidence.

## Slide 4 - Predicting Which Extracted Fields Are Correct

Assets:
- `slide4_field_confidence_architecture.mmd`
- `slide4_field_confidence_architecture.png`
- `slide4_field_confidence_example.csv`

What it shows: FieldConfidenceNet-Lite combines raw OCR text, field identity,
extraction flags, parsed value features, unit type, and plausibility flags to
predict whether one extracted field is correct.

Talking points:
- FieldConfidenceNet-Lite is the main trained neural contribution.
- It does not replace OCR; it checks whether each extracted field should be trusted.
- The model is a small MLP trained from synthetic labels where ground truth is known.
- It makes OCR uncertainty-aware at the field level.

## Slide 5 - Uncertainty-Aware Nutrition Extraction

Assets:
- `slide5_field_confidence_results.png`
- `slide5_app_integration_flow.mmd`
- `slide5_app_integration_flow.png`

What it shows: FieldConfidenceNet-Lite results and the final app decision flow:
accept high-confidence fields, verify medium-confidence fields, and retake or
manually correct low-confidence fields.

Talking points:
- FieldConfidenceNet-Lite had strong discrimination and calibration.
- At a strict threshold, it accepts fewer fields but with very high correctness.
- The app can avoid blindly passing bad OCR values into scoring.
- Final pipeline: Tesseract reads, neural confidence decides whether to trust.

## Backup visuals

Assets:
- `backup_unet_note.md`
- `backup_trocr_limitations.md`

Use these only for Q&A or backup discussion.

## Reminders

- FieldConfidenceNet-Lite is the main contribution.
- Small vision model is preliminary.
- TrOCR is a benchmark/justification for Tesseract.
- U-Net is backup/history only.

## Mermaid notes

The `.mmd` files can be pasted into Mermaid Live, PowerPoint Mermaid add-ins,
or any Markdown renderer with Mermaid support. PNG equivalents are included for
the diagrams so they can be embedded directly.
"""
    _write(out_dir / "README_presentation_assets.md", readme)


def run(args: argparse.Namespace) -> None:
    root = Path(args.root)
    out_dir = root / "presentation_assets"
    out_dir.mkdir(parents=True, exist_ok=True)
    create_slide1(out_dir)
    create_slide2(out_dir, root)
    create_slide3(out_dir, root)
    create_slide4(out_dir)
    create_slide5(out_dir, root)
    create_backups(out_dir)
    create_readme(out_dir)


def main() -> None:
    parser = argparse.ArgumentParser(description="Create OCR presentation visual assets")
    parser.add_argument("--root", default=str(OUT_ROOT), help="Final OCR V2 clean output directory")
    args = parser.parse_args()
    run(args)


if __name__ == "__main__":
    main()
