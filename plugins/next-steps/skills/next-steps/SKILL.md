---
name: next-steps
description: Collaborative task tracking with local next_steps.md files for project planning and progress tracking
version: 1.0.0
tags: [task-management, planning, checklist, collaboration, project-tracking]
---

# Next Steps - Collaborative Task Tracking

## Purpose

This skill manages local `next_steps.md` files as collaborative documents between Claude Code and the user. It provides structured task tracking while maintaining a conversational approach that eliminates assumptions.

**Key Principles:**
- Local-only tracking (always gitignored)
- Collaborative - both Claude and user contribute
- Conversational - ask before assuming
- Flexible structure - adapts to each project

## When to Use This Skill

Load this skill when:
- Creating a new branch with requirements or specifications
- Discussing task management or project planning
- Translating proposals, specs, or tickets into actionable work
- Planning multi-phase implementations
- Tracking progress across multiple sessions
- User mentions "next steps", "roadmap", or "checklist"

## Core Behaviors

### 1. Always Ask Before Creating
Never auto-create `next_steps.md`. Always confirm with the user first:
- "Would you like me to create a next_steps.md to track this work?"
- "I can set up a checklist for this project. Want me to proceed?"

### 2. Verify Gitignore Before Commits
Before any git commit operation:
1. Check if `.gitignore` exists in the repository root
2. Verify `next_steps.md` is listed
3. If missing, ask user for permission to add it
4. Never commit `next_steps.md` to the repository

### 3. Flexible Phase Structure
Adapt phases based on the specific task. Do not enforce a rigid template. Examples:
- Infrastructure work: Prerequisites, Configuration, Deployment, Validation
- Feature development: Research, Implementation, Testing, Documentation
- Bug fixes: Investigation, Fix, Verification
- Multi-repo changes: Repo A Changes, Repo B Changes, Integration, Validation

### 4. Optional Success Conditions
Only include a "Success Conditions" section when:
- User explicitly provides deliverables
- The work has clear, measurable outcomes
- Multiple repositories or systems are affected

### 5. Conversational Approach
Before creating or modifying the file:
- Ask clarifying questions about scope
- Confirm phase names and structure
- Validate understanding of deliverables
- Check before making major modifications

## File Format

### Standard Template
```markdown
# [Ticket/Feature]: Brief Description

## Reference (optional)
- [Documentation Link](url)
- [Related Ticket](url)

## Success Conditions (optional)
- [ ] Deliverable 1
- [ ] Deliverable 2

---

## Phase 1: [Phase Name]
- [ ] Task 1
- [ ] Task 2

## Phase 2: [Phase Name]
- [ ] Task 1
- [ ] Task 2
```

### Minimal Template (for simple tasks)
```markdown
# [Brief Description]

## Tasks
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3
```

### Multi-Repo Template
```markdown
# [Ticket]: Feature Name

## Success Conditions
- [ ] repo_a updated
- [ ] repo_b updated
- [ ] Integration tested

---

## Phase 1: Repo A Changes
- [ ] Task 1
- [ ] Task 2

## Phase 2: Repo B Changes
- [ ] Task 1
- [ ] Task 2

## Phase 3: Validation
- [ ] End-to-end test
- [ ] Documentation update
```

## Workflows

### Creating a New next_steps.md

1. **Detect opportunity** - User mentions requirements, specs, or multi-step work
2. **Ask for confirmation** - "Would you like me to create a next_steps.md for this?"
3. **Gather requirements** - Ask clarifying questions about scope and deliverables
4. **Propose structure** - Suggest phases based on the work type
5. **Verify gitignore** - Ensure file won't be committed
6. **Create file** - Write the initial structure
7. **Confirm with user** - "Here's the initial structure. Want me to adjust anything?"

### Updating Progress

When work is completed:
1. Read the current `next_steps.md`
2. Mark completed tasks with `[x]`
3. Add any new tasks discovered during implementation
4. Notify user of progress: "Marked Phase 1 tasks complete. Moving to Phase 2."

### Adding New Phases

When scope changes mid-project:
1. **Ask first** - "The scope has expanded. Should I add a new phase for [topic]?"
2. **Get details** - Clarify what tasks belong in the new phase
3. **Update file** - Add the new phase in logical order
4. **Confirm** - "Added Phase X. Does this look right?"

### Modifying Existing Phases

When tasks need adjustment:
1. **Explain the change** - "Based on what we learned, I think we should..."
2. **Get approval** - Wait for user confirmation
3. **Make changes** - Update the file
4. **Summarize** - "Updated Phase 2 with the revised tasks."

