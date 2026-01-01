---
name: gemimg-generation
description: AI image generation using Google's Gemini API via the gemimg CLI tool. Supports text-to-image, image-to-image, and batch generation for concept art, illustrations, and creative assets.
version: 1.0.1
tags: [image-generation, gemini-api, ai-art, text-to-image, concept-art, cli]
---

# Gemimg Generation Skill

## Purpose

This skill provides expertise in using `gemimg`, a lightweight CLI tool for generating images with Google's Gemini AI models. It covers prompt engineering, command-line usage, batch processing, and integration workflows for various creative projects.

## Capabilities

- Generate images from text prompts (text-to-image)
- Generate variations from reference images (image-to-image)
- Batch generation of multiple variations
- Control aspect ratios, temperature, and output formats
- Optimize prompts for concept art, illustrations, and reference images
- Automate image generation workflows

## When to Use This Skill

Use this skill when:
- Generating concept art or visual references
- Creating illustrations or scene compositions
- Experimenting with different artistic styles
- Need quick AI image generation without heavy tools
- Batch generating multiple variations of a concept
- Exploring visual ideas before final asset creation
- Automating image generation in CLI workflows

## Installation & Setup

### Prerequisites

- Python 3.10+ (installed via Homebrew or package manager)
- pipx (Python application installer)
- Gemini API key from Google AI Studio

### Installation

```bash
# Install pipx if not already installed
brew install pipx  # macOS
# or: sudo apt install pipx  # Linux

# Install gemimg
pipx install git+https://github.com/minimaxir/gemimg.git

# Verify installation
gemimg --help
```

### API Key Configuration

Add your Gemini API key to your shell configuration:

**For zsh (`~/.zshrc`):**
```bash
export GEMINI_API_KEY="your-api-key-here"
```

**For bash (`~/.bashrc`):**
```bash
export GEMINI_API_KEY="your-api-key-here"
```

Then reload:
```bash
source ~/.zshrc  # or ~/.bashrc
```

## Command Reference

### Basic Usage

```bash
gemimg "your prompt here" --model gemini-3-pro-image-preview [OPTIONS]
```

**IMPORTANT:** The CLI defaults to `gemini-2.5-flash-image`, but you should **always specify `--model gemini-3-pro-image-preview`** for best quality results. This model produces significantly better output for most use cases.

### Common Options

| Option | Description | Default |
|--------|-------------|---------|
| `-o, --output-file` | Output filename | `output.png` |
| `-n N` | Number of images to generate | 1 |
| `-i, --input-images` | Reference image(s) for guidance | None |
| `--aspect-ratio` | Image aspect ratio (e.g., `1:1`, `16:9`, `3:4`) | `1:1` |
| `--temperature` | Generation creativity (0.0-1.0) | 0.4 |
| `--model` | Gemini model to use (recommended: `gemini-3-pro-image-preview`) | `gemini-2.5-flash-image` |
| `--webp` | Save as WEBP instead of PNG | False |
| `-f, --force` | Overwrite existing files | False |
| `--store-prompt` | Embed prompt in image metadata | False |
| `--output-dir` | Directory for outputs | Current directory |
| `--no-resize` | Don't resize input images | False |

### Examples

#### Text-to-Image (Basic)
```bash
# Single image
gemimg "concept art of a futuristic city" -o city.png

# Multiple variations
gemimg "character portrait, warrior" -n 4

# Custom aspect ratio
gemimg "wide landscape illustration" --aspect-ratio 16:9 -o landscape.png
```

#### Image-to-Image (Reference-Based)
```bash
# Single reference image
gemimg "enhance with vibrant colors" -i base-image.png -o enhanced.png

# Multiple reference images
gemimg "combine these styles" -i style1.png style2.png -o combined.png

# Variation of existing work
gemimg "darker, more mysterious atmosphere" -i concept.png -n 3
```

#### Batch Generation
```bash
# Multiple variations with auto-naming
gemimg "abstract geometric pattern" -n 5

# Custom output directory
gemimg "scene illustration" -n 3 --output-dir ./output/
```

