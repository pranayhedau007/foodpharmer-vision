"""
Usage:
    python test_label_detector.py <image_path>

Runs detect_label on the given image and writes the cropped result to
ml/cv/outputs/cropped_label.jpg.
"""
import sys
from pathlib import Path

import cv2

sys.path.insert(0, str(Path(__file__).parent))
from ml.cv import detect_label


def main() -> None:
    if len(sys.argv) < 2:
        print("Usage: python test_label_detector.py <image_path>")
        sys.exit(1)

    path = sys.argv[1]
    image = cv2.imread(path)
    if image is None:
        print(f"Could not load image: {path}")
        sys.exit(1)

    cropped = detect_label(image)

    out_dir = Path("ml/cv/outputs")
    out_dir.mkdir(parents=True, exist_ok=True)
    out_path = out_dir / "cropped_label.jpg"
    cv2.imwrite(str(out_path), cropped)
    print(f"Saved → {out_path}  (shape: {cropped.shape})")


if __name__ == "__main__":
    main()
