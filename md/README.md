# 🥗 Food Pharmer – Mobile Food Label Scanner (CV + OCR + NLP)

**Food Pharmer** is a mobile AI application that scans food labels using **Computer Vision**, extracts ingredients and nutrition facts with **OCR**, interprets the text using **NLP**, and predicts a **health rating** — highlighting harmful ingredients in **red**.

This project aims to make clean eating simple, transparent, and accessible.

---

## 🚀 Features

- **Real‑time label detection** using mobile camera  
- **OCR extraction** of ingredients + nutrition facts  
- **NLP‑based ingredient understanding**  
- **Health scoring engine** combining rules + ML  
- **Red‑flagging harmful additives** (preservatives, sugar aliases, seed oils, etc.)  
- **Mobile‑optimized inference** (on‑device or cloud)  
- **Fast, lightweight models** via distillation or API-based inference  

---

## 🧩 System Architecture

### 1️⃣ Computer Vision (CV)
Used to detect and crop the product label.

#### A. OCR (Optical Character Recognition)
Extracts text from ingredient lists and nutrition labels.

Supported OCR engines:
- **Tesseract OCR** — open-source, lightweight  
- **Google ML Kit OCR** — mobile-friendly, fast  
- **PaddleOCR** — high accuracy  
- **TrOCR** — transformer-based OCR  

#### B. Image Preprocessing (Optional)
Handles:
- Curved packaging  
- Low-light images  
- Blurry or rotated labels  

Tools: **OpenCV**, **torchvision transforms**

---

### 2️⃣ NLP Model for Ingredient Understanding

After OCR, the extracted text is passed to an NLP model that can:

- Parse ingredient lists  
- Identify harmful additives  
- Detect sugar aliases  
- Understand nutrition facts  
- Assign a health score  

Candidate models:
- **Distilled BERT**  
- **DistilRoBERTa**  
- **MobileBERT**  
- **Small LLaMA variants**  

Training requires:
- Ingredient toxicity datasets  
- Food additive safety lists  
- Nutrition scoring systems (NutriScore, NOVA, etc.)

A custom classification head will be trained for:
- Ingredient-level risk detection  
- Product-level health scoring  

Repo note: this codebase includes an initial XGBoost scorer (`ml/models/xgb_health.json`) plus a DistilBERT
training entrypoint at `ml/nlp/training/train_distilbert.py` (see `ml/nlp/training/TRAINING.md`).

---

### 3️⃣ Model Distillation (Optional)

Used if deploying the NLP model **on-device**.

Benefits:
- Compress large models → mobile-friendly  
- Maintain accuracy  
- Reduce inference latency  
- Lower memory footprint  

If using **OpenAI APIs**, distillation may not be needed.

---

### 4️⃣ Backend + Mobile Stack

#### Mobile Options
- **Flutter** (recommended for cross-platform)
- **React Native**
- **Native Android (Kotlin)**  
- **iOS (Swift)**  

#### Backend Options
If using **cloud inference**:
- **FastAPI + PyTorch**
- **Node.js + ONNX Runtime**
- **AWS Lambda / GCP Cloud Run**

If using **on-device inference**:
- **CoreML** (iOS)
- **TensorFlow Lite** (Android)
- **ONNX Mobile**

---

### 5️⃣ Health Scoring Engine

The core of the Food Pharmer experience.

Combines **rules + ML** to evaluate:
- Sugar thresholds  
- Trans fats  
- Additives (E-numbers)  
- Ultra-processed markers  
- Artificial sweeteners  
- Seed oils  

Possible implementations:
- **Rule-based engine**  
- **ML classifier**  
- **Hybrid system** (recommended)

Output:
- **Health score (0–100)**  
- **Red‑flag list** of harmful ingredients  

---

## 📱 End-to-End Flow

1. User scans product  
2. CV detects label  
3. OCR extracts text  
4. NLP parses ingredients  
5. Health scoring engine evaluates product  
6. Harmful ingredients highlighted in **red**  
7. Score + explanation shown to user  

---

## 📦 Recommended Folder Structure

foodpharmer/
│
├── app/                     # Mobile app (Flutter/React Native)
│   ├── screens/
│   ├── components/
│   └── services/
│
├── backend/
│   ├── api/
│   ├── models/
│   ├── scoring/
│   └── inference/
│
├── ml/
│   ├── ocr/
│   ├── nlp/
│   ├── datasets/
│   ├── training/
│   └── distillation/
│
├── docs/
│   └── architecture-diagrams/
│
└── README.md


---

## 📚 Datasets (Hugging Face)

Relevant datasets exist on Hugging Face.

### Ingredient / Nutrition Datasets
- **openfoodfacts** — ingredients + nutrition  
- **food-ingredients-dataset**  
- **food-composition**  

### Additives / Toxicity
- **e-additives** — E-number safety  
- **food-additives-dataset**  

### Health Scoring
- **NutriScore dataset**  
- **NOVA classification dataset**  

### OCR Training Data
- **FUNSD**  
- **SROIE**  
- **DocVQA**  

---

## 🧪 Future Enhancements

- Barcode scanning (OpenFoodFacts API)  
- Chatbot explanation (“Why is this unhealthy?”)  
- Speculative decoding for faster LLM responses  
- Offline mode with distilled models  
- Healthier alternatives recommendation engine  

---

## 🏁 Summary

This repo contains the full pipeline for a mobile AI system that:

- Scans food labels  
- Extracts text  
- Understands ingredients  
- Scores healthiness  
- Flags harmful additives  

Built using **CV + OCR + NLP**, optimized for mobile, and aligned with the **Food Pharmer** mission.
