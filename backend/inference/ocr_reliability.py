"""OCR reliability integration for the Food Pharmer scan pipeline.

Runs two models on the nutrition label image only:
1. Image-level OCR quality model (MobileNetV3-Small) -- predicts bad/medium/good
2. FieldConfidenceNet-Lite (MLP) -- predicts per-field OCR correctness confidence

Neither model blocks the existing scoring pipeline.
"""

from __future__ import annotations

import logging
import pickle
from pathlib import Path
from typing import Any

import cv2
import numpy as np

logger = logging.getLogger(__name__)

# ---------------------------------------------------------------------------
# Model artifact paths
# ---------------------------------------------------------------------------
_REPO_ROOT = Path(__file__).resolve().parent.parent.parent

_QUALITY_MODEL_CANDIDATES = [
    _REPO_ROOT / "ml" / "ocr" / "neural" / "outputs" / "final_ocr_v2_clean" / "small_vision_quality" / "small_vision_quality_mobilenet_v3_small.pt",
    _REPO_ROOT / "ml" / "ocr" / "neural" / "outputs" / "final_ocr_strategy_comparison" / "small_vision_quality" / "small_vision_quality_mobilenet_v3_small.pt",
    _REPO_ROOT / "ml" / "ocr" / "neural" / "outputs" / "small_vision_quality_mobilenet_v3_small.pt",
    _REPO_ROOT / "ml" / "ocr" / "neural" / "weights" / "small_vision_quality_mobilenet_v3_small.pt",
]

_FIELD_CONF_MODEL_CANDIDATES = [
    _REPO_ROOT / "ml" / "ocr" / "neural" / "outputs" / "final_ocr_strategy_comparison" / "field_confidence_lite" / "field_confidence_lite.pt",
    _REPO_ROOT / "ml" / "ocr" / "neural" / "outputs" / "final_ocr_v2_clean" / "field_confidence_lite" / "field_confidence_lite.pt",
    _REPO_ROOT / "ml" / "ocr" / "neural" / "outputs" / "field_confidence_lite.pt",
    _REPO_ROOT / "ml" / "ocr" / "neural" / "weights" / "field_confidence_lite.pt",
]

_FIELD_CONF_VECTORIZER_CANDIDATES = [
    _REPO_ROOT / "ml" / "ocr" / "neural" / "outputs" / "final_ocr_strategy_comparison" / "field_confidence_lite" / "field_confidence_vectorizer.pkl",
    _REPO_ROOT / "ml" / "ocr" / "neural" / "outputs" / "final_ocr_v2_clean" / "field_confidence_lite" / "field_confidence_vectorizer.pkl",
    _REPO_ROOT / "ml" / "ocr" / "neural" / "outputs" / "field_confidence_vectorizer.pkl",
    _REPO_ROOT / "ml" / "ocr" / "neural" / "weights" / "field_confidence_vectorizer.pkl",
]

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------
QUALITY_CLASS_NAMES = ["bad", "medium", "good"]

QUALITY_MESSAGES: dict[str, str] = {
    "bad": "Bad photo -- take again",
    "medium": "Medium photo -- try taking a better photo for more accurate data",
    "good": "Good photo!",
    "unknown": "Photo quality model unavailable",
}

# Map NLP-parser nutrition keys -> canonical FieldConfidenceNet-Lite field names.
_PARSER_TO_MODEL_FIELD: dict[str, str] = {
    "sugars": "total_sugars",
    "fiber": "dietary_fiber",
    "fat": "total_fat",
    "carbohydrate": "total_carbohydrate",
    "carbs": "total_carbohydrate",
}

# ---------------------------------------------------------------------------
# Lazy-loaded model singletons
# ---------------------------------------------------------------------------
_quality_model: Any = None
_quality_model_loaded = False

_field_conf_model: Any = None
_field_conf_vectorizer: Any = None
_field_conf_checkpoint: dict | None = None
_field_conf_loaded = False


def _find_artifact(candidates: list[Path]) -> Path | None:
    for path in candidates:
        if path.exists():
            return path
    return None


def _map_parsed_key(key: str) -> str:
    return _PARSER_TO_MODEL_FIELD.get(key, key)


# ===================================================================
# 1.  IMAGE-LEVEL QUALITY MODEL  (MobileNetV3-Small)
# ===================================================================

def _load_quality_model():
    global _quality_model, _quality_model_loaded
    if _quality_model_loaded:
        return _quality_model
    _quality_model_loaded = True

    path = _find_artifact(_QUALITY_MODEL_CANDIDATES)
    if path is None:
        logger.error(
            "Image quality model not found. Searched: %s",
            [str(p) for p in _QUALITY_MODEL_CANDIDATES],
        )
        return None

    try:
        import torch
        import torch.nn as nn
        from torchvision.models import mobilenet_v3_small

        model = mobilenet_v3_small(weights=None)
        in_features = model.classifier[-1].in_features
        model.classifier[-1] = nn.Linear(in_features, len(QUALITY_CLASS_NAMES))
        model.load_state_dict(
            torch.load(str(path), map_location="cpu", weights_only=True)
        )
        model.eval()
        _quality_model = model
        logger.info("Loaded image quality model from %s", path)
        return model
    except Exception as exc:
        logger.error("Failed to load image quality model: %s", exc)
        return None


