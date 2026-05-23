import json
from pathlib import Path
from llama_health_model.prompt_templates import SFT_TEMPLATE

RAW_LABELED_PATH = Path("data/ingredient_dataset_labeled/labeled.jsonl")
OUT_SFT_PATH = Path("training/sft_dataset.jsonl")

def build_user_prompt(ingredients_text):
    return f"""
You are a nutrition and food‑safety analysis assistant. Analyze the following ingredient list and produce a structured JSON response.

Ingredient list:
{ingredients_text}

Your response must follow this JSON schema exactly:

{{
  "health_score": <0-100>,
  "risk_level": "<LOW|MEDIUM|HIGH>",
  "flags": [
    {{"ingredient": "<name>", "reason": "<why it is harmful>"}}
  ],
  "summary": "<one-sentence explanation>"
}}
""".strip()

def main():
    with open(RAW_LABELED_PATH, "r") as f_in, open(OUT_SFT_PATH, "w") as f_out:
        for line in f_in:
            item = json.loads(line)

            user_prompt = build_user_prompt(item["ingredients"])
            assistant_output = json.dumps({
                "health_score": item["health_score"],
                "risk_level": item["risk_level"],
                "flags": item["flags"],
                "summary": item["summary"]
            })

            sft_entry = {
                "messages": [
                    {"role": "user", "content": user_prompt},
                    {"role": "assistant", "content": assistant_output}
                ]
            }

            f_out.write(json.dumps(sft_entry) + "\n")

    print("SFT dataset created at:", OUT_SFT_PATH)

if __name__ == "__main__":
    main()