#### Advanced Options
```bash
# Higher creativity
gemimg "abstract magical effects" --temperature 0.8 -o effects.png

# WEBP format (smaller files)
gemimg "character portrait" --webp -o portrait.webp

# Force overwrite existing
gemimg "updated concept" -o existing.png -f

# Store prompt in metadata
gemimg "reference art" --store-prompt -o ref.png
```

## Prompt Engineering for Gemimg

### General Principles

1. **Be Specific**: Describe exactly what you want
2. **Use Style Keywords**: "watercolor", "ink drawing", "digital art"
3. **Specify Composition**: "centered", "aerial view", "close-up"
4. **Include Details**: Colors, lighting, mood, style references
5. **Reference Existing Work**: "in the style of...", "similar to..."
6. **Keep It Concise**: 1-3 sentences work best

### Example Prompts by Category

#### Concept Art & Characters
```bash
# Character portrait
gemimg "character portrait, cyberpunk hacker, neon lighting, digital art style" -o hacker.png

# Full body concept
gemimg "full body character design, space explorer, detailed spacesuit, concept art" -o explorer.png

# Multiple expression studies
gemimg "character face study, multiple expressions, sketch style" -n 4
```

#### Scenes & Environments
```bash
# Atmospheric scene
gemimg "futuristic city at night, neon signs, cyberpunk aesthetic, cinematic lighting" -o city-night.png

# Interior scene
gemimg "cozy library interior, warm lighting, books and furniture, detailed illustration" -o library.png

# Action scene
gemimg "space battle, starships and explosions, dynamic composition, sci-fi art" -o battle.png
```

#### Abstract & Decorative
```bash
# Pattern design
gemimg "abstract geometric pattern, vibrant colors, seamless tiling" -o pattern.png

# Texture generation
gemimg "organic texture, wood grain, high detail, natural materials" -o texture.png

# Artistic effects
gemimg "swirling magical energy, particle effects, fantasy art" -o magic.png
```

### Style Keywords

**Artistic Styles:**
- `watercolor`, `oil painting`, `digital art`, `concept art`
- `ink drawing`, `pen and ink`, `charcoal sketch`, `graphite drawing`
- `comic book style`, `manga style`, `anime style`, `illustration`

**Technical Styles:**
- `3D render`, `isometric`, `blueprint`, `technical drawing`
- `low poly`, `voxel art`, `pixel art`, `vector art`

**Photography Styles:**
- `photorealistic`, `cinematic`, `portrait photography`, `macro`
- `long exposure`, `HDR`, `black and white`, `film grain`

**Lighting & Mood:**
- `dramatic lighting`, `soft natural light`, `golden hour`, `moonlight`
- `mysterious`, `epic`, `intimate`, `ominous`, `hopeful`
- `high contrast`, `muted tones`, `vibrant colors`, `monochrome`

## Image-to-Image Workflows

### Enhance Existing Images

```bash
# Add color enhancement
gemimg "enhance colors, increase vibrancy" \
  -i base-image.png \
  -o enhanced.png

# Transform style
gemimg "convert to watercolor painting style" \
  -i photo.png \
  -o watercolor.png
```

### Create Variations

```bash
# Different styling
gemimg "same subject in cyberpunk style" \
  -i original.png \
  -o cyberpunk-variant.png

# Different lighting
gemimg "same composition, dramatic nighttime lighting" \
  -i daytime.png \
  -o nighttime.png
```

### Composition Studies

```bash
# Multiple angle variations
gemimg "same subject, different camera angles" \
  -i base-composition.png \
  -n 4
```

## Batch Processing Examples

### Generate Multiple Variations

```bash
#!/bin/bash
# generate-variants.sh

PROMPT="abstract geometric art, vibrant colors"
OUTPUT_DIR="output"
COUNT=10

mkdir -p "$OUTPUT_DIR"

gemimg "$PROMPT" -n $COUNT --output-dir "$OUTPUT_DIR"
```

### Compare Different Styles

