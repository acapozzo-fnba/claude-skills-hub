---
name: github-cli
description: Comprehensive GitHub CLI (gh) skill for repository and project management including repos, issues, PRs, projects, actions, and common workflows
version: 1.0.0
tags: [github, git, cli, project-management, repository, issues, pull-requests, actions, workflow]
---

# GitHub CLI (gh) Project & Repository Management

## Purpose
This skill provides comprehensive guidance for using the GitHub CLI (`gh`) to manage repositories and projects. It covers repository operations, issue tracking, pull requests, GitHub Projects, Actions, and common development workflows.

## Prerequisites
- GitHub CLI installed (`gh --version` to verify)
- Authenticated with GitHub (`gh auth status` to check)
- If not authenticated: `gh auth login`

## Capabilities

### 1. Repository Management
- Create, clone, fork, and delete repositories
- View repository information and statistics
- Manage repository settings and configuration
- Archive and unarchive repositories
- Sync forks with upstream

### 2. Issue Management
- Create, list, view, and close issues
- Assign issues and add labels
- Filter and search issues
- Bulk operations on issues
- Link issues to PRs and projects

### 3. Pull Request Management
- Create PRs from branches
- Review and merge PRs
- Check PR status and CI checks
- Request reviews and handle feedback
- Manage PR labels and assignees

### 4. GitHub Projects
- Create and manage GitHub Projects (beta)
- Add items to projects
- Update project fields
- View project status

### 5. GitHub Actions
- View workflow runs and status
- Trigger workflow dispatches
- Download workflow artifacts
- View and follow logs

### 6. Common Workflows
- Fork-and-PR workflow
- Issue-driven development
- Release management
- Team collaboration patterns

## Repository Management Commands

### Creating Repositories

```bash
# Create a new repository (interactive)
gh repo create

# Create with specific options
gh repo create my-repo --public --description "My project"

# Create and clone
gh repo create my-repo --public --clone

# Create from template
gh repo create my-repo --template owner/template-repo --public

# Create with .gitignore and license
gh repo create my-repo --public --gitignore Node --license MIT
```

### Cloning and Forking

```bash
# Clone a repository
gh repo clone owner/repo

# Clone with custom directory name
gh repo clone owner/repo custom-name

# Fork a repository
gh repo fork owner/repo

# Fork and clone
gh repo fork owner/repo --clone

# Fork and add remote
gh repo fork owner/repo --remote
```

### Repository Information

```bash
# View repository details
gh repo view

# View specific repository
gh repo view owner/repo

# View in browser
gh repo view --web

# View README
gh repo view owner/repo --readme

# List repositories
gh repo list

# List organization repositories
gh repo list org-name

# List with filters
gh repo list --limit 50 --source --language python
```

### Repository Settings

```bash
# Set repository visibility
gh repo edit --visibility private
gh repo edit --visibility public

# Enable/disable features
gh repo edit --enable-issues
gh repo edit --enable-wiki
gh repo edit --enable-projects

# Update description and homepage
gh repo edit --description "New description" --homepage "https://example.com"

# Set default branch
gh repo edit --default-branch main
```

### Repository Operations

```bash
# Archive repository
gh repo archive owner/repo

# Unarchive repository
gh repo unarchive owner/repo

# Delete repository (dangerous!)
gh repo delete owner/repo --yes

# Sync fork with upstream
gh repo sync

# Rename repository
gh repo rename new-name
```

## Issue Management Commands

### Creating Issues

```bash
# Create issue interactively
gh issue create

# Create with title and body
gh issue create --title "Bug: App crashes" --body "Steps to reproduce..."

# Create with labels and assignees
gh issue create --title "Feature request" --label enhancement --assignee username

# Create from template
gh issue create --template bug_report.md

# Create and assign to project
gh issue create --title "Task" --project "Project Name"
```

### Listing and Viewing Issues

```bash
# List open issues
gh issue list

# List with filters
gh issue list --label bug --state open --limit 20

# List assigned to you
gh issue list --assignee @me

# List by author
gh issue list --author username

# List with search query
gh issue list --search "error in:title"

# View specific issue
gh issue view 123

# View in browser
gh issue view 123 --web

# View with comments
gh issue view 123 --comments
```

### Managing Issues

