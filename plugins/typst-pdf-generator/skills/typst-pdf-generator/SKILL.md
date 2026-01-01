---
name: typst-pdf-generator
description: Automatically converts markdown files to professional PDFs using Typst and Pandoc. Handles images, templates, and generates organized project folders.
---

# Typst PDF Generator

## Overview

This skill converts markdown files to professional PDFs automatically. It handles image copying, template selection, and document compilation without user configuration. All artifacts are preserved in organized project folders under `~/Documents/typist/`.

**Core principle:** Zero configuration + sensible defaults = professional output.

**When to use:** User asks to convert markdown to PDF, generate a PDF from a document, or create a professional document from markdown.

## Invocation Examples

- "Generate a PDF from README.md"
- "Create a PDF of docs/report.md"
- "Convert my-notes.md to PDF using Typst"
- "Make a professional PDF from design-doc.md"

## Prerequisites

This skill requires Typst and Pandoc CLI tools. Check and install if needed:

```bash
# Check if installed
which typst && which pandoc

# Install if missing (macOS)
brew install typst pandoc
```

If tools are missing, display clear installation instructions and exit.

## Workflow

Follow these steps to convert markdown to PDF:

### Step 1: Detect Markdown File

Extract the markdown file path from the user's message. Look for:
- Explicit file paths (e.g., "docs/report.md")
- File references (e.g., "README.md", "my-notes.md")
- Current directory files if path is ambiguous

Validate the file exists and is readable:

```bash
test -f "$MARKDOWN_FILE" && test -r "$MARKDOWN_FILE"
```

If file doesn't exist or isn't readable, report error and exit.

### Step 2: Create Project Folder

Generate a timestamped project folder:

```bash
TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")
BASENAME=$(basename "$MARKDOWN_FILE" .md)
PROJECT_DIR="$HOME/Documents/typist/$TIMESTAMP-$BASENAME"

mkdir -p "$PROJECT_DIR/images"
```

Verify folder created:

```bash
test -d "$PROJECT_DIR" && echo "Project folder created: $PROJECT_DIR"
```

### Step 3: Copy Source Markdown

Copy the original markdown for reference:

```bash
cp "$MARKDOWN_FILE" "$PROJECT_DIR/source.md"
```

### Step 4: Select Template

Analyze the markdown to choose an appropriate template. Check in this order:

1. **Explicit frontmatter**: Look for `template:` field in YAML frontmatter
2. **Content analysis**: Scan document structure for indicators
   - Code blocks + technical terms → `technical`
   - Citation markers `[@ref]` or bibliography → `academic`
   - `# Executive Summary` or business terms → `report`
   - Default → `minimal`

Use Grep to detect patterns:

```bash
# Check for frontmatter template
TEMPLATE=$(grep -m1 "^template:" "$MARKDOWN_FILE" | cut -d: -f2 | tr -d ' ')

# If no frontmatter, analyze content
if [ -z "$TEMPLATE" ]; then
  if grep -q '```' "$MARKDOWN_FILE" && grep -qi 'function\|variable\|code\|implementation' "$MARKDOWN_FILE"; then
    TEMPLATE="technical"
  elif grep -q '\[@' "$MARKDOWN_FILE" || grep -qi 'bibliography\|references' "$MARKDOWN_FILE"; then
    TEMPLATE="academic"
  elif grep -qi 'executive summary\|quarterly\|fiscal' "$MARKDOWN_FILE"; then
    TEMPLATE="report"
  else
    TEMPLATE="minimal"
  fi