```bash
#!/bin/bash
# compare-styles.sh

SUBJECT="mountain landscape"

gemimg "$SUBJECT, watercolor style" -o style-watercolor.png
gemimg "$SUBJECT, ink drawing style" -o style-ink.png
gemimg "$SUBJECT, digital art style" -o style-digital.png
gemimg "$SUBJECT, oil painting style" -o style-oil.png
```

### Automated Concept Exploration

```bash
#!/bin/bash
# explore-concepts.sh

CONCEPT="futuristic vehicle"
STYLES=("cyberpunk" "steampunk" "minimalist" "retro-futuristic")

mkdir -p concepts

for style in "${STYLES[@]}"; do
  gemimg "$CONCEPT, $style style" \
    -n 3 \
    --output-dir "concepts/$style" \
    --store-prompt
done
```

## Quality Control & Selection

### Evaluation Criteria

**Technical Quality:**
- Image clarity and resolution
- Anatomical/structural accuracy
- Detail level appropriate for purpose
- Absence of artifacts or distortions

**Artistic Quality:**
- Composition and framing
- Color harmony and palette
- Lighting and atmosphere
- Style consistency

**Functional Quality:**
- Alignment with prompt intent
- Usability for intended purpose
- Consistency with existing assets
- Overall visual appeal

### Workflow Tips

1. **Generate Multiple Options**: Use `-n 5` or `-n 10` for variety
2. **Compare Side-by-Side**: View all variations before selecting
3. **Iterate on Best**: Use best result as reference for refinement
4. **Document Prompts**: Use `--store-prompt` to remember what worked
5. **Archive Explorations**: Keep all generations for future reference

## Limitations & Considerations

### Resolution Limitations

- Gemimg generates at 1024×1024 by default
- For higher resolution needs, consider:
  - Using upscaling tools (Real-ESRGAN, waifu2x)
  - Alternative services with higher resolution output
  - Post-processing with image enhancement tools

### When to Consider Alternatives

**Professional Character Work:**
- Consider services with reference systems for character consistency
- Use gemimg for initial exploration, then finalize elsewhere

**Precise Technical Work:**
- Gemimg is best for creative/artistic generation
- Use vector tools (Illustrator, Inkscape) for precise technical work
- Use CAD tools for engineering/architectural precision

**High-Volume Commercial Use:**
- Check Gemini API terms for commercial usage
- Consider dedicated commercial image generation services
- Evaluate cost/benefit of API usage limits

## Troubleshooting

### API Key Issues

```bash
# Check if API key is set
echo $GEMINI_API_KEY

# Reload shell configuration
source ~/.zshrc  # or ~/.bashrc

# Test with explicit key
gemimg "test prompt" --api-key "your-key-here" -o test.png
```

### Generation Failures

```bash
# Reduce temperature (more predictable results)
gemimg "complex scene" --temperature 0.2 -o output.png

# Simplify prompt (if too complex)
gemimg "simple concept" -o simple.png

# Try different model
gemimg "prompt" --model gemini-3-pro-image-preview -o output.png
```

### Output Issues

```bash
# Force overwrite existing files
gemimg "updated version" -o existing.png -f

# Change output directory
gemimg "new image" --output-dir ./new-location/

# Check disk space
df -h .

# Verify write permissions
ls -la output-directory/
```

## Best Practices

1. **Start Broad, Then Refine**: Generate multiple variations, then iterate on best
2. **Use Descriptive Filenames**: Include subject, style, date in filename
3. **Archive Everything**: Keep all explorations for future reference
4. **Document Successful Prompts**: Save prompts that work well
5. **Combine with Other Tools**: Use gemimg for generation, then enhance/process
6. **Respect API Limits**: Batch generate responsibly
7. **Test Temperature Settings**: Higher for creativity, lower for precision
8. **Use Reference Images**: Leverage image-to-image for consistency

## Quick Reference Card