```bash
# Close an issue
gh issue close 123

# Close with comment
gh issue close 123 --comment "Fixed in PR #124"

# Reopen issue
gh issue reopen 123

# Edit issue
gh issue edit 123 --title "New title" --body "Updated description"

# Add labels
gh issue edit 123 --add-label bug,urgent

# Remove labels
gh issue edit 123 --remove-label wontfix

# Assign issue
gh issue edit 123 --add-assignee username

# Pin/unpin issue
gh issue pin 123
gh issue unpin 123
```

### Issue Comments

```bash
# List comments
gh issue view 123 --comments

# Add comment
gh issue comment 123 --body "This is a comment"

# Edit comment
gh issue comment 123 --edit
```

## Pull Request Management Commands

### Creating Pull Requests

```bash
# Create PR interactively
gh pr create

# Create with title and body
gh pr create --title "Fix bug" --body "Fixes #123"

# Create draft PR
gh pr create --draft

# Create with reviewers and assignees
gh pr create --reviewer user1,user2 --assignee @me

# Create with labels
gh pr create --label bug,urgent

# Create to specific base branch
gh pr create --base develop

# Create and fill from commits
gh pr create --fill

# Create and open in browser
gh pr create --web
```

### Listing and Viewing PRs

```bash
# List open PRs
gh pr list

# List with filters
gh pr list --state all --label bug --limit 20

# List assigned to you
gh pr list --assignee @me

# List authored by you
gh pr list --author @me

# View specific PR
gh pr view 456

# View in browser
gh pr view 456 --web

# View with diff
gh pr diff 456

# View checks status
gh pr checks 456

# Watch checks in real-time
gh pr checks 456 --watch
```

### Managing Pull Requests

```bash
# Checkout PR locally
gh pr checkout 456

# Edit PR
gh pr edit 456 --title "New title" --body "Updated description"

# Add reviewers
gh pr edit 456 --add-reviewer user1,user2

# Add labels
gh pr edit 456 --add-label ready-for-review

# Mark as ready (from draft)
gh pr ready 456

# Convert to draft
gh pr edit 456 --draft

# Close PR
gh pr close 456

# Close with comment
gh pr close 456 --comment "Closing in favor of #457"

# Reopen PR
gh pr reopen 456
```

### Merging Pull Requests

```bash
# Merge PR (default strategy)
gh pr merge 456

# Merge with squash
gh pr merge 456 --squash

# Merge with rebase
gh pr merge 456 --rebase

# Merge and delete branch
gh pr merge 456 --squash --delete-branch

# Auto-merge when checks pass
gh pr merge 456 --auto --squash

# Merge with custom commit message
gh pr merge 456 --squash --body "Custom merge commit message"
```

### PR Reviews

```bash
# Request review
gh pr edit 456 --add-reviewer user1,user2

# Review PR
gh pr review 456

# Approve PR
gh pr review 456 --approve

# Request changes
gh pr review 456 --request-changes --body "Please fix X"

# Comment on PR
gh pr review 456 --comment --body "Looks good overall"

# View review status
gh pr view 456 --json reviewDecision

# List reviews
gh api repos/:owner/:repo/pulls/456/reviews
```

## GitHub Projects Commands

### Working with Projects (Beta)

```bash
# List projects
gh project list

# List organization projects
gh project list --owner org-name

# View project
gh project view 123

# Create project
gh project create --title "Q4 Goals" --owner @me

# Add item to project
gh project item-add 123 --owner @me --url https://github.com/owner/repo/issues/456

# List project items
gh project item-list 123

# Edit project field
gh project item-edit --id ITEM_ID --field-id FIELD_ID --text "In Progress"

# Delete project
gh project delete 123 --owner @me
```

### Legacy Projects (Classic)

```bash
# Create project
gh api repos/:owner/:repo/projects -f name="Project Name" -f body="Description"

# List projects
gh api repos/:owner/:repo/projects

# View project columns
gh api projects/PROJECT_ID/columns
```

## GitHub Actions Commands

### Workflow Management

```bash
# List workflows
gh workflow list

# View workflow details
gh workflow view workflow-name

# Enable workflow
gh workflow enable workflow-name

# Disable workflow
gh workflow disable workflow-name

# Trigger workflow
gh workflow run workflow-name

# Trigger with inputs
gh workflow run workflow-name -f input1=value1 -f input2=value2
```

### Workflow Runs

