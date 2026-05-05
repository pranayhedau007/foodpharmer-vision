import cv2
import numpy as np
from fastapi import APIRouter, File, HTTPException, UploadFile
from fastapi.responses import JSONResponse

from backend.inference import run_pipeline

router = APIRouter()


@router.post("/scan")
async def scan_label(file: UploadFile = File(...)) -> JSONResponse:
    """
    Accept a food label image and return:
      - health score (0–100)
      - letter grade (A–F)
      - red-flagged harmful ingredients
      - parsed ingredients list
      - parsed nutrition facts
      - raw OCR text
    """
    if not file.content_type.startswith("image/"):
        raise HTTPException(status_code=400, detail="File must be an image")

    raw = await file.read()
    arr = np.frombuffer(raw, dtype=np.uint8)
    image = cv2.imdecode(arr, cv2.IMREAD_COLOR)

    if image is None:
        raise HTTPException(status_code=400, detail="Could not decode image")

    result = run_pipeline(image)
    return JSONResponse(content=result)


@router.get("/health")
async def health_check() -> dict:
    return {"status": "ok"}
