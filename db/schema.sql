CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name TEXT,
    brand TEXT,
    ingredients_text TEXT,
    calories FLOAT,
    sugar_g FLOAT,
    fat_g FLOAT,
    saturated_fat_g FLOAT,
    protein_g FLOAT,
    fiber_g FLOAT,
    sodium_mg FLOAT,
    health_score FLOAT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ingredients (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE,
    category TEXT,
    health_label TEXT,
    health_score FLOAT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS product_ingredients (
    product_id INT REFERENCES products(id),
    ingredient_id INT REFERENCES ingredients(id),
    position INT,
    PRIMARY KEY (product_id, ingredient_id)
);

CREATE TABLE IF NOT EXISTS ingredient_aliases (
    id SERIAL PRIMARY KEY,
    alias TEXT,
    ingredient_id INT REFERENCES ingredients(id)
);