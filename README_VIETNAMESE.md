# Vietnamese TTS Models Support for F5-TTS

This repository contains enhanced F5-TTS support for Vietnamese text-to-speech synthesis with multiple model options.

## 🎯 Features

- **Multiple Vietnamese Models**: Support for 3 different Vietnamese TTS models
- **Automatic Model Selection**: Intelligently selects the best available model
- **Vietnamese Text Normalization**: Proper Unicode normalization for Vietnamese text
- **Improved Quality**: Enhanced NFE steps for better voice clarity
- **Character-level Tokenization**: Optimized tokenization for Vietnamese (no pinyin conversion)

## 📦 Supported Models

The system supports 3 Vietnamese models with automatic priority selection:

### 1. **ViVoice Model** (Best Quality - Priority 1)
- **Source**: `hynt/F5-TTS-Vietnamese-ViVoice`
- **Training Data**: 1000 hours of Vietnamese audio
- **Checkpoint**: `model_last.pt`
- **Location**: `app/ckpts/vietnamese_vivoice/model_last.pt`
- **Vocab**: `app/ckpts/vietnamese_vivoice/vocab.txt`

### 2. **100h Model** (Good Quality - Priority 2)
- **Source**: `hynt/F5-TTS-Vietnamese-100h`
- **Training Data**: 100 hours of Vietnamese audio
- **Training Steps**: 500,000 steps
- **Checkpoint**: `model_500000.pt`
- **Location**: `app/ckpts/vietnamese_nam194/model_500000.pt`
- **Vocab**: `app/ckpts/vietnamese_nam194/vocab.txt`

### 3. **Original Model** (Fallback - Priority 3)
- **Checkpoint**: `model_85044.safetensors`
- **Location**: `app/ckpts/vietnamese/model_85044.safetensors`
- **Vocab**: `app/ckpts/vietnamese/vocab.txt`

## 📁 Model Files Location

Place Vietnamese model files in the following directories:

```
app/ckpts/
├── vietnamese_vivoice/          # ViVoice model (recommended)
│   ├── model_last.pt            # ~5.1 GB
│   └── vocab.txt                # Vocabulary file
│
├── vietnamese_nam194/            # 100h model (alternative)
│   ├── model_500000.pt          # ~5.1 GB
│   └── vocab.txt                # Vocabulary file
│
└── vietnamese/                   # Original model (fallback)
    ├── model_85044.safetensors   # Model checkpoint
    └── vocab.txt                 # Vocabulary file
```

## ⚠️ Important: Model Files NOT in Git

**Large model files are NOT pushed to Git** (they're in `.gitignore`):

- ✅ **Pushed to Git**: Code changes, configuration, vocab files
- ❌ **NOT Pushed**: Model checkpoint files (`.pt`, `.safetensors`) - too large for Git

### How to Get Model Files

You need to download the model files manually:

#### Option 1: Download via HuggingFace Hub

```bash
cd app/ckpts

# Download ViVoice model (recommended - best quality)
python3 -m huggingface_hub.download \
    hynt/F5-TTS-Vietnamese-ViVoice \
    model_last.pt \
    --local-dir vietnamese_vivoice

# Download vocab (or copy from 100h model)
python3 -m huggingface_hub.download \
    hynt/F5-TTS-Vietnamese-100h \
    vocab.txt \
    --local-dir vietnamese_vivoice

# Or download 100h model
python3 -m huggingface_hub.download \
    hynt/F5-TTS-Vietnamese-100h \
    model_500000.pt \
    --local-dir vietnamese_nam194

python3 -m huggingface_hub.download \
    hynt/F5-TTS-Vietnamese-100h \
    vocab.txt \
    --local-dir vietnamese_nam194
```

#### Option 2: Using Python Script

```python
from huggingface_hub import hf_hub_download
from pathlib import Path

# Create directories
Path("app/ckpts/vietnamese_vivoice").mkdir(parents=True, exist_ok=True)

# Download ViVoice model
hf_hub_download(
    repo_id="hynt/F5-TTS-Vietnamese-ViVoice",
    filename="model_last.pt",
    local_dir="app/ckpts/vietnamese_vivoice"
)

# Download vocab
hf_hub_download(
    repo_id="hynt/F5-TTS-Vietnamese-100h",
    filename="vocab.txt",
    local_dir="app/ckpts/vietnamese_vivoice"
)
```

## 🚀 Usage

### Running the Gradio Web UI

1. **Install dependencies** (if not already done):
   ```bash
   cd app
   source env/bin/activate  # or create virtual environment
   pip install -r requirements.txt
   ```

2. **Run the application**:
   ```bash
   # Direct run (bypasses Pinokio)
   ./run_direct.sh
   
   # Or through Pinokio
   f5-tts_infer-gradio
   ```

3. **In the Web UI**:
   - Select "Vietnamese" from the "Choose TTS Model" dropdown
   - Upload a reference audio (female voice for female output, male for male)
   - Enter Vietnamese text
   - Click "Generate Voice"

### Recommended Settings for Vietnamese

- **NFE Steps**: 50-64 (automatically set to 50+ for Vietnamese models)
- **Speed**: 1.0 (natural speed)
- **Reference Audio**: 
  - Clear, high-quality audio (3-10 seconds)
  - Minimal background noise
  - Female audio → female voice, Male audio → male voice

## 🔧 Technical Details

### Model Priority Logic

The system automatically selects models in this order:
1. **ViVoice** (if `app/ckpts/vietnamese_vivoice/model_last.pt` exists)
2. **100h Model** (if `app/ckpts/vietnamese_nam194/model_500000.pt` exists)
3. **Original** (if `app/ckpts/vietnamese/model_85044.safetensors` exists)

### Text Processing

- **Normalization**: Unicode NFC normalization
- **Tokenization**: Character-level tokenization (no pinyin conversion)
- **Whitespace**: Automatic cleanup

### Vocab Size Handling

The system automatically detects checkpoint vocabulary size and adjusts:
- ViVoice model: 2567 embeddings
- 100h model: 2572 embeddings
- Handles both `.pt` and `.safetensors` formats

## 📝 Notes

- **Voice Gender**: Determined by your reference audio, not the model
- **Quality**: ViVoice model (1000h) provides best quality and clarity
- **Model Size**: Each model is ~5.1 GB (excluded from Git)
- **Compatibility**: Works with both `.pt` and `.safetensors` checkpoint formats

## 🔗 References

- **ViVoice Model**: [hynt/F5-TTS-Vietnamese-ViVoice](https://huggingface.co/hynt/F5-TTS-Vietnamese-ViVoice)
- **100h Model**: [hynt/F5-TTS-Vietnamese-100h](https://huggingface.co/hynt/F5-TTS-Vietnamese-100h)
- **Working Demo**: [nam194/F5-TTS-Vietnamese](https://huggingface.co/spaces/nam194/F5-TTS-Vietnamese)

## 📄 License

Please refer to the original F5-TTS repository and model licenses for usage terms.

