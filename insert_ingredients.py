import os
import sys
import json
import psycopg2
import pandas as pd
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

PROMPT_TEMPLATE = """You are a food science expert. Given an ingredient name, return a JSON object with exactly these fields:

- "is_valid": true if this is a real, recognized food ingredient, additive, or substance used in food products — false if it is gibberish, a non-food item, a brand name, a vague non-ingredient term, or otherwise unrecognizable
- "category": the type of ingredient (e.g. "sweetener", "preservative", "emulsifier", "vitamin", "mineral", "natural flavor", "artificial color", "protein", "fat", "fiber", "spice", "thickener", "antioxidant", etc.) — use null if is_valid is false
- "health_label": one of "healthy", "neutral", "caution", or "avoid" — use null if is_valid is false
- "health_score": a float from 0.0 (worst) to 10.0 (best) representing how healthy this ingredient is — use null if is_valid is false

Ingredient: {ingredient}

Respond with only valid JSON, no explanation."""


def classify_ingredient(name: str) -> dict:
    response = client.chat.completions.create(
        model="llama-3.3-70b-versatile",
        messages=[{"role": "user", "content": PROMPT_TEMPLATE.format(ingredient=name)}],
        response_format={"type": "json_object"},
        temperature=0.2,
    )
    return json.loads(response.choices[0].message.content)


def insert_ingredient(name: str, data: dict):
    cur.execute(
        """
        INSERT INTO ingredients (name, category, health_label, health_score)
        VALUES (%s, %s, %s, %s)
        ON CONFLICT (name) DO NOTHING
        """,
        (name, data.get("category"), data.get("health_label"), data.get("health_score")),
    )


def main(csv_path: str):
    df = pd.read_csv(csv_path)

    # Accept a column named "ingredient", "name", or use the first column
    if "ingredient" in df.columns:
        ingredients = df["ingredient"].dropna().tolist()
    elif "name" in df.columns:
        ingredients = df["name"].dropna().tolist()
    else:
        ingredients = df.iloc[:, 0].dropna().tolist()

    print(f"Processing {len(ingredients)} ingredients...")

    for i, name in enumerate(ingredients, 1):
        name = str(name).strip()
        if not name:
            continue
        try:
            data = classify_ingredient(name)
            if not data.get("is_valid"):
                print(f"[{i}/{len(ingredients)}] SKIPPED '{name}' — not a recognized ingredient")
                continue
            insert_ingredient(name, data)
            conn.commit()
            print(f"[{i}/{len(ingredients)}] {name} → category={data.get('category')}, label={data.get('health_label')}, score={data.get('health_score')}")
        except Exception as e:
            conn.rollback()
            print(f"[{i}/{len(ingredients)}] ERROR on '{name}': {e}")

    cur.close()
    conn.close()
    print("Done.")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python insert_ingredients.py <path_to_csv>")
        sys.exit(1)
    main(sys.argv[1])
