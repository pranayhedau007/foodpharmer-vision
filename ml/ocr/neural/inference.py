"""
Lightweight integration wrapper for the neural OCR pipeline.

Can be imported into the existing backend if USE_NEURAL_OCR=true,
but is not wired in by default.
"""

from __future__ import annotations

import os

import cv2
import numpy as np


def _apply_output_mode(logits, mode: str):
    """Apply neural output mode to raw logits."""
    import torch
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


def neural_ocr_preprocess_and_gate(
    image: np.ndarray,
    img_size: int = 128,
    output_mode: str = "soft",
) -> dict:
    """
    Run neural OCR preprocessing and quality gating on a label image.

    Args:
        image: Input BGR or grayscale image.
        img_size: Size to resize input before model inference (must match
                  training, default 128).
        output_mode: Neural output mode — one of soft, threshold,
                     inverted-threshold, raw-clamp, inverted-soft.

    Returns:
        {
            "preprocessed_image": np.ndarray,   # OCR-friendly image
            "ocr_confidence": float,            # 0-1 quality score
            "decision": str,                    # "high_confidence" / "medium_confidence" / "low_confidence"
            "should_run_ocr": bool,             # True if confidence >= 0.40
        }
    """
    import torch
    from . import get_device, load_checkpoint
    from .models.tiny_unet import TinyUNet
    from .models.ocr_quality_cnn import OCRQualityCNN

    device = get_device()

    # Resolve weight paths relative to this file
    weight_dir = os.path.join(os.path.dirname(__file__), "weights")
    preprocessor_path = os.path.join(weight_dir, "ocr_preprocessor_unet.pt")
    predictor_path = os.path.join(weight_dir, "ocr_quality_cnn.pt")

    # Convert to grayscale
    if len(image.shape) == 3:
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    else:
        gray = image
    h, w = gray.shape

    # Default result if models are not available
    result: dict = {
        "preprocessed_image": gray,
        "ocr_confidence": -1.0,
        "decision": "models_not_found",
        "should_run_ocr": True,
    }

    # Neural preprocessing
    if os.path.exists(preprocessor_path):
        unet = TinyUNet()
        load_checkpoint(unet, preprocessor_path)
        unet.to(device).eval()

        resized = cv2.resize(gray, (img_size, img_size))
        tensor = torch.from_numpy(resized).float().unsqueeze(0).unsqueeze(0) / 255.0
        tensor = tensor.to(device)

        with torch.no_grad():
            logits = unet(tensor)
            processed = _apply_output_mode(logits, output_mode)

        preprocessed = (processed[0, 0].cpu().numpy() * 255).astype(np.uint8)
        preprocessed = cv2.resize(preprocessed, (w, h))
        result["preprocessed_image"] = preprocessed
    else:
        return result

    # Quality prediction
    if os.path.exists(predictor_path):
        cnn = OCRQualityCNN()
        load_checkpoint(cnn, predictor_path)
        cnn.to(device).eval()

        resized = cv2.resize(preprocessed, (256, 256))
        tensor = torch.from_numpy(resized).float().unsqueeze(0).unsqueeze(0) / 255.0
        tensor = tensor.to(device)

        with torch.no_grad():
            conf = cnn(tensor).item()

        result["ocr_confidence"] = conf
        if conf >= 0.70:
            result["decision"] = "high_confidence"
            result["should_run_ocr"] = True
        elif conf >= 0.40:
            result["decision"] = "medium_confidence"
            result["should_run_ocr"] = True
        else:
            result["decision"] = "low_confidence"
            result["should_run_ocr"] = False

    return result
