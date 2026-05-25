"""
Corruption / augmentation pipeline for synthetic nutrition labels.

Applies 1-3 random corruptions per image at a given severity level
to simulate real phone-camera conditions.

Usage:
    python -m ml.ocr.neural.corrupt_labels \
        --clean data/synthetic_ocr/clean \
        --targets data/synthetic_ocr/clean_targets \
        --out data/synthetic_ocr/corrupted \
        --variants 5 --max-severity 4
"""

from __future__ import annotations

import argparse
import json
import logging
import os
import random
from pathlib import Path
from typing import Any

import cv2
import numpy as np

logger = logging.getLogger(__name__)

# ── Individual corruption functions ───────────────────────────────────────────
# Each returns (corrupted_image, params_dict).

def _gaussian_blur(img: np.ndarray, severity: int) -> tuple[np.ndarray, dict]:
    k = [1, 3, 5, 7, 11][severity]
    if k <= 1:
        return img, {"kernel": 1}
    out = cv2.GaussianBlur(img, (k, k), 0)
    return out, {"kernel": k}


def _motion_blur(img: np.ndarray, severity: int) -> tuple[np.ndarray, dict]:
    k = [3, 5, 9, 13, 19][severity]
    kernel = np.zeros((k, k))
    kernel[k // 2, :] = 1.0 / k
    if random.random() < 0.5:
        kernel = kernel.T  # vertical
    out = cv2.filter2D(img, -1, kernel)
    return out, {"kernel": k}


def _gaussian_noise(img: np.ndarray, severity: int) -> tuple[np.ndarray, dict]:
    sigma = [5, 15, 30, 50, 80][severity]
    noise = np.random.normal(0, sigma, img.shape).astype(np.float32)
    out = np.clip(img.astype(np.float32) + noise, 0, 255).astype(np.uint8)
    return out, {"sigma": sigma}


def _salt_pepper(img: np.ndarray, severity: int) -> tuple[np.ndarray, dict]:
    prob = [0.005, 0.01, 0.03, 0.06, 0.10][severity]
    out = img.copy()
    mask = np.random.random(img.shape[:2])
    out[mask < prob / 2] = 0
    out[mask > 1 - prob / 2] = 255
    return out, {"probability": prob}


def _brightness_reduce(img: np.ndarray, severity: int) -> tuple[np.ndarray, dict]:
    factor = [0.90, 0.75, 0.60, 0.45, 0.30][severity]
    out = np.clip(img.astype(np.float32) * factor, 0, 255).astype(np.uint8)
    return out, {"factor": factor}


def _brightness_increase(img: np.ndarray, severity: int) -> tuple[np.ndarray, dict]:
    factor = [1.10, 1.25, 1.50, 1.80, 2.20][severity]
    out = np.clip(img.astype(np.float32) * factor, 0, 255).astype(np.uint8)
    return out, {"factor": factor}


def _contrast_reduce(img: np.ndarray, severity: int) -> tuple[np.ndarray, dict]:
    factor = [0.90, 0.75, 0.55, 0.40, 0.25][severity]
    mean = img.mean()
    out = np.clip(mean + (img.astype(np.float32) - mean) * factor, 0, 255).astype(np.uint8)
    return out, {"factor": factor}


def _jpeg_compress(img: np.ndarray, severity: int) -> tuple[np.ndarray, dict]:
    quality = [80, 50, 30, 15, 5][severity]
    _, buf = cv2.imencode(".jpg", img, [cv2.IMWRITE_JPEG_QUALITY, quality])
    out = cv2.imdecode(buf, cv2.IMREAD_COLOR if len(img.shape) == 3 else cv2.IMREAD_GRAYSCALE)
    return out, {"quality": quality}


def _rotation(img: np.ndarray, severity: int) -> tuple[np.ndarray, dict]:
    max_angle = [1, 3, 5, 8, 12][severity]
    angle = random.uniform(-max_angle, max_angle)
    h, w = img.shape[:2]
    M = cv2.getRotationMatrix2D((w / 2, h / 2), angle, 1.0)
    bg = 255 if img.mean() > 127 else 0
    out = cv2.warpAffine(img, M, (w, h), borderValue=(bg, bg, bg) if len(img.shape) == 3 else bg)
    return out, {"angle": round(angle, 2)}


def _perspective_warp(img: np.ndarray, severity: int) -> tuple[np.ndarray, dict]:
    magnitude = [4, 8, 14, 22, 32][severity]
    h, w = img.shape[:2]
    pts1 = np.float32([[0, 0], [w, 0], [w, h], [0, h]])
    offsets = np.random.randint(-magnitude, magnitude + 1, (4, 2)).astype(np.float32)
    pts2 = pts1 + offsets
    M = cv2.getPerspectiveTransform(pts1, pts2)
    bg = 255 if img.mean() > 127 else 0
    out = cv2.warpPerspective(img, M, (w, h),
                              borderValue=(bg, bg, bg) if len(img.shape) == 3 else bg)
    return out, {"magnitude": magnitude}


def _glare_spot(img: np.ndarray, severity: int) -> tuple[np.ndarray, dict]:
    intensity = [0.15, 0.30, 0.50, 0.70, 0.90][severity]
    h, w = img.shape[:2]
    cx = random.randint(w // 4, 3 * w // 4)
    cy = random.randint(h // 4, 3 * h // 4)
    radius = random.randint(min(h, w) // 6, min(h, w) // 3)

    Y, X = np.ogrid[:h, :w]
    dist = np.sqrt((X - cx) ** 2 + (Y - cy) ** 2).astype(np.float32)
    mask = np.clip(1.0 - dist / radius, 0, 1) * intensity

    if len(img.shape) == 3:
        mask = mask[:, :, np.newaxis]
    out = np.clip(img.astype(np.float32) + mask * 255, 0, 255).astype(np.uint8)
    return out, {"cx": cx, "cy": cy, "radius": radius, "intensity": intensity}


def _downscale_upscale(img: np.ndarray, severity: int) -> tuple[np.ndarray, dict]:
    scale = [0.80, 0.60, 0.40, 0.25, 0.15][severity]
    h, w = img.shape[:2]
    small = cv2.resize(img, (max(int(w * scale), 1), max(int(h * scale), 1)),
                       interpolation=cv2.INTER_AREA)
    out = cv2.resize(small, (w, h), interpolation=cv2.INTER_LINEAR)
    return out, {"scale": scale}


def _off_center_crop(img: np.ndarray, severity: int) -> tuple[np.ndarray, dict]:
    pad = [5, 12, 25, 40, 60][severity]
    h, w = img.shape[:2]
    top = random.randint(0, pad)
    left = random.randint(0, pad)
    bottom = random.randint(0, pad)
    right = random.randint(0, pad)
    bg = 255 if img.mean() > 127 else 0
    if len(img.shape) == 3:
        out = cv2.copyMakeBorder(img, top, bottom, left, right,
                                 cv2.BORDER_CONSTANT, value=(bg, bg, bg))
    else:
        out = cv2.copyMakeBorder(img, top, bottom, left, right,
                                 cv2.BORDER_CONSTANT, value=bg)
    # Resize back to original dimensions
    out = cv2.resize(out, (w, h))
    return out, {"pad_top": top, "pad_left": left, "pad_bottom": bottom, "pad_right": right}


def _shadow_gradient(img: np.ndarray, severity: int) -> tuple[np.ndarray, dict]:
    strength = [0.10, 0.20, 0.35, 0.50, 0.65][severity]
    h, w = img.shape[:2]
    direction = random.choice(["left", "right", "top", "bottom"])
    if direction in ("left", "right"):
        grad = np.linspace(0, 1, w, dtype=np.float32)
        if direction == "right":
            grad = grad[::-1]
        grad = np.tile(grad, (h, 1))
    else:
        grad = np.linspace(0, 1, h, dtype=np.float32)
        if direction == "bottom":
            grad = grad[::-1]
        grad = np.tile(grad.reshape(-1, 1), (1, w))

    shadow = 1.0 - grad * strength
    if len(img.shape) == 3:
        shadow = shadow[:, :, np.newaxis]
    out = np.clip(img.astype(np.float32) * shadow, 0, 255).astype(np.uint8)
    return out, {"strength": strength, "direction": direction}


# Registry
_CORRUPTIONS: list[tuple[str, Any]] = [
    ("gaussian_blur", _gaussian_blur),
    ("motion_blur", _motion_blur),
    ("gaussian_noise", _gaussian_noise),
    ("salt_pepper", _salt_pepper),
    ("brightness_reduce", _brightness_reduce),
    ("brightness_increase", _brightness_increase),
    ("contrast_reduce", _contrast_reduce),
    ("jpeg_compress", _jpeg_compress),
    ("rotation", _rotation),
    ("perspective_warp", _perspective_warp),
    ("glare_spot", _glare_spot),
    ("downscale_upscale", _downscale_upscale),
    ("off_center_crop", _off_center_crop),
    ("shadow_gradient", _shadow_gradient),
]


# ── Public API ────────────────────────────────────────────────────────────────

def corrupt_image(img: np.ndarray, severity: int,
                  num_corruptions: int | None = None) -> tuple[np.ndarray, list[dict]]:
    """
    Apply random corruptions to an image.

    Returns (corrupted_image, list_of_corruption_records).
    """
    severity = max(0, min(severity, 4))
    if severity == 0:
        return img.copy(), []

    if num_corruptions is None:
        num_corruptions = random.randint(1, 3)

    chosen = random.sample(_CORRUPTIONS, min(num_corruptions, len(_CORRUPTIONS)))
    records: list[dict] = []
    out = img.copy()

    for name, fn in chosen:
        out, params = fn(out, severity)
        records.append({"name": name, "params": params})

    return out, records


def corrupt_dataset(clean_dir: str, targets_dir: str | None, out_dir: str,
                    variants: int = 5, max_severity: int = 4) -> None:
    """
    Generate corrupted variants for every clean label in *clean_dir*.

    Writes corrupted images and a JSONL corruption log.
    """
    os.makedirs(out_dir, exist_ok=True)
    meta_dir = os.path.join(os.path.dirname(clean_dir), "metadata")
    os.makedirs(meta_dir, exist_ok=True)

    clean_paths = sorted(Path(clean_dir).glob("*.png"))
    if not clean_paths:
        logger.warning("No PNGs found in %s", clean_dir)
        return

    log_path = os.path.join(meta_dir, "corruption_log.jsonl")
    count = 0

    with open(log_path, "w") as log_f:
        for p in clean_paths:
            clean_id = p.stem
            img = cv2.imread(str(p))
            if img is None:
                continue

            target_path = ""
            if targets_dir:
                tp = os.path.join(targets_dir, p.name)
                if os.path.exists(tp):
                    target_path = tp

            for vi in range(variants):
                sev = random.randint(1, max_severity)
                corrupted, records = corrupt_image(img, sev)

                cid = f"{clean_id}__sev{sev}__aug{vi:02d}"
                out_path = os.path.join(out_dir, f"{cid}.png")
                cv2.imwrite(out_path, corrupted)

                entry = {
                    "corrupted_id": cid,
                    "clean_id": clean_id,
                    "clean_image": str(p),
                    "target_image": target_path,
                    "corrupted_image": out_path,
                    "severity": sev,
                    "corruptions": records,
                }
                log_f.write(json.dumps(entry) + "\n")
                count += 1

            if (count) % 500 == 0 or p == clean_paths[-1]:
                logger.info("Corrupted images written: %d", count)

    logger.info("Done.  %d corrupted images in %s", count, out_dir)
    logger.info("Corruption log: %s", log_path)


# ── CLI ───────────────────────────────────────────────────────────────────────

def main() -> None:
    parser = argparse.ArgumentParser(description="Corrupt synthetic nutrition labels")
    parser.add_argument("--clean", required=True, help="Directory of clean PNGs")
    parser.add_argument("--targets", default=None, help="Directory of OCR-friendly target PNGs")
    parser.add_argument("--out", required=True, help="Output directory for corrupted images")
    parser.add_argument("--variants", type=int, default=5, help="Corrupted variants per image")
    parser.add_argument("--max-severity", type=int, default=4, help="Max severity 1-4")
    parser.add_argument("--seed", type=int, default=42, help="Random seed")
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
    random.seed(args.seed)
    np.random.seed(args.seed)

    corrupt_dataset(args.clean, args.targets, args.out, args.variants, args.max_severity)


if __name__ == "__main__":
    main()
