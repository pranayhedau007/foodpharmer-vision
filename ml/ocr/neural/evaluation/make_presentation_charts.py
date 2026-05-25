"""Regenerate FieldConfidenceNet-Lite presentation charts with better styling.

Run from anywhere — paths are resolved relative to this script's location:
    python ml/ocr/neural/evaluation/make_presentation_charts.py

Inputs (relative to project root):
    ml/ocr/neural/outputs/final_ocr_strategy_comparison/
        field_confidence_lite/field_confidence_test_predictions.csv
        field_confidence_threshold_sweep.csv
        ocr_strategy_comparison.csv

Outputs (overwrites existing PNGs):
    field_confidence_reliability_summary.png
    field_confidence_threshold_sweep.png
    ocr_strategy_accuracy_latency.png
"""

from __future__ import annotations

from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

# Resolve paths relative to this script's location so it works from any cwd.
# This file lives at: <project_root>/ml/ocr/neural/evaluation/make_presentation_charts.py
SCRIPT_DIR = Path(__file__).resolve().parent
PROJECT_ROOT = SCRIPT_DIR.parent.parent.parent.parent  # up 4 levels

OUT_DIR = PROJECT_ROOT / "ml" / "ocr" / "neural" / "outputs" / "final_ocr_strategy_comparison"
PRED_PATH = OUT_DIR / "field_confidence_lite" / "field_confidence_test_predictions.csv"
SWEEP_PATH = OUT_DIR / "field_confidence_threshold_sweep.csv"
STRATEGY_PATH = OUT_DIR / "ocr_strategy_comparison.csv"

# Color palette: muted, slide-friendly
COLOR_PRIMARY = "#2E7DAF"       # blue for coverage
COLOR_SUCCESS = "#3FA13F"       # green for accuracy / good results
COLOR_FAIL = "#7A7A7A"          # gray for failed approaches
COLOR_NEUTRAL = "#D08642"       # orange for OpenCV
COLOR_REFERENCE = "#888888"     # gray for reference lines
COLOR_HIGHLIGHT = "#C2185B"     # magenta for callout/highlight

plt.rcParams.update({
    "font.size": 12,
    "axes.titlesize": 14,
    "axes.labelsize": 12,
    "xtick.labelsize": 11,
    "ytick.labelsize": 11,
    "legend.fontsize": 11,
    "figure.dpi": 160,
    "savefig.dpi": 200,
    "axes.spines.top": False,
    "axes.spines.right": False,
})


def make_reliability_chart() -> None:
    """Reliability diagram with clear bins, annotation, and title."""
    pred = pd.read_csv(PRED_PATH)
    pred["probability_correct"] = pred["probability_correct"].astype(float)
    pred["label_correct"] = pred["label_correct"].astype(int)

    bins = np.linspace(0, 1, 11)
    pred["bin"] = pd.cut(pred["probability_correct"], bins=bins, include_lowest=True)
    binned = pred.groupby("bin", observed=False).agg(
        mean_confidence=("probability_correct", "mean"),
        actual_accuracy=("label_correct", "mean"),
        n=("label_correct", "count"),
    ).dropna(subset=["mean_confidence"])

    fig, ax = plt.subplots(figsize=(8, 5.5))

    ax.plot([0, 1], [0, 1], "--", color=COLOR_REFERENCE, linewidth=1.5,
            label="Perfect calibration", zorder=1)

    sizes = np.clip(binned["n"].values, 30, 800)
    ax.scatter(
        binned["mean_confidence"], binned["actual_accuracy"],
        s=sizes, alpha=0.75, color=COLOR_PRIMARY,
        edgecolor="white", linewidth=1.5,
        label="Confidence bins (size = # predictions)",
        zorder=3,
    )

    largest = binned.loc[binned["n"].idxmax()]
    ax.annotate(
        f"{int(largest['n'])} predictions\nin this bin",
        xy=(largest["mean_confidence"], largest["actual_accuracy"]),
        xytext=(largest["mean_confidence"] - 0.35, largest["actual_accuracy"] - 0.15),
        fontsize=10, color=COLOR_HIGHLIGHT,
        arrowprops=dict(arrowstyle="->", color=COLOR_HIGHLIGHT, lw=1.2),
        zorder=4,
    )

    ax.set_xlabel("Predicted confidence (mean per bin)")
    ax.set_ylabel("Observed correctness rate")
    ax.set_title("Calibration: Predicted vs. Actual Correctness\n"
                 "Bins near the diagonal = well-calibrated",
                 pad=14, loc="left", fontweight="bold")
    ax.set_xlim(-0.02, 1.02)
    ax.set_ylim(-0.02, 1.05)
    ax.grid(True, alpha=0.25, linestyle="-")
    ax.legend(loc="lower right", framealpha=0.95)

    ax.text(0.02, 0.96, "ECE = 0.031\n(Lower is better)",
            transform=ax.transAxes, fontsize=11, fontweight="bold",
            color=COLOR_SUCCESS,
            verticalalignment="top",
            bbox=dict(boxstyle="round,pad=0.4", facecolor="white",
                      edgecolor=COLOR_SUCCESS, linewidth=1.5))

    fig.tight_layout()
    fig.savefig(OUT_DIR / "field_confidence_reliability_summary.png",
                bbox_inches="tight", facecolor="white")
    plt.close(fig)
    print("Wrote field_confidence_reliability_summary.png")