fi
```

Report selected template to user.

### Step 5: Detect and Copy Images

Scan markdown for image references:

```bash
# Find image patterns: ![alt](path) or <img src="path">
grep -oE '!\[.*?\]\(([^)]+)\)' "$MARKDOWN_FILE" | grep -oE '\([^)]+\)' | tr -d '()' > /tmp/images.txt
grep -oE '<img[^>]+src="([^"]+)"' "$MARKDOWN_FILE" | grep -oE 'src="[^"]+"' | cut -d'"' -f2 >> /tmp/images.txt
```

For each image:
1. Resolve path relative to markdown file location
2. Verify image exists
3. Copy to `$PROJECT_DIR/images/`
4. Warn if image is missing (but continue)

```bash
MARKDOWN_DIR=$(dirname "$MARKDOWN_FILE")
while IFS= read -r IMG; do
  IMG_PATH="$MARKDOWN_DIR/$IMG"
  if [ -f "$IMG_PATH" ]; then
    cp "$IMG_PATH" "$PROJECT_DIR/images/$(basename "$IMG")"
    echo "Copied: $(basename "$IMG")"
  else
    echo "Warning: Image not found: $IMG"
  fi
done < /tmp/images.txt
```

### Step 6: Convert Markdown to Typst

Use Pandoc to convert markdown to Typst format, then apply executive formatting:

```bash
cd "$PROJECT_DIR"
pandoc source.md -o document_raw.typ --to=typst

# Fix common Pandoc conversion issues
# Horizontal rules (---) get converted to #horizontalrule which doesn't exist in Typst
sed -i '' 's/#horizontalrule/#line(length: 100%)/g' document_raw.typ 2>/dev/null || \
  sed -i 's/#horizontalrule/#line(length: 100%)/g' document_raw.typ 2>/dev/null

# Apply executive formatting preamble (compact, professional output)
cat > document.typ << 'EOF'
#set page(margin: (x: 1.5cm, y: 1.5cm))
#set text(size: 10pt)
#set par(leading: 0.5em, spacing: 0.8em)
#set heading(numbering: none)
#show heading.where(level: 1): it => [#text(size: 14pt, weight: "bold")[#it.body]]
#show heading.where(level: 2): it => [#v(0.3em)#text(size: 11pt, weight: "bold")[#it.body]#v(0.2em)]
#show table: set text(size: 9pt)
#set table(inset: 4pt)

EOF

cat document_raw.typ >> document.typ
```

If conversion fails, show pandoc error and exit.

**Note**: The `sed` command fixes horizontal rule conversion. First command is for macOS (BSD sed), second for Linux (GNU sed). The `||` ensures one succeeds without failing the workflow.

### Step 7: Compile PDF with Typst

Compile the Typst file to PDF using the selected template:

```bash
TEMPLATE_PATH="$HOME/.claude/skills/typst-pdf-generator/templates/$TEMPLATE.typ"

# Check if custom template exists
CUSTOM_TEMPLATE="$HOME/Documents/typist/templates/$TEMPLATE.typ"
if [ -f "$CUSTOM_TEMPLATE" ]; then
  TEMPLATE_PATH="$CUSTOM_TEMPLATE"
fi

# Extract metadata from markdown frontmatter if present
TITLE=$(grep -m1 "^title:" source.md | cut -d: -f2- | sed 's/^ *//')
AUTHOR=$(grep -m1 "^author:" source.md | cut -d: -f2- | sed 's/^ *//')
DATE=$(grep -m1 "^date:" source.md | cut -d: -f2- | sed 's/^ *//')

# Compile PDF
typst compile document.typ document.pdf \
  --root . \
  $([ -n "$TITLE" ] && echo "--input title=\"$TITLE\"") \
  $([ -n "$AUTHOR" ] && echo "--input author=\"$AUTHOR\"") \
  $([ -n "$DATE" ] && echo "--input date=\"$DATE\"")
```

If compilation fails, show typst error and suggest trying 'minimal' template.

### Step 8: Create Build Metadata

Save build information for reference:

```bash
cat > "$PROJECT_DIR/metadata.json" <<EOF
{
  "timestamp": "$(date -Iseconds)",
  "source": "$MARKDOWN_FILE",
  "template": "$TEMPLATE",
  "typst_version": "$(typst --version)",
  "pandoc_version": "$(pandoc --version | head -1)"
}
EOF
```

### Step 9: Report Success and Open PDF

Display success message with file path:

```
✓ PDF generated successfully!

