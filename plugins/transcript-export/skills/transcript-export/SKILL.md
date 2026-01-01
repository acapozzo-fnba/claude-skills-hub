---
name: transcript-export
description: Export Claude Code session transcripts to searchable HTML files using the claude-code-transcripts tool. Supports local exports with descriptive naming and optional GitHub Gist publishing.
version: 1.0.0
tags: [transcript, export, session, html, gist, documentation, archive]
---

# Transcript Export

## Overview

This skill exports Claude Code session transcripts to searchable, paginated HTML files. It uses Simon Willison's `claude-code-transcripts` tool to convert your conversation history into browsable documentation that can be saved locally or shared via GitHub Gist.

**Core principle:** Export sessions with meaningful names to create a searchable archive of your Claude Code conversations.

## When to Use This Skill

- Archiving completed Claude Code sessions for future reference
- Creating documentation from coding sessions
- Sharing session transcripts with team members
- Building a searchable knowledge base of past conversations
- Preserving important troubleshooting or implementation sessions
- Creating training materials from exemplary sessions

## Invocation Examples

- "Export this session as a transcript"
- "Save the transcript of this conversation"
- "Create a transcript called 'react-migration-session'"
- "Export transcript to gist"
- "Archive this session with the name 'api-refactoring'"
- "/transcript-export"

## Prerequisites

This skill requires `uv` (Python package manager) and `claude-code-transcripts`. The skill will auto-install missing dependencies.

### Check Installation Status

```bash
# Check if uv is installed
which uv && uv --version

# Check if claude-code-transcripts is installed
which claude-code-transcripts || uv tool list | grep claude-code-transcripts
```

### Manual Installation (if needed)

```bash
# Install uv (if not present)
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.bashrc  # or source ~/.zshrc

# Install claude-code-transcripts
uv tool install claude-code-transcripts
```

## Workflow

Follow these steps when a user requests transcript export:

### Step 1: Check and Install Dependencies

First, verify that required tools are installed:

```bash
# Check for uv
if ! command -v uv &> /dev/null; then
    echo "Installing uv package manager..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
fi

# Check for claude-code-transcripts
if ! uv tool list 2>/dev/null | grep -q "claude-code-transcripts"; then
    echo "Installing claude-code-transcripts..."
    uv tool install claude-code-transcripts
fi

# Verify installation
claude-code-transcripts --help > /dev/null 2>&1 && echo "claude-code-transcripts is ready"
```

### Step 2: Prompt for Transcript Name

**IMPORTANT:** Always ask the user for a descriptive name before exporting.

Ask the user:
```
What would you like to name this transcript?

Please provide a short, descriptive name that captures the session's purpose.
Examples:
- "react-auth-implementation"
- "bug-fix-login-timeout"
- "database-migration-planning"
- "api-endpoint-refactor"

This name will be used to create the output folder.
```

**Naming conventions:**
- Use lowercase letters, numbers, and hyphens
- No spaces (use hyphens instead)
- Be descriptive but concise
- Include date if relevant (e.g., "2025-01-feature-review")

### Step 3: Determine Output Location

By default, save transcripts to the current working directory:

```bash
# Get current working directory
OUTPUT_BASE="$(pwd)"

# Create transcript folder with user-provided name
TRANSCRIPT_NAME="<user-provided-name>"
TIMESTAMP=$(date +"%Y-%m-%d")
OUTPUT_DIR="${OUTPUT_BASE}/${TIMESTAMP}-${TRANSCRIPT_NAME}-transcript"
```

**Alternative locations** (if user specifies):
- `~/Documents/claude-transcripts/` - Personal archive
- Project root - For project-specific sessions
- Temporary location for gist-only exports

### Step 4: Export Transcript Locally

Execute the export command:

```bash
# Create output directory
mkdir -p "$OUTPUT_DIR"

# Export transcript
claude-code-transcripts local -o "$OUTPUT_DIR"
```

**Expected output structure:**
```
2025-01-15-react-auth-transcript/
  index.html          # Main entry point with search
  page-001.html       # First page of conversation
  page-002.html       # Second page (if conversation is long)
  ...                 # Additional pages as needed
```

### Step 5: Optional - Include JSON Source

If the user wants the original session JSON (for programmatic access or backup):

```bash
claude-code-transcripts local -o "$OUTPUT_DIR" --json
```

This adds the original session JSON file alongside the HTML files.

### Step 6: Optional - Export to GitHub Gist

