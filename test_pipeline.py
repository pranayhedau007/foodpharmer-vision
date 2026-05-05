"""
End-to-end pipeline test.

Usage:
    python3 test_pipeline.py data/pop_tart_label.jpg
"""
import json
import sys
from pathlib import Path

import cv2

sys.path.insert(0, str(Path(__file__).parent))
from backend.inference import run_pipeline


def main() -> None:
    if len(sys.argv) < 2:
        print("Usage: python3 test_pipeline.py <image_path>")
        sys.exit(1)

    image = cv2.imread(sys.argv[1])
    if image is None:
        print(f"Could not load: {sys.argv[1]}")
        sys.exit(1)

    result = run_pipeline(image)

    print(f"\n{'='*50}")
    print(f"  Health Score : {result['score']} / 100  (Grade: {result['grade']})")
    print(f"{'='*50}")

    if result["red_flags"]:
        print(f"\n  Red Flags ({len(result['red_flags'])}):")
        for flag in result["red_flags"]:
            sev = flag["severity"].upper()
            print(f"    [{sev}]  {flag['name']}")
            print(f"           {flag['reason']}")
    else:
        print("\n  No red flags found.")

    if result["ingredients"]:
        print(f"\n  Ingredients ({len(result['ingredients'])}):")
        print("   ", ", ".join(result["ingredients"][:10]),
              "..." if len(result["ingredients"]) > 10 else "")

    if result["nutrition"]:
        print(f"\n  Nutrition Facts:")
        for k, v in result["nutrition"].items():
            print(f"    {k:<22} {v}")

    print(f"\n  Raw OCR text ({len(result['raw_text'])} chars) — first 300:")
    print("   ", result["raw_text"][:300].replace("\n", " | "))
    print()


if __name__ == "__main__":
    main()
