# Zensical CLI Reference

## Commands

| Command | Purpose |
|---------|---------|
| `zensical serve` | Start development server with hot reload |
| `zensical build` | Build static site to `site/` directory |
| `zensical new` | Create a new project |

## Serve Command Options

```
zensical serve [OPTIONS]
```

| Option | Short | Default | Description |
|--------|-------|---------|-------------|
| `--dev-addr` | `-a` | localhost:8000 | Server address and port |
| `--open` | `-o` | false | Auto-open browser on start |
| `--config-file` | `-f` | zensical.toml | Path to config file |
| `--help` | | | Display help information |

## Configuration File (zensical.toml)

```toml
[project]
site_name = "My Documentation"
site_description = "Project documentation"

nav = [
    { "Home" = "index.md" },
    { "Guide" = "guide.md" },
    { "Section" = [
        { "Page 1" = "section/page1.md" },
        { "Page 2" = "section/page2.md" },
    ]},
]

[project.theme]
language = "en"
features = [
    "content.code.copy",
    "navigation.tabs",
    "navigation.sections",
    "navigation.expand",
    "search.highlight",
]

[[project.theme.palette]]
scheme = "slate"
primary = "indigo"
accent = "indigo"
toggle.icon = "lucide/sun"
toggle.name = "Switch to light mode"

[[project.theme.palette]]
scheme = "default"
primary = "indigo"
accent = "indigo"
toggle.icon = "lucide/moon"
toggle.name = "Switch to dark mode"
```

## Hot Reload Scope

Changes that trigger automatic browser reload:
- Markdown file content (`.md` files)
- Theme CSS changes
- Asset updates

Changes that require server restart:
- `zensical.toml` navigation structure
- `zensical.toml` theme configuration
- Adding new page files to nav

## Common Port Configurations

| Port | Use Case |
|------|----------|
| 8000 | Default zensical port |
| 8001 | Secondary docs site |
| 8080 | Alternative when 8000 in use |

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | General error |
| 98 | Address already in use (os error) |
| 144 | Process terminated by signal (128 + 16) |
