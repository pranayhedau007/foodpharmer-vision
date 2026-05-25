"""
Generate synthetic FDA-style nutrition label images with ground-truth JSON.

Usage:
    python -m ml.ocr.neural.synthetic_label_generator --num 2000 --out data/synthetic_ocr
    python -m ml.ocr.neural.synthetic_label_generator --num 10 --out data/synthetic_ocr_smoke
"""

from __future__ import annotations

import argparse
import json
import logging
import os
import random
import sys
from pathlib import Path
from typing import Optional

from PIL import Image, ImageDraw, ImageFont

from .fields import FIELD_RANGES, FIELD_UNITS, NUTRITION_FIELDS

logger = logging.getLogger(__name__)

# ── Font resolution ───────────────────────────────────────────────────────────

_FONT_CANDIDATES_REGULAR = [
    "arial.ttf",
    "Arial.ttf",
    "Helvetica.ttf",
    "DejaVuSans.ttf",
    "LiberationSans-Regular.ttf",
    "C:/Windows/Fonts/arial.ttf",
    "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
    "/usr/share/fonts/truetype/liberation/LiberationSans-Regular.ttf",
    "/System/Library/Fonts/Helvetica.ttc",
]

_FONT_CANDIDATES_BOLD = [
    "arialbd.ttf",
    "Arial Bold.ttf",
    "Helvetica-Bold.ttf",
    "DejaVuSans-Bold.ttf",
    "LiberationSans-Bold.ttf",
    "C:/Windows/Fonts/arialbd.ttf",
    "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf",
    "/usr/share/fonts/truetype/liberation/LiberationSans-Bold.ttf",
    "/System/Library/Fonts/Helvetica.ttc",
]


def _load_font(candidates: list[str], size: int) -> ImageFont.FreeTypeFont | ImageFont.ImageFont:
    for name in candidates:
        try:
            return ImageFont.truetype(name, size)
        except (OSError, IOError):
            continue
    logger.warning("No TrueType font found; falling back to default bitmap font.")
    return ImageFont.load_default()


# ── Layout styles ─────────────────────────────────────────────────────────────

_LAYOUT_STYLES = ["tall_fda", "narrow_tall", "wide_short", "compact", "elongated_vertical", "off_center_canvas"]


def _pick_layout(style: str) -> dict:
    """Return width/height ranges for a given layout style.

    Dimensions are large enough (~800x1000+) to produce text at 300+ DPI
    equivalent, which Tesseract reads much more reliably.
    """
    if style == "tall_fda":
        return {"w": (700, 880), "h": (1200, 1500)}
    elif style == "narrow_tall":
        return {"w": (600, 720), "h": (1300, 1600)}
    elif style == "wide_short":
        return {"w": (800, 1000), "h": (900, 1100)}
    elif style == "compact":
        return {"w": (650, 780), "h": (1000, 1200)}
    elif style == "elongated_vertical":
        return {"w": (650, 780), "h": (1400, 1700)}
    else:  # off_center_canvas
        return {"w": (700, 880), "h": (1200, 1500)}


# ── Serving-size phrases ──────────────────────────────────────────────────────

_SERVING_PHRASES = [
    "{n} cup", "{n} cups", "{n} tbsp", "{n} piece", "{n} pieces",
    "{n} oz", "{n} slice", "{n} slices", "{n} bar", "{n} pouch",
    "{n} cookie", "{n} cookies", "{n} crackers",
]


def _random_serving() -> str:
    phrase = random.choice(_SERVING_PHRASES)
    n = random.choice(["1/2", "1", "1 1/2", "2", "2/3", "3/4", "1/3", "3", "4"])
    grams = random.randint(15, 350)
    return f"{phrase.format(n=n)} ({grams}g)"


# ── Field generation ──────────────────────────────────────────────────────────

