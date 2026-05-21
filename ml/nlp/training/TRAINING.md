# DistilBERT training (health score)

This repo currently ships an `XGBoost` model (`ml/models/xgb_health.json`) and a rule-based scorer.
If you want a **text-first model** that learns directly from OCR output, use the scripts in this folder.

## 1) Prepare data

Create a CSV with at least:

- `text`: OCR output (ideally **nutrition + ingredients** combined)
- `score`: numeric health score in `0..100` (regression) **or** a label column for classification

Example (header only):

```csv
text,score
```

## 2) Train (regression)

```bash
python -m ml.nlp.training.train_distilbert \
  --train_csv path/to/train.csv \
  --text_col text \
  --label_col score \
  --task regression \
  --output_dir ml/models/distilbert_health
```

## 3) Train (classification)

If you only have numeric scores but want classes, use bins (default bins: `20,40,60,80` => 5 classes):

```bash
python -m ml.nlp.training.train_distilbert \
  --train_csv path/to/train.csv \
  --text_col text \
  --label_col score \
  --task classification \
  --classification_from bins \
  --bins 20,40,60,80 \
  --output_dir ml/models/distilbert_health_cls
```

If you already have categorical labels (e.g. `A/B/C/D/F`), set `--classification_from labels` and
use `--label_col grade`.

## 4) Inference sanity check

```bash
python -m ml.nlp.training.infer_distilbert \
  --model_dir ml/models/distilbert_health \
  --text "ingredients: sugar, palm oil ... sodium 600mg ..."
```