Output: $PROJECT_DIR/document.pdf
Project: $PROJECT_DIR

Opening PDF...
```

Attempt to open PDF with system default viewer:

```bash
open "$PROJECT_DIR/document.pdf" 2>/dev/null || \
xdg-open "$PROJECT_DIR/document.pdf" 2>/dev/null || \
echo "Please open: $PROJECT_DIR/document.pdf"
```

## Error Handling

### Missing Dependencies

If typst or pandoc is not installed:

```
Error: Required tool not found: [typst|pandoc]

To install on macOS:
  brew install typst pandoc

To install on Linux:
  # Typst
  cargo install typst-cli
  # or download from https://github.com/typst/typst/releases

  # Pandoc
  sudo apt-get install pandoc  # Debian/Ubuntu
  sudo dnf install pandoc      # Fedora
```

### Markdown File Not Found

If the specified markdown file doesn't exist:

```
Error: Markdown file not found: [path]

Please check the file path and try again.
```

### Pandoc Conversion Failure

If pandoc fails to convert markdown:

```
Error: Pandoc conversion failed

[Pandoc error output]

This may indicate invalid markdown syntax. Try:
1. Simplifying the markdown
2. Checking for unsupported extensions
3. Creating a .typ file manually
```

### Typst Compilation Failure

If typst fails to compile:

```
Error: Typst compilation failed

[Typst error output]

Try:
1. Using the 'minimal' template (specify template: minimal in frontmatter)
2. Checking for missing fonts: typst fonts
3. Reviewing the generated .typ file: [path]/document.typ
```

**Common Issue: Unknown Variable Errors**

Pandoc may convert some markdown elements to Typst commands that don't exist. Most common:

```
error: unknown variable: horizontalrule
```

This occurs when markdown contains horizontal rules (`---` or `***`). Pandoc converts these to `#horizontalrule`, which is not a valid Typst command.

**Fix**: After Step 6 (Pandoc conversion), automatically fix common conversion issues:

```bash
# Fix horizontal rule conversion
sed -i '' 's/#horizontalrule/#line(length: 100%)/g' "$PROJECT_DIR/document.typ"
```

Add this to Step 6 after Pandoc completes but before Typst compilation. This converts the invalid `#horizontalrule` to the valid Typst command `#line(length: 100%)`.

### Image Issues

Missing images generate warnings but don't stop PDF generation:

```
Warning: Image not found: path/to/image.png
Continuing without this image...
```

Large images (>10MB) generate size warnings:

```
Warning: Large image detected: image.png (15.2 MB)
This may slow compilation or increase PDF size.
```

### Disk Space

Before starting, verify sufficient disk space:

```bash
FREE_SPACE=$(df -k "$HOME/Documents" | tail -1 | awk '{print $4}')
if [ "$FREE_SPACE" -lt 102400 ]; then
  echo "Warning: Low disk space (< 100MB available)"
fi
```

## Built-in Templates

Five templates are provided in `~/.claude/skills/typst-pdf-generator/templates/`:

### minimal.typ
Clean, simple formatting for general documents. Default choice when no other template matches.

**Best for:** General documentation, notes, simple reports

### technical.typ
Code-friendly with syntax highlighting, monospace elements, numbered sections.

**Best for:** Technical documentation, API docs, implementation guides

**Auto-selected when:** Document contains code blocks and technical terms

### academic.typ
Citation support, numbered sections, formal styling, separate title page.

**Best for:** Academic papers, research documents, formal writing

**Auto-selected when:** Document contains citation markers `[@ref]` or bibliography

### report.typ
Professional business style with cover page, section numbering.

**Best for:** Business reports, proposals, executive summaries

**Auto-selected when:** Document contains "Executive Summary" or business terminology