def _generate_fields(include_vitamins: bool, include_added_sugars: bool) -> dict[str, str]:
    """Generate random but internally consistent nutrition values."""
    fields: dict[str, str] = {}

    def _rand(key: str, force_int: bool = False) -> float:
        lo, hi = FIELD_RANGES[key]
        val = random.uniform(lo, hi)
        if force_int:
            val = round(val)
        else:
            val = round(val, 1)
        return val

    # Independent fields
    calories = _rand("calories", force_int=True)
    total_fat = _rand("total_fat")
    cholesterol = _rand("cholesterol", force_int=True)
    sodium = _rand("sodium", force_int=True)
    total_carb = _rand("total_carbohydrate")
    protein = _rand("protein")

    # Constrained sub-fields
    sat_fat = round(random.uniform(0, min(total_fat, 25)), 1)
    trans_fat = round(random.uniform(0, min(total_fat - sat_fat, 5)), 1) if total_fat > sat_fat else 0
    fiber = round(random.uniform(0, min(total_carb, 25)), 1)
    total_sugars = round(random.uniform(0, min(total_carb - fiber, 80)), 1) if total_carb > fiber else 0
    added_sugars = round(random.uniform(0, min(total_sugars, 60)), 1) if total_sugars > 0 else 0

    def _fmt(val: float, unit: str) -> str:
        if unit in ("mg", "mcg", ""):
            return f"{int(val)}{unit}"
        ival = int(val)
        return f"{ival}{unit}" if val == ival else f"{val}{unit}"

    fields["calories"] = str(int(calories))
    fields["total_fat"] = _fmt(total_fat, "g")
    fields["saturated_fat"] = _fmt(sat_fat, "g")
    fields["trans_fat"] = _fmt(trans_fat, "g")
    fields["cholesterol"] = _fmt(cholesterol, "mg")
    fields["sodium"] = _fmt(sodium, "mg")
    fields["total_carbohydrate"] = _fmt(total_carb, "g")
    fields["dietary_fiber"] = _fmt(fiber, "g")
    fields["total_sugars"] = _fmt(total_sugars, "g")
    fields["protein"] = _fmt(protein, "g")

    if include_added_sugars:
        fields["added_sugars"] = _fmt(added_sugars, "g")

    if include_vitamins:
        fields["vitamin_d"] = _fmt(_rand("vitamin_d"), "mcg")
        fields["calcium"] = _fmt(_rand("calcium", force_int=True), "mg")
        fields["iron"] = _fmt(_rand("iron"), "mg")
        fields["potassium"] = _fmt(_rand("potassium", force_int=True), "mg")

    return fields


# ── Label rendering ───────────────────────────────────────────────────────────

def _draw_label(fields: dict[str, str], style: str,
                include_dv: bool, include_vitamins: bool,
                include_added_sugars: bool) -> tuple[Image.Image, dict]:
    """Render a single nutrition label image and return (image, layout_info)."""
    dims = _pick_layout(style)
    width = random.randint(*dims["w"])

    # Larger spacing / padding for Tesseract readability
    pad_lr = random.randint(30, 50)
    pad_tb = random.randint(20, 40)
    font_title = random.randint(36, 44)
    font_header = random.randint(24, 30)
    font_body = random.randint(20, 26)
    line_gap = random.randint(6, 12)
    border_thick = random.randint(2, 5)
    sep_thick = random.randint(2, 4)

    # Pure black on pure white — maximum contrast for OCR
    bg_color = (255, 255, 255)
    fg_color = (0, 0, 0)

    bold_font = _load_font(_FONT_CANDIDATES_BOLD, font_title)
    header_font = _load_font(_FONT_CANDIDATES_BOLD, font_header)
    body_font = _load_font(_FONT_CANDIDATES_REGULAR, font_body)
    body_bold = _load_font(_FONT_CANDIDATES_BOLD, font_body)
    small_font = _load_font(_FONT_CANDIDATES_REGULAR, max(font_body - 2, 8))

    # We draw onto a tall canvas, then crop at the end.
    canvas_h = 2400
    img = Image.new("RGB", (width, canvas_h), bg_color)
    draw = ImageDraw.Draw(img)

    x_left = pad_lr
    x_right = width - pad_lr
    y = pad_tb

    def _text(font, text, x=None, bold=False, indent=0):
        nonlocal y
        tx = (x if x is not None else x_left) + indent
        draw.text((tx, y), text, fill=fg_color, font=font)
        bbox = font.getbbox(text)
        y += (bbox[3] - bbox[1]) + line_gap

    def _line(thickness=1):
        nonlocal y
        y += 2
        draw.rectangle([x_left, y, x_right, y + thickness], fill=fg_color)
        y += thickness + 3

    def _field_row(label: str, value: str, bold_label: bool = True, indent: int = 0,
                   dv: Optional[str] = None):
        nonlocal y
        lf = body_bold if bold_label else body_font
        txt = f"{label} {value}"
        tx = x_left + indent
        draw.text((tx, y), txt, fill=fg_color, font=lf)
        if include_dv and dv is not None:
            dv_text = f"{dv}%"
            dv_bbox = body_font.getbbox(dv_text)
            dv_w = dv_bbox[2] - dv_bbox[0]
            draw.text((x_right - dv_w, y), dv_text, fill=fg_color, font=body_font)
        bbox = lf.getbbox(txt)
        y += (bbox[3] - bbox[1]) + line_gap

    servings = random.randint(*[int(x) for x in FIELD_RANGES["servings_per_container"]])
    serving_size = _random_serving()

    # ── Title ──
    _text(bold_font, "Nutrition Facts")
    _line(sep_thick + 2)

    # Servings
    _text(body_font, f"{servings} servings per container")
    _text(body_bold, f"Serving size  {serving_size}")
    _line(sep_thick + 4)

    # Calories — use same size as title, not larger.
    # Oversized text causes Tesseract PSM 4 to skip the line entirely.
    cal_font = _load_font(_FONT_CANDIDATES_BOLD, font_title)
    _text(cal_font, f"Calories {fields['calories']}")
    _line(sep_thick + 2)

    # % DV header
    if include_dv:
        _text(small_font, "% Daily Value*")

    # Main nutrients
    _field_row("Total Fat", fields["total_fat"], dv=str(random.randint(1, 80)))
    _line(1)
    _field_row("Saturated Fat", fields["saturated_fat"], indent=16, dv=str(random.randint(1, 60)))
    _line(1)
    _field_row("Trans Fat", fields["trans_fat"], bold_label=False, indent=16)
    _line(1)
    _field_row("Cholesterol", fields["cholesterol"], dv=str(random.randint(0, 50)))
    _line(1)
    _field_row("Sodium", fields["sodium"], dv=str(random.randint(1, 90)))
    _line(1)
    _field_row("Total Carbohydrate", fields["total_carbohydrate"], dv=str(random.randint(1, 60)))
    _line(1)
    _field_row("Dietary Fiber", fields["dietary_fiber"], indent=16, dv=str(random.randint(0, 80)))
    _line(1)
    _field_row("Total Sugars", fields["total_sugars"], indent=16)

    if include_added_sugars and "added_sugars" in fields:
        _line(1)
        _field_row("Includes", f"{fields['added_sugars']} Added Sugars",
                   bold_label=False, indent=24, dv=str(random.randint(0, 40)))

    _line(1)
    _field_row("Protein", fields["protein"], dv=str(random.randint(1, 60)))
    _line(sep_thick + 2)

    # Vitamins / minerals
    if include_vitamins and "vitamin_d" in fields:
        _field_row("Vitamin D", fields["vitamin_d"], bold_label=False, dv=str(random.randint(0, 50)))
        _line(1)
        _field_row("Calcium", fields["calcium"], bold_label=False, dv=str(random.randint(0, 50)))
        _line(1)
        _field_row("Iron", fields["iron"], bold_label=False, dv=str(random.randint(0, 80)))
        _line(1)
        _field_row("Potassium", fields["potassium"], bold_label=False, dv=str(random.randint(0, 50)))
        _line(sep_thick)

    # Footer
    if include_dv:
        y += 4
        _text(small_font, "* The % Daily Value tells you how much a nutrient")
        _text(small_font, "  in a serving of food contributes to a daily diet.")

    # Crop to content
    final_h = y + pad_tb
    img = img.crop((0, 0, width, final_h))

    # Draw border
    draw2 = ImageDraw.Draw(img)
    draw2.rectangle([0, 0, width - 1, final_h - 1], outline=fg_color, width=border_thick)

    # Off-center canvas style: embed in a larger canvas with offset
    if style == "off_center_canvas":
        extra_w = random.randint(30, 80)
        extra_h = random.randint(30, 80)
        offset_x = random.randint(5, extra_w)
        offset_y = random.randint(5, extra_h)
        canvas = Image.new("RGB", (width + extra_w, final_h + extra_h), bg_color)
        canvas.paste(img, (offset_x, offset_y))
        img = canvas
        width = img.width
        final_h = img.height

    layout = {"width": width, "height": final_h, "style": style}
    return img, layout


