from __future__ import annotations
import json
import os
import re

from dotenv import load_dotenv
from groq import Groq

load_dotenv()
_groq: Groq | None = None


def _get_groq() -> Groq:
    global _groq
    if _groq is None:
        _groq = Groq(api_key=os.getenv("GROQ_API_KEY"))
    return _groq

_CLEAN_PROMPT = """\
You are a food label expert. Below is raw OCR text from a food product label.
It contains OCR noise, garbled characters, and artifacts.
Extract only the actual ingredient names as a clean list.

Rules:
- Return a JSON object with one key: "ingredients" containing a list of strings
- Each string is one clean ingredient name in lowercase
- Remove all OCR noise (random symbols, partial words, table borders)
- Fix obvious OCR typos (e.g. "hydrolwyzed" -> "hydrolyzed", "andior" -> "and/or")
- Keep sub-ingredients in parentheses if they make sense
- Do not invent ingredients that are not present in the text

Raw OCR text:
{text}"""


# ── Nutrition facts (regex — fast, reliable for structured numbers) ────────────

_NUTRIENT_PATTERNS: list[tuple[str, str, str]] = [
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
    return re.sub(r"[|\\]{1,3}", " ", text)


def _fix_gram_value(raw: str, g_captured: str) -> str:
    value = raw.rstrip(".")
    if g_captured == "g":
        return value
    if value.endswith("9") and len(value) > 1:
        trimmed = value[:-1].rstrip(".")
        if trimmed and (trimmed[-1].isdigit() or trimmed[-1] == "."):
            return trimmed
    return value


def parse_nutrition(text: str) -> dict[str, str]:
    """Extract nutrition facts from raw OCR text using regex."""
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


def clean_ingredients_with_groq(ocr_text: str) -> list[str]:
    """
    Send raw OCR text to Groq (Llama 3.3 70B) to extract a clean ingredient list.
    Falls back to an empty list on failure so the pipeline doesn't crash.
    """
    try:
        response = _get_groq().chat.completions.create(
            model="llama-3.3-70b-versatile",
            messages=[{"role": "user", "content": _CLEAN_PROMPT.format(text=ocr_text)}],
            response_format={"type": "json_object"},
            temperature=0,
            max_tokens=300,
        )
        data = json.loads(response.choices[0].message.content)
        return [i.strip().lower() for i in data.get("ingredients", []) if i.strip()]
    except Exception as e:
        print(f"[groq] clean_ingredients_with_groq failed: {e}")
        return []