def make_threshold_chart() -> None:
    """Threshold sweep with legend, title, and headline callout at 0.95."""
    sweep = pd.read_csv(SWEEP_PATH)

    fig, ax1 = plt.subplots(figsize=(8.5, 5.5))

    line1 = ax1.plot(
        sweep["threshold"], sweep["coverage_percent"],
        marker="o", markersize=8, linewidth=2.2,
        color=COLOR_PRIMARY, label="Coverage (% of fields accepted)",
        zorder=3,
    )
    ax1.set_xlabel("Confidence threshold")
    ax1.set_ylabel("Coverage (%)", color=COLOR_PRIMARY)
    ax1.tick_params(axis="y", labelcolor=COLOR_PRIMARY)
    ax1.set_ylim(0, 105)
    ax1.set_xlim(0.05, 1.0)
    ax1.grid(True, alpha=0.25)

    ax2 = ax1.twinx()
    ax2.spines["top"].set_visible(False)
    accepted_acc_pct = 100 * sweep["accepted_accuracy"]
    line2 = ax2.plot(
        sweep["threshold"], accepted_acc_pct,
        marker="s", markersize=8, linewidth=2.2,
        color=COLOR_SUCCESS, label="Accuracy on accepted fields (%)",
        zorder=3,
    )
    ax2.set_ylabel("Accuracy on accepted fields (%)", color=COLOR_SUCCESS)
    ax2.tick_params(axis="y", labelcolor=COLOR_SUCCESS)
    ax2.set_ylim(0, 105)

    ax1.axvline(0.95, linestyle=":", color=COLOR_HIGHLIGHT, linewidth=1.5, alpha=0.7, zorder=2)

    t95 = sweep[np.isclose(sweep["threshold"], 0.95)]
    if not t95.empty:
        row = t95.iloc[0]
        cov = float(row["coverage_percent"])
        acc = float(row["accepted_accuracy"]) * 100
        ax1.annotate(
            f"At threshold 0.95:\n"
            f"  - Accept {cov:.1f}% of fields\n"
            f"  - {acc:.1f}% of those are correct",
            xy=(0.95, cov),
            xytext=(0.55, 30),
            fontsize=11, color=COLOR_HIGHLIGHT, fontweight="bold",
            arrowprops=dict(arrowstyle="->", color=COLOR_HIGHLIGHT, lw=1.5),
            bbox=dict(boxstyle="round,pad=0.5", facecolor="white",
                      edgecolor=COLOR_HIGHLIGHT, linewidth=1.5),
            zorder=5,
        )

    lines = line1 + line2
    labels = [l.get_label() for l in lines]
    ax1.legend(lines, labels, loc="lower left", framealpha=0.95)

    ax1.set_title("Confidence Threshold Tradeoff:\n"
                  "Higher threshold = fewer fields accepted, but more reliable",
                  pad=14, loc="left", fontweight="bold")

    fig.tight_layout()
    fig.savefig(OUT_DIR / "field_confidence_threshold_sweep.png",
                bbox_inches="tight", facecolor="white")
    plt.close(fig)
    print("Wrote field_confidence_threshold_sweep.png")


