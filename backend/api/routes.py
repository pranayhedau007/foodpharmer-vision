import cv2
import numpy as np
from fastapi import APIRouter, File, HTTPException, UploadFile
from fastapi.responses import JSONResponse

from backend.inference import run_pipeline

router = APIRouter()


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


@router.get("/health")
async def health_check() -> dict:
    return {"status": "ok"}
