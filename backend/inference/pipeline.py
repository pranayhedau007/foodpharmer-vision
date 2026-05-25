import sys
import cv2
import numpy as np

from ml.cv import detect_label
from ml.nlp import parse_label
from ml.ocr import extract_nutrition_text, extract_text
from backend.scoring import score_label
from backend.scoring.xgb_predictor import predict_from_parsed
from backend.scoring.allergens import detect_allergens
from backend.inference.ocr_reliability import run_ocr_reliability


def run_pipeline(nutrition_image: np.ndarray, ingredients_image: np.ndarray) -> dict:
    """
    Full CV -> OCR -> NLP -> scoring pipeline.

    Args:
        nutrition_image:   photo of the nutrition facts panel
        ingredients_image: photo of the ingredients list

    Returns:
        {
            "score":       int,      (rule-based, 0-100)
            "xgb_score":   float,    (XGBoost model prediction, 0-100)
            "grade":       str,
            "red_flags":   list,
            "ingredients": list,
            "nutrition":   dict,
            "raw_text":    str,
        }
    """
    nutrition_text   = extract_nutrition_text(nutrition_image)
    ingredients_text = extract_text(ingredients_image)

    combined_text = nutrition_text + "\n" + ingredients_text
    parsed     = parse_label(combined_text)
    result     = score_label(parsed)
    xgb_result = predict_from_parsed(parsed)
    allergens  = detect_allergens(parsed["ingredients"])
    ocr_reliability = run_ocr_reliability(
        nutrition_image, nutrition_text, parsed["nutrition"],
    )

    return {
        **result,
        "xgb_score":   xgb_result["xgb_score"],
        "ingredients": parsed["ingredients"],
        "nutrition":   parsed["nutrition"],
        "allergens":        allergens,
        "raw_text":         parsed["raw_text"],
        "ocr_reliability":  ocr_reliability,
    }


def _load_image(path: str) -> np.ndarray:
    """Load image with EXIF rotation correction (handles iPhone photos)."""
    from PIL import Image, ExifTags
    import numpy as np

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

    img = cv2.cvtColor(np.array(pil.convert("RGB")), cv2.COLOR_RGB2BGR)
    return img


if __name__ == "__main__":
    import json

    if len(sys.argv) != 3:
        print("Usage: python -m backend.inference.pipeline <nutrition_image> <ingredients_image>")
        sys.exit(1)

    nutrition_img   = _load_image(sys.argv[1])
    ingredients_img = _load_image(sys.argv[2])

    from ml.ocr.preprocessor import ocr_preprocess
    import pytesseract
    from PIL import Image

    debug_dir = "ml/cv/outputs"

    # Save preprocessed images so you can verify what Tesseract receives
    n_prepped = ocr_preprocess(nutrition_img)
    i_prepped = ocr_preprocess(ingredients_img)
    cv2.imwrite(f"{debug_dir}/debug_nutrition_prepped.jpg", n_prepped)
    cv2.imwrite(f"{debug_dir}/debug_ingredients_prepped.jpg", i_prepped)
    print(f"Preprocessed — nutrition: {n_prepped.shape}, ingredients: {i_prepped.shape}")

    n_text = pytesseract.image_to_string(Image.fromarray(n_prepped), config="--oem 3 --psm 6")
    i_text = pytesseract.image_to_string(Image.fromarray(i_prepped), config="--oem 3 --psm 6")
    print(f"Nutrition OCR ({len(n_text)} chars):\n{n_text[:300]}")
    print(f"Ingredients OCR ({len(i_text)} chars):\n{i_text[:300]}")

    output = run_pipeline(nutrition_img, ingredients_img)
    print(json.dumps(output, indent=2))
