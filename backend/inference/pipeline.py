import numpy as np

from ml.cv import detect_label
from ml.nlp import parse_label
from ml.ocr import extract_nutrition_text, extract_text
from backend.scoring import score_label


def run_pipeline(image: np.ndarray) -> dict:
    """
    Full CV → OCR → NLP → scoring pipeline.

    Uses two OCR passes:
      - extract_nutrition_text: column-aware pass for nutrition facts (accurate values)
      - extract_text: full-image pass to catch the ingredient list

    Returns:
        {
            "score":       int,
            "grade":       str,
            "red_flags":   list,
            "ingredients": list,
            "nutrition":   dict,
            "raw_text":    str,
        }
    """
    cropped = detect_label(image)
    nutrition_text = extract_nutrition_text(cropped)
    full_text = extract_text(cropped)
    combined_text = nutrition_text + "\n" + full_text
    parsed = parse_label(combined_text)
    result = score_label(parsed)

    return {
        **result,
        "ingredients": parsed["ingredients"],
        "nutrition": parsed["nutrition"],
        "raw_text": parsed["raw_text"],
    }
