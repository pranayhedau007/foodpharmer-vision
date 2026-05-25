import numpy as np

from .detection.contour_detector import crop_bounding_rect, find_label_contour
from .detection.perspective import four_point_transform
from .preprocessing.preprocess import preprocess


def detect_label(image: np.ndarray) -> np.ndarray:
    """
    Detect and crop the food label region from an image.

    Phase 1 — contour detection:
      Grayscale → blur → Canny → find largest rect contour → crop

    Phase 2 — perspective correction:
      When a clean 4-point contour is found, warp it to a flat rectangle
      instead of taking the axis-aligned bounding rect.

    Returns the full image unchanged if no label region is found.
    """
    edges = preprocess(image)
    contour = find_label_contour(edges)

    if contour is None:
        return image

    pts = contour.reshape(-1, 2).astype("float32")

    if len(pts) == 4:
        return four_point_transform(image, pts)

    return crop_bounding_rect(image, contour)
