---
name: implementation-plan
description: This skill should be used when the user asks to "create an implementation plan", "write a Jira summary", "summarize this work for documentation", "generate PR comments", "create release notes", "document these changes", or needs to consolidate completed work across multiple repositories into a structured document for project management tools.
version: 1.0.0
tags: [jira, documentation, implementation, pr-summary, release-notes, github, summarize-work, project-planning, technical-writing, change-management]
---

# Implementation Plan Generator

Generate structured implementation plans and documentation from completed or planned work. Transform technical changes into clear, stakeholder-friendly documents suitable for Jira tickets, PR descriptions, release notes, and project documentation.

## When to Use This Skill

- Consolidating changes across multiple repositories into a single document
- Creating Jira ticket descriptions with implementation details
- Writing comprehensive PR descriptions with context
- Generating release notes for completed features
- Documenting infrastructure or configuration changes
- Summarizing work for handoff or review
- Creating change management documentation

## Output Format Guidelines

### Document Structure

Implementation plans follow a consistent structure optimized for scanning:

```markdown
# [Ticket ID]: [Brief Title]

## Release Timeline (if applicable)
Target release date and any scheduling considerations.

---

## Summary
2-3 sentences explaining the change at a high level.

## Problem Statement
Bulleted list explaining why this change is needed.

## Solution
Brief description of the approach taken.

---

## [Details Section - varies by type]
Tables, host lists, configuration changes, etc.

---

## Implementation Details

### Repository 1: [repo-name]
**PR:** [link]
**File Modified:** `path/to/file`
**Change:** Description of what changed
**Effect:** What this accomplishes

### Repository 2: [repo-name]
[Same structure]

---

## Deployment Steps
Numbered list of steps to deploy the changes.
```

### Key Principles

1. **Lead with context** - Start with timeline and summary before details
2. **Use tables for data** - Host lists, configurations, and mappings work well as tables
3. **Separate repositories clearly** - Each repo gets its own section with PR links
4. **Include effects** - Explain what each change accomplishes, not just what it does
5. **End with deployment** - Concrete steps to ship the changes

## Section Templates

### Problem Statement
```markdown
## Problem Statement

These [items/hosts/configurations] have [issue]:
- [Specific problem 1]
- [Specific problem 2]
- [Current state that needs to change]
```

### Solution
```markdown
## Solution

[Approach taken] via [method]. This:
- [Benefit 1]
- [Benefit 2]
- [Expected outcome]
```

### Host/Item Tables
```markdown
## [Items] Included ([count])

| Name | Identifier | Category |
|------|------------|----------|
| item1 | id-001 | Type A |
| item2 | id-002 | Type B |
```

### Multi-Repository Changes
```markdown
## Implementation Details

### Repository 1: [repo-name]

**PR:** [URL]
**File Modified:** `path/to/file.yml`
**Change:** [What was modified]
**Effect:**
- [Result 1]
- [Result 2]
```

### Schedule/Impact Section
```markdown
## Schedule Impact

| Setting | Value |
|---------|-------|
| Schedule | [When] |
| Frequency | [How often] |
| Dependencies | [Related systems] |
```

## Multi-Repository Handling

When changes span multiple repositories:

1. **Identify relationships** - Note which repo handles what aspect
2. **Create companion PRs** - Reference related PRs in each description
3. **Document order** - Specify if merge order matters
4. **Cross-reference** - Link PRs to each other in the documentation

Example cross-reference:
```markdown
## Related Changes

- **[other-repo]**: Companion PR adds [related functionality]
  PR: [link]
```

## Common Workflows

### Workflow 1: Jira Implementation Plan

1. Gather context from completed PRs and commits
2. Identify all repositories and files changed
3. Structure document with Summary, Problem, Solution sections
4. Create tables for any list-based data
5. Document each repository's changes
6. Add deployment steps
7. Output as markdown for Jira

### Workflow 2: PR Description

1. Analyze the diff and commit messages
2. Write concise summary (2-3 sentences)
3. Explain problem being solved
4. Detail the solution approach
5. List files changed with brief explanations
6. Add any testing notes or caveats

### Workflow 3: Release Notes

1. Collect all PRs/commits for the release
2. Group changes by category (features, fixes, infrastructure)
3. Write user-facing descriptions (avoid internal jargon)
4. Note any breaking changes or migration steps
5. Include timeline and version information

## Best Practices

- **Be specific** - Use exact file paths, host names, and configuration values
- **Explain the "why"** - Stakeholders need context, not just technical details
- **Use consistent formatting** - Tables for data, bullets for lists, headers for sections
- **Include links** - PR URLs, documentation references, related tickets
- **Consider the audience** - Jira tickets may need less technical depth than PR descriptions
- **Note dependencies** - What must happen before or after this change

## Additional Resources

### Reference Files

For detailed examples of implementation plans:
- **`references/template-examples.md`** - Complete real-world examples

## Quick Reference

| Document Type | Key Sections | Audience |
|---------------|--------------|----------|
| Jira Ticket | Summary, Problem, Solution, Deployment | PM, Stakeholders |
| PR Description | Summary, Problem, Solution, Files Changed | Developers |
| Release Notes | Features, Fixes, Breaking Changes | End Users |
| Change Doc | Timeline, Impact, Rollback Plan | Operations |