If the user wants to share via Gist:

```bash
# Check gh authentication first
if ! gh auth status &> /dev/null; then
    echo "GitHub CLI not authenticated. Please run: gh auth login"
    exit 1
fi

# Export to gist
claude-code-transcripts local -o "$OUTPUT_DIR" --gist
```

**With browser auto-open:**
```bash
claude-code-transcripts local -o "$OUTPUT_DIR" --gist --open
```

### Step 7: Report Success

Display completion message with file locations:

```
Transcript exported successfully!

Location: /path/to/2025-01-15-react-auth-transcript/
Files created:
  - index.html (main entry point)
  - page-001.html
  - page-002.html (if applicable)

To view the transcript:
  xdg-open "/path/to/2025-01-15-react-auth-transcript/index.html"  # Linux
  open "/path/to/2025-01-15-react-auth-transcript/index.html"      # macOS
```

If gist was created:
```
GitHub Gist created successfully!

Gist URL: https://gist.github.com/username/abc123...
Preview: https://gistpreview.github.io/?abc123/index.html
Local copy: /path/to/2025-01-15-react-auth-transcript/
```

## Command Reference

### claude-code-transcripts local

Export the most recent Claude Code session to HTML files.

```bash
claude-code-transcripts local [OPTIONS]
```

| Option | Description |
|--------|-------------|
| `-o, --output DIRECTORY` | Output directory for HTML files (required) |
| `--gist` | Upload to GitHub Gist (requires gh CLI authenticated) |
| `--open` | Open result in browser |
| `--json` | Include original session JSON file |

### Common Usage Patterns

```bash
# Basic local export
claude-code-transcripts local -o ./my-transcript

# Export with JSON backup
claude-code-transcripts local -o ./my-transcript --json

# Export to gist and open
claude-code-transcripts local -o ./my-transcript --gist --open

# Export to gist only (with local copy)
claude-code-transcripts local -o ./my-transcript --gist
```

## Examples

### Example 1: Simple Local Export

**User:** "Export this session transcript"

**Process:**
1. Check dependencies (install if needed)
2. Ask: "What would you like to name this transcript?"
3. User responds: "database-migration"
4. Export to `./2025-01-15-database-migration-transcript/`
5. Report success with file path

**Commands executed:**
```bash
# Verify installation
which claude-code-transcripts

# Create and export
OUTPUT_DIR="./2025-01-15-database-migration-transcript"
mkdir -p "$OUTPUT_DIR"
claude-code-transcripts local -o "$OUTPUT_DIR"

# Report
echo "Transcript saved to: $OUTPUT_DIR"
ls -la "$OUTPUT_DIR"
```

### Example 2: Export with Gist Sharing

**User:** "Export this transcript and share it as a gist"

**Process:**
1. Check dependencies
2. Verify GitHub CLI is authenticated
3. Ask for transcript name
4. User responds: "api-design-review"
5. Export locally AND to gist
6. Report both local path and gist URL

**Commands executed:**
```bash
# Check gh auth
gh auth status

# Export with gist
OUTPUT_DIR="./2025-01-15-api-design-review-transcript"
mkdir -p "$OUTPUT_DIR"
claude-code-transcripts local -o "$OUTPUT_DIR" --gist --open
```

### Example 3: Archive to Specific Location

**User:** "Save transcript to my documents folder, call it 'refactoring-session'"

**Process:**
1. Check dependencies
2. Use user-specified location
3. Export to `~/Documents/claude-transcripts/2025-01-15-refactoring-session-transcript/`

**Commands executed:**
```bash
OUTPUT_DIR="$HOME/Documents/claude-transcripts/2025-01-15-refactoring-session-transcript"
mkdir -p "$OUTPUT_DIR"
claude-code-transcripts local -o "$OUTPUT_DIR"

# Open in browser
xdg-open "$OUTPUT_DIR/index.html"  # Linux
```

### Example 4: Export with JSON for Programmatic Access

**User:** "Export transcript with the raw JSON data"

**Process:**
1. Ask for name
2. Export with --json flag
3. User gets HTML files AND original JSON

**Commands executed:**
```bash
OUTPUT_DIR="./2025-01-15-session-backup-transcript"
mkdir -p "$OUTPUT_DIR"
claude-code-transcripts local -o "$OUTPUT_DIR" --json

ls -la "$OUTPUT_DIR"
# Shows: index.html, page-*.html, session.json
```

## Error Handling

### Missing uv

