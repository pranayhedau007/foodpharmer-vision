import json
from pathlib import Path

RAW_PATH = Path("data/ingredient_dataset_raw/ingredients_raw.jsonl")
OUT_PATH = Path("data/ingredient_dataset_labeled/labeled.jsonl")

# 1. Harmful ingredient dictionary
HARMFUL_INGREDIENTS = {
    "high fructose corn syrup": "High added sugar linked to metabolic issues",
    "hfcs": "High added sugar linked to metabolic issues",
    "red 40": "Artificial colorant with potential health concerns",
    "yellow 6": "Artificial colorant with potential health concerns",
    "monosodium glutamate": "Flavor enhancer linked to sensitivity in some individuals",
    "msg": "Flavor enhancer linked to sensitivity in some individuals",
    "artificial flavors": "Synthetic additives with unclear long-term effects",
    "palm oil": "Highly processed oil high in saturated fats",
    "vegetable oil": "Often refined seed oils linked to inflammation",
    "canola oil": "Refined seed oil linked to inflammation",
    "corn syrup": "Added sugar contributing to metabolic issues",
    "aspartame": "Artificial sweetener with potential health concerns",
    "sucralose": "Artificial sweetener with potential gut microbiome effects",
}

def compute_health_score(ingredients_text):
    ingredients = ingredients_text.lower()
    score = 100

    harmful_found = []

    for item, reason in HARMFUL_INGREDIENTS.items():
        if item in ingredients:
            score -= 10
            harmful_found.append({"ingredient": item, "reason": reason})

    score = max(0, min(100, score))
    return score, harmful_found

def risk_level(score):
    if score <= 30:
        return "HIGH"
    elif score <= 60:
        return "MEDIUM"
    return "LOW"

def summarize(product_name, score, harmful_list):
    if not harmful_list:
        return f"{product_name} contains mostly clean ingredients and appears low risk."

    top_issue = harmful_list[0]["ingredient"]
    return f"{product_name} contains {top_issue}, contributing to a higher health risk."

def main():
    with open(RAW_PATH, "r") as f_in, open(OUT_PATH, "w") as f_out:
        for line in f_in:
            item = json.loads(line)
            score, harmful_list = compute_health_score(item["ingredients"])
            risk = risk_level(score)
            summary = summarize(item["product_name"], score, harmful_list)

            labeled = {
                "id": item["id"],
                "product_name": item["product_name"],
                "ingredients": item["ingredients"],
                "category": item.get("category", None),
                "health_score": score,
                "risk_level": risk,
                "flags": harmful_list,
                "summary": summary,
            }

            f_out.write(json.dumps(labeled) + "\n")

    print("Labeled dataset created at:", OUT_PATH)

if __name__ == "__main__":
    main()
