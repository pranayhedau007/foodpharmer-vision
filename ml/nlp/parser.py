from __future__ import annotations
import os
import re
import json
from groq import Groq
from dotenv import load_dotenv

load_dotenv()
_groq = Groq(api_key=os.getenv("GROQ_API_KEY"))

_CLEAN_PROMPT = """You are a food label expert. Below is raw OCR text from a food product's ingredients section.
It contains OCR noise, garbled characters, and artifacts. Extract only the actual ingredient names as a clean list.

Rules:
- Return a JSON object with one key: "ingredients" containing a list of strings
- Each string should be one clean ingredient name in lowercase
- Remove all OCR noise (=f, =|, \\@, random symbols, partial words that are clearly noise)
- Fix obvious OCR typos (e.g. "hydrolwyzed" -> "hydrolyzed", "andior" -> "and/or")
- Keep sub-ingredients in parentheses if they make sense
- Do not invent ingredients that aren't there

Raw OCR text:
{text}"""


# ── Ingredients ────────────────────────────────────────────────────────────────

_INGREDIENTS_RE = re.compile(
    r".{0,3}ngredients?\s*[:\(]?\s*(.+?)(?:\n\n|\Z)",
    re.IGNORECASE | re.DOTALL,
)


def _parse_ingredients(text: str) -> list[str]:
    match = _INGREDIENTS_RE.search(text)
    if not match:
        return []
    raw = match.group(1)
    raw = re.sub(r"\s+", " ", raw).strip().rstrip(".")
    items = [i.strip().lower() for i in re.split(r",\s*", raw) if i.strip()]
    return items


# ── Nutrition facts ────────────────────────────────────────────────────────────

# Each pattern captures a raw token that may include the "g" unit or a "9"
# that Tesseract substituted for "g" (they look similar at small sizes).
# A second capture group grabs a trailing "g" when Tesseract reads it correctly.
_NUTRIENT_PATTERNS: list[tuple[str, str, str]] = [
    # (key, pattern, unit)
    ("calories",           r"ca[tl]or(?:ies|es|ie)?\s+(\d{1,4})",         ""),
    ("calories_from_fat",  r"ca[tl]or\w*\s+from\s+fat\s+(\d{1,4})",       ""),
    ("total_fat",          r"total\s+fat\s+([\d.]{1,6})(g?)",              "g"),
    ("saturated_fat",      r"saturated\s+fat\s+([\d.]{1,6})(g?)",          "g"),
    ("trans_fat",          r"trans\s+fat\s+([\d.]{1,6})(g?)",              "g"),
    ("cholesterol",        r"cholesterol\s+([\d.]{1,6})\s*m?g?",           "mg"),
    ("sodium",             r"sodium\s+([\d.]{1,6})\s*m?g?",               "mg"),
    ("total_carbohydrate", r"total\s+carbo\w*\s+([\d.]{1,6})(g?)",        "g"),
    ("dietary_fiber",      r"dietary\s+fiber\s+([\d.]{1,6})(g?)",          "g"),
    ("sugars",             r"sugars?\s+([\d.]{1,6})(g?)",                  "g"),
    ("protein",            r"protein\s+([\d.]{1,6})(g?)",                  "g"),
]


def _clean_for_ocr(text: str) -> str:
    """Strip table border chars that Tesseract emits for ruled lines."""
    return re.sub(r"[|\\]{1,3}", " ", text)


def _fix_gram_value(raw: str, g_captured: str) -> str:
    """
    Normalise a gram-based numeric value from OCR.

    Tesseract frequently reads the 'g' unit as '9' (they look similar at
    small sizes, especially after adaptive thresholding).  When 'g' was NOT
    captured correctly, a trailing '9' (and any trailing periods) is stripped.

    Examples:
        '79.'  g_captured=''  →  '7'   (7g → 79.)
        '2.59' g_captured=''  →  '2.5' (2.5g → 2.59)
        '359'  g_captured=''  →  '35'  (35g → 359)
        '7'    g_captured='g' →  '7'   (correctly read)
    """
    value = raw.rstrip(".")
    if g_captured == "g":
        return value  # Tesseract read the unit correctly
    if value.endswith("9") and len(value) > 1:
        trimmed = value[:-1].rstrip(".")
        if trimmed and (trimmed[-1].isdigit() or trimmed[-1] == "."):
            return trimmed
    return value


def _parse_nutrition(text: str) -> dict[str, str]:
    nutrition: dict[str, str] = {}
    cleaned = _clean_for_ocr(text).lower()
    for key, pattern, unit in _NUTRIENT_PATTERNS:
        m = re.search(pattern, cleaned)
        if not m:
            continue
        raw = m.group(1).strip()
        if unit == "g":
            g_cap = m.group(2) if m.lastindex and m.lastindex >= 2 else ""
            value = _fix_gram_value(raw, g_cap)
        else:
            value = raw.rstrip(".")
        nutrition[key] = f"{value}{unit}"
    return nutrition


# ── Public API ─────────────────────────────────────────────────────────────────

def _clean_ingredients_with_groq(raw_text: str) -> list[str]:
    try:
        response = _groq.chat.completions.create(
            model="llama-3.1-8b-instant",
            messages=[{"role": "user", "content": _CLEAN_PROMPT.format(text=raw_text)}],
            response_format={"type": "json_object"},
            temperature=0,
        )
        data = json.loads(response.choices[0].message.content)
        return [i.strip().lower() for i in data.get("ingredients", []) if i.strip()]
    except Exception:
        return _parse_ingredients(raw_text)


def parse_label(text: str) -> dict:
    """
    Parse raw OCR text into structured label data.

    Returns:
        {
            "ingredients": [...],
            "nutrition":   {"calories": "210", "total_fat": "7g", ...},
            "raw_text":    "...",
        }
    """
    return {
        "ingredients": _clean_ingredients_with_groq(text),
        "nutrition": _parse_nutrition(text),
        "raw_text": text.strip(),
    }
