# Implementation Plan Examples

This reference contains complete real-world examples of implementation plans for various scenarios.

---

## Example 1: Multi-Repository Infrastructure Change

This example shows a Jira-ready implementation plan for adding hosts to WSUS coverage across two repositories.

```markdown
# OPS-1234: Add 192.168.1.x Hosts to Production WSUS Coverage

## Release Timeline

**Target Release: January 2025**

Delaying release until after the holiday season to avoid introducing changes during the December change freeze period.

---

## Summary

Add 8 hosts with dev/int naming prefixes that reside in the 192.168.1.x production subnet to Production WSUS coverage. These hosts will be assigned to Ring 3 (Saturday schedule) via static group assignments.

## Problem Statement

These hosts have dev/int naming conventions but:
- Reside in production IP space (192.168.1.x)
- Are domain-joined to example.com (Production AD)
- Dev WSUS only filters for 10.10.x subnet - cannot discover these hosts
- Were not receiving any WSUS management

## Solution

Add all 8 hosts to Production WSUS Group 5 (Ring 3) as static assignments across two repositories:

| Repository | Change | Purpose |
|------------|--------|---------|
| ansible-wsus | Add to `wsus_static_groups` Group 5 | WSUS server-side group membership |
| server-hardening | Add to `wsus_pilot` group | WSUS client registry configuration |

---

## Hosts Included (8)

| Host | IP Address | Category |
|------|------------|----------|
| devserver1.example.com | 192.168.1.100 | Dev Workstation |
| devserver2.example.com | 192.168.1.101 | Dev Workstation |
| intsqlserver1.example.com | 192.168.1.107 | SQL Server |
| intsqlserver2.example.com | 192.168.1.108 | SQL Server |
| devapps1.example.com | 192.168.1.151 | Application Server |
| devapps2.example.com | 192.168.1.152 | Application Server |
| intwarehouse1.example.com | 192.168.1.158 | Data Warehouse |
| intwarehouse2.example.com | 192.168.1.159 | Data Warehouse |

---

## Implementation Details

### Repository 1: ansible-wsus

**PR:** https://github.com/org/ansible-wsus/pull/1

**File Modified:** `master/group_vars/all.yml`

**Change:** Add 8 hosts to `wsus_static_groups` under "Update Group 5"

**Effect:**
- Hosts assigned to WSUS Group 5 on wsus.example.com
- Excluded from dynamic LDAP discovery (static assignment takes precedence)
- Updates approved based on 4-day threshold from Patch Tuesday
- Installation triggered by Ring 3 Saturday workflow

### Repository 2: server-hardening

**PR:** https://github.com/org/server-hardening/pull/2

**File Modified:** `master/hosts.yml`

**Change:** Add 8 hosts to `wsus_pilot` group

**Effect:**
- WSUS client registry settings configured to point to `wsus.example.com:8531`
- Configuration applied via `win_server_security` role during hardening runs
- Hosts receive settings from `master/group_vars/wsus_pilot.yml`

---

## Deployment Steps

1. Merge ansible-wsus PR #1
2. Merge server-hardening PR #2
3. Run group sorting workflow (daily at 3:00 PM EST) - hosts will appear in WSUS Group 5
4. Run hardening workflow on 192.168.x zone - hosts will receive WSUS client config
5. Verify hosts appear in WSUS Console under "Update Group 5"
6. First updates will be approved/installed on the next Ring 3 Saturday cycle
```

---

## Example 2: Feature Implementation PR Description

This example shows a PR description for a new feature.

```markdown
## Summary

Add dark mode toggle to the application settings page with system preference detection and persistent user choice.

## Problem

Users have requested dark mode support for:
- Reduced eye strain during extended use
- Better accessibility for light-sensitive users
- Consistency with OS-level dark mode settings

## Solution

Implement a three-state toggle (Light/Dark/System) in Settings with:
- CSS custom properties for theme colors
- localStorage persistence for user preference
- `prefers-color-scheme` media query detection for System mode
- Smooth transitions between themes

## Files Changed

| File | Change |
|------|--------|
| `src/components/Settings.tsx` | Add theme toggle component |
| `src/contexts/ThemeContext.tsx` | New context for theme state management |
| `src/styles/themes.css` | CSS custom properties for light/dark themes |
| `src/hooks/useTheme.ts` | Hook for theme detection and persistence |
| `src/App.tsx` | Wrap app in ThemeProvider |

## Related Changes

- **design-system**: Updated component library with dark mode variants (PR #156)
```

---

## Example 3: Release Notes

This example shows release notes for a version update.

```markdown
# Release Notes - v2.4.0

**Release Date:** January 15, 2025

## New Features

### Dark Mode Support
Users can now choose between Light, Dark, or System theme in Settings. The System option automatically matches your OS preference.

### Export to PDF
Reports can now be exported directly to PDF format from the Reports page. Includes customizable headers and page layouts.

## Improvements

- **Performance:** Dashboard load time reduced by 40% through lazy loading
- **Search:** Full-text search now includes archived items
- **Mobile:** Improved touch targets for better mobile usability

## Bug Fixes

- Fixed issue where notifications would not clear after being read
- Resolved timezone display bug in scheduled reports
- Fixed CSV export encoding for special characters

## Breaking Changes

### API v1 Deprecation
API v1 endpoints are now deprecated and will be removed in v3.0. Please migrate to API v2. See [Migration Guide](link).

## Upgrade Notes

1. Clear browser cache after update for theme changes
2. Re-authenticate if using SSO (token format updated)
3. Review notification settings (new granular options available)
```

---

## Example 4: Change Management Document

This example shows a formal change management document.

```markdown
# Change Request: Database Migration to PostgreSQL 15

## Change Overview

| Field | Value |
|-------|-------|
| Change ID | CHG-2025-0042 |
| Requested By | Database Team |
| Target Date | January 20, 2025 02:00 EST |
| Duration | 4 hours |
| Impact | Medium - Read-only mode during migration |

## Business Justification

PostgreSQL 15 provides:
- 25% improvement in sort operations
- Enhanced JSON path queries for reporting
- Required security patches (CVE-2024-XXXX)

## Technical Details

### Pre-Migration
1. Full backup of production database
2. Verify replica sync status
3. Enable maintenance mode (read-only)

### Migration Steps
1. Stop application servers
2. Perform pg_upgrade from 14 to 15
3. Run ANALYZE on all tables
4. Validate data integrity checksums
5. Restart application servers
6. Disable maintenance mode

### Rollback Plan
1. Stop application servers
2. Restore from pre-migration backup
3. Point connection strings to backup
4. Restart application servers

## Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Data corruption | Low | High | Checksums, tested backup restore |
| Extended downtime | Medium | Medium | Parallel environment ready |
| Application incompatibility | Low | Low | Tested in staging |

## Approval

- [ ] Database Team Lead
- [ ] Infrastructure Manager
- [ ] Change Advisory Board
```

---

## Template Selection Guide

| Scenario | Use Template | Key Sections |
|----------|--------------|--------------|
| Jira ticket for infra work | Example 1 | Timeline, Problem, Solution, Hosts, Deployment |
| PR for new feature | Example 2 | Summary, Problem, Solution, Files Changed |
| Version release | Example 3 | Features, Improvements, Fixes, Breaking Changes |
| Formal change request | Example 4 | Overview, Justification, Steps, Rollback, Risk |
