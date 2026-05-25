"""
Metrics for comparing OCR-extracted nutrition fields against ground truth.
"""

from __future__ import annotations

from typing import Optional

from ..fields import NUTRITION_FIELDS, FIELD_UNITS


def strip_unit(value: str) -> str:
    """Remove unit suffix to get bare number string."""
    for suffix in ("mcg", "mg", "g"):
        if value.endswith(suffix):
            return value[:-len(suffix)]
    return value


def field_match(pred_val: Optional[str], gt_val: str, field: str) -> bool:
    """
    Check whether a predicted value matches ground truth within tolerance.

    Integer fields (calories, mg, mcg): exact or within 1.
    Decimal fields (g): abs difference <= 0.1.
    """
    if pred_val is None:
        return False
    try:
        gt_num = float(strip_unit(gt_val))
        pred_num = float(strip_unit(pred_val))
    except (ValueError, TypeError):
        return strip_unit(pred_val) == strip_unit(gt_val)

    unit = FIELD_UNITS.get(field, "")
    if unit in ("", "mg", "mcg"):
        return abs(pred_num - gt_num) <= 1
    else:
        return abs(pred_num - gt_num) <= 0.1


def field_extraction_accuracy(parsed: dict, ground_truth: dict,
                              fields: list[str] | None = None) -> tuple[int, int, float]:
    """
    Compute field extraction accuracy.

    Returns (correct, total, accuracy).
    """
    if fields is None:
        fields = NUTRITION_FIELDS

    correct = 0
    total = 0
    for f in fields:
        gt = ground_truth.get(f)
        if gt is None:
            continue
        total += 1
        if field_match(parsed.get(f), gt, f):
            correct += 1

    acc = correct / total if total > 0 else 0.0
    return correct, total, acc


def per_field_accuracy(all_parsed: list[dict], all_gt: list[dict],
                       fields: list[str] | None = None) -> dict[str, dict]:
    """
    Compute per-field accuracy across a list of samples.

    Returns {field: {"correct": int, "total": int, "accuracy": float}}.
    """
    if fields is None:
        fields = NUTRITION_FIELDS

    stats: dict[str, dict] = {f: {"correct": 0, "total": 0} for f in fields}

    for parsed, gt in zip(all_parsed, all_gt):
        for f in fields:
            gt_val = gt.get(f)
            if gt_val is None:
                continue
            stats[f]["total"] += 1
            if field_match(parsed.get(f), gt_val, f):
                stats[f]["correct"] += 1

    for f in fields:
        t = stats[f]["total"]
        stats[f]["accuracy"] = stats[f]["correct"] / t if t > 0 else 0.0

    return stats
