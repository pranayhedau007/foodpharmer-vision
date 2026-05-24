"""
Health-analysis inference with a pluggable backend.

Set INFERENCE_BACKEND in .env:
  groq  — Groq cloud API, Llama 3.3 70B, ~1-2s (default, good for demos)
  local — Your fine-tuned Llama 3.2 3B via Ollama + GGUF, ~2-5s on Apple Silicon

Both backends accept the same inputs and return the same schema:
  {health_score, risk_level, flags, summary, _raw_model_output}
"""
import json
import os
import re
import time
from typing import Any, Dict

import httpx
from dotenv import load_dotenv
from groq import Groq

load_dotenv()

# ── Backend selection ──────────────────────────────────────────────────────────
INFERENCE_BACKEND = os.getenv("INFERENCE_BACKEND", "groq").lower()

# ── Ollama config (local backend) ─────────────────────────────────────────────
OLLAMA_BASE_URL = "http://localhost:11434"
OLLAMA_MODEL    = "foodpharmer"   # registered via: ollama create foodpharmer -f Modelfile
OLLAMA_TIMEOUT  = 120.0

# ── Groq config (groq backend) ────────────────────────────────────────────────
_groq_client: Groq | None = None

def _get_groq() -> Groq:
    global _groq_client
    if _groq_client is None:
        _groq_client = Groq(api_key=os.getenv("GROQ_API_KEY"))
    return _groq_client

# ── Exact prompt format from training data (sft_dataset.jsonl) ───────────────
# The model was trained with the instruction embedded in the user turn.
# Note the non-breaking hyphen in "food‑safety" — must match training exactly.
_USER_PROMPT_TEMPLATE = """\
You are a nutrition and food‑safety analysis assistant. Analyze the following ingredient list and produce a structured JSON response.

Ingredient list:
{ingredients}

Your response must follow this JSON schema exactly:

{{
  "health_score": <0-100>,
  "risk_level": "<LOW|MEDIUM|HIGH>",
  "flags": [
    {{"ingredient": "<name>", "reason": "<why it is harmful>"}}
  ],
  "summary": "<one-sentence explanation>"
}}"""


# ── JSON extraction ────────────────────────────────────────────────────────────
def _extract_json(text: str) -> Dict[str, Any]:
    try:
        return json.loads(text)
    except Exception:
        pass

    m = re.search(r"\{[\s\S]*\}", text)
    if m:
        try:
            return json.loads(m.group(0))
        except Exception:
            pass

    return {
        "health_score": None,
        "risk_level":   None,
        "flags":        [],
        "summary":      text.strip()[:512],
    }


# ── Local backend (Ollama + your fine-tuned GGUF) ─────────────────────────────
def _analyze_with_ollama(ingredients_text: str) -> Dict[str, Any]:
    prompt = _USER_PROMPT_TEMPLATE.format(ingredients=ingredients_text)
    try:
        resp = httpx.post(
            f"{OLLAMA_BASE_URL}/api/generate",
            json={
                "model":  OLLAMA_MODEL,
                "prompt": prompt,
                "stream": False,
                "format": "json",
                "options": {"temperature": 0.1, "num_predict": 150},
            },
            timeout=OLLAMA_TIMEOUT,
        )
        resp.raise_for_status()
    except httpx.ConnectError:
        raise RuntimeError(
            "Cannot connect to Ollama at http://localhost:11434. "
            "Run `ollama serve` in a terminal."
        )
    raw = resp.json().get("response", "")
    parsed = _extract_json(raw)
    parsed["_raw_model_output"] = raw
    return parsed


# ── Groq backend ──────────────────────────────────────────────────────────────
def _analyze_with_groq(ingredients_text: str) -> Dict[str, Any]:
    prompt = _USER_PROMPT_TEMPLATE.format(ingredients=ingredients_text)
    response = _get_groq().chat.completions.create(
        model="llama-3.3-70b-versatile",
        messages=[{"role": "user", "content": prompt}],
        response_format={"type": "json_object"},
        temperature=0.1,
        max_tokens=150,
    )
    raw = response.choices[0].message.content
    parsed = _extract_json(raw)
    parsed["_raw_model_output"] = raw
    return parsed


# ── Public API ────────────────────────────────────────────────────────────────
def analyze_ingredients(ingredients_text: str) -> Dict[str, Any]:
    """
    Analyze a clean ingredient list string.

    Routes to Groq or local Ollama based on INFERENCE_BACKEND env var.
    Returns: {health_score, risk_level, flags, summary, _raw_model_output}
    """
    print(f"[inference] backend={INFERENCE_BACKEND} | analyzing {len(ingredients_text)} chars")
    t = time.time()

    if INFERENCE_BACKEND == "local":
        result = _analyze_with_ollama(ingredients_text)
    else:
        result = _analyze_with_groq(ingredients_text)

    print(f"[inference] done in {time.time()-t:.1f}s | risk={result.get('risk_level')} score={result.get('health_score')}")
    return result


# ── Legacy no-op kept for API compatibility ───────────────────────────────────
def _load_model() -> None:
    pass
