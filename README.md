# claude-skills-hub

Curated collection of 16 individually installable plugins for Claude Code.

## Installation

### Prerequisites

- Claude Code installed
- GitHub CLI authenticated (`gh auth status` to verify)

### Add Marketplace

```bash
/plugin marketplace add acapozzo-fnba/claude-skills-hub
```

### Install Plugins

Use the interactive UI to browse and install plugins:
```bash
/plugin
```

Or install individual plugins via command:
```bash
/plugin install github-cli@acapozzo-claude-marketplace
/plugin install gemimg-generation@acapozzo-claude-marketplace
```

## Available Plugins (16)

### Image & Design

| Plugin | Description |
|--------|-------------|
| **artifacts-builder** | Multi-component claude.ai HTML artifacts with React/Tailwind/shadcn |
| **diagram-generation** | Technical network/infrastructure diagrams |
| **gemimg-generation** | AI image generation using Gemini API |
| **image-upscaling** | AI-powered image upscaling with Real-ESRGAN |
| **theme-factory** | Styling artifacts with 10 pre-set themes |

### Development Tools

| Plugin | Description |
|--------|-------------|
| **changelog-generator** | Auto-generate changelogs from git commits |
| **github-cli** | GitHub CLI for repo/project management |
| **implementation-plan** | Generate structured implementation plans for Jira, PRs, and release docs |
| **jira-story-generator** | Generate well-structured Jira user stories |
| **next-steps** | Task tracking with next_steps.md |
| **playwright** | Browser automation with Playwright |
| **zensical-local** | Best practices for running Zensical documentation server locally |

### Document & File Processing

| Plugin | Description |
|--------|-------------|
| **document-skills** | Work with Office documents (docx, pdf, pptx, xlsx) |
| **file-organizer** | Intelligent file/folder organization |
| **transcript-export** | Export Claude Code session transcripts to searchable HTML |
| **typst-pdf-generator** | Markdown to PDF conversion using Typst |

## Usage

After installation, skills are auto-invoked by Claude based on task context. Each plugin can be enabled/disabled independently via `/plugin`.

## Structure

```
claude-skills-hub/
├── .claude-plugin/
│   └── marketplace.json          # Lists all 16 plugins
└── plugins/
    ├── github-cli/
    │   ├── .claude-plugin/
    │   │   └── plugin.json       # Plugin manifest
    │   └── skills/
    │       └── github-cli/
    │           └── SKILL.md      # Skill definition
    └── ... (15 more plugins)
```

## Version

3.2.0

## License

MIT
