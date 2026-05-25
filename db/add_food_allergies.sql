CREATE TABLE IF NOT EXISTS food_allergies (
    id SERIAL PRIMARY KEY,
    ingredient_name TEXT NOT NULL UNIQUE
);
