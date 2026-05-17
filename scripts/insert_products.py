import os
import psycopg2
import pandas as pd
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

COLS = [
    "product_name", "brands", "ingredients_text",
    "energy_100g", "sugars_100g", "fat_100g", "saturated-fat_100g",
    "proteins_100g", "fiber_100g", "salt_100g",
    "nutrition_grade_fr", "countries_en"
]

print("Loading TSV...")
df = pd.read_csv(
    "food_dataset/en.openfoodfacts.org.products.tsv",
    sep='\t',
    low_memory=False,
    usecols=COLS
)

df = df[df["countries_en"] == "United States"].head(11136).reset_index(drop=True)
print(f"Inserting {len(df)} rows into products...")

for i, row in df.iterrows():
    try:
        cur.execute(
            """
            INSERT INTO products (
                name, brand, ingredients_text,
                calories, sugar_g, fat_g, saturated_fat_g,
                protein_g, fiber_g, sodium_mg,
                product_grade
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """,
            (
                row.get("product_name") or None,
                row.get("brands") or None,
                row.get("ingredients_text") or None,
                row.get("energy_100g") if pd.notna(row.get("energy_100g")) else None,
                row.get("sugars_100g") if pd.notna(row.get("sugars_100g")) else None,
                row.get("fat_100g") if pd.notna(row.get("fat_100g")) else None,
                row.get("saturated-fat_100g") if pd.notna(row.get("saturated-fat_100g")) else None,
                row.get("proteins_100g") if pd.notna(row.get("proteins_100g")) else None,
                row.get("fiber_100g") if pd.notna(row.get("fiber_100g")) else None,
                row.get("salt_100g") if pd.notna(row.get("salt_100g")) else None,
                row.get("nutrition_grade_fr") if pd.notna(row.get("nutrition_grade_fr")) else None,
            )
        )
        if (i + 1) % 500 == 0:
            conn.commit()
            print(f"[{i + 1}/{len(df)}] committed...")
    except Exception as e:
        conn.rollback()
        print(f"[{i + 1}] ERROR: {e}")

conn.commit()
cur.close()
conn.close()
print("Done.")
