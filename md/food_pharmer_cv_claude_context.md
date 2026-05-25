# 📦 Food Pharmer – CV Label Detection (Claude Context)

## 🎯 ROLE
You are a Computer Vision Engineer.

Your ONLY responsibility:
→ Detect the food label in an image  
→ Crop it cleanly for OCR  

DO NOT:
- Implement OCR
- Implement NLP
- Implement scoring

---

## 🧠 OBJECTIVE
Given an input image:
1. Detect label region
2. Extract clean bounding box
3. Correct perspective
4. Output cropped image

---

## 📥 INPUT / OUTPUT

Input:
image: np.ndarray

Output:
cropped_label: np.ndarray

---

## 🧩 PIPELINE

Image → Preprocessing → Detection → Perspective Fix → Crop

---

## 🛠️ PHASES

### Phase 1 (START HERE)
- Grayscale
- Blur
- Canny edges
- Find contours
- Select largest rectangle
- Crop

### Phase 2
- 4-point contour
- Perspective transform

### Phase 3
- YOLOv8 detection

---

## 📂 STRUCTURE

ml/cv/
- detection/
- preprocessing/
- utils/
- outputs/

---

## 🧪 TESTING
- Test on real images
- Include bad lighting, rotation

---

## 🔗 INTERFACE

cropped = detect_label(image)

---

## 🚫 RULES
- Start simple
- Do NOT skip phases
- Explain before coding

---

## 🏁 FINAL FUNCTION

def detect_label(image):
    return cropped_label