```bash
# List workflow runs
gh run list

# List for specific workflow
gh run list --workflow=ci.yml

# List with status filter
gh run list --status failure --limit 10

# View run details
gh run view 123456

# View run in browser
gh run view 123456 --web

# View run logs
gh run view 123456 --log

# Follow logs in real-time
gh run watch 123456

# Download run artifacts
gh run download 123456

# Rerun failed jobs
gh run rerun 123456 --failed

# Rerun entire workflow
gh run rerun 123456

# Cancel run
gh run cancel 123456

# Delete run
gh run delete 123456
```

## Common Workflows

### Workflow 1: Fork-and-PR Development

```bash
# 1. Fork the repository
gh repo fork original-owner/repo --clone

# 2. Create a feature branch
cd repo
git checkout -b feature/my-feature

# 3. Make changes and commit
git add .
git commit -m "Add new feature"

# 4. Push to your fork
git push origin feature/my-feature

# 5. Create pull request
gh pr create --fill --web

# 6. Address review feedback
git add .
git commit -m "Address review comments"
git push

# 7. Sync with upstream
gh repo sync
```

### Workflow 2: Issue-Driven Development

```bash
# 1. Create issue
gh issue create --title "Add user authentication" --label enhancement

# 2. Assign to yourself and add to project
gh issue edit 789 --add-assignee @me --project "Sprint 1"

# 3. Create branch from issue
git checkout -b issue-789-user-auth

# 4. Develop and commit
git add .
git commit -m "Implement user authentication\n\nCloses #789"

# 5. Push and create PR that references issue
git push origin issue-789-user-auth
gh pr create --title "Implement user authentication" --body "Closes #789"

# 6. Merge PR (closes issue automatically)
gh pr merge --squash --delete-branch
```

### Workflow 3: Quick Bug Fix

```bash
# 1. Create issue for bug
gh issue create --title "Fix login error" --label bug --priority high

# 2. Create branch and fix
git checkout -b fix/login-error
# ... make changes ...
git commit -am "Fix login error handling"

# 3. Push and create PR
git push origin fix/login-error
gh pr create --fill

# 4. Watch CI checks
gh pr checks --watch

# 5. Once approved, merge
gh pr merge --squash --delete-branch
```

### Workflow 4: Release Management

```bash
# 1. Check if ready for release
gh pr list --label ready-for-release

# 2. Create release PR
gh pr create --title "Release v2.0.0" --base main --head develop

# 3. Merge release PR
gh pr merge --merge

# 4. Create and push tag
git tag v2.0.0
git push origin v2.0.0

# 5. Create GitHub release
gh release create v2.0.0 --title "Version 2.0.0" --notes "Release notes here"

# 6. Upload release assets
gh release upload v2.0.0 dist/*
```

### Workflow 5: Team Collaboration

```bash
# Morning standup - check team activity
gh pr list --assignee team-member
gh issue list --assignee @me

# Review pending PRs
gh pr list --review-requested @me
gh pr view 123 --comments

# Approve teammate's PR
gh pr review 123 --approve --body "LGTM! Great work."

# Help with teammate's issue
gh issue comment 456 --body "I can help with this. Assigning to myself."
gh issue edit 456 --add-assignee @me
```

## Advanced Usage

### Using GitHub API with gh

```bash
# Get repository information
gh api repos/:owner/:repo

# List repository collaborators
gh api repos/:owner/:repo/collaborators

# Get issue comments
gh api repos/:owner/:repo/issues/123/comments

# Create a comment via API
gh api repos/:owner/:repo/issues/123/comments -f body="Comment via API"

# Use JQ to process JSON
gh api repos/:owner/:repo/issues --jq '.[].title'

# Paginate results
gh api repos/:owner/:repo/issues --paginate
```

### Bulk Operations

```bash
# Close multiple stale issues
gh issue list --label stale --limit 100 --json number --jq '.[].number' | \
  xargs -I {} gh issue close {} --comment "Closing stale issue"

# Add label to all open PRs
gh pr list --json number --jq '.[].number' | \
  xargs -I {} gh pr edit {} --add-label needs-review

# List all failing CI runs
gh run list --status failure --json databaseId --jq '.[].databaseId' | \
  xargs -I {} gh run view {}
```

### Aliases and Shortcuts

