import os
import re
import json
import numpy as np
import psycopg2
from pathlib import Path
from typing import Optional
from groq import Groq
from xgboost import XGBRegressor
from dotenv import load_dotenv

load_dotenv()

_groq = Groq(api_key=os.getenv("GROQ_API_KEY"))

_CANONICAL_PROMPT = """You are a food science expert. Given an ingredient name, return the canonical/standard name used in food science for this ingredient.

For example:
- "high fructose corn syrup" -> "fructose"
- "sodium chloride" -> "salt"
- "ascorbic acid" -> "vitamin c"

Return a JSON object with one field:
- "canonical_name": the standard ingredient name in lowercase

Ingredient: {ingredient}

Respond with only valid JSON, no explanation."""

_MODEL_PATH = Path(__file__).parent.parent.parent / "ml" / "models" / "xgb_health.json"
_model: Optional[XGBRegressor] = None

FEATURES = ["protein_g", "fiber_g", "sugar_g", "saturated_fat_g", "sodium_mg", "ingredients_score"]


def _load_model() -> XGBRegressor:
    global _model
    if _model is None:
        _model = XGBRegressor()
        _model.load_model(str(_MODEL_PATH))
    return _model


def _to_float(val: Optional[str]) -> float:
    if not val:
        return 0.0
    try:
        return float(re.sub(r"[^\d.]", "", str(val)))
    except ValueError:
        return 0.0


def _resolve_ingredient(name: str, cur, conn) -> None:
    """Ensure `name` exists in ingredient_aliases, inserting it if needed."""
    cur.execute("SELECT id FROM ingredient_aliases WHERE LOWER(alias) = LOWER(%s)", (name,))
    if cur.fetchone():
        return  # already aliased

    # Check if it directly matches an ingredient
    cur.execute("SELECT id FROM ingredients WHERE LOWER(name) = LOWER(%s)", (name,))
    row = cur.fetchone()
    if row:
        ingredient_id = row[0]
    else:
        # Ask Groq for the canonical name
        try:
            response = _groq.chat.completions.create(
                model="llama-3.3-70b-versatile",
                messages=[{"role": "user", "content": _CANONICAL_PROMPT.format(ingredient=name)}],
                response_format={"type": "json_object"},
                temperature=0,
            )
            data = json.loads(response.choices[0].message.content)
            canonical = data["canonical_name"]
            if isinstance(canonical, dict):
                canonical = canonical.get("name") or next(iter(canonical.values()))
            canonical = str(canonical).strip().lower()
        except Exception:
            canonical = name  # fallback: use as-is

        cur.execute("SELECT id FROM ingredients WHERE LOWER(name) = LOWER(%s)", (canonical,))
        row = cur.fetchone()
        if row:
            ingredient_id = row[0]
        else:
            cur.execute("INSERT INTO ingredients (name) VALUES (%s) RETURNING id", (canonical,))
            ingredient_id = cur.fetchone()[0]
        conn.commit()

    cur.execute(
        "INSERT INTO ingredient_aliases (alias, ingredient_id) VALUES (%s, %s) ON CONFLICT DO NOTHING",
        (name, ingredient_id),
    )
    conn.commit()
    print(f"  resolved '{name}' -> ingredient_id={ingredient_id}")


def _compute_ingredients_score(ingredients: list[str]) -> float:
    """Resolve any unknown ingredients then compute position-weighted score."""
    conn = psycopg2.connect(
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        host=os.getenv("DB_HOST"),
        port=os.getenv("DB_PORT"),
    )
    cur = conn.cursor()

    # Ensure every ingredient is in the alias table before scoring
    for ingredient in ingredients:
        ingredient = ingredient.strip()
        if ingredient:
            _resolve_ingredient(ingredient, cur, conn)

    weighted = []
    for pos, ingredient in enumerate(ingredients, 1):
        ingredient = ingredient.strip()
        if not ingredient:
            continue
        cur.execute(
            """
            SELECT i.health_score
            FROM ingredient_aliases ia
            JOIN ingredients i ON ia.ingredient_id = i.id
            WHERE LOWER(ia.alias) = LOWER(%s) AND i.health_score IS NOT NULL
            """,
            (ingredient,)
        )
        row = cur.fetchone()
        if row:
            weighted.append((pos, row[0]))

    cur.close()
    conn.close()

    if not weighted:
        return 50.0  # neutral fallback if nothing matched

    weighted_sum = sum(score / pos for pos, score in weighted)
    max_possible = sum(10.0 / pos for pos, _ in weighted)
    return round((weighted_sum / max_possible) * 100, 2)


def resolve_ingredient_names(ingredients: list[str]) -> list[str]:
    """
    Map each alias to its canonical ingredient name and deduplicate,
    preserving order of first occurrence.
    Must be called after predict_from_parsed so all aliases are already in the DB.
    """
    conn = psycopg2.connect(
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        host=os.getenv("DB_HOST"),
        port=os.getenv("DB_PORT"),
    )
    cur = conn.cursor()

    seen: set[str] = set()
    result: list[str] = []
    for ing in ingredients:
        ing = ing.strip()
        if not ing:
            continue
        cur.execute(
            """
            SELECT i.name
            FROM ingredient_aliases ia
            JOIN ingredients i ON ia.ingredient_id = i.id
            WHERE LOWER(ia.alias) = LOWER(%s)
            LIMIT 1
            """,
            (ing,),
        )
        row = cur.fetchone()
        canonical = row[0] if row else ing
        key = canonical.lower()
        if key not in seen:
            seen.add(key)
            result.append(canonical)

    cur.close()
    conn.close()
    return result


def predict_from_parsed(parsed: dict) -> dict:
    """
    Takes the output of parse_label() and returns an XGBoost health score.

    Args:
        parsed: {"ingredients": [...], "nutrition": {...}, "raw_text": "..."}

    Returns:
        {"xgb_score": float, "features": dict}
    """
    nutrition = parsed.get("nutrition", {})
    ingredients = parsed.get("ingredients", [])

    ingredients_score = _compute_ingredients_score(ingredients)

    features = {
        "protein_g":        _to_float(nutrition.get("protein")),
        "fiber_g":          _to_float(nutrition.get("dietary_fiber")),
        "sugar_g":          _to_float(nutrition.get("sugars")),
        "saturated_fat_g":  _to_float(nutrition.get("saturated_fat")),
        "sodium_mg":        _to_float(nutrition.get("sodium")),
        "ingredients_score": ingredients_score,
    }

    X = np.array([[features[f] for f in FEATURES]])
    score = float(_load_model().predict(X)[0])
    score = round(max(0.0, min(100.0, score)), 2)

    return {"xgb_score": score, "features": features}
