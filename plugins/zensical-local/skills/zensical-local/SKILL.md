---
name: zensical-local
description: This skill should be used when the user asks to "start zensical", "run zensical", "zensical serve", "reload zensical", "restart zensical", "documentation preview", "docs server", or mentions zensical not updating or changes not showing. Provides patterns for running Zensical documentation server locally with proper hot reload awareness.
version: 1.0.0
tags: [zensical, documentation, mkdocs, dev-server, hot-reload, static-site]
---

# Zensical Local Development

Run Zensical documentation servers locally with efficient patterns that minimize unnecessary restarts.

## Hot Reload Behavior

Zensical has built-in hot reload. As changes are made to source files, the browser automatically reloads.

**Hot reload handles automatically:**
- Editing existing markdown files
- Updating content within pages
- Fixing typos, adding sections
- Any changes to files already in the nav

**Hot reload does NOT handle (restart required):**
- Adding new pages to `zensical.toml` nav
- Changing theme/config settings in `zensical.toml`
- Adding new directories or restructuring nav

## Starting Zensical

For initial startup or after nav/config changes:

```bash
cd /path/to/project && zensical serve -a localhost:8001
```

To run in background with output capture:

```bash
nohup zensical serve -a localhost:8001 > /tmp/zensical.log 2>&1 & sleep 3 && cat /tmp/zensical.log
```

## Restarting Zensical (When Required)

Only restart when `zensical.toml` nav or config changes. Use this pattern to handle port conflicts and exit code 144 from pkill:

```bash
(pkill -f zensical || true); sleep 2; rm -rf site && nohup zensical serve -a localhost:8001 > /tmp/zensical.log 2>&1 & sleep 3 && cat /tmp/zensical.log
```

**Pattern breakdown:**
- `(pkill -f zensical || true)` - Kill existing process, ignore exit code 144
- `sleep 2` - Allow port to be released
- `rm -rf site` - Force clean build (resolves caching issues)
- `nohup ... &` - Run in background
- `sleep 3 && cat /tmp/zensical.log` - Wait and verify build output

## Anti-Patterns to Avoid

**Do NOT restart after every edit.** Trust hot reload for content changes.

**Do NOT chain pkill with &&:**
```bash
# BAD - exit code 144 breaks the chain
pkill -f zensical && zensical serve
```

**Do NOT skip the site cleanup:**
```bash
# BAD - may show stale pages
zensical serve
```

## Decision Guide

| Change Type | Action Required |
|-------------|-----------------|
| Edit markdown content | None - hot reload handles it |
| Add section to existing page | None - hot reload handles it |
| Add new page to `zensical.toml` | Restart required |
| Change nav structure | Restart required |
| Change theme settings | Restart required |

## CLI Quick Reference

| Option | Purpose |
|--------|---------|
| `-a localhost:PORT` | Set server address (default: 8000) |
| `-o` | Auto-open browser |
| `-f FILE` | Custom config file path |

## Verifying the Server

Check if zensical is running:
```bash
pgrep -f zensical
```

Check build output:
```bash
cat /tmp/zensical.log
```

View in browser: Navigate to http://localhost:8001 (or configured port)

## Troubleshooting

**"Address already in use" error:**
```bash
(pkill -f zensical || true); sleep 3; zensical serve -a localhost:8001
```

**Changes not showing (nav/config change):**
```bash
rm -rf site && zensical serve -a localhost:8001
```

**Exit code 144 from pkill:**
This is normal - it means pkill successfully terminated the process. Use `|| true` to suppress.
