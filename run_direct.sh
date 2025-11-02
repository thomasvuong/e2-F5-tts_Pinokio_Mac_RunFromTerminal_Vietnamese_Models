#!/bin/bash
# Run F5-TTS directly without Pinokio to avoid git reset issues
# This script bypasses Pinokio's update/reset mechanisms

cd "$(dirname "$0")/app" || exit 1

# Activate the virtual environment
source env/bin/activate

# Set environment variables
export PYTORCH_ENABLE_MPS_FALLBACK=1
export HF_HUB_ENABLE_HF_TRANSFER=0

# Run the gradio app directly
f5-tts_infer-gradio

