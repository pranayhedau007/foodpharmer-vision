# OCR Reliability App Integration

## What it does

The OCR Reliability section is an informational display added below the health
score.  It tells the user two things:

1. **Photo quality** -- Is the uploaded nutrition label photo likely to produce
   reliable OCR output?  (bad / medium / good)
2. **OCR confidence** -- After OCR runs and nutrition fields are parsed, how
   confident is the system that each extracted field is correct?  (0-100%)

Neither result blocks the existing scoring pipeline.  The app always returns a
score regardless of reliability results.

## Which image it uses

Only the **nutrition label image** (`nutrition_image`).
The ingredients image is never passed to these assessments.

## How photo quality is computed

Three methods are tried in order (first success wins):

### 1. Neural model (if weights exist)
- **Model:** MobileNetV3-Small (torchvision, transfer-learned)
- **Input:** Nutrition label photo resized to 224x224, ImageNet-normalized
- **Output:** 3-class softmax -- `bad` (idx 0), `medium` (idx 1), `good` (idx 2)
- **Confidence:** Max class probability as a percentage

### 2. Heuristic (always available, used when neural weights are missing)
- **Blur:** Laplacian variance (higher = sharper, weighted 40%)
- **Brightness:** Distance from optimal ~130 mean (weighted 25%)
- **Contrast:** Pixel intensity standard deviation (weighted 15%)
- **Resolution:** Image area relative to 800x600 baseline (weighted 20%)
- Combined weighted score mapped to bad (<35) / medium (35-60) / good (>60)

### UI messages
- bad: "Bad photo -- take again"
- medium: "Medium photo -- try taking a better photo for more accurate data"
- good: "Good photo!"

## How OCR confidence is computed

Three methods are tried in order (first success wins):

### 1. FieldConfidenceNet-Lite neural model (if weights exist)
- 2-layer MLP with TF-IDF (768 dims) + engineered features
- Sigmoid probability per field that the extracted value is correct
- Overall = mean of per-field confidences for extracted fields
- Requires `field_confidence_lite.pt` and `field_confidence_vectorizer.pkl`

### 2. Tesseract word-level confidence (always available when Tesseract runs)
- Runs `pytesseract.image_to_data()` on the preprocessed nutrition image
- Averages per-word confidence scores from Tesseract (0-100 scale)
- Per-field confidence is adjusted: +10% for plausible values, -30% for non-numeric
- This is the default method since the neural weights are not committed

### 3. Extraction quality heuristic (last resort, no Tesseract needed)
- Scores each parsed field: +50 base, +25 numeric, +25 plausible range
- Penalizes based on extraction rate (how many core fields were found)
- Always produces a result even if Tesseract is unavailable

## How the frontend displays it

A new "OCR Reliability" card appears between the score row and the Nutrition
Facts section.  It shows:

```
Photo quality:  Good photo!
OCR confidence: 88%
```

Photo quality text is color-coded: green (good), orange (medium), red (bad).

## Backend response shape

```json
{
  "ocr_reliability": {
    "photo_quality": {
      "label": "good",
      "message": "Good photo!",
      "confidence_percent": 74.7,
      "probabilities": {"bad": 0.1, "medium": 16.3, "good": 83.7}
    },
    "field_confidence": {
      "overall_confidence_percent": 88.4,
      "message": "OCR confidence: 88%",
      "fields_evaluated": 9,
      "per_field": [
        {"field": "calories", "value": "210", "confidence_percent": 92.1}
      ]
    },
    "status": "ok"
  }
}
```

## Optional neural model artifacts

If trained weights are available, place them in any of these directories:
- `ml/ocr/neural/outputs/final_ocr_v2_clean/small_vision_quality/`
- `ml/ocr/neural/outputs/final_ocr_strategy_comparison/field_confidence_lite/`
- `ml/ocr/neural/weights/`

| Artifact | Filename |
|---|---|
| Image quality model | `small_vision_quality_mobilenet_v3_small.pt` |
| Field confidence model | `field_confidence_lite.pt` |
| Field confidence vectorizer | `field_confidence_vectorizer.pkl` |

## How to run

```bash
# Backend
uvicorn backend.api.main:app --reload

# Frontend (from foodpharmer-vision-partner directory)
cd frontend && npm run dev
```

Upload both images and click Analyze.

## Known limitations

- Neural model weights are not committed.  The heuristic and Tesseract
  fallbacks produce meaningful results without them.
- Parser key mapping (`sugars` -> `total_sugars`, etc.) covers common
  mismatches but may miss edge cases for unusual field names.
- The Tesseract confidence fallback adds one extra Tesseract call on the
  nutrition image (the main pipeline discards word-level confidence data).
