---
name: image-upscaling
description: Use Real-ESRGAN for AI-powered image upscaling (maps, character art, scenes) to create high-quality assets for HTML companions
---

# Image Upscaling with Real-ESRGAN

## Overview
This skill documents the process for upscaling all project images (maps, character reference sheets, scene illustrations) using Real-ESRGAN (Real-Enhanced Super-Resolution Generative Adversarial Network) to create high-quality assets for the HTML reading companion.

## Why Real-ESRGAN?

**Real-ESRGAN is the STANDARD for this project.** All images (maps, character art, scenes) are upscaled using Real-ESRGAN-ncnn-vulkan.

### Reasons for Real-ESRGAN:
- **AI-powered:** Uses deep learning for intelligent upscaling, not simple interpolation
- **Detail preservation:** Maintains sharp edges, text, and fine details
- **Proven and stable:** Released 2022, battle-tested across thousands of projects
- **Fast:** ~6 seconds per 1024×1024 image on M4 MacBook
- **CLI-based:** Fully scriptable and automatable for batch processing
- **No dependencies:** Standalone binary with included models
- **Excellent quality:** 9.2/10 quality score, more than sufficient for web display
- **Consistent results:** Same model for all 100+ images ensures visual consistency
- **GPU acceleration:** Uses Apple Metal/Vulkan automatically on M4 Mac

### Why NOT newer models?
While newer architectures exist (SwinIR, RealPLKSR, HAT), they have significant drawbacks:
- **SwinIR:** 16× slower (~96s per image) for marginal quality improvement
- **RealPLKSR:** MPS compatibility issues on macOS, requires CPU mode (slow)
- **Complexity:** Python dependencies, model compatibility issues, setup overhead
- **Diminishing returns:** Quality differences imperceptible at 4096×4096 web display sizes
- **Batch processing:** With 100+ images to process, speed matters

**Decision:** Real-ESRGAN provides the best balance of quality, speed, and reliability for this project.

## Technology Stack

### Real-ESRGAN Installation (Standalone Binary - Recommended)

**Download and Install:**
```bash
# Download Real-ESRGAN for macOS
cd /tmp
curl -L https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.5.0/realesrgan-ncnn-vulkan-20220424-macos.zip -o realesrgan-macos.zip

# Extract binary and models
unzip -o -q realesrgan-macos.zip

# Install to project tools directory
cd /path/to/reading-companion
mkdir -p tools/realesrgan
cp /tmp/realesrgan-ncnn-vulkan tools/realesrgan/
cp -r /tmp/models tools/realesrgan/
chmod +x tools/realesrgan/realesrgan-ncnn-vulkan
```

**Why Standalone Binary?**
- No Python dependency conflicts
- Includes all pre-trained models (67MB total)
- Uses macOS Metal/Vulkan for GPU acceleration
- Works perfectly on M4 MacBook
- Project-local installation (gitignored)

## Real-ESRGAN Models Index

The Real-ESRGAN binary includes **three model families** with different scale factors. All models are in `tools/realesrgan/models/`.

### 1. realesrgan-x4plus (**PROJECT STANDARD**)

**Model Name:** `realesrgan-x4plus`
**Files:** `realesrgan-x4plus.bin` (17MB) + `realesrgan-x4plus.param` (36KB)
**Scale Factor:** 4× only
**Best For:** General purpose images - maps, photographs, character art, scenes
**Used For:** **ALL project images** (maps, character sheets, scene illustrations)

**Characteristics:**
- Sharpest details and edge preservation
- Excellent text legibility on maps
- Best for realistic photography and artwork
- Minimal artifacts or over-smoothing

**Usage:**
```bash
./tools/realesrgan/realesrgan-ncnn-vulkan -i input.png -o output.png -s 4 -n realesrgan-x4plus
```

**Project Examples:**
- `maps/Final_Empire_8192x8192.png` (8192×8192, 29MB)
- `maps/Luthadel_6272x4800.png` (6272×4800, 27MB)
- `assets/characters/kelsier/kelsier-mistcloak-4x.png` (4096×4096)
- `assets/characters/hoid/hoid-beggar-4x.png` (4096×4096)

---

### 2. realesrgan-x4plus-anime

**Model Name:** `realesrgan-x4plus-anime`
**Files:** `realesrgan-x4plus-anime.bin` (17MB) + `realesrgan-x4plus-anime.param` (36KB)
**Scale Factor:** 4× only
**Best For:** Anime-style illustrations, manga, stylized artwork

**Characteristics:**
- Optimized for anime/manga art style
- Preserves clean linework typical of anime
- Reduces noise while maintaining style
- Better for hand-drawn illustration than photographs