```bash
# Basic generation (always specify model for best results)
gemimg "concept art" --model gemini-3-pro-image-preview -o output.png

# Multiple variations
gemimg "character concept" --model gemini-3-pro-image-preview -n 5

# With reference image
gemimg "enhance colors" --model gemini-3-pro-image-preview -i base.png -o enhanced.png

# Custom aspect ratio
gemimg "landscape" --model gemini-3-pro-image-preview --aspect-ratio 16:9 -o wide.png

# Higher creativity
gemimg "abstract art" --model gemini-3-pro-image-preview --temperature 0.8 -o art.png

# Batch to directory
gemimg "scene study" --model gemini-3-pro-image-preview -n 10 --output-dir ./output/

# WEBP format
gemimg "portrait" --model gemini-3-pro-image-preview --webp -o portrait.webp

# Store prompt in metadata
gemimg "reference" --model gemini-3-pro-image-preview --store-prompt -o ref.png
```

---

## Example Use Case: Reading Companion Project

This section demonstrates how gemimg integrates into a specific project workflow. Adapt these patterns to your own project needs.

### Project Context

The Reading Companion project uses gemimg for exploring visual concepts for fantasy book visualization - maps, character studies, and scene references. This workflow demonstrates practical integration patterns.

### Asset Pipeline Workflow

#### Map Concept Exploration
```bash
# Explore different map styles
mkdir -p maps/exploration/
cd maps/exploration/

gemimg "fantasy city map, medieval architecture, parchment style" -n 5

# Test regional variations
gemimg "fantasy world map showing terrain, aged parchment" -n 3
```

#### Character Concept Exploration
```bash
# Initial concept exploration
mkdir -p assets/characters/exploration/
cd assets/characters/exploration/

gemimg "fantasy character portrait, dark cloak, mysterious, sketch style" -n 4

# Study specific features
gemimg "character face study, multiple angles" -n 3
```

#### Scene Reference Generation
```bash
# Create scene references for inspiration
mkdir -p scenes/exploration/
cd scenes/exploration/

gemimg "fantasy city rooftops at night, atmospheric lighting" -o scene-ref.png
```

### Naming Conventions Example

**Exploration Files:**
```
{type}-exploration-{description}-{timestamp}.png

Examples:
- map-exploration-city-district-20250114.png
- character-exploration-warrior-concept-20250114.png
- scene-exploration-rooftops-night-20250114.png
```

**Reference Files:**
```
{name}-reference-{variant}.png

Examples:
- city-map-reference-aerial.png
- warrior-reference-pose.png
- throne-room-reference-lighting.png
```

### Directory Structure Example

```
project/
├── maps/
│   └── exploration/          # Map generation experiments
├── assets/
│   └── characters/
│       └── exploration/      # Character concept exploration
└── scenes/
    └── exploration/          # Scene reference generation
```

### Batch Generation Script Example

```bash
#!/bin/bash
# generate-character-concepts.sh

CHARACTER_NAME="Warrior"
DESCRIPTION="armored fighter, sword and shield, battle-worn"
STYLE="concept art, detailed illustration"
OUTPUT_DIR="assets/characters/exploration"

mkdir -p "$OUTPUT_DIR"

gemimg "$CHARACTER_NAME character portrait, $DESCRIPTION, $STYLE" \
  -n 5 \
  --output-dir "$OUTPUT_DIR" \
  --store-prompt

echo "Generated $CHARACTER_NAME concepts in $OUTPUT_DIR"
```

### Integration Tips

1. **Separate Exploration from Finals**: Keep gemimg explorations in dedicated directories
2. **Version Control Assets**: Git-ignore exploration directories, commit only finals
3. **Document Workflows**: Create project-specific scripts for repeatability
4. **Chain with Other Tools**: Use gemimg output as input for upscaling/editing tools
5. **Maintain Asset Database**: Track which explorations led to final assets

---

## Resources

- **Gemimg Repository**: https://github.com/minimaxir/gemimg
- **Gemini API Docs**: https://ai.google.dev/gemini-api/docs
- **API Key Setup**: https://ai.google.dev/gemini-api/docs/api-key
- **Google AI Studio**: https://aistudio.google.com/

## Version History

- **v1.0.1** (2025-12-08): Fixed model documentation - CLI defaults to `gemini-2.5-flash-image`, updated docs to clarify users must explicitly specify `--model gemini-3-pro-image-preview` for best results
- **v1.0.0** (2025-01-24): Global skill creation with comprehensive gemimg documentation and Reading Companion example use case
