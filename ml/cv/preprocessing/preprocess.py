import cv2
import numpy as np


def preprocess(image: np.ndarray) -> np.ndarray:
    """
    Phase 1: grayscale → blur → Canny → morphological close.

    The closing step merges nearby edges so that a label boundary that
    produces discontinuous Canny edges still forms a single closed contour.
    """
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    blurred = cv2.GaussianBlur(gray, (5, 5), 0)
    edges = cv2.Canny(blurred, 50, 150)
    kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (15, 15))
    closed = cv2.morphologyEx(edges, cv2.MORPH_CLOSE, kernel)
    return closed