### presentation.typ
Slide-like layout with large text, colored headers, designed for handouts.

**Best for:** Presentation notes, training materials, slides

## Custom Templates

Users can create custom templates in `~/Documents/typist/templates/`:

1. Create a `.typ` file in that directory
2. Specify in markdown frontmatter: `template: my-custom-template`
3. The skill will use the custom template if found, otherwise fall back to built-in

Custom templates should accept these input variables:
- `sys.inputs.at("title", default: "")`
- `sys.inputs.at("author", default: "")`
- `sys.inputs.at("date", default: "")`
- `sys.inputs.at("content", default: "")`

## Template Variables

Templates receive metadata from markdown frontmatter:

```yaml
---
title: My Document Title
author: John Doe
date: 2025-10-24
template: technical
---
```

These are passed to Typst as `--input` parameters.

## Examples

### Example 1: Simple Document

User: "Convert README.md to PDF"

Expected behavior:
1. Detect file: README.md
2. Create: ~/Documents/typist/2025-10-24-14-30-00-README/
3. Analyze content → Select 'minimal' template
4. Copy any images found
5. Convert: markdown → typst → PDF
6. Report: "✓ PDF generated: ~/Documents/typist/2025-10-24-14-30-00-README/document.pdf"
7. Open PDF in system viewer

### Example 2: Technical Documentation with Images

User: "Generate a PDF from docs/api-guide.md"

Markdown contains:
- Multiple code blocks
- Technical terminology
- Embedded images: ![diagram](../images/architecture.png)

Expected behavior:
1. Detect file: docs/api-guide.md
2. Create project folder with timestamp
3. Analyze content → Select 'technical' template (code blocks detected)
4. Copy images/architecture.png to project/images/
5. Convert with syntax highlighting enabled
6. Generate PDF with professional code formatting
7. Open result

### Example 3: Academic Paper

User: "Create a PDF of research-paper.md"

Markdown frontmatter:
```yaml
---
title: "Machine Learning Applications in Climate Science"
author: "Dr. Jane Smith"
date: "2025-10-24"
template: academic
---
```

Expected behavior:
1. Read frontmatter → Use 'academic' template (explicit)
2. Extract title, author, date for template variables
3. Generate formal academic-style PDF with title page
4. Numbered sections for chapters
5. Open result

### Example 4: Custom Template

User: "Convert proposal.md to PDF"

User has created: ~/Documents/typist/templates/company-branded.typ

Markdown frontmatter:
```yaml
---
template: company-branded
title: "Q4 Business Proposal"
---
```

Expected behavior:
1. Check for custom template: ~/Documents/typist/templates/company-branded.typ
2. Found → Use custom template instead of built-in
3. Pass title variable to template
4. Generate branded PDF
5. Open result

## User Feedback

Provide clear progress indicators at each step:

```
Detecting markdown file...
✓ Found: docs/report.md

Creating project workspace...
✓ Created: ~/Documents/typist/2025-10-24-14-30-45-report/

Analyzing document structure...
✓ Selected 'technical' template (detected code blocks)

Copying images...
✓ Copied 3 images:
  - diagram.png
  - chart.svg
  - screenshot.jpg

Converting markdown to Typst...
✓ Conversion complete

Compiling PDF with Typst...
✓ Compilation successful

✓ PDF generated successfully!

Output: ~/Documents/typist/2025-10-24-14-30-45-report/document.pdf
Project: ~/Documents/typist/2025-10-24-14-30-45-report/

Opening PDF...
```

Each step should:
- State what's happening
- Show success (✓) or error (✗)
- Include relevant details (file counts, paths, selections)

## Build Logs

All operations are logged to `$PROJECT_DIR/build.log`:

```bash
exec > >(tee -a "$PROJECT_DIR/build.log") 2>&1

echo "=== Typst PDF Generator Build Log ==="
echo "Timestamp: $(date)"
echo "Source: $MARKDOWN_FILE"
echo "Typst version: $(typst --version)"
echo "Pandoc version: $(pandoc --version | head -1)"
echo "Template: $TEMPLATE"
echo "==="
```

