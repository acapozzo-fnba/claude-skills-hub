# Typst PDF Generator Skill

Automatically converts markdown files to professional PDFs using Typst and Pandoc.

## Features

- **Zero configuration** - Just specify a markdown file
- **Smart template selection** - Automatically chooses appropriate styling
- **Image handling** - Automatically copies and references images
- **Organized output** - Timestamped project folders preserve all artifacts
- **Custom templates** - Support for user-defined Typst templates
- **Comprehensive error handling** - Clear messages guide troubleshooting

## Installation

This skill requires Typst and Pandoc CLI tools:

```bash
# macOS
brew install typst pandoc

# Linux
cargo install typst-cli  # or download from releases
sudo apt-get install pandoc  # Debian/Ubuntu
```

## Usage

Simply ask Claude to convert a markdown file:

```
"Generate a PDF from README.md"
"Create a PDF of docs/report.md"
"Convert my-notes.md to PDF"
```

Claude will:
1. Detect the markdown file
2. Create an organized project folder
3. Select an appropriate template
4. Copy referenced images
5. Generate a professional PDF
6. Open the result

## Templates

Five built-in templates:
- **minimal** - Clean, simple formatting (default)
- **technical** - Code-friendly with syntax highlighting
- **academic** - Formal styling with citations
- **report** - Business style with cover page
- **presentation** - Slide-like layout

Specify template in markdown frontmatter:

```yaml
---
template: technical
title: My Document
author: Your Name
---
```

## Custom Templates

Create templates in `~/Documents/typist/templates/`:

1. Write a `.typ` file with your styling
2. Reference by name in frontmatter
3. Skill will use custom template automatically

## Output Structure

Each conversion creates a timestamped project folder:

```
~/Documents/typist/2025-10-24-14-30-45-report/
├── source.md          # Original markdown
├── document.typ       # Generated Typst
├── document.pdf       # Final PDF
├── images/           # Referenced images
├── metadata.json     # Build info
└── build.log         # Complete log
```

## Testing

Use the included test document:

```
"Generate a PDF from skills/typst-pdf-generator/test-document.md"
```

This validates:
- Code block formatting
- Lists and tables
- Emphasis and links
- Template application
- Metadata extraction

## Troubleshooting

See `SKILL.md` for detailed error handling and debugging tips.

Common issues:
- **Tool not found** - Install typst and pandoc
- **Image not found** - Check relative paths from markdown location
- **Compilation failed** - Try 'minimal' template, check build.log

## Design Documentation

See `docs/plans/2025-10-24-typst-pdf-generator-design.md` for architecture and design decisions.
