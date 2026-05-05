from collections import defaultdict

import numpy as np
import pytesseract
from PIL import Image

from .preprocessor import ocr_preprocess

_TESS_CONFIG = "--oem 3 --psm 6"

# Nutrition facts panels are two-column: [value | % DV].
# Only trust words whose left edge is in the left 65% of the panel width —
# this excludes the % Daily Value column so digits don't bleed across columns.
_VALUE_COLUMN_RATIO = 0.65


def extract_text(image: np.ndarray) -> str:
    """Full-image OCR (used for ingredient list parsing)."""
    prepped = ocr_preprocess(image)
    return pytesseract.image_to_string(Image.fromarray(prepped), config=_TESS_CONFIG)


def extract_nutrition_text(image: np.ndarray) -> str:
    """
    Column-aware OCR for the nutrition facts panel.

    Uses Tesseract word-level bounding boxes to keep only words from the
    left 65% of the panel (the value column), discarding the % DV column.
    Words are then re-assembled row-by-row and returned as plain text.
    """
    prepped = ocr_preprocess(image)
    pil = Image.fromarray(prepped)
    panel_width = pil.width

    data = pytesseract.image_to_data(
        pil, config=_TESS_CONFIG, output_type=pytesseract.Output.DICT
    )

    # Group words by row (block_num, par_num, line_num triple)
    rows: dict[tuple, list[tuple[int, str]]] = defaultdict(list)
    for i, word in enumerate(data["text"]):
        word = word.strip()
        if not word:
            continue
        left = data["left"][i]
        if left > panel_width * _VALUE_COLUMN_RATIO:
            continue  # skip % DV column
        row_key = (data["block_num"][i], data["par_num"][i], data["line_num"][i])
        rows[row_key].append((left, word))

    lines = []
    for key in sorted(rows):
        words_in_row = [w for _, w in sorted(rows[key])]
        lines.append(" ".join(words_in_row))

    return "\n".join(lines)