Users can review this log for troubleshooting.

## Quick Reference

| Step | Command | Purpose |
|------|---------|---------|
| Check deps | `which typst && which pandoc` | Verify tools installed |
| Create project | `mkdir -p ~/Documents/typist/$TIMESTAMP-$NAME` | Project folder |
| Detect images | `grep -oE '!\[.*?\]\(([^)]+)\)'` | Find image references |
| Convert | `pandoc source.md -o document.typ --to=typst` | Markdown → Typst |
| Fix conversions | `sed -i 's/#horizontalrule/#line(length: 100%)/g' document.typ` | Fix Pandoc issues |
| Compile | `typst compile document.typ document.pdf` | Typst → PDF |
| Open PDF | `open document.pdf` | View result |

## Tips

### Specifying Templates

Add YAML frontmatter to markdown:

```yaml
---
template: technical
title: API Documentation
author: Development Team
---
```

### Image Paths

Use relative paths from markdown file location:

```markdown
![Diagram](./images/diagram.png)
![Chart](../assets/chart.svg)
```

### Custom Styling

Create custom template in `~/Documents/typist/templates/my-style.typ` and reference:

```yaml
---
template: my-style
---
```

### Default Executive Formatting

This skill applies executive-style formatting by default, producing compact, professional documents. The formatting preamble is automatically prepended during Step 6.

**Default preamble (applied automatically):**

```typst
#set page(margin: (x: 1.5cm, y: 1.5cm))
#set text(size: 10pt)
#set par(leading: 0.5em, spacing: 0.8em)
#set heading(numbering: none)
#show heading.where(level: 1): it => [#text(size: 14pt, weight: "bold")[#it.body]]
#show heading.where(level: 2): it => [#v(0.3em)#text(size: 11pt, weight: "bold")[#it.body]#v(0.2em)]
#show table: set text(size: 9pt)
#set table(inset: 4pt)
```

**What each setting does:**

| Setting | Typst Default | Executive | Effect |
|---------|---------------|-----------|--------|
| `page(margin)` | ~2.5cm | 1.5cm | Tighter page margins |
| `text(size)` | 11pt | 10pt | Smaller body text |
| `par(leading)` | 0.65em | 0.5em | Tighter line spacing |
| `par(spacing)` | 1.2em | 0.8em | Less space between paragraphs |
| `heading` sizes | 17pt/13pt | 14pt/11pt | Smaller headings |
| `table(inset)` | 5pt | 4pt | Tighter table cell padding |
| `table` text | 11pt | 9pt | Smaller table text |

**Why executive formatting is the default:** Typst keeps tables and sections together rather than splitting them across pages. With standard spacing, this often leaves large whitespace at page bottoms. Executive formatting reduces element sizes so more content fits per page, producing cleaner, more professional documents.

### Debugging

If compilation fails:
1. Check `$PROJECT_DIR/build.log` for details
2. Review `$PROJECT_DIR/document.typ` for Typst syntax
3. Look for Pandoc conversion issues (e.g., `#horizontalrule` should be `#line(length: 100%)`)
4. Try `minimal` template to isolate issues
5. Run `typst compile document.typ document.pdf` manually

**Common Pandoc Conversion Issues:**
- Horizontal rules (`---` in markdown) may convert to `#horizontalrule` (invalid) instead of `#line(length: 100%)`
- The workflow includes automatic fixes, but manual review of `document.typ` can catch edge cases

### Project Organization

All artifacts are preserved:
- `source.md` - Original markdown
- `document.typ` - Generated Typst source
- `document.pdf` - Final PDF
- `images/` - All referenced images
- `metadata.json` - Build information
- `build.log` - Complete build log

This makes it easy to:
- Reproduce builds
- Debug issues
- Iterate on custom templates
- Share complete project folders
