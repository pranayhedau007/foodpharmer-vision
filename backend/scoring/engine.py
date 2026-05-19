import json
from pathlib import Path

_DB_PATH = Path(__file__).parent / "ingredients_db.json"
_DB: list[dict] = json.loads(_DB_PATH.read_text())["harmful_ingredients"]

_SEVERITY_DEDUCTION = {"high": 20, "medium": 10, "low": 5}
_GRADE_THRESHOLDS = [(80, "A"), (60, "B"), (40, "C"), (20, "D"), (0, "F")]


def _check_ingredients(ingredients: list[str]) -> list[dict]:
    """Match a flat ingredient list against the harmful-ingredients database."""
    found: list[dict] = []
    ingredient_blob = " ".join(ingredients).lower()

    for entry in _DB:
        for alias in entry["aliases"]:
            if alias.lower() in ingredient_blob:
                found.append({
                    "name": entry["name"],
                    "severity": entry["severity"],
                    "reason": entry["reason"],
                    "matched_alias": alias,
                })
                break  # only flag each entry once

    return found


def _check_nutrition(nutrition: dict) -> list[dict]:
    """Flag nutrition-based red flags (trans fat, very high sugar, sodium)."""
    flags: list[dict] = []

    def _grams(val: str) -> float:
        try:
            return float(val.lower().replace("g", "").replace("mg", "").strip())
        except (ValueError, AttributeError):
            return 0.0

    trans_fat = _grams(nutrition.get("trans_fat", "0g"))
    if trans_fat > 0:
        flags.append({
            "name": "Trans Fat Detected",
            "severity": "high",
            "reason": f"Contains {nutrition['trans_fat']} trans fat per serving",
            "matched_alias": "trans fat",
        })

    sugars_g = _grams(nutrition.get("sugars", "0g"))
    if sugars_g >= 20:
        flags.append({
            "name": "Very High Sugar",
            "severity": "medium",
            "reason": f"Contains {nutrition['sugars']} of sugar per serving (≥ 20g threshold)",
            "matched_alias": "sugars",
        })

    sodium_mg = _grams(nutrition.get("sodium", "0mg"))
    if sodium_mg >= 600:
        flags.append({
            "name": "High Sodium",
            "severity": "medium",
            "reason": f"Contains {nutrition['sodium']} sodium per serving (≥ 600mg threshold)",
            "matched_alias": "sodium",
        })

    return flags


def _grade(score: int) -> str:
    for threshold, letter in _GRADE_THRESHOLDS:
        if score >= threshold:
            return letter
    return "F"


def score_label(parsed: dict) -> dict:
    """
    Compute a health score and flag harmful items.

    Returns:
        {
            "score":      int   (0–100),
            "grade":      str   (A / B / C / D / F),
            "red_flags":  list  of {name, severity, reason, matched_alias},
        }
    """
    ingredient_flags = _check_ingredients(parsed.get("ingredients", []))
    nutrition_flags = _check_nutrition(parsed.get("nutrition", {}))
    red_flags = ingredient_flags + nutrition_flags

    score = 100
    for flag in red_flags:
        score -= _SEVERITY_DEDUCTION.get(flag["severity"], 0)
    score = max(0, score)

    return {
        "score": score,
        "grade": _grade(score),
        "red_flags": red_flags,
    }
