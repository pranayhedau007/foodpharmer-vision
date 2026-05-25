import os
import re
import psycopg2
from dotenv import load_dotenv

load_dotenv()

conn = psycopg2.connect(
    dbname=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT"),
)
cur = conn.cursor()

cur.execute("SELECT id, ingredients_text FROM products WHERE ingredients_text IS NOT NULL AND ingredients_score IS NULL")
products = cur.fetchall()
print(f"Scoring {len(products)} products...")

for i, (product_id, ingredients_text) in enumerate(products, 1):
    raw_ingredients = [
        re.sub(r"[\[\]()_*]", "", part).strip()
        for part in ingredients_text.split(",")
        if part.strip()
    ]

    # (position, score) — position is 1-indexed place in the ingredient list
    weighted = []
    for pos, ingredient in enumerate(raw_ingredients, 1):
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

    if not weighted:
        continue

    # Each ingredient contributes score/position; earlier = more weight
    weighted_sum = sum(score / pos for pos, score in weighted)
    # Theoretical max: all found ingredients score 10
    max_possible = sum(10 / pos for pos, _ in weighted)

    ingredients_score = round((weighted_sum / max_possible) * 100, 2)

    cur.execute(
        "UPDATE products SET ingredients_score = %s WHERE id = %s",
        (ingredients_score, product_id)
    )
    print(f"[{i}/{len(products)}] product_id={product_id} -> score={ingredients_score}")

    conn.commit()

conn.commit()
cur.close()
conn.close()
print("Done.")
