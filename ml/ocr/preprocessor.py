import cv2
import numpy as np


def isolate_white_panel(image: np.ndarray) -> np.ndarray:
    """
    Find and crop to the largest white rectangular region in the label crop.

    Nutrition facts panels are white-background rectangles surrounded by
    colorful branding.  Isolating this region before OCR removes the branding
    noise that confuses Tesseract.

    Falls back to the full image if no qualifying white region is found.
    """
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    _, white_mask = cv2.threshold(gray, 200, 255, cv2.THRESH_BINARY)

    kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (30, 30))
    closed = cv2.morphologyEx(white_mask, cv2.MORPH_CLOSE, kernel)

    contours, _ = cv2.findContours(closed, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    if not contours:
        return image

    img_area = image.shape[0] * image.shape[1]
    contours = sorted(contours, key=cv2.contourArea, reverse=True)
    best = contours[0]

    if cv2.contourArea(best) < 0.10 * img_area:
        return image  # no meaningfully large white region

    x, y, w, h = cv2.boundingRect(best)
    return image[y : y + h, x : x + w]


def ocr_preprocess(image: np.ndarray) -> np.ndarray:
    """
    Prepare a cropped label image for Tesseract.

    Steps:
      1. Isolate white nutrition panel (strips colorful branding)
      2. Grayscale
      3. CLAHE (contrast normalisation)
      4. Upscale to ≥ 1000px wide
      5. Adaptive threshold → clean black-on-white binary image
    """
    panel = isolate_white_panel(image)
    gray = cv2.cvtColor(panel, cv2.COLOR_BGR2GRAY)

    clahe = cv2.createCLAHE(clipLimit=2.0, tileGridSize=(8, 8))
    enhanced = clahe.apply(gray)

    h, w = enhanced.shape
    if w < 1000:
        scale = 1000 / w
        enhanced = cv2.resize(enhanced, (1000, int(h * scale)), interpolation=cv2.INTER_CUBIC)

    binary = cv2.adaptiveThreshold(
        enhanced, 255,
        cv2.ADAPTIVE_THRESH_GAUSSIAN_C,
        cv2.THRESH_BINARY,
        blockSize=31,
        C=10,
    )
    return binary