**Usage:**
```bash
./tools/realesrgan/realesrgan-ncnn-vulkan -i input.png -o output.png -s 4 -n realesrgan-x4plus-anime
```

**When to Use:**
- Anime-style character art
- Manga panels or illustrations
- Stylized non-photorealistic artwork
- **NOT for this project** (using realistic Shallan-style sketches)

---

### 3. realesr-animevideov3

**Model Family:** `realesr-animevideov3`
**Files (3 variants):**
- `realesr-animevideov3-x2.bin/.param` (2.4MB model)
- `realesr-animevideov3-x3.bin/.param` (2.4MB model)
- `realesr-animevideov3-x4.bin/.param` (2.4MB model)

**Scale Factors:** 2×, 3×, or 4× (three separate models)
**Best For:** Video frames, animation, temporal consistency across frames

**Characteristics:**
- Optimized for video/animation frame sequences
- Temporal consistency (reduces flickering between frames)
- Smaller model size than x4plus variants
- Designed for batch video processing

**Usage:**
```bash
# 2× upscaling
./tools/realesrgan/realesrgan-ncnn-vulkan -i input.png -o output.png -s 2 -n realesr-animevideov3-x2

# 3× upscaling
./tools/realesrgan/realesrgan-ncnn-vulkan -i input.png -o output.png -s 3 -n realesr-animevideov3-x3

# 4× upscaling
./tools/realesrgan/realesrgan-ncnn-vulkan -i input.png -o output.png -s 4 -n realesr-animevideov3-x4
```

**When to Use:**
- Video upscaling (frame sequences)
- Animation frames requiring temporal consistency
- When 2× or 3× scale factors are needed (x4plus only does 4×)
- **NOT for this project** (using static images with x4plus)

---

### Model Selection Guide

| Image Type | Recommended Model | Scale | Rationale |
|------------|-------------------|-------|-----------|
| **Maps** | `realesrgan-x4plus` | 4× | Best text legibility and detail |
| **Character Art (realistic)** | `realesrgan-x4plus` | 4× | Shallan-style sketches are realistic |
| **Scene Illustrations** | `realesrgan-x4plus` | 4× | General photography model works best |
| Anime character art | `realesrgan-x4plus-anime` | 4× | Optimized for anime style |
| Video frames | `realesr-animevideov3-x4` | 2-4× | Temporal consistency |
| Smaller upscale needed | `realesr-animevideov3-x2/x3` | 2-3× | Only models supporting 2× or 3× |

**Project Standard:** `realesrgan-x4plus` at 4× scale for ALL images.

## Upscaling Process

### 1. Prepare Source Image
- Source file should be highest quality available (PNG preferred)
- Minimum recommended: 1024px on shortest side
- For maps: Store in `maps/archive/{map-name}-source.png`
- For character art: Store originals as `{name}-original.png`

### 2. Run Real-ESRGAN

**Standard Command:**
```bash
./tools/realesrgan/realesrgan-ncnn-vulkan \
  -i input.png \
  -o output.png \
  -s 4 \
  -n realesrgan-x4plus \
  -m ./tools/realesrgan/models
```

**Parameters:**
- `-i` : Input file path
- `-o` : Output file path
- `-s` : Scale factor (2, 3, or 4)
- `-n` : Model name (see index above)
- `-m` : Path to models directory

**Performance:**
- Uses Apple M4 GPU automatically via Vulkan
- Progress displayed during upscaling (0-100%)
- Typical time: ~6 seconds for 1024×1024 → 4096×4096
- Typical time: 1-3 minutes for 1568×1200 → 6272×4800 (maps)

### 3. Target Resolutions

For consistency across all project assets:
- **World maps:** ~8192px on longest side (e.g., 8192×8192)
- **City maps:** ~6000-8000px on longest side (aspect ratio maintained)
- **Character art:** 4096×4096 (from 1024×1024 Gemini output)
- **Scene illustrations:** 4096×4096 (from 1024×1024 Gemini output)

### 4. Verify Quality

After upscaling:
- Open in image viewer and zoom to 100%
- Check text legibility (for maps)
- Verify line sharpness and detail preservation
- Confirm no artifacts or blurriness
- Compare against original to ensure quality improvement

### 5. Commit to Git

```bash
git add maps/{map-name}.png
git add assets/characters/{character}/{name}-4x.png
git commit -m "Add upscaled {asset-name} (4096×4096) with Real-ESRGAN"
```

## Current Upscaled Assets

### Maps
- **Scadrial World Map:** `maps/Final_Empire_8192x8192.png` (8192×8192, 29MB)
  - Source: Official Mistborn map
  - Upscaled: 4× with `realesrgan-x4plus`
  - Usage: Continent-scale chapters across all Era 1 books

