"""
Fetch ingredient lists from OpenFoodFacts and label them using Claude.

Usage:
    python -m data.fetch_and_label             # default: 500 new samples
    python -m data.fetch_and_label --target 200
    python -m data.fetch_and_label --target 1000

Requires:
    export ANTHROPIC_API_KEY="sk-ant-..."

Output: data/ingredient_dataset_labeled/labeled.jsonl  (appends — safe to re-run)
"""
import argparse
import json
import os
import re
import time
from pathlib import Path

import anthropic
import httpx
from tqdm import tqdm

# ── paths ─────────────────────────────────────────────────────────────────────
OUT_PATH = Path("data/ingredient_dataset_labeled/labeled.jsonl")

# ── Claude settings ───────────────────────────────────────────────────────────
CLAUDE_MODEL = "claude-haiku-4-5"

_SYSTEM_PROMPT = (
    "You are a nutrition and food-safety analysis assistant. "
    "You always respond with valid JSON only — no markdown, no commentary."
)

_USER_TEMPLATE = """\
Analyze the following ingredient list and return ONLY a JSON object matching this schema exactly:

{{
  "health_score": <integer 0-100, where 100 is perfectly healthy>,
  "risk_level": "<LOW | MEDIUM | HIGH>",
  "flags": [
    {{"ingredient": "<name>", "reason": "<why it is harmful>"}}
  ],
  "summary": "<one-sentence explanation>"
}}

Ingredient list:
{ingredients}

Output JSON only. No markdown, no extra text."""

# ── OpenFoodFacts settings ─────────────────────────────────────────────────────
OFF_BASE = "https://us.openfoodfacts.org/api/v2/search"
OFF_FIELDS = "product_name,ingredients_text,categories_tags"
OFF_PAGE_SIZE = 50

CATEGORIES = [
    "snacks", "beverages", "cereals", "condiments",
    "cookies", "candy", "chips", "sauces",
    "frozen-foods", "dairy", "breakfast-cereals",
    "soft-drinks", "juices", "crackers",
]

MIN_INGREDIENT_LEN = 40
MAX_INGREDIENT_LEN = 800


# ── helpers ───────────────────────────────────────────────────────────────────
def _is_english(text: str) -> bool:
    if not text:
        return False
    ascii_chars = sum(1 for c in text if ord(c) < 128)
    return ascii_chars / len(text) > 0.85


def _clean(text: str) -> str:
    text = re.sub(r"\s+", " ", text).strip()
    for marker in ["may contain", "contains:", "allergen", "manufactured in"]:
        idx = text.lower().find(marker)
        if idx > 40:
            text = text[:idx].strip().rstrip(",.")
    return text


def _load_existing() -> set[str]:
    seen: set[str] = set()
    if OUT_PATH.exists():
        with open(OUT_PATH) as f:
            for line in f:
                try:
                    seen.add(json.loads(line)["product_name"].lower())
                except Exception:
                    pass
    return seen


def _fetch_page(category: str, page: int) -> list[dict]:
    try:
        r = httpx.get(
            OFF_BASE,
            params={
                "categories_tags_en": category,
                "fields": OFF_FIELDS,
                "page_size": OFF_PAGE_SIZE,
                "page": page,
            },
            timeout=15,
        )
        r.raise_for_status()
        return r.json().get("products", [])
    except Exception as e:
        tqdm.write(f"  [warn] fetch failed ({category} p{page}): {e}")
        return []


def _extract_json(text: str) -> dict:
    try:
        return json.loads(text)
    except Exception:
        pass
    json_match = re.search(r"\{[\s\S]*\}", text)
    if json_match:
        try:
            return json.loads(json_match.group(0))
        except Exception:
            pass
    return {}


def _validate(result: dict) -> bool:
    hs = result.get("health_score")
    rl = result.get("risk_level")
    return (
        isinstance(hs, (int, float)) and 0 <= hs <= 100
        and isinstance(rl, str) and rl.upper() in {"LOW", "MEDIUM", "HIGH"}
    )


# ── Claude labeling ───────────────────────────────────────────────────────────
def _label_with_claude(client: anthropic.Anthropic, ingredients: str) -> dict:
    """Call Claude with prompt caching on the system prompt."""
    resp = client.messages.create(
        model=CLAUDE_MODEL,
        max_tokens=256,
        system=[
            {
                "type": "text",
                "text": _SYSTEM_PROMPT,
                "cache_control": {"type": "ephemeral"},
            }
        ],
        messages=[
            {
                "role": "user",
                "content": _USER_TEMPLATE.format(ingredients=ingredients),
            }
        ],
    )
    raw = resp.content[0].text if resp.content else ""
    return _extract_json(raw)


# ── main ──────────────────────────────────────────────────────────────────────
def main(target: int):
    api_key = os.environ.get("ANTHROPIC_API_KEY")
    if not api_key:
        raise SystemExit(
            "ANTHROPIC_API_KEY is not set.\n"
            "Run: export ANTHROPIC_API_KEY='sk-ant-...'"
        )

    client = anthropic.Anthropic(api_key=api_key)

    OUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    seen  = _load_existing()
    start = len(seen)
    print(f"Already labeled: {start}  |  target: {start + target} total")

    written  = 0
    skipped  = 0
    bad_json = 0

    pbar = tqdm(total=target, unit="sample", desc="labeling")

    with open(OUT_PATH, "a") as out_f:
        for category in CATEGORIES:
            if written >= target:
                break

            for page in range(1, 10):
                if written >= target:
                    break

                products = _fetch_page(category, page)
                if not products:
                    break

                for prod in products:
                    if written >= target:
                        break

                    name = (prod.get("product_name") or "").strip()
                    raw_text = (prod.get("ingredients_text") or "").strip()

                    if not name or not raw_text:
                        skipped += 1
                        continue
                    if name.lower() in seen:
                        skipped += 1
                        continue
                    if not _is_english(raw_text):
                        skipped += 1
                        continue

                    ingredients = _clean(raw_text)
                    if not (MIN_INGREDIENT_LEN <= len(ingredients) <= MAX_INGREDIENT_LEN):
                        skipped += 1
                        continue

                    cat_tags = prod.get("categories_tags") or []
                    cat = next(
                        (t.replace("en:", "").replace("-", " ")
                         for t in cat_tags if t.startswith("en:")),
                        category,
                    )

                    try:
                        result = _label_with_claude(client, ingredients)
                    except anthropic.APIError as e:
                        tqdm.write(f"\n[error] Claude API error: {e}")
                        pbar.close()
                        return

                    if not _validate(result):
                        bad_json += 1
                        continue

                    entry = {
                        "id": str(start + written + 1).zfill(4),
                        "product_name": name,
                        "ingredients": ingredients,
                        "category": cat,
                        "health_score": int(result["health_score"]),
                        "risk_level": result["risk_level"].upper(),
                        "flags": result.get("flags") or [],
                        "summary": (result.get("summary") or "").strip(),
                    }

                    out_f.write(json.dumps(entry) + "\n")
                    out_f.flush()

                    seen.add(name.lower())
                    written += 1
                    pbar.update(1)
                    pbar.set_postfix(skipped=skipped, bad_json=bad_json)

                time.sleep(0.1)

    pbar.close()
    total = start + written
    print(f"\nDone. Added {written} samples  |  total in file: {total}")
    print(f"Skipped: {skipped}  |  Bad JSON from model: {bad_json}")
    if written < target:
        print(f"[warn] Only reached {written}/{target} — re-run to fetch more categories.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--target", type=int, default=500,
                        help="Number of NEW samples to add (default: 500)")
    args = parser.parse_args()
    main(args.target)
