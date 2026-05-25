"""
Parse Tesseract OCR output from synthetic nutrition labels.

This parser is tuned for the exact formatting produced by
synthetic_label_generator.py and handles common Tesseract misreads.
"""

from __future__ import annotations

import re
from typing import Optional

from .fields import NUTRITION_FIELDS, FIELD_UNITS

# ---------------------------------------------------------------------------
# Regex patterns for each field.  Order matters only for readability.
# Each pattern captures the *numeric* portion of the value.
#
# Design notes:
#   - \s* (not \s+) between words: Tesseract often merges words
#     ("SaturatedFat", "TotalCarbohydrate")
#   - Patterns allow optional leading garbage (indent artefacts)
#   - Multiple spelling variants for OCR-confused field names
# ---------------------------------------------------------------------------

_PATTERNS: dict[str, re.Pattern] = {
    "calories": re.compile(
        r"calorie[s ]?\s*(\d{1,4})", re.I),

    "total_fat": re.compile(
        r"total\s*fat\s+([\d.]+)\s*g?", re.I),

    "saturated_fat": re.compile(
        r"saturated\s*fat\s+([\d.]+)\s*g?", re.I),

    "trans_fat": re.compile(
        r"trans\s*fat\s+([\d.]+)\s*g?", re.I),

    "cholesterol": re.compile(
        r"cholesterol\s+([\d.]+)\s*m?g?", re.I),

    "sodium": re.compile(
        r"sod[il1]um\s+([\d.]+)\s*m?g?", re.I),

    "total_carbohydrate": re.compile(
        r"total\s*carbo\w*\s+([\d.]+)\s*g?", re.I),

    "dietary_fiber": re.compile(
        r"(?:dietary\s*)?fiber\s+([\d.]+)\s*g?", re.I),

    "total_sugars": re.compile(
        r"(?:total\s*)?sugars?\s+([\d.]+)\s*g?", re.I),

    "added_sugars": re.compile(
        r"(?:includes?\s*)?([\d.]+)\s*g?\s*added\s*sugars?", re.I),

    "protein": re.compile(
        r"prote[il1]n\s+([\d.]+)\s*g?", re.I),

    "vitamin_d": re.compile(
        r"v[il1]tam[il1]n\s*d\s+([\d.]+)\s*m?c?g?", re.I),

    "calcium": re.compile(
        r"calc[il1]um\s+([\d.]+)\s*m?g?", re.I),

    "iron": re.compile(
        r"[il1I]ron\s+([\d.]+)\s*m?g?", re.I),

    "potassium": re.compile(
        r"potass[il1]um\s+([\d.]+)\s*m?g?", re.I),
}


def _clean_ocr_text(text: str) -> str:
    """Normalise common Tesseract artefacts."""
    # Strip non-ASCII garbage (indent markers, table borders)
    text = re.sub(r"[^\x20-\x7E\n]", " ", text)
    # Table border chars
    text = re.sub(r"[|\\]{1,3}", " ", text)

    # --- OCR character confusions ---
    # "lron" -> "Iron", "lncludes" -> "Includes" (lowercase L at word start)
    text = re.sub(r"\bl(?=ron\b)", "I", text)
    text = re.sub(r"\bl(?=ncludes?\b)", "I", text)
    # "O" -> "0" when surrounded by digits or before unit letters (mg/mcg/g)
    # e.g. "Omg" -> "0mg", "1O5mg" -> "105mg"
    text = re.sub(r"(?<=\d)O(?=\d)", "0", text)
    text = re.sub(r"\bO(?=m?c?g\b)", "0", text)
    # "img" -> "1mg" (digit 1 misread as lowercase i before mg)
    text = re.sub(r"\bimg\b", "1mg", text)
    # "S" -> "5" before mcg/mg (e.g. "Smcg" -> "5mcg")
    text = re.sub(r"\bS(?=m?c?g\b)", "5", text)

    # Collapse whitespace (but preserve newlines for line-based fallback)
    text = re.sub(r"[^\S\n]+", " ", text)
    # Also collapse across newlines for the single-string search
    text = re.sub(r"\n+", " ", text)

    return text


def parse_synthetic_ocr(raw_text: str) -> dict[str, Optional[str]]:
    """
    Extract nutrition fields from raw OCR text.

    Returns a dict keyed by field name.  Values include the unit suffix
    (e.g. ``"4g"``, ``"430mg"``).  Missing fields map to ``None``.
    """
    cleaned = _clean_ocr_text(raw_text)
    result: dict[str, Optional[str]] = {}

    for field in NUTRITION_FIELDS:
        pat = _PATTERNS.get(field)
        if pat is None:
            result[field] = None
            continue
        m = pat.search(cleaned)
        if m is None:
            result[field] = None
            continue
        value = m.group(1).rstrip(".")
        unit = FIELD_UNITS.get(field, "")
        result[field] = f"{value}{unit}"

    return result
