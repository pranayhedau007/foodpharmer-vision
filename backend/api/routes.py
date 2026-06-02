import json
import os

import cv2
import numpy as np
import psycopg2
from fastapi import APIRouter, File, HTTPException, UploadFile
from fastapi.responses import JSONResponse
from groq import Groq

from backend.inference import run_pipeline

router = APIRouter()

_groq = Groq(api_key=os.getenv("GROQ_API_KEY"))

_INFO_PROMPT = """You are a food science expert. Provide information about the food ingredient "{ingredient}".
Return a JSON object with exactly these fields:
- "origin": where it comes from (plant, animal, mineral, or synthetic) in 1-2 sentences
- "uses": common uses in food products in 1-2 sentences
- "health_notes": relevant health benefits or concerns in 1-2 sentences

Respond with only valid JSON, no explanation."""


def _db_connect():
    return psycopg2.connect(
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        host=os.getenv("DB_HOST"),
        port=os.getenv("DB_PORT"),
    )


@router.post("/scan")
async def scan_label(
    nutrition_image: UploadFile = File(...),
    ingredients_image: UploadFile = File(...),
) -> JSONResponse:
    """
    Accept two food label images (nutrition facts + ingredients) and return:
      - health score (0–100)
      - letter grade (A–F)
      - red-flagged harmful ingredients
      - parsed ingredients list
      - parsed nutrition facts
      - raw OCR text
    """
    for f in (nutrition_image, ingredients_image):
        if not f.content_type.startswith("image/"):
            raise HTTPException(status_code=400, detail=f"{f.filename}: file must be an image")

    def _decode(raw: bytes) -> np.ndarray:
        arr = np.frombuffer(raw, dtype=np.uint8)
        img = cv2.imdecode(arr, cv2.IMREAD_COLOR)
        if img is None:
            raise HTTPException(status_code=400, detail="Could not decode image")
        return img

    nutrition_img   = _decode(await nutrition_image.read())
    ingredients_img = _decode(await ingredients_image.read())

    result = run_pipeline(nutrition_img, ingredients_img)
    return JSONResponse(content=result)


@router.get("/ingredient-info")
async def ingredient_info(name: str) -> JSONResponse:
    """
    Return info about an ingredient. Resolves alias -> canonical name first,
    then checks ingredient_info table. Generates via Groq and caches if missing.
    """
    conn = _db_connect()
    cur = conn.cursor()

    # Resolve alias to canonical ingredient name
    cur.execute(
        """
        SELECT i.name
        FROM ingredient_aliases ia
        JOIN ingredients i ON ia.ingredient_id = i.id
        WHERE LOWER(ia.alias) = LOWER(%s)
        LIMIT 1
        """,
        (name,),
    )
    row = cur.fetchone()
    canonical = row[0] if row else name

    # Check cache
    cur.execute(
        "SELECT info FROM ingredient_info WHERE LOWER(ingredient) = LOWER(%s)",
        (canonical,),
    )
    row = cur.fetchone()
    if row and row[0]:
        info_data = json.loads(row[0])
        cur.close()
        conn.close()
        return JSONResponse(content={"canonical_name": canonical, "info": info_data})

    # Generate via Groq
    try:
        response = _groq.chat.completions.create(
            model="llama-3.3-70b-versatile",
            messages=[{"role": "user", "content": _INFO_PROMPT.format(ingredient=canonical)}],
            response_format={"type": "json_object"},
            temperature=0,
        )
        info_data = json.loads(response.choices[0].message.content)
    except Exception:
        info_data = {"origin": "", "uses": "", "health_notes": "Information unavailable."}

    # Cache result
    cur.execute(
        """
        INSERT INTO ingredient_info (ingredient, info) VALUES (%s, %s)
        ON CONFLICT (ingredient) DO UPDATE SET info = EXCLUDED.info
        """,
        (canonical, json.dumps(info_data)),
    )
    conn.commit()
    cur.close()
    conn.close()

    return JSONResponse(content={"canonical_name": canonical, "info": info_data})


@router.get("/red-flag-info")
async def red_flag_info(name: str) -> JSONResponse:
    """
    Return a Groq-generated explanation for why a red-flag ingredient is harmful.
    Checks red_flag_info table first; generates and caches if missing.
    """
    conn = _db_connect()
    cur = conn.cursor()

    cur.execute(
        "SELECT explanation FROM red_flag_info WHERE LOWER(ingredient) = LOWER(%s)",
        (name,),
    )
    row = cur.fetchone()
    if row and row[0]:
        cur.close()
        conn.close()
        return JSONResponse(content={"explanation": row[0]})

    try:
        response = _groq.chat.completions.create(
            model="llama-3.3-70b-versatile",
            messages=[{
                "role": "user",
                "content": (
                    f'You are a nutritionist. In 1-2 clear sentences, explain why "{name}" '
                    f"is considered harmful or concerning in food products. "
                    f"Focus on the specific health risk for a general audience. Be direct."
                ),
            }],
            temperature=0,
        )
        explanation = response.choices[0].message.content.strip()
    except Exception:
        explanation = "Information unavailable."

    cur.execute(
        """
        INSERT INTO red_flag_info (ingredient, explanation) VALUES (%s, %s)
        ON CONFLICT (ingredient) DO UPDATE SET explanation = EXCLUDED.explanation
        """,
        (name, explanation),
    )
    conn.commit()
    cur.close()
    conn.close()

    return JSONResponse(content={"explanation": explanation})


@router.get("/health")
async def health_check() -> dict:
    return {"status": "ok"}