def make_strategy_chart() -> None:
    """Accuracy vs latency scatter with NUMBERED MARKERS and a legend table.

    Solves the label-overlap problem by replacing in-chart text labels with
    numbered circles that index into a clean legend table on the right.
    """
    strategy = pd.read_csv(STRATEGY_PATH)
    strategy["mean_field_accuracy"] = pd.to_numeric(strategy["mean_field_accuracy"], errors="coerce")
    strategy["mean_latency_s"] = pd.to_numeric(strategy["mean_latency_s"], errors="coerce")

    # Filter to plottable rows (exclude TrOCR/EasyOCR which have no accuracy data)
    plot_df = strategy[
        strategy["mean_field_accuracy"].notna()
        & strategy["mean_latency_s"].notna()
        & ~strategy["method"].astype(str).str.contains("TrOCR|EasyOCR", case=False, na=False)
    ].copy()
    plot_df["acc_pct"] = 100 * plot_df["mean_field_accuracy"]

    def categorize(row: pd.Series) -> str:
        method = str(row["method"]).lower()
        if "u-net" in method or "neural ablation" in method or ("neural" in method and "tesseract" not in method):
            return "Failed neural ablation"
        if "opencv" in method:
            return "OpenCV preprocessing"
        return "Tesseract"

    plot_df["category"] = plot_df.apply(categorize, axis=1)

    color_map = {
        "Tesseract": COLOR_SUCCESS,
        "OpenCV preprocessing": COLOR_NEUTRAL,
        "Failed neural ablation": COLOR_FAIL,
    }

    # Sort for consistent legend order: Tesseract -> OpenCV -> Failed
    category_order = ["Tesseract", "OpenCV preprocessing", "Failed neural ablation"]
    plot_df["category_rank"] = plot_df["category"].map({c: i for i, c in enumerate(category_order)})
    plot_df = plot_df.sort_values(["category_rank", "acc_pct"], ascending=[True, False]).reset_index(drop=True)
    plot_df["marker_num"] = range(1, len(plot_df) + 1)

    # Two-column layout: chart left, legend right
    fig = plt.figure(figsize=(13, 6.5))
    gs = fig.add_gridspec(1, 2, width_ratios=[1.6, 1], wspace=0.05)
    ax = fig.add_subplot(gs[0, 0])
    ax_legend = fig.add_subplot(gs[0, 1])

    # Plot scatter colored by category
    for category in category_order:
        sub = plot_df[plot_df["category"] == category]
        if sub.empty:
            continue
        ax.scatter(
            sub["mean_latency_s"], sub["acc_pct"],
            s=320, color=color_map[category], edgecolor="white", linewidth=2.5,
            label=category, zorder=3,
        )

    # Add number labels inside each marker
    for _, row in plot_df.iterrows():
        ax.text(
            row["mean_latency_s"], row["acc_pct"],
            str(row["marker_num"]),
            ha="center", va="center",
            fontsize=10, fontweight="bold", color="white",
            zorder=4,
        )

    ax.set_xlabel("Mean latency per image (seconds)")
    ax.set_ylabel("Field extraction accuracy (%)")
    ax.set_title("OCR Strategy Comparison: Accuracy vs. Latency\n"
                 "Top-left = ideal (fast + accurate)",
                 pad=14, loc="left", fontweight="bold")
    ax.set_ylim(-8, 110)

    # Dynamic x-range with a small buffer
    x_min = max(0.1, plot_df["mean_latency_s"].min() - 0.1)
    x_max = plot_df["mean_latency_s"].max() + 0.25
    ax.set_xlim(x_min, x_max)
    ax.grid(True, alpha=0.25)
    ax.legend(loc="lower right", framealpha=0.95)

    # "Ideal zone" shading in top-left
    ax.axhspan(80, 110, xmin=0, xmax=0.25, alpha=0.06, color=COLOR_SUCCESS, zorder=1)

    # ---- Legend column ----
    ax_legend.axis("off")
    ax_legend.set_xlim(0, 1)
    ax_legend.set_ylim(0, 1)

    ax_legend.text(0.05, 0.98, "Legend", fontsize=13, fontweight="bold",
                   transform=ax_legend.transAxes, va="top")

    # Headers
    header_y = 0.90
    ax_legend.text(0.05, header_y, "#", fontsize=10, fontweight="bold",
                   color="#666", transform=ax_legend.transAxes, va="center")
    ax_legend.text(0.15, header_y, "Method", fontsize=10, fontweight="bold",
                   color="#666", transform=ax_legend.transAxes, va="center")
    ax_legend.text(0.70, header_y, "Dataset", fontsize=10, fontweight="bold",
                   color="#666", transform=ax_legend.transAxes, va="center")

    # Underline below headers
    ax_legend.plot([0.05, 0.98], [header_y - 0.025, header_y - 0.025],
                   color="#BBB", linewidth=0.7, transform=ax_legend.transAxes)

    # Auto-adjust row spacing based on number of rows
    n_rows = len(plot_df)
    available_space = header_y - 0.10  # leave 10% margin at bottom
    row_step = available_space / max(n_rows, 1)
    row_start = header_y - 0.08

    # Compute marker radius based on row spacing to avoid overlap
    marker_radius = min(0.022, row_step * 0.3)

    for idx, row in plot_df.iterrows():
        y = row_start - idx * row_step
        color = color_map[row["category"]]

        circle = plt.Circle((0.07, y), marker_radius,
                            color=color, transform=ax_legend.transAxes,
                            zorder=2)
        ax_legend.add_patch(circle)
        ax_legend.text(0.07, y, str(row["marker_num"]),
                       ha="center", va="center",
                       fontsize=9, fontweight="bold", color="white",
                       transform=ax_legend.transAxes, zorder=3)

        ax_legend.text(0.15, y, row["method"],
                       fontsize=10, va="center",
                       transform=ax_legend.transAxes)
        ax_legend.text(0.70, y, str(row.get("dataset", "")).replace("_", " "),
                       fontsize=10, va="center", color="#555",
                       transform=ax_legend.transAxes)

    fig.savefig(OUT_DIR / "ocr_strategy_accuracy_latency.png",
                bbox_inches="tight", facecolor="white")
    plt.close(fig)
    print("Wrote ocr_strategy_accuracy_latency.png")


def main() -> None:
    if not OUT_DIR.exists():
        raise FileNotFoundError(
            f"Output directory not found: {OUT_DIR}\n"
            f"Expected project root: {PROJECT_ROOT}\n"
            f"Script must be at: <project>/ml/ocr/neural/evaluation/make_presentation_charts.py"
        )
    make_reliability_chart()
    make_threshold_chart()
    make_strategy_chart()
    print("\nAll three charts regenerated.")


if __name__ == "__main__":
    main()