def _run_photo_quality(nutrition_img: np.ndarray) -> dict:
    """Run the MobileNetV3-Small quality classifier on the nutrition image."""
    model = _load_quality_model()
    if model is None:
        return {
            "label": "unknown",
            "message": QUALITY_MESSAGES["unknown"],
            "confidence_percent": None,
            "probabilities": {},
        }

    try:
        import torch
        from PIL import Image
        from torchvision import transforms

        rgb = cv2.cvtColor(nutrition_img, cv2.COLOR_BGR2RGB)
        pil_img = Image.fromarray(rgb)

        transform = transforms.Compose([
            transforms.Resize((224, 224)),
            transforms.ToTensor(),
            transforms.Normalize(
                mean=[0.485, 0.456, 0.406],
                std=[0.229, 0.224, 0.225],
            ),
        ])

        tensor = transform(pil_img).unsqueeze(0)
        with torch.no_grad():
            logits = model(tensor)
            probs = torch.softmax(logits, dim=1).squeeze(0).numpy()

        pred_idx = int(probs.argmax())
        label = QUALITY_CLASS_NAMES[pred_idx]

        return {
            "label": label,
            "message": QUALITY_MESSAGES[label],
            "confidence_percent": round(float(probs[pred_idx]) * 100, 1),
            "probabilities": {
                name: round(float(probs[i]) * 100, 1)
                for i, name in enumerate(QUALITY_CLASS_NAMES)
            },
        }
    except Exception as exc:
        logger.error("Photo quality inference failed: %s", exc)
        return {
            "label": "unknown",
            "message": QUALITY_MESSAGES["unknown"],
            "confidence_percent": None,
            "probabilities": {},
        }


# ===================================================================
# 2.  FIELD CONFIDENCE NET-LITE  (MLP)
# ===================================================================

def _load_field_confidence():
    global _field_conf_model, _field_conf_vectorizer, _field_conf_checkpoint, _field_conf_loaded
    if _field_conf_loaded:
        return _field_conf_model, _field_conf_vectorizer, _field_conf_checkpoint
    _field_conf_loaded = True

    model_path = _find_artifact(_FIELD_CONF_MODEL_CANDIDATES)
    vec_path = _find_artifact(_FIELD_CONF_VECTORIZER_CANDIDATES)

    missing: list[str] = []
    if model_path is None:
        missing.append("field_confidence_lite.pt")
    if vec_path is None:
        missing.append("field_confidence_vectorizer.pkl")
    if missing:
        logger.error("FieldConfidenceNet-Lite artifacts missing: %s", missing)
        return None, None, None

    try:
        import torch
        from ml.ocr.neural.field_confidence_lite import FieldConfidenceMLP

        checkpoint = torch.load(str(model_path), map_location="cpu", weights_only=False)
        model = FieldConfidenceMLP(
            input_dim=checkpoint["input_dim"],
            hidden_dim=checkpoint.get("hidden_dim", 128),
            dropout=checkpoint.get("dropout", 0.15),
        )
        model.load_state_dict(checkpoint["state_dict"])
        model.eval()

        with open(str(vec_path), "rb") as fh:
            vectorizer = pickle.load(fh)  # noqa: S301

        _field_conf_model = model
        _field_conf_vectorizer = vectorizer
        _field_conf_checkpoint = checkpoint
        logger.info("Loaded FieldConfidenceNet-Lite from %s", model_path)
        return model, vectorizer, checkpoint
    except Exception as exc:
        logger.error("Failed to load FieldConfidenceNet-Lite: %s", exc)
        return None, None, None


