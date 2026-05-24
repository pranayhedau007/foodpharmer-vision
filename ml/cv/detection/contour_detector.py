from typing import Optional

import cv2
import numpy as np


_MIN_AREA_RATIO = 0.05  # contour must cover at least 5% of the image


def find_label_contour(edges: np.ndarray) -> Optional[np.ndarray]:
    """
    Phase 1: find the largest approximately-rectangular contour.

    Only considers contours covering >= 5% of the image area so that tiny
    text/graphic elements inside the label are ignored.  Checks the top 10
    qualifying contours for a 4-sided polygon; falls back to the bounding
    rect of the largest qualifying contour.  Returns None if the label
    boundary can't be isolated (caller should use the full image).
    """
    image_area = edges.shape[0] * edges.shape[1]
    min_area = _MIN_AREA_RATIO * image_area

    contours, _ = cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    if not contours:
        return None

    contours = sorted(contours, key=cv2.contourArea, reverse=True)
    large = [c for c in contours if cv2.contourArea(c) >= min_area]

    candidates = large if large else contours  # relax if nothing qualifies

    for contour in candidates[:10]:
        peri = cv2.arcLength(contour, True)
        for eps in (0.02, 0.03, 0.04, 0.05, 0.06, 0.08):
            approx = cv2.approxPolyDP(contour, eps * peri, True)
            if len(approx) == 4:
                return approx

    if not large:
        return None  # no meaningful region found; caller returns full image

    # Fallback: synthesize a 4-point contour from the bounding rect
    x, y, w, h = cv2.boundingRect(large[0])
    return np.array(
        [[x, y], [x + w, y], [x + w, y + h], [x, y + h]],
        dtype="float32",
    ).reshape(-1, 1, 2)


def crop_bounding_rect(image: np.ndarray, contour: np.ndarray) -> np.ndarray:
    """Phase 1 fallback crop: axis-aligned bounding rectangle."""
    x, y, w, h = cv2.boundingRect(contour)
    return image[y : y + h, x : x + w]
