import os
import json
import psycopg2
from typing import Optional
from groq import Groq
from dotenv import load_dotenv

load_dotenv()

client = Groq(api_key=os.getenv("GROQ_API_KEY"))

conn = psycopg2.connect(
    dbname=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT"),
)
cur = conn.cursor()

GROQ_PROMPT = """You are a food science expert. Given an ingredient name, return the canonical/standard name used in food science for this ingredient.

For example:
- "high fructose corn syrup" -> "fructose"
- "sodium chloride" -> "salt"
- "ascorbic acid" -> "vitamin c"

Return a JSON object with one field:
- "canonical_name": the standard ingredient name in lowercase

Ingredient: {ingredient}

Respond with only valid JSON, no explanation."""


def already_aliased(name: str) -> bool:
    cur.execute("SELECT id FROM ingredient_aliases WHERE LOWER(alias) = LOWER(%s)", (name,))
    return cur.fetchone() is not None


def find_in_ingredients(name: str) -> Optional[tuple]:
    cur.execute("SELECT id, name FROM ingredients WHERE LOWER(name) = LOWER(%s)", (name,))
    return cur.fetchone()


def get_groq_canonical(name: str) -> str:
    response = client.chat.completions.create(
        model="llama-3.3-70b-versatile",
        messages=[{"role": "user", "content": GROQ_PROMPT.format(ingredient=name)}],
        response_format={"type": "json_object"},
        temperature=0.2,
    )
    data = json.loads(response.choices[0].message.content)
    canonical = data["canonical_name"]
    if isinstance(canonical, dict):
        canonical = canonical.get("name") or next(iter(canonical.values()))
    return str(canonical).strip().lower()


def get_or_insert_ingredient(canonical_name: str) -> int:
    cur.execute("SELECT id FROM ingredients WHERE LOWER(name) = LOWER(%s)", (canonical_name,))
    row = cur.fetchone()
    if row:
        return row[0]
    cur.execute(
        "INSERT INTO ingredients (name) VALUES (%s) RETURNING id",
        (canonical_name,)
    )
    return cur.fetchone()[0]


def insert_alias(alias: str, ingredient_id: int):
    cur.execute(
        "INSERT INTO ingredient_aliases (alias, ingredient_id) VALUES (%s, %s)",
        (alias, ingredient_id)
    )


def resolve_ingredient(name: str):
    name = name.strip()

    if already_aliased(name):
        print(f"'{name}' is already aliased — skipping.")
        return

    match = find_in_ingredients(name)

    if match:
        ingredient_id, matched_name = match
        insert_alias(name, ingredient_id)
        conn.commit()
        print(f"'{name}' matched '{matched_name}' in ingredients table -> inserted as alias (ingredient_id={ingredient_id})")
    else:
        canonical = get_groq_canonical(name)
        ingredient_id = get_or_insert_ingredient(canonical)
        conn.commit()
        insert_alias(name, ingredient_id)
        conn.commit()
        print(f"'{name}' not found -> Groq canonical: '{canonical}' -> inserted as alias (ingredient_id={ingredient_id})")


if __name__ == "__main__":
    import sys
    if len(sys.argv) != 2:
        print("Usage: python get_similar_ingredient_name.py \"<ingredient name>\"")
        sys.exit(1)
    resolve_ingredient(sys.argv[1])
    cur.close()
    conn.close()