def _run_field_confidence(
    nutrition_img: np.ndarray,
    ocr_text: str | None = None,
    parsed_nutrition: dict | None = None,
) -> dict:
    """Run FieldConfidenceNet-Lite on parsed nutrition fields."""
    model, vectorizer, checkpoint = _load_field_confidence()
    if model is None or vectorizer is None or checkpoint is None:
        return {
            "overall_confidence_percent": None,
            "message": "OCR confidence unavailable",
            "fields_evaluated": 0,
            "per_field": [],
        }

    try:
        import pandas as pd
        import torch
        from ml.ocr.neural.field_confidence_lite import (
            build_engineered_features,
            extract_numeric_value,
            extract_unit_type,
            numeric_value_normalized,
            plausible_range_flag as plausible_flag,
        )
        from ml.ocr.neural.fields import NUTRITION_FIELDS

        # Re-use pre-computed OCR text when available
        if ocr_text is None:
            from ml.ocr import extract_nutrition_text
            ocr_text = extract_nutrition_text(nutrition_img)

        # Re-use pre-parsed nutrition dict when available
        if parsed_nutrition is None:
            from ml.nlp import parse_label
            parsed_nutrition = parse_label(ocr_text).get("nutrition", {})

        # Remap parser keys to canonical model field names
        mapped: dict[str, Any] = {_map_parsed_key(k): v for k, v in parsed_nutrition.items()}
        field_names: list[str] = checkpoint.get("field_names", list(NUTRITION_FIELDS))

        # Build a row for every canonical field
        rows: list[dict[str, Any]] = []
        for field in field_names:
            value = mapped.get(field)
            rows.append({
                "field_name": field,
                "raw_ocr_text": ocr_text or "",
                "extracted_value": "" if value is None else str(value),
                "was_extracted": int(value is not None),
                "value_is_numeric": int(extract_numeric_value(value) is not None),
                "numeric_value_normalized": numeric_value_normalized(field, value),
                "plausible_range_flag": plausible_flag(field, value),
                "unit_type": extract_unit_type(value),
                "value_length": len(str(value)) if value is not None else 0,
                "severity": 0,
            })

        if not rows:
            return {
                "overall_confidence_percent": None,
                "message": "Not enough fields detected",
                "fields_evaluated": 0,
                "per_field": [],
            }

        df = pd.DataFrame(rows)

        # TF-IDF text features
        text_inputs = (
            df["raw_ocr_text"].fillna("").astype(str)
            + "\nFIELD="
            + df["field_name"].fillna("").astype(str)
            + "\nVALUE="
            + df["extracted_value"].fillna("").astype(str)
        )
        text_features = vectorizer.transform(text_inputs).toarray().astype(np.float32)

        # Engineered features
        eng_features = build_engineered_features(df, field_names)

        x = np.hstack([text_features, eng_features]).astype(np.float32)

        with torch.no_grad():
            logits = model(torch.from_numpy(x))
            probs = torch.sigmoid(logits).numpy()

        per_field: list[dict] = []
        extracted_count = 0
        confidence_sum = 0.0

        for i, row in enumerate(rows):
            conf = float(probs[i]) * 100
            if row["was_extracted"]:
                extracted_count += 1
                confidence_sum += conf
                per_field.append({
                    "field": row["field_name"],
                    "value": row["extracted_value"],
                    "confidence_percent": round(conf, 1),
                })

        if extracted_count > 0:
            overall = round(confidence_sum / extracted_count, 1)
            message = f"OCR confidence: {overall:.0f}%"
        else:
            overall = None
            message = "Not enough fields detected"

        return {
            "overall_confidence_percent": overall,
            "message": message,
            "fields_evaluated": extracted_count,
            "per_field": per_field,
        }
    except Exception as exc:
        logger.error("Field confidence inference failed: %s", exc)
        return {
            "overall_confidence_percent": None,
            "message": "OCR confidence unavailable",
            "fields_evaluated": 0,
            "per_field": [],
        }


# ===================================================================
# 3.  PUBLIC API
# ===================================================================

def run_ocr_reliability(
    nutrition_img: np.ndarray,
    ocr_text: str | None = None,
    parsed_nutrition: dict | None = None,
) -> dict:
    """Run OCR reliability models on the nutrition label image.

    Args:
        nutrition_img: OpenCV BGR array of the nutrition label photo.
        ocr_text: Pre-extracted OCR text (avoids redundant Tesseract run).
        parsed_nutrition: Pre-parsed nutrition dict (avoids redundant parsing).

    Returns:
        OCR reliability result dict.  Always returns; never raises.
    """
    try:
        photo_quality = _run_photo_quality(nutrition_img)
        field_confidence = _run_field_confidence(
            nutrition_img, ocr_text, parsed_nutrition,
        )

        quality_ok = photo_quality["label"] != "unknown"
        confidence_ok = field_confidence["overall_confidence_percent"] is not None

        result: dict[str, Any] = {
            "photo_quality": photo_quality,
            "field_confidence": field_confidence,
            "status": "ok" if (quality_ok or confidence_ok) else "unavailable",
        }
        if not quality_ok and not confidence_ok:
            result["error"] = "Both OCR reliability models unavailable"
        return result
    except Exception as exc:
        logger.error("run_ocr_reliability failed: %s", exc)
        return {
            "photo_quality": {
                "label": "unknown",
                "message": "Photo quality model unavailable",
                "confidence_percent": None,
                "probabilities": {},
            },
            "field_confidence": {
                "overall_confidence_percent": None,
                "message": "OCR confidence unavailable",
                "fields_evaluated": 0,
                "per_field": [],
            },
            "status": "unavailable",
            "error": str(exc),
        }
