# Push Instructions

## ⚠️ Push Issue

The repository is quite large (~2.6 GB) due to the `app` submodule, which is causing HTTP 500 errors when pushing via HTTPS.

## ✅ Alternative Solutions

### Option 1: Use SSH Instead of HTTPS

```bash
# Change remote to SSH
git remote set-url myrepo git@github.com:thomasvuong/e2-F5-tts_Pinokio_Mac_RunFromTerminal_Vietnamese_Models.git

# Push
git push myrepo main
```

### Option 2: Use GitHub CLI

```bash
# Install GitHub CLI if needed: brew install gh
gh auth login
git push myrepo main
```

### Option 3: Push in Parts

If the above don't work, you can push manually:

1. **Initialize the repo on GitHub first** (add a README through GitHub web interface)

2. **Push without the submodule first**:
   ```bash
   # Temporarily remove submodule
   git rm --cached app
   git commit -m "Temporary: remove submodule for initial push"
   git push myrepo main
   
   # Then add submodule back
   git checkout HEAD~1 -- app
   git commit -m "Re-add app submodule"
   ```

3. **Push the app submodule separately**:
   ```bash
   cd app
   git remote add myrepo git@github.com:thomasvuong/e2-F5-tts_Pinokio_Mac_RunFromTerminal_Vietnamese_Models.git
   git push myrepo main
   ```

### Option 4: Manual File Upload

If Git push continues to fail:

1. **Commit summary**: The changes are in these files:
   - `README_VIETNAMESE.md` - Documentation
   - `.gitignore` - Updated to exclude history files
   - `app/src/f5_tts/infer/infer_gradio.py` - Vietnamese TTS support
   - `app/src/f5_tts/infer/utils_infer.py` - Model loading improvements

2. **Create a ZIP** of the essential files:
   ```bash
   # Create a clean export without large files
   git archive --format=zip --output=vietnamese-tts-changes.zip HEAD
   ```

3. **Upload the ZIP** to GitHub manually or use web interface

## 📋 What Was Changed

### Main Repository
- ✅ `README_VIETNAMESE.md` - Complete documentation
- ✅ `.gitignore` - Updated to exclude `.history/` files

### App Submodule
- ✅ `app/src/f5_tts/infer/infer_gradio.py` - Vietnamese model support
- ✅ `app/src/f5_tts/infer/utils_infer.py` - Improved model loading

## 🔍 Check Current Status

```bash
# See what's ready to push
git log --oneline origin/main..main

# Check remote
git remote -v

# Verify commits
git log --oneline -5
```

## 📝 Commits Ready to Push

1. `25fd7c2` - Add comprehensive README for Vietnamese TTS models support
2. `2fe25ed` - Add Vietnamese TTS support and update .gitignore
3. `bd2c70c` - Vietnamese
4. `def5053` - Prevent Pinokio from overwriting changes and add direct run script
5. `d7a163f` - Update .gitignore to exclude large model files and cache directories