If uv is not installed:
```
uv package manager not found. Installing...

Running: curl -LsSf https://astral.sh/uv/install.sh | sh

After installation, please restart your shell or run:
  source ~/.bashrc  (or source ~/.zshrc)

Then try again.
```

### Missing claude-code-transcripts

If the tool is not installed:
```
claude-code-transcripts not found. Installing via uv...

Running: uv tool install claude-code-transcripts

Installation complete. Ready to export transcripts.
```

### No Session Data

If there is no Claude Code session to export:
```
Error: No Claude Code session data found.

This could mean:
1. This is a new session with no conversation history
2. Session data has been cleared

Please ensure you have an active Claude Code session with conversation history.
```

### GitHub CLI Not Authenticated (for gist)

If `--gist` is requested but gh is not authenticated:
```
Error: GitHub CLI is not authenticated.

To enable gist uploads, please authenticate with GitHub:
  gh auth login

Then try the export again with --gist.
```

### Output Directory Issues

If the output directory cannot be created:
```
Error: Cannot create output directory: /path/to/directory

Please check:
1. You have write permissions to the parent directory
2. The path is valid
3. Disk space is available

Try specifying a different output location.
```

## Best Practices

### Naming Conventions

1. **Be descriptive:** Use names that capture what the session was about
   - Good: `react-hooks-refactoring`, `aws-lambda-debugging`
   - Bad: `session1`, `test`, `stuff`

2. **Include context:** Add project or feature context
   - Good: `myapp-auth-implementation`, `backend-api-migration`
   - Bad: `auth`, `api`

3. **Use dates for chronological archives:**
   - Good: `2025-01-sprint-review`, `2025-q1-planning`

### Organization Tips

1. **Create a dedicated archive folder:**
   ```bash
   mkdir -p ~/Documents/claude-transcripts
   ```

2. **Use consistent naming patterns:**
   ```
   ~/Documents/claude-transcripts/
     2025-01-15-project-kickoff-transcript/
     2025-01-16-bug-investigation-transcript/
     2025-01-17-code-review-session-transcript/
   ```

3. **Archive important sessions immediately:** Export transcripts at the end of significant sessions while context is fresh.

### Sharing Guidelines

1. **Review before sharing gists:** Check that no sensitive information (API keys, passwords, internal URLs) is in the transcript
2. **Use private gists for sensitive content:** Consider gist visibility settings
3. **Add context when sharing:** Include a brief description of what the transcript covers

## Troubleshooting

### Issue: "command not found: claude-code-transcripts"

**Solution:**
```bash
# Add uv tools to PATH
export PATH="$HOME/.local/bin:$PATH"

# Or reinstall
uv tool install claude-code-transcripts --force
```

### Issue: Export produces empty files

**Solution:**
- Ensure you have an active Claude Code session
- Check that the session has conversation history
- Try running from the directory where Claude Code was launched

### Issue: Gist creation fails

**Solution:**
```bash
# Check GitHub authentication
gh auth status

# Re-authenticate if needed
gh auth login --scopes gist

# Try export again
claude-code-transcripts local -o ./transcript --gist
```

### Issue: Permission denied on output directory

**Solution:**
```bash
# Check permissions
ls -la /path/to/parent/directory

# Use a directory you have write access to
claude-code-transcripts local -o ~/transcript-export
```

## Quick Reference

```bash
# Check installation
which uv && which claude-code-transcripts

# Install dependencies
curl -LsSf https://astral.sh/uv/install.sh | sh
uv tool install claude-code-transcripts

# Basic export
claude-code-transcripts local -o ./my-transcript

# Export with JSON
claude-code-transcripts local -o ./my-transcript --json

# Export to gist
claude-code-transcripts local -o ./my-transcript --gist

# Export to gist and open
claude-code-transcripts local -o ./my-transcript --gist --open

# View transcript
xdg-open ./my-transcript/index.html  # Linux
open ./my-transcript/index.html      # macOS
```

## Resources

- **claude-code-transcripts repository:** https://github.com/simonw/claude-code-transcripts
- **uv documentation:** https://docs.astral.sh/uv/
- **GitHub CLI documentation:** https://cli.github.com/manual/

## Reference Example

A real transcript example is included with this skill:

- **Location:** `references/2025-12-29-skill-creation-transcript/`
- **Contents:** The session where this skill was created
- **Files:** `index.html`, `page-001.html`

Open `index.html` in a browser to see how exported transcripts appear.
