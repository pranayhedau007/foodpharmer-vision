SFT_TEMPLATE = """
<|user|>
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
}}

<|assistant|>
{label_json}
"""

INFERENCE_TEMPLATE = """
<|user|>
You are a nutrition and food‑safety analysis assistant. Analyze the following ingredient list and return a JSON response only.

Ingredient list:
{ingredients}

Return only valid JSON. No explanations outside the JSON.
<|assistant|>
"""

STRICT_JSON_TEMPLATE = """
<|user|>
Analyze the following ingredient list and respond ONLY with valid JSON.

Ingredient list:
{ingredients}

JSON schema:
{{
  "health_score": number,
  "risk_level": string,
  "flags": [
    {{"ingredient": string, "reason": string}}
  ],
  "summary": string
}}

Do not include backticks, markdown, or commentary. Output JSON only.
<|assistant|>
"""
