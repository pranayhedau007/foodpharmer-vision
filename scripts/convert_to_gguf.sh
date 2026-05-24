#!/usr/bin/env bash
# Converts outputs/merged_model → outputs/foodpharmer-q4_k_m.gguf
# Run from the repo root:  bash scripts/convert_to_gguf.sh

set -e
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LLAMA_DIR="$HOME/llama.cpp"
MERGED_MODEL="$REPO_ROOT/outputs/merged_model"
GGUF_F16="$REPO_ROOT/outputs/foodpharmer-f16.gguf"
GGUF_Q4="$REPO_ROOT/outputs/foodpharmer-q4_k_m.gguf"

# ── 1. Clone llama.cpp if not present ──────────────────────────────────────
if [ ! -d "$LLAMA_DIR" ]; then
  echo "[1/4] Cloning llama.cpp ..."
  git clone https://github.com/ggerganov/llama.cpp "$LLAMA_DIR"
else
  echo "[1/4] llama.cpp already at $LLAMA_DIR — pulling latest ..."
  git -C "$LLAMA_DIR" pull --ff-only
fi

# ── 2. Build with Metal (Apple GPU) support ─────────────────────────────────
echo "[2/4] Building llama.cpp with Metal support ..."
cmake -S "$LLAMA_DIR" -B "$LLAMA_DIR/build" -DGGML_METAL=ON -DCMAKE_BUILD_TYPE=Release
cmake --build "$LLAMA_DIR/build" --config Release -j"$(sysctl -n hw.ncpu)"

# ── 3. Install Python deps for the conversion script ────────────────────────
echo "[3/4] Installing llama.cpp Python requirements ..."
PYTHON="$REPO_ROOT/.venv/bin/python"
"$PYTHON" -m pip install -r "$LLAMA_DIR/requirements.txt" -q

# ── 4. Convert HuggingFace → f16 GGUF ──────────────────────────────────────
echo "[4/4] Converting merged model to GGUF (f16) ..."
"$PYTHON" "$LLAMA_DIR/convert_hf_to_gguf.py" \
  "$MERGED_MODEL" \
  --outfile "$GGUF_F16" \
  --outtype f16

# ── 5. Quantize f16 → Q4_K_M ───────────────────────────────────────────────
echo "[5/4] Quantizing to Q4_K_M ..."
"$LLAMA_DIR/build/bin/llama-quantize" "$GGUF_F16" "$GGUF_Q4" Q4_K_M

echo ""
echo "Done! GGUF written to: $GGUF_Q4"
ls -lh "$GGUF_Q4"
