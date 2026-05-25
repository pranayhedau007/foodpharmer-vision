"""
Scans the ingredients table and uses Groq to identify common food allergens,
then inserts them into the food_allergies table.
"""
import os
import json
import psycopg2
from groq import Groq
from dotenv import load_dotenv

load_dotenv()

BATCH_SIZE = 150

GROQ_PROMPT = """You are a food safety expert. Below is a list of ingredient names from a food database.

Identify which ones are common food allergens or directly derived from the major allergen groups:
- Milk / dairy (e.g. whey, casein, lactose, butter, cream, cheese)
- Eggs (e.g. albumin, mayonnaise)
- Fish (e.g. cod, salmon, anchovies)
- Shellfish (e.g. shrimp, crab, lobster)
- Tree nuts (e.g. almond, cashew, walnut, pecan, pistachio, hazelnut)
- Peanuts (e.g. peanut oil, groundnut)
- Wheat / gluten (e.g. flour, semolina, spelt, farro, malt)
- Soybeans (e.g. tofu, tempeh, soy lecithin, miso)
- Sesame (e.g. tahini, sesame oil)
- Sulfites / sulfur dioxide (preservative allergen)
- Mustard
- Celery
- Lupin

Return a JSON object with one key: "allergens" — a list of ingredient names from the input list
that are allergens or allergen-derived. Only include names that appear exactly in the input list.
Do not invent names. If none match, return an empty list.

Ingredient list:
{ingredients}"""


def get_all_ingredients(cur) -> list[tuple[int, str]]:
    cur.execute("SELECT id, name FROM ingredients WHERE name IS NOT NULL ORDER BY id")
    return cur.fetchall()


def ask_groq(client: Groq, batch: list[str]) -> list[str]:
    ingredient_text = "\n".join(f"- {name}" for name in batch)
    response = client.chat.completions.create(
        model="llama-3.3-70b-versatile",
        messages=[{"role": "user", "content": GROQ_PROMPT.format(ingredients=ingredient_text)}],
        response_format={"type": "json_object"},
        temperature=0,
    )
    data = json.loads(response.choices[0].message.content)
    return [a.strip().lower() for a in data.get("allergens", []) if a.strip()]


def insert_allergens(cur, conn, allergens: list[str]) -> int:
    inserted = 0
    for name in allergens:
        cur.execute(
            "INSERT INTO food_allergies (ingredient_name) VALUES (%s) ON CONFLICT DO NOTHING",
            (name,)
        )
        if cur.rowcount:
            inserted += 1
    conn.commit()
    return inserted


def main():
    conn = psycopg2.connect(
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        host=os.getenv("DB_HOST"),
        port=os.getenv("DB_PORT"),
    )
    cur = conn.cursor()
    client = Groq(api_key=os.getenv("GROQ_API_KEY"))

    rows = get_all_ingredients(cur)
    names = [name for _, name in rows]
    total_batches = (len(names) + BATCH_SIZE - 1) // BATCH_SIZE
    print(f"Found {len(names)} ingredients -> {total_batches} batches of {BATCH_SIZE}")

    total_inserted = 0
    for i in range(0, len(names), BATCH_SIZE):
        batch = names[i : i + BATCH_SIZE]
        batch_num = i // BATCH_SIZE + 1
        print(f"[{batch_num}/{total_batches}] Sending batch to Groq...", end=" ", flush=True)

        try:
            allergens = ask_groq(client, batch)
            inserted = insert_allergens(cur, conn, allergens)
            print(f"found {len(allergens)} allergens, inserted {inserted} new")
        except Exception as e:
            print(f"ERROR: {e}")

    cur.execute("SELECT COUNT(*) FROM food_allergies")
    final_count = cur.fetchone()[0]
    print(f"\nDone. food_allergies table now has {final_count} entries.")

    cur.close()
    conn.close()


if __name__ == "__main__":
    main()
