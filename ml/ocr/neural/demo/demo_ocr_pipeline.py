"""
Demo: run the full neural OCR pipeline on a single image.

Saves visual outputs and prints extracted nutrition to console.

Usage:
    python -m ml.ocr.neural.demo.demo_ocr_pipeline \
        --image data/synthetic_ocr/corrupted/example.png \
        --preprocessor ml/ocr/neural/weights/ocr_preprocessor_unet.pt \
        --predictor ml/ocr/neural/weights/ocr_quality_cnn.pt \
        --out ml/ocr/neural/outputs/demo
"""

from __future__ import annotations

import argparse
import json
import logging
import os

import cv2
import numpy as np
import pytesseract
import torch
from PIL import Image

from .. import get_device, load_checkpoint
from ..models.tiny_unet import TinyUNet
from ..models.ocr_quality_cnn import OCRQualityCNN
from ..parse_synthetic_ocr import parse_synthetic_ocr

logger = logging.getLogger(__name__)

_TESS_CONFIG = "--oem 3 --psm 11"


def _apply_output_mode(logits: torch.Tensor, mode: str) -> torch.Tensor:
    """Apply neural output mode to raw model logits."""
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


def run_demo(image_path: str, preprocessor_path: str,
             predictor_path: str | None, out_dir: str,
             img_size: int = 128,
             neural_output_mode: str = "soft") -> None:
    device = get_device()
    os.makedirs(out_dir, exist_ok=True)

    # Load image
    img = cv2.imread(image_path)
    if img is None:
        raise FileNotFoundError(f"Cannot read image: {image_path}")

    # Save original
    cv2.imwrite(os.path.join(out_dir, "original.png"), img)

    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    h, w = gray.shape

    # ── Neural preprocessing ──
    unet = TinyUNet()
    load_checkpoint(unet, preprocessor_path)
    unet.to(device).eval()

    resized = cv2.resize(gray, (img_size, img_size))
    tensor = torch.from_numpy(resized).float().unsqueeze(0).unsqueeze(0) / 255.0
    tensor = tensor.to(device)

    with torch.no_grad():
        logits = unet(tensor)
        preprocessed = _apply_output_mode(logits, neural_output_mode)

    pre_np = (preprocessed[0, 0].cpu().numpy() * 255).astype(np.uint8)
    pre_np = cv2.resize(pre_np, (w, h))
    cv2.imwrite(os.path.join(out_dir, "preprocessed.png"), pre_np)

    # ── Quality prediction ──
    confidence = -1.0
    decision = "predictor_not_loaded"

    if predictor_path and os.path.exists(predictor_path):
        cnn = OCRQualityCNN()
        load_checkpoint(cnn, predictor_path)
        cnn.to(device).eval()

        resized_pre = cv2.resize(pre_np, (256, 256))
        t = torch.from_numpy(resized_pre).float().unsqueeze(0).unsqueeze(0) / 255.0
        t = t.to(device)

        with torch.no_grad():
            confidence = cnn(t).item()

        if confidence >= 0.70:
            decision = "high confidence, run OCR"
        elif confidence >= 0.40:
            decision = "medium confidence, run OCR but mark uncertain"
        else:
            decision = "low confidence, ask user to retake photo"

    qual = {"confidence": round(confidence, 4), "decision": decision}
    with open(os.path.join(out_dir, "quality_prediction.json"), "w") as f:
        json.dump(qual, f, indent=2)

    # ── OCR ──
    raw_text = pytesseract.image_to_string(Image.fromarray(pre_np), config=_TESS_CONFIG)
    with open(os.path.join(out_dir, "tesseract_raw_text.txt"), "w") as f:
        f.write(raw_text)

    # ── Parse ──
    parsed = parse_synthetic_ocr(raw_text)
    with open(os.path.join(out_dir, "parsed_nutrition.json"), "w") as f:
        json.dump(parsed, f, indent=2)

    # ── Side-by-side visualisation ──
    try:
        import matplotlib
        matplotlib.use("Agg")
        import matplotlib.pyplot as plt

        fig, axes = plt.subplots(1, 3, figsize=(15, 5))
        axes[0].imshow(cv2.cvtColor(img, cv2.COLOR_BGR2RGB))
        axes[0].set_title("Original")
        axes[0].axis("off")

        axes[1].imshow(pre_np, cmap="gray")
        axes[1].set_title("Neural Preprocessed")
        axes[1].axis("off")

        # Build text block for nutrition table
        lines = []
        for k, v in parsed.items():
            if v is not None:
                lines.append(f"{k}: {v}")
        text_block = "\n".join(lines) if lines else "(no fields extracted)"

        axes[2].text(0.05, 0.95, text_block, transform=axes[2].transAxes,
                     fontsize=9, verticalalignment="top", fontfamily="monospace",
                     bbox=dict(boxstyle="round", facecolor="wheat", alpha=0.5))
        axes[2].set_title(f"Extracted (conf={confidence:.2f})")
        axes[2].axis("off")

        plt.tight_layout()
        fig.savefig(os.path.join(out_dir, "side_by_side.png"), dpi=150)
        plt.close(fig)
    except ImportError:
        logger.warning("matplotlib not available; skipping side_by_side.png")

    # ── Console output ──
    print(f"\nOCR confidence: {confidence:.2f}")
    print(f"Decision: {decision}")
    print("\nExtracted nutrition:")
    for k, v in parsed.items():
        if v is not None:
            print(f"  - {k}: {v}")

    logger.info("Demo outputs saved to %s", out_dir)


# ── CLI ───────────────────────────────────────────────────────────────────────

def main() -> None:
    parser = argparse.ArgumentParser(description="Demo the neural OCR pipeline")
    parser.add_argument("--image", required=True, help="Input image path")
    parser.add_argument("--preprocessor", required=True, help="Preprocessor .pt")
    parser.add_argument("--predictor", default=None, help="Quality predictor .pt")
    parser.add_argument("--out", default="ml/ocr/neural/outputs/demo", help="Output dir")
    parser.add_argument("--img-size", type=int, default=128,
                        help="Image size for neural preprocessor (must match training)")
    parser.add_argument("--neural-output-mode", default="soft",
                        choices=["soft", "threshold", "inverted-threshold",
                                 "raw-clamp", "inverted-soft"],
                        help="Neural output mode (default: soft)")
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
    run_demo(args.image, args.preprocessor, args.predictor, args.out,
             img_size=args.img_size, neural_output_mode=args.neural_output_mode)


if __name__ == "__main__":
    main()