- **Luthadel City Map:** `maps/Luthadel_6272x4800.png` (6272×4800, 27MB)
  - Source: `maps/archive/Luthadel.png` (1568×1200)
  - Upscaled: 4× with `realesrgan-x4plus`
  - Usage: City-scale chapters in The Final Empire and Well of Ascension
  - Coordinates: See `maps/luthadel-landmark-coordinates.md`
  - **IMPORTANT:** Coordinates are specific to 6272×4800 dimensions

### Character Reference Sheets
- **Kelsier:**
  - `assets/characters/kelsier/kelsier-mistcloak-4x.png` (4096×4096, 28MB)
  - `assets/characters/kelsier/kelsier-streetclothes-4x.png` (4096×4096, 27MB)

- **Hoid:**
  - `assets/characters/hoid/hoid-beggar-4x.png` (4096×4096, 30MB)
  - `assets/characters/hoid/hoid-worldhopper-4x.png` (4096×4096, 27MB)

### Planned
- **Maps:** Fadrex City, Urteau (Hero of Ages)
- **Character Sheets:** Vin, Sazed (if needed for Chapter 19)
- **Scene Illustrations:** Chapter 19 scene (Kelsier meeting Hoid)

## Best Practices

### Source File Management
- Keep original low-res sources with `-original.png` suffix
- For maps: Store in `maps/archive/`
- For character art: Store alongside upscaled versions
- Never overwrite original sources

### Upscaling Workflow
1. Save/generate source image (1024×1024 from Gemini, or map source)
2. Run Real-ESRGAN upscaling with `realesrgan-x4plus`
3. Verify quality before proceeding
4. Create primary version (copy 4x as main file)
5. Commit both original and upscaled versions to git

### File Naming Convention

**Maps:**
- Format: `{MapName}_{width}x{height}.png`
- Examples: `Final_Empire_8192x8192.png`, `Luthadel_6272x4800.png`

**Character Art:**
- Original: `{character}-{outfit}-original.png` (e.g., `kelsier-mistcloak-original.png`)
- Upscaled 4×: `{character}-{outfit}-4x.png` (e.g., `kelsier-mistcloak-4x.png`)
- Primary: `{character}-{outfit}.png` (copy of 4x, e.g., `kelsier-mistcloak.png`)

**Scene Illustrations:**
- Original: `chapter-{##}-scene-{descriptor}-original.png`
- Upscaled 4×: `chapter-{##}-scene-{descriptor}-4x.png`
- Primary: `chapter-{##}-scene-{descriptor}.png`

### Git Considerations
- High-res images are large (10-30MB each)
- Commit with descriptive messages
- Document upscaling model and scale factor in commit message
- Archive sources are gitignored for maps (not for character art)

## Troubleshooting

### Issue: Real-ESRGAN not installed
**Solution:** Follow installation steps above

### Issue: Out of memory during upscaling
**Solution:**
- Use tile mode: `-t 256` (processes in chunks)
- Close other applications to free RAM
- M4 MacBook with 16GB+ should handle 8192px images

### Issue: Upscaled image looks over-sharpened
**Solution:**
- This is rare with `realesrgan-x4plus`
- Try `realesr-animevideov3-x4` for softer result
- Reduce scale factor (use 2× or 3× instead of 4×)

### Issue: Need 2× or 3× upscaling
**Solution:**
- Use `realesr-animevideov3-x2` or `realesr-animevideov3-x3`
- Only these models support 2× and 3× scale factors
- `realesrgan-x4plus` only supports 4× scaling

### Issue: Slow processing on large images
**Solution:**
- Expected for maps >6000px (1-3 minutes is normal)
- Use tile mode: `-t 512` to reduce memory pressure
- Processing is GPU-accelerated, so ensure no other GPU-heavy tasks running

## Related Documentation
- Project overview: `CLAUDE.md` (Tech Stack section)
- Memory files: `plans/memory/` (phase completion documentation)
- Archive directory: `maps/archive/` (map source files)

## Notes
- Real-ESRGAN requires GPU for best performance (CPU mode is much slower)
- M4 MacBook has unified memory suitable for AI upscaling
- First upscale may take 1-5 minutes depending on source size
- Subsequent upscales are faster as models are cached in memory
- All models use `.bin` (weights) + `.param` (architecture) file pairs

---

## Alternative Upscaling Models (Reference Only)

**NOTE:** The information below is for reference only. **Real-ESRGAN is the standard** for this project. Do not attempt to use these alternatives without explicit user approval.

### Model Performance Comparison (2024-2025)

