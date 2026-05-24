import os
import psycopg2
from dotenv import load_dotenv

load_dotenv()


def detect_allergens(ingredients: list) -> list:
    """
    For each parsed ingredient, resolve it via ingredient_aliases to its
    canonical ingredient, then check if that ingredient is in food_allergies.

    Returns a deduplicated list of allergen names found.
    """
    if not ingredients:
        return []

    conn = psycopg2.connect(
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        host=os.getenv("DB_HOST"),
        port=os.getenv("DB_PORT"),
    )
    cur = conn.cursor()

    found = []
    seen = set()

    for ingredient in ingredients:
        ingredient = ingredient.strip()
        if not ingredient:
            continue

        cur.execute(
            """
            SELECT fa.ingredient_name
            FROM ingredient_aliases ia
            JOIN ingredients i ON ia.ingredient_id = i.id
            JOIN food_allergies fa ON LOWER(fa.ingredient_name) = LOWER(i.name)
            WHERE LOWER(ia.alias) = LOWER(%s)
            LIMIT 1
            """,
            (ingredient,)
        )
        row = cur.fetchone()
        if row:
            allergen = row[0]
            if allergen.lower() not in seen:
                seen.add(allergen.lower())
                found.append(allergen)

    cur.close()
    conn.close()

    return found
