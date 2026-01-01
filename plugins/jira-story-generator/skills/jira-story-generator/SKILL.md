---
name: jira-story-generator
description: Generates well-structured Jira user stories from problem descriptions, including user story format, acceptance criteria, technical details, and story point estimates. Perfect for converting investigation findings into actionable backlog items.
---

# Jira Story Generator

This skill transforms problem descriptions, investigation findings, or feature requests into well-structured Jira user stories ready for your backlog.

## When to Use This Skill

- Converting investigation findings into actionable tasks
- Creating user stories from bug reports
- Generating backlog items from technical debt discoveries
- Writing stories for new feature requests
- Creating tasks from post-incident reviews
- Documenting improvement opportunities as stories

## What This Skill Produces

Each user story includes:

1. **Title**: Clear, concise story title
2. **Story Points**: Fibonacci estimate (1, 2, 3, 5, 8, 13)
3. **User Story Format**: "As a... I want... so that..."
4. **Background/Context**: Why this story exists
5. **Acceptance Criteria**: Checkboxes for completion
6. **Technical Details**: Implementation notes, file paths, code references
7. **Definition of Done**: Final checklist for story completion

## How to Use

### Single Story

```
Create a Jira story for: [describe the problem or feature]
```

### Multiple Stories from Investigation

```
Create Jira stories for each problem found in this investigation:
[paste findings or describe issues]
```

### With Specific Context

```
Create a user story for fixing the authentication timeout issue.
The bug affects login on mobile devices and we traced it to session handling.
```

## Story Point Guidelines

| Points | Complexity | Example |
|--------|------------|---------|
| 1 | Trivial | Config change, typo fix |
| 2 | Simple | Investigation, small bug fix |
| 3 | Medium | Config + testing, documentation |
| 5 | Complex | Code changes + testing, new script |
| 8 | Large | Multi-file changes, new feature |
| 13 | Epic-level | Architecture change, major feature |

## Example

**User**: "Create a story for: LAPS authentication is failing for appserver1 host during automated patching"

**Output**:

```markdown
# Fix LAPS Authentication Failure for appserver1

**Story Points:** 3

## User Story

**As a** SRE team member,
**I want** the LAPS authentication to work correctly for appserver1,
**so that** the host can be patched via automation.

## Background

During the December patch deployment, appserver1 failed with
STATUS_LOGON_FAILURE (0xc000006d). The LAPS password retrieval
returned a stale or incorrect password.

## Acceptance Criteria

- [ ] Root cause of LAPS failure identified
- [ ] LAPS password rotation verified on host
- [ ] Successful Ansible connection test to host
- [ ] Host successfully patched

## Technical Details

- **Error:** STATUS_LOGON_FAILURE 0xc000006d
- **Host:** appserver1.example.com
- **Module:** win_updates via CredSSP

## Definition of Done

- [ ] Host successfully authenticates via LAPS
- [ ] Host patched with latest CU
- [ ] Root cause documented
```

## Output Format Options

### Markdown File (Default)

Creates a `.md` file ready for copy-paste into Jira or attaching to an Epic.

### Multiple Files

When generating multiple stories, creates one file per story with naming convention:
`[EPIC-ID]-story-[short-description].md`

## Tips

- Provide context about the system/environment for better stories
- Mention related files or code paths for technical details
- Specify the Epic ID if stories should reference a parent
- Include any error messages or log snippets
- Mention team conventions for story format if different from default

## Customization

You can request modifications to the default format:

```
Create a Jira story for [issue] with:
- No story points (PM will estimate)
- Include "How to Test" section
- Add "Dependencies" section
```

## Related Use Cases

- Sprint planning preparation
- Technical debt backlog creation
- Post-incident action item generation
- Feature breakdown into stories
- Bug triage documentation
