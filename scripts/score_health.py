import os
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

cur.execute("""
    SELECT id, ingredients_score, protein_g, fiber_g, sugar_g, saturated_fat_g, sodium_mg, product_grade
    FROM products
""")
products = cur.fetchall()
print(f"Scoring {len(products)} products...")

GRADE_MAP = {"a": 100, "b": 75, "c": 50, "d": 25, "e": 0}


def clamp(value, lo, hi):
    return max(lo, min(hi, value))


for i, (product_id, ingredients_score, protein_g, fiber_g, sugar_g, saturated_fat_g, sodium_mg, product_grade) in enumerate(products, 1):
    components = {}

    if ingredients_score is not None:
        components["ingredients"] = (ingredients_score, 0.50)

    # Nutrition score — only include if at least one column has a value
    nutrition_inputs = [protein_g, fiber_g, sugar_g, saturated_fat_g, sodium_mg]
    if any(v is not None for v in nutrition_inputs):
        score = 50
        score += (protein_g or 0) * 2
        score += (fiber_g or 0) * 3
        score -= (sugar_g or 0) * 1.5
        score -= (saturated_fat_g or 0) * 2
        score -= (sodium_mg or 0) * 0.05
        components["nutrition"] = (clamp(score, 0, 100), 0.35)

    if product_grade and product_grade.lower() in GRADE_MAP:
        components["grade"] = (GRADE_MAP[product_grade.lower()], 0.15)

    if not components:
        print(f"[{i}/{len(products)}] product_id={product_id} -> skipped (no data)")
        continue

    # Re-normalize weights to account for missing components
    total_weight = sum(w for _, w in components.values())
    health_score = sum((score * weight) / total_weight for score, weight in components.values())
    health_score = round(health_score, 2)

    cur.execute("UPDATE products SET health_score = %s WHERE id = %s", (health_score, product_id))
    conn.commit()
    print(f"[{i}/{len(products)}] product_id={product_id} -> health_score={health_score} {dict((k, round(v[0],1)) for k,v in components.items())}")

cur.close()
conn.close()
print("Done.")