```bash
# Set up useful aliases
gh alias set prc 'pr create --fill'
gh alias set prs 'pr status'
gh alias set issues-me 'issue list --assignee @me'
gh alias set prs-me 'pr list --assignee @me'

# Use aliases
gh prc
gh prs
gh issues-me
```

## Best Practices

### 1. Repository Management
- Use descriptive repository names and descriptions
- Set up branch protection rules through GitHub web UI
- Archive repositories instead of deleting when possible
- Keep forks synced regularly with `gh repo sync`

### 2. Issue Management
- Use templates for consistent issue reporting
- Apply labels consistently for easier filtering
- Link issues to PRs with "Closes #123" in PR description
- Keep issues focused on single problems/features

### 3. Pull Request Management
- Create draft PRs for work-in-progress
- Request specific reviewers who know the code area
- Use descriptive PR titles that explain the change
- Include issue references in PR descriptions
- Keep PRs focused and reasonably sized
- Respond to review comments promptly

### 4. Workflow Automation
- Use GitHub Actions for CI/CD
- Set up auto-merge for low-risk PRs
- Use issue and PR templates
- Configure branch protection rules

### 5. Team Collaboration
- Check `gh pr list --review-requested @me` daily
- Use `gh pr checks --watch` to monitor CI
- Comment on issues/PRs to keep team informed
- Use projects to track work across repositories

## Troubleshooting

### Authentication Issues
```bash
# Check auth status
gh auth status

# Re-authenticate
gh auth login

# Use different account
gh auth login --hostname github.com

# Set default account
gh auth switch
```

### Common Errors

**"Not found" errors:**
```bash
# Ensure you're authenticated
gh auth status

# Check you have access to repository
gh repo view owner/repo
```

**"Refusing to merge" errors:**
```bash
# Check PR status and required checks
gh pr checks

# View merge requirements
gh pr view --json mergeStateStatus
```

**API rate limiting:**
```bash
# Check rate limit status
gh api rate_limit

# Use authenticated requests (automatic with gh auth)
```

## Integration with Claude Skills

When using this skill with Claude:

1. **Context Awareness**: Provide repository context if working in a git directory
2. **Error Handling**: Share full error messages for better troubleshooting
3. **Batch Operations**: Describe bulk operations needed and Claude can script them
4. **Workflow Guidance**: Ask for complete workflows, not just individual commands
5. **Configuration**: Share relevant gh configuration with `gh config list`

## Examples

### Example 1: Start New Feature
```bash
# Create issue first
gh issue create --title "Add dark mode" --label enhancement --assignee @me

# Create branch
git checkout -b feature/dark-mode

# After development
git push origin feature/dark-mode
gh pr create --title "Add dark mode" --body "Closes #123" --draft

# Mark ready when done
gh pr ready
```

### Example 2: Review and Merge PR
```bash
# Check out the PR to test locally
gh pr checkout 456

# Run tests
npm test

# If good, approve and merge
gh pr review 456 --approve --body "Tested locally, works great!"
gh pr merge 456 --squash --delete-branch
```

### Example 3: Check Project Status
```bash
# View all your work
gh issue list --assignee @me
gh pr list --author @me

# Check PRs waiting for your review
gh pr list --review-requested @me

# Check CI status across PRs
gh pr list --json number,title,statusCheckRollup
```

## Reference

### Key Commands Quick Reference
```bash
# Repository
gh repo create, clone, fork, view, edit, list

# Issues
gh issue create, list, view, edit, close, comment

# Pull Requests
gh pr create, list, view, checkout, merge, review, checks

# Projects
gh project list, view, create, item-add

# Actions
gh workflow list, run, view
gh run list, view, watch, download, rerun

# API
gh api <endpoint>

# Help
gh help, gh <command> --help
```

### Useful Flags
- `--web`: Open in browser
- `--json`: Output as JSON
- `--jq`: Process JSON with jq
- `--limit N`: Limit results
- `--state all|open|closed`: Filter by state
- `--label LABEL`: Filter by label
- `--assignee USER`: Filter by assignee
- `--author USER`: Filter by author

## Notes

- Always check authentication with `gh auth status` if commands fail
- Use `--help` flag for detailed command documentation
- Most commands work without arguments in interactive mode
- Tab completion is available in most shells
- Combine with standard git commands for complete version control
- Use `gh alias` to create shortcuts for frequent operations

This skill provides comprehensive GitHub CLI capabilities for efficient project and repository management within Claude Code workflows.
