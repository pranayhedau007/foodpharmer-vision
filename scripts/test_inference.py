"""
Quick test for both backends. Run from the repo root:

  # Test Groq (default):
  INFERENCE_BACKEND=groq .venv/bin/python scripts/test_inference.py

  # Test local Ollama model (after GGUF setup):
  INFERENCE_BACKEND=local .venv/bin/python scripts/test_inference.py
"""
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent.parent))

from llama_health_model.inference import analyze_ingredients, INFERENCE_BACKEND

SAMPLE = (
    "sugar, enriched flour, palm oil, high fructose corn syrup, "
    "sodium benzoate, red 40, yellow 5, partially hydrogenated soybean oil, "
    "artificial flavors, sodium nitrate"
)

print(f"Backend : {INFERENCE_BACKEND}")
print(f"Input   : {SAMPLE}\n")

t0 = time.time()
result = analyze_ingredients(SAMPLE)
elapsed = time.time() - t0

print(f"health_score : {result.get('health_score')}")
print(f"risk_level   : {result.get('risk_level')}")
print(f"flags        : {len(result.get('flags', []))} items")
print(f"summary      : {result.get('summary')}")
print(f"\nTime: {elapsed:.1f}s")
