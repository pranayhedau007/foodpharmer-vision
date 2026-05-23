from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import Dict, Any

# Import the inference functions that exist
from llama_health_model.inference import analyze_ingredients, _load_model

app = FastAPI(title="Llama Health Ingredient API")

class AnalyzeRequest(BaseModel):
    ingredients: str

@app.on_event("startup")
def startup_event():
    # Attempt to load model adapters lazily; this keeps first request warm.
    try:
        _load_model()
    except Exception as e:
        # Log warning; keep app running so endpoints can return a helpful error if model missing
        print("Warning: model failed to load at startup:", e)

@app.post("/analyze_ingredients")
def analyze(req: AnalyzeRequest) -> Dict[str, Any]:
    if not req.ingredients or not req.ingredients.strip():
        raise HTTPException(status_code=400, detail="ingredients field must be a non-empty string")
    try:
        _load_model()  # optional: ensures model and adapters are loaded
        result = analyze_ingredients(req.ingredients)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Model inference failed: {e}")
    response = {
        "health_score": result.get("health_score"),
        "risk_level": result.get("risk_level"),
        "flags": result.get("flags", []),
        "summary": result.get("summary"),
        "_raw_model_output": result.get("_raw_model_output"),
    }
    return response

