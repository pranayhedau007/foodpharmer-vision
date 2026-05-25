"""Shared utilities for FieldConfidenceNet-Lite.

The model predicts whether one parsed nutrition field is correct, using the
raw OCR text plus lightweight engineered features for that field.
"""

from __future__ import annotations

import re
from typing import Any

import numpy as np
import pandas as pd
import torch
import torch.nn as nn

from .fields import FIELD_UNITS, NUTRITION_FIELDS


PLAUSIBLE_RANGES: dict[str, tuple[float, float]] = {
    "calories": (0, 1000),
    "total_fat": (0, 100),
    "saturated_fat": (0, 50),
    "trans_fat": (0, 20),
    "cholesterol": (0, 500),
    "sodium": (0, 3000),
    "total_carbohydrate": (0, 200),
    "dietary_fiber": (0, 100),
    "total_sugars": (0, 150),
    "added_sugars": (0, 150),
    "protein": (0, 100),
    "vitamin_d": (0, 100),
    "calcium": (0, 2000),
    "iron": (0, 100),
    "potassium": (0, 5000),
}

UNIT_TYPES = ["none", "g", "mg", "mcg", "percent", "other"]


def clean_id_from_image_id(image_id: str) -> str:
    """Return the synthetic clean label id for a clean/corrupted image id."""
    return str(image_id).split("__")[0]


def extract_severity_from_id(image_id: str) -> int:
    """Parse corruption severity from names like label_000001__sev3__aug00."""
    match = re.search(r"__sev(\d+)__", str(image_id))
    if not match:
        return 0
    return int(match.group(1))


def normalize_value_string(value: Any) -> str:
    """Normalize OCR/ground-truth nutrition values for tolerant comparison."""
    if value is None or (isinstance(value, float) and np.isnan(value)):
        return ""
    text = str(value).strip().lower()
    text = text.replace(",", "")
    text = re.sub(r"less\s+than\s+", "<", text)
    text = re.sub(r"\s+(?=mcg\b|mg\b|g\b|%)", "", text)
    text = re.sub(r"<\s+", "<", text)
    text = re.sub(r"\s+", " ", text)
    return text.strip()


def extract_numeric_value(value: Any) -> float | None:
    """Extract the first numeric value from a nutrition string."""
    text = normalize_value_string(value)
    if not text:
        return None
    match = re.search(r"-?\d+(?:\.\d+)?", text)
    if not match:
        return None
    try:
        return float(match.group(0))
    except ValueError:
        return None


def extract_unit_type(value: Any) -> str:
    """Return a coarse unit category for a nutrition value string."""
    text = normalize_value_string(value)
    if not text:
        return "none"
    if "%" in text:
        return "percent"
    if "mcg" in text:
        return "mcg"
    if "mg" in text:
        return "mg"
    if re.search(r"\d\s*g\b|<\d+g\b", text):
        return "g"
    if extract_numeric_value(text) is not None:
        return "none"
    return "other"


def tolerant_value_match(predicted: Any, ground_truth: Any, field: str | None = None) -> bool:
    """Compare parsed OCR values against ground truth with OCR-friendly tolerance."""
    if ground_truth is None or (isinstance(ground_truth, float) and np.isnan(ground_truth)):
        return False
    if predicted is None or (isinstance(predicted, float) and np.isnan(predicted)):
        return False

    norm_pred = normalize_value_string(predicted)
    norm_gt = normalize_value_string(ground_truth)
    if not norm_pred or not norm_gt:
        return False
    if norm_pred == norm_gt:
        return True

    pred_num = extract_numeric_value(norm_pred)
    gt_num = extract_numeric_value(norm_gt)
    if pred_num is None or gt_num is None:
        return False

    pred_unit = extract_unit_type(norm_pred)
    gt_unit = extract_unit_type(norm_gt)
    units_compatible = pred_unit == gt_unit or "percent" in {pred_unit, gt_unit}
    if field == "calories":
        units_compatible = True

    return units_compatible and abs(pred_num - gt_num) <= 1.0


def numeric_value_normalized(field: str, value: Any) -> float:
    """Normalize a parsed numeric value by the field's plausible upper range."""
    num = extract_numeric_value(value)
    if num is None:
        return 0.0
    low, high = PLAUSIBLE_RANGES.get(field, (0.0, max(abs(num), 1.0)))
    denom = max(high - low, 1.0)
    return float(np.clip((num - low) / denom, -1.0, 2.0))


def plausible_range_flag(field: str, value: Any) -> int:
    """Return 1 if the parsed value is inside a broad plausible range."""
    num = extract_numeric_value(value)
    if num is None:
        return 0
    unit = extract_unit_type(value)
    if unit == "percent":
        return int(0 <= num <= 100)
    low, high = PLAUSIBLE_RANGES.get(field, (float("-inf"), float("inf")))
    return int(low <= num <= high)


