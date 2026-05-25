# Claude Prompt: Integrate OCR Reliability Models Into Food Pharmer App

## Repo / Branch Context

You are working in the integrated partner branch of the Food Pharmer app.

Likely path:

```text
C:\Users\sherw\OneDrive\Desktop\CS274\foodpharmer-vision-partner
```

The app currently has two image inputs:

```text
1. Nutrition/Food Label image
2. Ingredients image
```

When the user clicks **Analyze**, the app runs the existing backend pipeline and displays a food/nutrition score based on everyone’s components.

Now we need to integrate Sherwin’s OCR reliability work into the app UI.

---

# Goal

Add a new display section under the existing food/nutrition score that shows OCR reliability results from Sherwin’s two models:

```text
1. Image-level OCR quality model
2. FieldConfidenceNet-Lite field-level confidence model
```

Important:

```text
Only run these models on the NUTRITION / FOOD LABEL PHOTO.
Do NOT run these models on the ingredients image.
Do NOT change the existing score calculation.
Do NOT block scoring based on confidence.
Always return/display an evaluation no matter what.
```

The new UI section should tell the user:

```text
Photo quality:
- Bad photo — take again
- Medium photo — try taking a better photo for more accurate data
- Good photo!

OCR confidence:
- confidence percentage %
```

---

# High-Level App Behavior

Current app behavior:

```text
Nutrition label image + Ingredients image
        ↓
Analyze button
        ↓
Backend /scan route
        ↓
Existing OCR / ingredient / scoring pipeline
        ↓
Frontend displays score/results
```

New behavior:

```text
Nutrition label image + Ingredients image
        ↓
Analyze button
        ↓
Backend /scan route
        ↓
Existing pipeline still runs normally
        ↓
In parallel or immediately after:
    nutrition label image only
        ↓
    image-level OCR quality model
        ↓
    FieldConfidenceNet-Lite
        ↓
Frontend displays OCR reliability section under score
```

The reliability section is informational. It should not prevent scoring.

---

# Existing OCR Model Context

Sherwin’s branch added OCR reliability scripts under:

```text
ml/ocr/neural/
```

Important files likely available:

```text
ml/ocr/neural/field_confidence_lite.py
ml/ocr/neural/fields.py
ml/ocr/neural/parse_synthetic_ocr.py
ml/ocr/neural/inference.py
ml/ocr/neural/training/train_small_vision_quality.py
ml/ocr/neural/training/train_field_confidence_lite.py
ml/ocr/neural/evaluation/evaluate_field_confidence_lite_real.py
ml/ocr/neural/evaluation/final_ocr_strategy_comparison.py
ml/ocr/neural/evaluation/build_final_ocr_v2_clean_outputs.py
```

Expected model/output locations may include:

```text
ml/ocr/neural/outputs/final_ocr_v2_clean/small_vision_quality/
ml/ocr/neural/outputs/final_ocr_strategy_comparison/field_confidence_lite/
```

Possible model files:

```text
field_confidence_lite.pt
small_vision_quality.pt
```

But do not assume exact filenames. First inspect the repo for existing `.pt`, `.joblib`, `.pkl`, `.json`, and metadata files needed to run inference.

Use:

```powershell
dir ml\ocr\neural\outputs -Recurse
dir ml\ocr\neural -Recurse -Include *.pt,*.pkl,*.joblib,*.json
```

If model weights are not committed, create clean placeholder/loading behavior and document exactly which artifacts need to be copied into the repo or mounted locally.

---

# Important Model Meanings

## 1. Image-Level OCR Quality Model

This model does **not** read nutrition values.

It predicts:

```text
Is this nutrition label image likely to produce reliable OCR?
```

Expected output classes:

```text
bad
medium
good
```

UI mapping:

```text
bad    → "Bad photo — take again"
medium → "Medium photo — try taking a better photo for more accurate data"
good   → "Good photo!"
```

Also expose a probability/confidence if available:

```text
photo_quality_confidence_percent
```

If the model outputs class probabilities, use the max probability as the photo quality confidence.

If the model is unavailable, return:

```json
{
  "photo_quality_label": "unknown",
  "photo_quality_message": "Photo quality model unavailable",
  "photo_quality_confidence_percent": null
}
```

Do not crash the `/scan` endpoint.

---

## 2. FieldConfidenceNet-Lite

This model works **after OCR**.

It predicts:

```text
For each extracted nutrition field, is this field probably correct?
```

It may return a confidence score per field.

For the frontend, we need one simple display number:

```text
OCR confidence: XX%
```

Recommended aggregation:

```text
overall_ocr_confidence_percent = average confidence over extracted/evaluated nutrition fields
```

If no extracted fields exist, return either:

```text
0%
```

or:

```json
null with message "No nutrition fields extracted"
```

Preferred behavior for UI:

```text
Always show a result.
If no fields were extracted, show:
"OCR confidence: Not enough fields detected"
```

If per-field confidences are easy to include, return them too for debugging/future UI, but the frontend only needs the overall percentage right now.

Do **not** threshold-gate the result. Do **not** only accept above 0.85 or 0.95. The user wants the app to always display an evaluation.

---

# Required Backend Changes

Find the current scan route and pipeline.

Known/likely files:

```text
backend/api/routes.py
backend/inference/pipeline.py
```

Existing route likely does:

```python
result = run_pipeline(nutrition_img, ingredients_img)
```

Add OCR reliability integration without breaking existing result format.

Preferred approach:

Create a new backend helper module, for example:

```text
backend/inference/ocr_reliability.py
```

or if cleaner:

```text
ml/ocr/neural/runtime_reliability.py
```

The helper should expose something like:

```python
def run_ocr_reliability(nutrition_img) -> dict:
    ...
```

Expected returned shape:

```python
{
    "photo_quality": {
        "label": "bad" | "medium" | "good" | "unknown",
        "message": "Bad photo — take again",
        "confidence_percent": 87.3,
        "probabilities": {
            "bad": 0.05,
            "medium": 0.10,
            "good": 0.85
        }
    },
    "field_confidence": {
        "overall_confidence_percent": 92.4,
        "message": "OCR confidence: 92.4%",
        "fields_evaluated": 12,
        "per_field": [
            {
                "field": "calories",
                "value": "120",
                "confidence_percent": 96.1
            }
        ]
    },
    "status": "ok"
}
```

If anything fails, return a safe fallback:

```python
{
    "photo_quality": {
        "label": "unknown",
        "message": "Photo quality unavailable",
        "confidence_percent": None,
        "probabilities": {}
    },
    "field_confidence": {
        "overall_confidence_percent": None,
        "message": "OCR confidence unavailable",
        "fields_evaluated": 0,
        "per_field": []
    },
    "status": "unavailable",
    "error": "short error message"
}
```

Do not raise an exception from this helper into `/scan`.

In `run_pipeline` or the `/scan` route, attach this to the existing response:

```python
result["ocr_reliability"] = run_ocr_reliability(nutrition_img)
```

or if the response is a Pydantic model/dict with another structure, add equivalent field.

Important:

```text
The nutrition image may be an UploadFile, PIL Image, path, bytes, or OpenCV array depending on the current code.
Inspect current pipeline and adapt the helper to the existing image type.
Do not run on ingredients_img.
```

---

# Required Inference Details

## Image quality model inference

Inspect `train_small_vision_quality.py` to reproduce preprocessing exactly:

Expected preprocessing:

```text
PIL/OpenCV image
resize to 224x224
normalize using torchvision pretrained weights transform if used
MobileNetV3-small backbone
3-class classifier head
softmax
```

Class order must match training.

Expected class order from docs:

```text
bad, medium, good
```

Verify from code/checkpoint metadata. Do not guess if metadata exists.

If class order is not saved, infer from training script and document it.

## FieldConfidenceNet-Lite inference

Inspect:

```text
ml/ocr/neural/field_confidence_lite.py
ml/ocr/neural/training/train_field_confidence_lite.py
ml/ocr/neural/training/generate_field_confidence_lite_pairs.py
```

Need to reproduce the exact feature pipeline:

```text
Tesseract OCR text
parse nutrition fields
build field rows/features
load TF-IDF/vectorizer if saved
load MLP checkpoint
predict confidence per field
average confidence for overall score
```

If the trained vectorizer/scaler/model metadata are missing, do **not** fake confidence. Return `unavailable` and document which artifact is missing.

If runtime confidence inference is too difficult because artifacts were not committed, implement the backend/API structure and add clear TODO paths so Sherwin can copy model artifacts later.

But first inspect what exists.

---

# Required Frontend Changes

Find the result display component.

Likely frontend files may be in:

```text
frontend/
src/
app/
components/
```

Search for:

```text
Analyze
score
scan
nutrition
```

Add a new section under the existing nutrition/food score.

Suggested UI text:

```text
OCR Reliability
Photo quality: Good photo!
OCR confidence: 92%
```

For photo quality messages:

