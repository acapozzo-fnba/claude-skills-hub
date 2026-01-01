---
name: playwright
description: Install and configure the Playwright MCP server for browser automation, testing, and web scraping capabilities
version: 1.0.0
tags: [playwright, mcp, browser-automation, testing, web-scraping, headless, chromium]
---

# Playwright MCP Server Installation Skill

## Purpose

This skill installs the Playwright MCP (Model Context Protocol) server, enabling Claude to automate browser interactions, perform web testing, and scrape web content directly through natural language commands.

## When to Use This Skill

Load this skill when:
- Setting up browser automation capabilities in a project
- Need to interact with web pages programmatically
- Setting up end-to-end testing with Playwright
- Configuring web scraping capabilities
- User asks to "install playwright" or "add browser automation"

## Prerequisites

- **Node.js 18 or newer** - Required for npx execution
- **Claude Code CLI** - For MCP server management

## Installation

### Quick Install (Recommended)

Run this command to add the Playwright MCP server:

```bash
claude mcp add playwright -- npx @playwright/mcp@latest
```

This registers the MCP server with Claude Code and makes browser automation tools available.

### Verify Installation

```bash
claude mcp list
```

You should see `playwright` in the list of configured MCP servers.

## Configuration Options

The Playwright MCP server supports various command-line arguments:

### Browser Selection
```bash
# Use specific browser (default: chromium)
claude mcp add playwright -- npx @playwright/mcp@latest --browser chrome
claude mcp add playwright -- npx @playwright/mcp@latest --browser firefox
claude mcp add playwright -- npx @playwright/mcp@latest --browser webkit
claude mcp add playwright -- npx @playwright/mcp@latest --browser msedge
```

### Display Mode
```bash
# Run headless (no visible browser window)
claude mcp add playwright -- npx @playwright/mcp@latest --headless

# Default is headed (visible browser)
```

### Viewport Configuration
```bash
# Set custom viewport size
claude mcp add playwright -- npx @playwright/mcp@latest --viewport-size 1920x1080
```

### Profile Management
```bash
# Use persistent profile (stores cookies, login state)
claude mcp add playwright -- npx @playwright/mcp@latest --user-data-dir /path/to/profile

# Use isolated profile (fresh session each time)
claude mcp add playwright -- npx @playwright/mcp@latest --isolated
```

### Timeouts
```bash
# Set action timeout in milliseconds (default: 5000)
claude mcp add playwright -- npx @playwright/mcp@latest --timeout-action 10000
```

### Video Recording
```bash
# Record session video
claude mcp add playwright -- npx @playwright/mcp@latest --save-video 1280x720
```

## Advanced Configuration

For complex setups, create a JSON configuration file:

```json
{
  "browser": {
    "browserName": "chromium",
    "isolated": false,
    "userDataDir": "/path/to/profile",
    "launchOptions": {
      "slowMo": 100
    },
    "contextOptions": {
      "ignoreHTTPSErrors": true
    }
  },
  "server": {
    "port": 3000,
    "host": "localhost"
  },
  "capabilities": ["core", "pdf", "vision"],
  "timeouts": {
    "action": 5000,
    "navigation": 60000
  }
}
```

Then install with config:
```bash
claude mcp add playwright -- npx @playwright/mcp@latest --config /path/to/playwright-config.json
```

## Capabilities

Once installed, Claude gains access to browser automation tools:

| Capability | Description |
|------------|-------------|
| **Navigation** | Open URLs, go back/forward, refresh |
| **Interaction** | Click, type, select, hover, drag |
| **Extraction** | Get text, attributes, screenshots |
| **Forms** | Fill forms, submit, upload files |
| **Waiting** | Wait for elements, navigation, network |
| **PDF** | Generate PDFs from pages |
| **Vision** | Visual analysis of page content |

## Usage Examples

After installation, you can ask Claude to:

- "Open https://example.com and take a screenshot"
- "Fill out the login form with test credentials"
- "Extract all product prices from this page"
- "Click the 'Submit' button and wait for the response"
- "Navigate through a multi-step checkout flow"

## Removing the MCP Server

```bash
claude mcp remove playwright
```

## Troubleshooting

### Node.js Version Too Old
```bash
# Check Node version
node --version

# Should be 18.x or higher
# Update via nvm if needed:
nvm install 18
nvm use 18
```

### MCP Server Not Starting
```bash
# Test npx directly
npx @playwright/mcp@latest --help

# If it fails, clear npm cache
npm cache clean --force
```

### Browser Not Found
```bash
# Install Playwright browsers
npx playwright install chromium
npx playwright install firefox
npx playwright install webkit
```

### Permission Denied
```bash
# On Linux/WSL, may need to install dependencies
npx playwright install-deps
```

### Headless Mode Required (Server/CI)
```bash
# Force headless for environments without display
claude mcp add playwright -- npx @playwright/mcp@latest --headless
```

## Best Practices

1. **Use headless mode** for CI/CD and server environments
2. **Set reasonable timeouts** for slow-loading pages
3. **Use isolated mode** when you don't need persistent login state
4. **Enable video recording** for debugging complex flows
5. **Configure viewport** to match your target device

## Integration Notes

- The MCP server runs as a subprocess managed by Claude Code
- Browser state persists within a session unless using `--isolated`
- Multiple Claude sessions can share the same MCP server configuration
- Server starts on-demand when browser tools are invoked
