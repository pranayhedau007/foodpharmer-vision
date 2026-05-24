import sys
import time
import cv2
import numpy as np

from ml.cv import detect_label
from ml.ocr import extract_nutrition_text, extract_text
from ml.nlp import parse_nutrition, clean_ingredients_with_groq
from llama_health_model.inference import analyze_ingredients


def run_pipeline(nutrition_image: np.ndarray, ingredients_image: np.ndarray) -> dict:
    """
    Full pipeline:
      CV crop → Tesseract OCR → Groq (clean ingredients) → Local Llama (health analysis)

    Step 1 — OCR:         Tesseract extracts raw text from both panels
    Step 2 — Parse:       Regex pulls structured nutrition numbers
    Step 3 — Groq:        Llama 3.3 70B cleans OCR noise → tidy ingredient list (~1-2s)
    Step 4 — Local Llama: Fine-tuned 3B model scores health from clean list (~30-60s)
    """
    t0 = time.time()

    print("[pipeline] Step 1: OCR nutrition panel ...")
    t1 = time.time()
    nutrition_text = extract_nutrition_text(nutrition_image)
    print(f"[pipeline] Step 1 done in {time.time()-t1:.1f}s | chars={len(nutrition_text)}")

    print("[pipeline] Step 2: OCR ingredients panel ...")
    t2 = time.time()
    ingredients_text = extract_text(ingredients_image)
    print(f"[pipeline] Step 2 done in {time.time()-t2:.1f}s | chars={len(ingredients_text)}")

    print("[pipeline] Step 3: Regex nutrition parsing ...")
    t3 = time.time()
    nutrition = parse_nutrition(nutrition_text)
    print(f"[pipeline] Step 3 done in {time.time()-t3:.1f}s | fields={list(nutrition.keys())}")

    print("[pipeline] Step 4: Groq cleaning OCR noise → ingredient list ...")
    t4 = time.time()
    combined_ocr = ingredients_text + "\n" + nutrition_text
    ingredients = clean_ingredients_with_groq(combined_ocr)
    print(f"[pipeline] Step 4 done in {time.time()-t4:.1f}s | ingredients={len(ingredients)}")

    print(f"[pipeline] Step 5: Local Llama analyzing {len(ingredients)} ingredients ...")
    t5 = time.time()
    ingredients_text_for_llama = ", ".join(ingredients) if ingredients else combined_ocr
    llama_result = analyze_ingredients(ingredients_text_for_llama)
    print(f"[pipeline] Step 5 done in {time.time()-t5:.1f}s")

    print(f"[pipeline] Total pipeline time: {time.time()-t0:.1f}s")

    return {
        "health_score": llama_result.get("health_score"),
        "risk_level":   llama_result.get("risk_level"),
        "flags":        llama_result.get("flags", []),
        "summary":      llama_result.get("summary"),
        "ingredients":  ingredients,
        "nutrition":    nutrition,
        "raw_text":     combined_ocr,
    }


def _load_image(path: str) -> np.ndarray:
    """Load image with EXIF rotation correction (handles iPhone photos)."""
    from PIL import Image, ExifTags

    pil = Image.open(path)
    try:
        exif = pil._getexif()
        if exif:
            orientation_key = next(k for k, v in ExifTags.TAGS.items() if v == "Orientation")
            orientation = exif.get(orientation_key)
            rotations = {3: 180, 6: 270, 8: 90}
            if orientation in rotations:
                pil = pil.rotate(rotations[orientation], expand=True)
    except Exception:
        pass

    return cv2.cvtColor(np.array(pil.convert("RGB")), cv2.COLOR_RGB2BGR)


if __name__ == "__main__":
    import json

    if len(sys.argv) != 3:
        print("Usage: python -m backend.inference.pipeline <nutrition_image> <ingredients_image>")
        sys.exit(1)

    nutrition_img   = _load_image(sys.argv[1])
    ingredients_img = _load_image(sys.argv[2])
    output = run_pipeline(nutrition_img, ingredients_img)
    print(json.dumps(output, indent=2))
