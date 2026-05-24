import cv2
import numpy as np
from fastapi import APIRouter, File, HTTPException, UploadFile
from fastapi.responses import JSONResponse
from pydantic import BaseModel
from typing import Dict, Any

from backend.inference import run_pipeline
from llama_health_model.inference import analyze_ingredients

router = APIRouter()


@router.post("/scan")
async def scan_label(
    nutrition_image: UploadFile = File(...),
    ingredients_image: UploadFile = File(...),
) -> JSONResponse:
    """
    Accept two food label images (nutrition facts + ingredients list) and return:
      - health_score (0–100)
      - risk_level (LOW / MEDIUM / HIGH)
      - flags (harmful ingredients with reasons)
      - ingredients (cleaned list)
      - nutrition (parsed nutrition facts)
      - summary
      - raw_text
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


class AnalyzeRequest(BaseModel):
    ingredients: str


@router.post("/analyze_ingredients")
def analyze(req: AnalyzeRequest) -> Dict[str, Any]:
    """Analyze a plain-text ingredient list directly (no image required)."""
    if not req.ingredients or not req.ingredients.strip():
        raise HTTPException(status_code=400, detail="ingredients field must be a non-empty string")
    try:
        result = analyze_ingredients(req.ingredients)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Model inference failed: {e}")
    return {
        "health_score":      result.get("health_score"),
        "risk_level":        result.get("risk_level"),
        "flags":             result.get("flags", []),
        "summary":           result.get("summary"),
        "_raw_model_output": result.get("_raw_model_output"),
    }


@router.get("/health")
async def health_check() -> dict:
    return {"status": "ok"}


_DUMMY_INGREDIENTS = (
    "sugar, enriched flour, palm oil, high fructose corn syrup, "
    "sodium benzoate, red 40, yellow 5, partially hydrogenated soybean oil, "
    "artificial flavors, sodium nitrate"
)

@router.post("/test_llama")
def test_llama() -> Dict[str, Any]:
    """
    Bypasses CV+OCR entirely. Sends a hardcoded ingredient list straight to
    Llama so we can measure pure model inference time in isolation.
    """
    import time
    from llama_health_model.inference import analyze_ingredients
    print(f"[test_llama] Calling analyze_ingredients with dummy ingredients ...")
    t0 = time.time()
    result = analyze_ingredients(_DUMMY_INGREDIENTS)
    print(f"[test_llama] Done in {time.time()-t0:.1f}s")
    return result
