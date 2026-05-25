"""Nutrition field definitions shared across the OCR neural pipeline."""

from __future__ import annotations

# Canonical field keys in display order.
NUTRITION_FIELDS: list[str] = [
    "calories",
    "total_fat",
    "saturated_fat",
    "trans_fat",
    "cholesterol",
    "sodium",
    "total_carbohydrate",
    "dietary_fiber",
    "total_sugars",
    "added_sugars",
    "protein",
    "vitamin_d",
    "calcium",
    "iron",
    "potassium",
]

# Core nine fields (always expected even if parser is limited).
CORE_FIELDS: list[str] = [
    "calories",
    "total_fat",
    "saturated_fat",
    "trans_fat",
    "sodium",
    "total_carbohydrate",
    "dietary_fiber",
    "total_sugars",
    "protein",
]

# Units per field.
FIELD_UNITS: dict[str, str] = {
    "calories": "",
    "total_fat": "g",
    "saturated_fat": "g",
    "trans_fat": "g",
    "cholesterol": "mg",
    "sodium": "mg",
    "total_carbohydrate": "g",
    "dietary_fiber": "g",
    "total_sugars": "g",
    "added_sugars": "g",
    "protein": "g",
    "vitamin_d": "mcg",
    "calcium": "mg",
    "iron": "mg",
    "potassium": "mg",
}

# Realistic random ranges  (min, max).
FIELD_RANGES: dict[str, tuple[float, float]] = {
    "servings_per_container": (1, 12),
    "calories": (0, 900),
    "total_fat": (0, 50),
    "saturated_fat": (0, 25),
    "trans_fat": (0, 5),
    "cholesterol": (0, 300),
    "sodium": (0, 2000),
    "total_carbohydrate": (0, 120),
    "dietary_fiber": (0, 25),
    "total_sugars": (0, 80),
    "added_sugars": (0, 60),
    "protein": (0, 50),
    "vitamin_d": (0, 40),
    "calcium": (0, 1500),
    "iron": (0, 30),
    "potassium": (0, 2000),
}

# Display labels for rendering on the image.
FIELD_DISPLAY: dict[str, str] = {
    "calories": "Calories",
    "total_fat": "Total Fat",
    "saturated_fat": "Saturated Fat",
    "trans_fat": "Trans Fat",
    "cholesterol": "Cholesterol",
    "sodium": "Sodium",
    "total_carbohydrate": "Total Carbohydrate",
    "dietary_fiber": "Dietary Fiber",
    "total_sugars": "Total Sugars",
    "added_sugars": "Includes {value} Added Sugars",
    "protein": "Protein",
    "vitamin_d": "Vitamin D",
    "calcium": "Calcium",
    "iron": "Iron",
    "potassium": "Potassium",
}