# ── Public API ────────────────────────────────────────────────────────────────

def generate_label(label_id: str) -> tuple[Image.Image, dict]:
    """Generate one synthetic label.  Returns (PIL image, metadata dict)."""
    style = random.choice(_LAYOUT_STYLES)
    include_dv = random.random() < 0.7
    include_vitamins = random.random() < 0.6
    include_added_sugars = random.random() < 0.7

    fields = _generate_fields(include_vitamins, include_added_sugars)
    img, layout = _draw_label(fields, style, include_dv, include_vitamins, include_added_sugars)

    meta = {"id": label_id, "fields": fields, "layout": layout}
    return img, meta


def generate_dataset(num: int, out_dir: str) -> None:
    """Generate *num* labels, saving images and metadata to *out_dir*."""
    clean_dir = os.path.join(out_dir, "clean")
    meta_dir = os.path.join(out_dir, "metadata")
    os.makedirs(clean_dir, exist_ok=True)
    os.makedirs(meta_dir, exist_ok=True)

    for i in range(num):
        label_id = f"label_{i:06d}"
        img, meta = generate_label(label_id)
        img.save(os.path.join(clean_dir, f"{label_id}.png"))
        with open(os.path.join(meta_dir, f"{label_id}.json"), "w") as f:
            json.dump(meta, f, indent=2)
        if (i + 1) % 100 == 0 or (i + 1) == num:
            logger.info("Generated %d / %d labels", i + 1, num)

    logger.info("Done.  Labels saved to %s", out_dir)


# ── CLI ───────────────────────────────────────────────────────────────────────

def main() -> None:
    parser = argparse.ArgumentParser(description="Generate synthetic nutrition labels")
    parser.add_argument("--num", type=int, default=2000, help="Number of labels")
    parser.add_argument("--out", type=str, default="data/synthetic_ocr", help="Output directory")
    parser.add_argument("--seed", type=int, default=42, help="Random seed")
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
    random.seed(args.seed)

    generate_dataset(args.num, args.out)


if __name__ == "__main__":
    main()
