SYSTEM_PROMPT = (
    "You are a nutrition and food-safety analysis assistant. "
    "You always respond with valid JSON only — no markdown, no commentary."
)

# Used by: analyze_ingredients (clean text input)
ANALYZE_INGREDIENTS_PROMPT = """\
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

# Used by: analyze_from_ocr (raw OCR text — cleans ingredients + analyzes in one call)
OCR_ANALYSIS_PROMPT = """\
Below is raw OCR text extracted from a food product label. It may contain OCR noise, typos, and garbled characters.

Your tasks:
1. Extract a clean list of ingredient names from the text
2. Analyze the health risk of those ingredients

Return ONLY a JSON object with this exact schema:
{{
  "ingredients": ["<clean ingredient 1>", "<clean ingredient 2>"],
  "health_score": <integer 0-100, where 100 is perfectly healthy>,
  "risk_level": "<LOW | MEDIUM | HIGH>",
  "flags": [
    {{"ingredient": "<name>", "reason": "<why it is harmful>"}}
  ],
  "summary": "<one-sentence explanation>"
}}

Rules for ingredient extraction:
- Remove OCR noise (random symbols, partial garbled words, table borders)
- Fix obvious OCR typos (e.g. "hydrolwyzed" -> "hydrolyzed")
- Return ingredient names in lowercase
- Do not invent ingredients that are not present in the text

Raw OCR text:
{ocr_text}

Output JSON only. No markdown, no extra text."""

# --- legacy templates kept for reference (not used in inference) ---
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