## Gitignore Management

### Checking Gitignore
```bash
# Check if next_steps.md is ignored
grep -q "next_steps.md" .gitignore && echo "Already ignored" || echo "Not ignored"
```

### Adding to Gitignore
Before adding, always ask:
- "I need to add next_steps.md to .gitignore to keep it local. Is that okay?"

Then append to `.gitignore`:
```
next_steps.md
```

### Pre-Commit Verification
Before any commit operation:
1. Check if `next_steps.md` exists in the repo
2. Verify it's in `.gitignore`
3. If not ignored, warn the user and offer to fix

## Conversational Guidelines

### Questions to Ask When Creating
- "What's the main goal of this work?"
- "Are there specific deliverables or success criteria?"
- "How many phases do you see this taking?"
- "Are there dependencies on other systems or repos?"
- "Any reference documentation I should link?"

### Questions to Ask When Updating
- "Should I mark [task] as complete?"
- "I noticed [new requirement]. Should I add it to the list?"
- "This phase seems done. Ready to move to the next one?"

### Questions to Ask When Modifying
- "The scope has changed. Should I restructure the phases?"
- "Should I add a new phase for [topic]?"
- "Some tasks are no longer relevant. Should I remove them?"

## Examples

### Example 1: New Feature Branch with Spec

**User:** "Create a branch called feature/OPS-1234. Here's the spec: We need to add RingCX whitelisting to our firewalls and split tunnel the domains in Cloudflare."

**Claude:** "I'll create the branch. Would you like me to set up a next_steps.md to track this work? Based on the spec, I'm thinking:

- Phase 1: Documentation review (extract IPs/domains)
- Phase 2: EDL file creation
- Phase 3: Firewall configuration
- Phase 4: Cloudflare split tunnel
- Phase 5: Validation

Does this structure work, or would you like different phases?"

### Example 2: Updating Progress

**User:** "The EDL files are deployed."

**Claude:** *Updates next_steps.md*

"Marked Phase 2 complete:
- [x] Create IP EDL file
- [x] Create domain EDL file
- [x] Deploy via operations playbook

Moving to Phase 3: Firewall Configuration. Ready to proceed?"

### Example 3: Scope Change Mid-Project

**User:** "Actually, we also need to update the DNS records."

**Claude:** "Got it. Should I add a new phase for DNS updates? I'm thinking it should go between the current Phase 3 and Phase 4 since it's related to network configuration.

Proposed new phase:
## Phase 4: DNS Configuration
- [ ] Identify required DNS records
- [ ] Update DNS zone files
- [ ] Verify propagation

This would push Cloudflare to Phase 5 and Validation to Phase 6. Does that work?"

### Example 4: Simple Task (Minimal Template)

**User:** "Help me fix the login bug reported in ticket BUG-567"

**Claude:** "Want me to create a quick next_steps.md for this? Something simple like:

# BUG-567: Login Bug Fix

## Tasks
- [ ] Reproduce the issue
- [ ] Identify root cause
- [ ] Implement fix
- [ ] Test fix
- [ ] Create PR

Or is this small enough to just work through without tracking?"

## Integration Notes

### With Git Workflows
- Always verify gitignore before `/git-commit`
- Reference ticket numbers in the file header
- Keep file updated as branches progress

### With Other Skills
- Can be combined with `github-cli` skill for PR creation
- Reference documentation gathered by other skills in the Reference section

### Session Continuity
- The file persists between sessions
- On session start, offer to review current progress
- "I see there's an existing next_steps.md. Want me to summarize where we left off?"

## Best Practices

1. **Keep it current** - Update checkboxes immediately after completing tasks
2. **Stay high-level** - Phases should be broad; details emerge during work
3. **Be conversational** - Always confirm before major changes
4. **Link references** - Include relevant documentation URLs
5. **Track blockers** - Add notes about blockers or dependencies discovered
6. **Clean up** - Remove or archive completed files when work is done

## Troubleshooting

### File Accidentally Committed
```bash
# Remove from git but keep local file
git rm --cached next_steps.md
git commit -m "Remove next_steps.md from tracking"
# Then add to .gitignore
```

### File Not Found
If `next_steps.md` doesn't exist but should:
- Ask user if they want to recreate it
- Offer to pull context from git branch name or recent commits

### Merge Conflicts
Since this is local-only, merge conflicts shouldn't occur. If the file somehow gets into a conflict state:
- Back up current version
- Take the version that reflects actual progress
- Reconcile manually if needed