def make_field_confidence_row(
    *,
    image_id: str,
    field_name: str,
    raw_ocr_text: str,
    parsed_fields: dict[str, Any],
    ground_truth_fields: dict[str, Any],
    severity: int | None = None,
    dataset: str = "",
) -> dict[str, Any] | None:
    """Build one FieldConfidenceNet-Lite training/eval row."""
    if field_name not in ground_truth_fields or ground_truth_fields.get(field_name) is None:
        return None

    extracted = parsed_fields.get(field_name)
    gt_value = ground_truth_fields.get(field_name)
    severity_value = extract_severity_from_id(image_id) if severity is None else severity
    unit_type = extract_unit_type(extracted)
    numeric = extract_numeric_value(extracted)

    return {
        "dataset": dataset,
        "image_id": image_id,
        "clean_id": clean_id_from_image_id(image_id),
        "field_name": field_name,
        "raw_ocr_text": raw_ocr_text or "",
        "extracted_value": "" if extracted is None else str(extracted),
        "ground_truth_value": "" if gt_value is None else str(gt_value),
        "was_extracted": int(extracted is not None),
        "value_is_numeric": int(numeric is not None),
        "numeric_value_normalized": numeric_value_normalized(field_name, extracted),
        "plausible_range_flag": plausible_range_flag(field_name, extracted),
        "unit_type": unit_type,
        "value_length": len(str(extracted)) if extracted is not None else 0,
        "severity": int(severity_value),
        "label_correct": int(tolerant_value_match(extracted, gt_value, field_name)),
    }


def build_engineered_features(df: pd.DataFrame, field_names: list[str]) -> np.ndarray:
    """Create numeric, unit, and field one-hot features from pair rows."""
    if df.empty:
        return np.zeros((0, 0), dtype=np.float32)

    text_lengths = df["raw_ocr_text"].fillna("").astype(str).str.len().to_numpy(dtype=np.float32)
    line_counts = (
        df["raw_ocr_text"].fillna("").astype(str).str.count(r"\n").to_numpy(dtype=np.float32) + 1.0
    )

    base = np.column_stack([
        df["was_extracted"].fillna(0).astype(float).to_numpy(),
        df["value_is_numeric"].fillna(0).astype(float).to_numpy(),
        df["numeric_value_normalized"].fillna(0).astype(float).to_numpy(),
        df["plausible_range_flag"].fillna(0).astype(float).to_numpy(),
        np.clip(df["value_length"].fillna(0).astype(float).to_numpy() / 20.0, 0.0, 5.0),
        np.clip(df["severity"].fillna(0).astype(float).to_numpy() / 5.0, 0.0, 2.0),
        np.clip(text_lengths / 2500.0, 0.0, 5.0),
        np.clip(line_counts / 60.0, 0.0, 5.0),
    ]).astype(np.float32)

    units = df["unit_type"].fillna("none").astype(str).to_numpy()
    unit_one_hot = np.zeros((len(df), len(UNIT_TYPES)), dtype=np.float32)
    unit_lookup = {name: idx for idx, name in enumerate(UNIT_TYPES)}
    for row_idx, unit in enumerate(units):
        unit_one_hot[row_idx, unit_lookup.get(unit, unit_lookup["other"])] = 1.0

    fields = df["field_name"].fillna("").astype(str).to_numpy()
    field_one_hot = np.zeros((len(df), len(field_names)), dtype=np.float32)
    field_lookup = {name: idx for idx, name in enumerate(field_names)}
    for row_idx, field in enumerate(fields):
        if field in field_lookup:
            field_one_hot[row_idx, field_lookup[field]] = 1.0

    return np.hstack([base, unit_one_hot, field_one_hot]).astype(np.float32)


class FieldConfidenceMLP(nn.Module):
    """Small binary classifier for per-field OCR correctness."""

    def __init__(self, input_dim: int, hidden_dim: int = 128, dropout: float = 0.15) -> None:
        super().__init__()
        self.net = nn.Sequential(
            nn.Linear(input_dim, hidden_dim),
            nn.ReLU(),
            nn.Dropout(dropout),
            nn.Linear(hidden_dim, max(hidden_dim // 2, 16)),
            nn.ReLU(),
            nn.Dropout(dropout),
            nn.Linear(max(hidden_dim // 2, 16), 1),
        )

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        return self.net(x).squeeze(-1)


def default_field_names(df: pd.DataFrame | None = None) -> list[str]:
    """Use canonical field order, extended by any extra fields present."""
    fields = list(NUTRITION_FIELDS)
    if df is not None and "field_name" in df:
        for field in sorted(set(df["field_name"].dropna().astype(str))):
            if field not in fields:
                fields.append(field)
    return fields

