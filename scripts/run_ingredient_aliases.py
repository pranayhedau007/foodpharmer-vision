import re
import pandas as pd
from scripts.get_similar_ingredient_name import resolve_ingredient, cur, conn

df = pd.read_csv("food_dataset/relevant_data.csv", skiprows=range(1, 11136), nrows=2000)

for row_idx, row in df.iterrows():
    raw = row["ingredients_text"]
    if pd.isna(raw):
        print(f"Row {row_idx}: no ingredients_text — skipping.")
        continue

    ingredients = [re.sub(r"[\[\]()_*]", "", i).strip() for i in raw.split(",") if i.strip()]

    print(f"\n--- Row {row_idx} ({len(ingredients)} ingredients) ---")
    for ingredient in ingredients:
        if ingredient:
            resolve_ingredient(ingredient)

cur.close()
conn.close()
