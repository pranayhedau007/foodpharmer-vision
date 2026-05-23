import json
import re
from typing import Dict, Any

import httpx

# === CONFIG ===
OLLAMA_BASE_URL = "http://localhost:11434"
OLLAMA_MODEL = "llama3.2:latest"
OLLAMA_TIMEOUT = 120.0

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


# === JSON EXTRACTION ===
def _extract_json(text: str) -> Dict[str, Any]:
    # 1) Direct parse
    try:
        return json.loads(text)
    except Exception:
        pass

    # 2) First JSON object in text
    json_match = re.search(r"\{[\s\S]*\}", text)
    if json_match:
        try:
            return json.loads(json_match.group(0))
        except Exception:
            pass

    # 3) Heuristic key: value fallback
    obj: Dict[str, Any] = {}
    for line in text.splitlines()[:20]:
        line = line.strip()
        if ":" in line:
            k, _, v = line.partition(":")
            key = k.strip().strip('"\'')
            val = v.strip().strip('",\'')
            if re.fullmatch(r"\d+(\.\d+)?", val):
                obj[key] = float(val) if "." in val else int(val)
            else:
                obj[key] = val
    if obj:
        return obj

    return {
        "health_score": None,
        "risk_level": None,
        "flags": [],
        "summary": text.strip()[:512],
    }


# === PUBLIC API ===
def analyze_ingredients(ingredients_text: str) -> Dict[str, Any]:
    """
    Call the locally running Ollama llama3.2 model and return:
    {
      "health_score": int or None,
      "risk_level": "LOW"|"MEDIUM"|"HIGH" or None,
      "flags": [{"ingredient": str, "reason": str}, ...],
      "summary": str,
      "_raw_model_output": str
    }
    """
    user_message = _USER_TEMPLATE.format(ingredients=ingredients_text)

    try:
        resp = httpx.post(
            f"{OLLAMA_BASE_URL}/api/chat",
            json={
                "model": OLLAMA_MODEL,
                "messages": [
                    {"role": "system", "content": _SYSTEM_PROMPT},
                    {"role": "user", "content": user_message},
                ],
                "stream": False,
                "format": "json",
                "options": {"temperature": 0.1, "top_p": 0.95, "num_predict": 180},
            },
            timeout=OLLAMA_TIMEOUT,
        )
        resp.raise_for_status()
    except httpx.ConnectError:
        raise RuntimeError(
            "Cannot connect to Ollama at http://localhost:11434. "
            "Run `ollama serve` in a terminal to start it."
        )

    raw = resp.json().get("message", {}).get("content", "")
    parsed = _extract_json(raw)
    parsed["_raw_model_output"] = raw
    return parsed


def _load_model():
    """No-op: Ollama manages the model process. Kept for API compatibility."""
    pass