| Model | Quality Score | Speed (1024×1024) | macOS Support | Notes |
|-------|---------------|-------------------|---------------|-------|
| **Real-ESRGAN** | 9.2/10 | ~6 seconds | ✅ Excellent | **PROJECT STANDARD** |
| RealPLKSR | 9.5/10 | ~9 seconds (CPU) | ⚠️ MPS issues | Requires CPU mode on macOS |
| SwinIR-L | 9.7/10 | ~96 seconds | ✅ Good | 16× slower, minimal quality gain |
| HAT-L | 9.8/10 | ~177 seconds | ✅ Good | 30× slower, impractical |
| SwinIR-S | 9.5/10 | ~14 seconds | ✅ Good | 2× slower, small quality gain |

### State-of-the-Art Models Index

#### 1. **SwinIR** (2021)
- **Repository:** https://github.com/JingyunLiang/SwinIR
- **Architecture:** Swin Transformer
- **Best for:** Maximum quality, research use cases
- **Variants:** Small (S), Medium (M), Large (L)
- **Real-World Model:** `003_realSR_BSRGAN_DFOWMFC_s64w8_SwinIR-L_x4_GAN.pth` (136MB)
- **Implementation:** Python/PyTorch, spandrel library
- **Speed:** 14-96 seconds per image depending on variant
- **Quality:** 9.5-9.7/10 (0.3-0.5dB improvement over Real-ESRGAN)

#### 2. **RealPLKSR** (2024)
- **Repository:** https://github.com/Phhofm/models
- **Architecture:** PLKSR (Partial Large Kernel Sparse Reconstruction)
- **Best for:** Speed/quality balance
- **Popular Models:**
  - `4xNomos2_realplksr_dysample.pth` (28MB) - General purpose
  - `4xNomosWebPhoto_RealPLKSR.pth` - Photography/web images
  - `4xArtFaces_realplksr_dysample.pth` - Art and paintings
- **Implementation:** Python/PyTorch, spandrel library, neosr framework
- **Speed:** 9 seconds per image (CPU mode on macOS)
- **Quality:** 9.5/10 (similar to SwinIR-S)
- **macOS Issue:** MPS backend unsupported, requires `--cpu` flag

#### 3. **HAT** (Hybrid Attention Transformer) (2023)
- **Repository:** https://github.com/XPixelGroup/HAT
- **Architecture:** Hybrid Attention Transformer
- **Best for:** Research, maximum quality regardless of speed
- **Variants:** Small (S), Medium (M), Large (L)
- **Speed:** 71-177 seconds per image
- **Quality:** 9.7-9.8/10 (highest available)
- **Practical use:** Too slow for batch processing

#### 4. **Real-ESRGAN** (2022) - **PROJECT STANDARD**
- **Repository:** https://github.com/xinntao/Real-ESRGAN
- **Architecture:** Enhanced ESRGAN
- **Best for:** Production use, batch processing
- **Models:** See "Real-ESRGAN Models Index" section above
- **Implementation:** Standalone binary (ncnn-vulkan), no Python needed
- **Speed:** 6 seconds per image
- **Quality:** 9.2/10 (excellent for web display)

### Implementation Options

#### Option 1: Real-ESRGAN Binary (CURRENT)
**Pros:** Fast, simple, no dependencies, proven
**Cons:** Limited to ESRGAN architecture
**Command:**
```bash
./tools/realesrgan/realesrgan-ncnn-vulkan -i input.png -o output.png -s 4 -n realesrgan-x4plus
```

#### Option 2: Spandrel (Python Library)
**Pros:** Access to all modern models (SwinIR, PLKSR, HAT, etc.)
**Cons:** Python dependencies, slower setup, macOS compatibility issues
**Installation:**
```bash
pip install spandrel spandrel_extra_arches
```
**Usage:**
```python
from spandrel import ModelLoader
model = ModelLoader().load_from_file("model.pth")
output = model(input_image)
```

#### Option 3: chaiNNer (GUI)
**Pros:** Node-based workflow, supports all models, visual
**Cons:** GUI-only, not scriptable
**Installation:**
```bash
brew install --cask chainner
```

### Model Sources

- **OpenModelDB:** https://openmodeldb.info/ - Searchable database of 600+ upscaling models
- **Philip Hofmann (Phhofm):** https://github.com/Phhofm/models - Community-trained RealPLKSR models
- **Official Repositories:** GitHub releases for SwinIR, HAT, Real-ESRGAN
- **Hugging Face:** https://huggingface.co/ - Model hosting platform

### When to Reconsider Alternatives

Consider investigating alternatives if:
1. **Quality requirements change:** Need absolute maximum quality for print/commercial use
2. **Processing time is not a constraint:** Single images, not batch processing
3. **macOS MPS support improves:** Future PyTorch versions fix RealPLKSR compatibility
4. **New models emerge:** Faster alternatives with Real-ESRGAN quality

**Current Status (2025):** Real-ESRGAN remains the best choice for this project's requirements.
