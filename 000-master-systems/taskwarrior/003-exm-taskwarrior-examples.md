# Taskwarrior Command Examples

Collection of practical Taskwarrior commands organized by category for common development and operations tasks.

---

## Repository / CI-CD Tasks

```bash
# Audit GitHub Actions workflows
task add "Audit GitHub Actions workflows" project:devops tags:ci,release priority:H due:2025-10-12

# Update Docker base images
task add "Bump Docker base images to latest digests" project:devops tags:docker,security priority:M

# Changelog verification
task add "Cross-check changelog against last release" project:devops tags:release,docs priority:H

# Dependency management
task add "Lock dependency versions with Renovate" project:devops tags:dependencies priority:M

# Docker optimization
task add "Verify multi-stage Docker build cache efficiency" project:devops tags:docker,optimize
```

---

## Cloud / Infrastructure Tasks

```bash
# Cloud Run service quotas
task add "Confirm Cloud Run service quotas" project:infra tags:gcp,quotas due:2025-10-15

# Firestore index validation
task add "Check Firestore indexes match schema" project:infra tags:gcp,db priority:H

# Storage bucket security
task add "Validate Cloud Storage bucket ACLs" project:infra tags:gcp,security

# Staging environment testing
task add "Run smoke test on staging service" project:infra tags:test,staging priority:H

# Security credential rotation
task add "Rotate API keys and secrets" project:infra tags:security,keys due:2025-10-20
```

---

## Documentation / Standards Tasks

```bash
# Update project documentation
task add "Update CLAUDE.md with new directory standards" project:docs tags:standards,claude

# Template management
task add "Add PRD template to claudes-docs" project:docs tags:prd,template

# Architecture decision records
task add "Write ADR for OAuth2 token refresh" project:docs tags:adr,auth priority:H

# Task synchronization
task add "Sync claudes-docs/tasks with Taskwarrior export" project:docs tags:tasks,sync

# Standards review
task add "Review universal directory-excellence-system" project:docs tags:standards,audit
```

---

## Product / Features Tasks

```bash
# Feature development
task add "Implement soccer stats sync module" project:hustle tags:feature,soccer priority:H

# Testing and QA
task add "Test DiagnosticPro intake form" project:diagnostic-pro tags:form,testing

# Data integration
task add "Verify equipment repairability list integration" project:diagnostic-pro tags:repair,data

# Mobile testing
task add "QA Hustle PWA on mobile viewport" project:hustle tags:pwa,mobile due:2025-10-18

# Payment verification
task add "Cross-check Stripe webhook logs" project:diagnostic-pro tags:stripe,payments priority:H
```

---

## Task Management Best Practices

### Priority Levels
- `priority:H` - High priority, blocking or critical
- `priority:M` - Medium priority, important but not blocking
- `priority:L` - Low priority, nice to have

### Common Projects
- `project:devops` - DevOps and CI/CD tasks
- `project:infra` - Infrastructure and cloud operations
- `project:docs` - Documentation and standards
- `project:hustle` - Hustle product features
- `project:diagnostic-pro` - DiagnosticPro product features

### Useful Tags
- `tags:ci,release` - CI/CD and release management
- `tags:docker,security` - Docker and security related
- `tags:gcp` - Google Cloud Platform tasks
- `tags:test,staging` - Testing and staging environment
- `tags:adr,auth` - Architecture decisions and authentication
- `tags:feature` - New feature development
- `tags:mobile,pwa` - Mobile and PWA specific

### Date Management
- `due:2025-10-12` - Set a due date
- `scheduled:2025-10-10` - Schedule when to start
- `wait:2025-10-05` - Hide task until this date

---

## Quick Reference Commands

```bash
# List all tasks
task list

# List tasks by project
task project:devops list

# List high priority tasks
task priority:H list

# Mark task as complete
task <id> done

# Modify task priority
task <id> modify priority:H

# Add dependency
task <id> modify depends:<other-id>

# View task details
task <id> info

# Start working on a task
task <id> start

# Stop working on a task
task <id> stop

# Delete a task
task <id> delete

# Export tasks to JSON
task export

# Generate report
task summary
task burndown.daily
task burndown.weekly
```

---

**Created**: 2025-10-09
**Category**: Examples and Reference
**Related**: 001-tsk-mandatory-integration-protocol.md, 002-gde-complete-usage-guide.md
