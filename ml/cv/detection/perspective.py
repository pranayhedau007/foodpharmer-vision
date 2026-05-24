import cv2
import numpy as np

from ..utils.image_utils import order_points


def four_point_transform(image: np.ndarray, pts: np.ndarray) -> np.ndarray:
    """
    Phase 2: perspective-correct crop.

    Warps the quadrilateral defined by pts into a flat, top-down rectangle.
    """
    rect = order_points(pts.reshape(4, 2))
    tl, tr, br, bl = rect

    width_a = np.linalg.norm(br - bl)
    width_b = np.linalg.norm(tr - tl)
    max_width = max(int(width_a), int(width_b))

    height_a = np.linalg.norm(tr - br)
    height_b = np.linalg.norm(tl - bl)
    max_height = max(int(height_a), int(height_b))

    dst = np.array(
        [
            [0, 0],
            [max_width - 1, 0],
            [max_width - 1, max_height - 1],
            [0, max_height - 1],
        ],
        dtype="float32",
    )

    M = cv2.getPerspectiveTransform(rect, dst)
    return cv2.warpPerspective(image, M, (max_width, max_height))
