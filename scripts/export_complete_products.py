import os
import pandas as pd
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

query = """
    SELECT * FROM products
    WHERE name IS NOT NULL
      AND brand IS NOT NULL
      AND ingredients_text IS NOT NULL
      AND calories IS NOT NULL
      AND sugar_g IS NOT NULL
      AND fat_g IS NOT NULL
      AND saturated_fat_g IS NOT NULL
      AND protein_g IS NOT NULL
      AND fiber_g IS NOT NULL
      AND sodium_mg IS NOT NULL
      AND health_score IS NOT NULL
      AND ingredients_score IS NOT NULL
"""

df = pd.read_sql(query, conn)
conn.close()

output_path = "food_dataset/complete_products.csv"
df.to_csv(output_path, index=False)
print(f"Exported {len(df)} rows to {output_path}")