```text
bad:
"Bad photo — take again"

medium:
"Medium photo — try taking a better photo for more accurate data"

good:
"Good photo!"

unknown:
"Photo quality unavailable"
```

For confidence:

```text
if overall_confidence_percent is a number:
    "OCR confidence: {percent}%"
else:
    "OCR confidence: unavailable"
```

Do not hide the section if score exists. If backend returns `ocr_reliability`, show it. If backend does not return it, show nothing or a subtle unavailable state.

Keep UI style consistent with existing app.

---

# Required API Response Example

After implementation, `/scan` response should include something like:

```json
{
  "score": 82,
  "nutrition": {...},
  "ingredients": [...],
  "ocr_reliability": {
    "photo_quality": {
      "label": "good",
      "message": "Good photo!",
      "confidence_percent": 91.2,
      "probabilities": {
        "bad": 1.3,
        "medium": 7.5,
        "good": 91.2
      }
    },
    "field_confidence": {
      "overall_confidence_percent": 88.4,
      "message": "OCR confidence: 88.4%",
      "fields_evaluated": 13,
      "per_field": [
        {
          "field": "calories",
          "value": "120",
          "confidence_percent": 97.8
        }
      ]
    },
    "status": "ok"
  }
}
```

If models are unavailable:

```json
{
  "ocr_reliability": {
    "photo_quality": {
      "label": "unknown",
      "message": "Photo quality unavailable",
      "confidence_percent": null,
      "probabilities": {}
    },
    "field_confidence": {
      "overall_confidence_percent": null,
      "message": "OCR confidence unavailable",
      "fields_evaluated": 0,
      "per_field": []
    },
    "status": "unavailable",
    "error": "Missing model artifact: ..."
  }
}
```

---

# Important UX Requirement

Do not make this an accept/reject gate.

Sherwin specifically wants:

```text
The section should always provide an evaluation.
Do not only accept certain percentages.
Do not block the existing food score.
Do not prevent analysis from completing.
```

The confidence percentage is informational.

Suggested message logic:

```python
if quality_label == "bad":
    photo_message = "Bad photo — take again"
elif quality_label == "medium":
    photo_message = "Medium photo — try taking a better photo for more accurate data"
elif quality_label == "good":
    photo_message = "Good photo!"
else:
    photo_message = "Photo quality unavailable"
```

For field confidence:

```python
if percent is not None:
    confidence_message = f"OCR confidence: {percent:.0f}%"
else:
    confidence_message = "OCR confidence unavailable"
```

---

# Testing Requirements

After implementation, run these checks.

## Backend import test

```powershell
python -c "from backend.inference.ocr_reliability import run_ocr_reliability; print('ocr reliability import ok')"
```

or if module is elsewhere, adjust.

## API test

Start backend:

```powershell
uvicorn backend.api.main:app --reload
```

Run the frontend or use the UI and submit both images.

Expected:

```text
Existing score still appears.
New OCR Reliability section appears under the food/nutrition score.
No crash if model files are missing.
No crash if nutrition OCR fails.
Ingredients image is not passed to these models.
```

## Docker test

If this repo uses Docker:

```powershell
docker compose up --build
```

Then test `/scan`.

---

# Deliverables

At the end, report:

```text
1. Files changed
2. Backend response shape added
3. Whether model artifacts were found
4. Whether image-quality inference works
5. Whether FieldConfidenceNet-Lite inference works
6. If anything is unavailable, exactly which artifact/path is missing
7. How to run/test the app
```

Also update or create a short integration note:

```text
md/ocr_reliability_app_integration.md
```

It should explain:

```text
- What OCR reliability section does
- Which image it uses
- How photo quality is computed
- How OCR confidence is computed
- How frontend displays it
- What artifacts are needed
- Known limitations
```

---

# Do Not Do

```text
Do not change the scoring formula.
Do not run OCR reliability on ingredients_img.
Do not make confidence a blocker.
Do not remove existing result fields.
Do not commit generated CSVs/PNGs/model weights unless explicitly required.
Do not hardcode fake confidence values.
Do not crash the app if model artifacts are missing.
```

---

# Final Expected User-Facing Display

Under the existing food/nutrition score, show a section like:

```text
OCR Reliability

Photo quality:
Good photo!

OCR confidence:
88%
```

or:

```text
OCR Reliability

Photo quality:
Medium photo — try taking a better photo for more accurate data

OCR confidence:
63%
```

or:

```text
OCR Reliability

Photo quality:
Bad photo — take again

OCR confidence:
41%
```
