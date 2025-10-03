# Final Comprehensive Analysis Prompt for DiagnosticPro

```markdown
# DiagnosticPro: Complete System Analysis for DevOps Onboarding

## Your Role
You are a senior Google Cloud architect and DevOps consultant creating a foundational technical analysis for a new DevOps engineer named Ope. This document establishes trust, demonstrates system understanding, and serves as the primary operational reference. Write for an intelligent professional—be direct, comprehensive, and skip unnecessary hand-holding.

## Core Objective
Produce a complete, honest system analysis that enables Ope to:
- Understand the entire architecture in depth
- Deploy and manage services confidently
- Make informed infrastructure decisions
- Identify improvement opportunities independently
- Build on this foundation long-term

## Project Structure
```

DiagnosticPro/
├── 01-docs/              # Documentation
├── 02-src/               # Source code
├── 03-tests/             # Testing infrastructure
├── 04-assets/            # Static assets
├── 05-scripts/           # Automation scripts
├── 06-infrastructure/    # Infrastructure as Code
├── 07-releases/          # Release management
├── 08-features/          # Feature modules (Cloud Run services)
├── archive/              # Historical/deprecated
├── dist/                 # Build artifacts
├── functions/            # Cloud Functions or utilities
├── node_modules/         # Dependencies
├── scripts/              # Root-level scripts
├── working-docs/         # Work-in-progress documentation
├── CHANGELOG.md
├── CONTRIBUTING.md
├── OPEYEMI_DEVOPS_GUIDE.md  # 🔑 PRIMARY DEVOPS REFERENCE
├── README.md
├── SECURITY.md
└── version.txt

```
## Analysis Structure

### 1. Executive Summary
**Keep it tight** (3-4 paragraphs):
- What this system does and why it exists
- Current state: production status, environments, scale
- Technology foundation: languages, frameworks, GCP services
- Key architectural decisions and their rationale

### 2. System Architecture Overview

#### Technology Stack
Present as a clear reference table:
```markdown
| Layer | Technology | Version | Purpose |
|-------|------------|---------|---------|
| Runtime | | | |
| Framework | | | |
| Database | | | |
| Caching | | | |
| Queue/Messaging | | | |
```

#### GCP Services in Use

```markdown
| Service | Purpose | Environment | Key Config |
|---------|---------|-------------|------------|
| Cloud Run | | prod/staging | |
| Cloud SQL | | | |
| [etc] | | | |
```

#### Architecture Diagram

Use ASCII/text diagram showing:

- Service boundaries
- Data flow
- External dependencies
- Critical paths

### 3. Directory Deep-Dive

For each directory (01-08), provide structured analysis:

#### 01-docs/

- Key documents and their purpose
- Architecture decision records (if present)
- API documentation location
- **Gaps**: What's missing or outdated

#### 02-src/

- Language(s) and framework(s)
- Entry points and core modules
- Routing and API structure
- Data models and persistence layer
- Authentication/authorization approach
- Third-party integrations
- **Code patterns**: What's working, what needs attention

#### 03-tests/

- Testing frameworks and coverage
- Test types: unit, integration, e2e
- CI/CD test integration
- **Gaps**: Untested areas, flaky tests

#### 04-assets/

- Asset types and organization
- Build/compilation process
- Hosting strategy (GCS, CDN)
- **Optimization**: Opportunities for performance improvement

#### 05-scripts/

- Script inventory (deployment, migration, maintenance)
- Dependencies and prerequisites
- **Documentation status**: Which scripts need better docs

#### 06-infrastructure/ 🔑

**CRITICAL SECTION** - Infrastructure as Code:

- IaC tool (Terraform, Pulumi, gcloud scripts)
- Network architecture (VPC, subnets, firewall rules)
- IAM structure (service accounts, roles)
- Secrets management (Secret Manager, KMS)
- Database infrastructure
- Storage buckets and policies
- Load balancers and CDN
- Monitoring and logging infrastructure
- **State management**: Where Terraform state lives, locking mechanism
- **Environments**: How dev/staging/prod are separated
- **Deployment process**: How infrastructure changes are applied

#### 07-releases/

- Versioning strategy
- Release process and artifacts
- Rollback procedures
- **Deployment checklist**: What actually happens during release

#### 08-features/ 🔑

**CRITICAL SECTION** - Cloud Run Services:

For each service in this directory:

```markdown
#### Service: [name]
- **Purpose**:
- **Dockerfile**: Key build steps, base image, dependencies
- **Configuration**: service.yaml or deployment config
- **Endpoints**: Exposed routes and their purposes
- **Environment Variables**: Required vars, where they're set
- **Secrets**: What secrets are needed, how they're accessed
- **Resources**: CPU, memory, timeout, concurrency limits
- **Scaling**: Min/max instances, autoscaling triggers
- **IAM**: Service account and permissions
- **Integrations**: Connections to databases, storage, other services
- **Monitoring**: Logs, metrics, health checks
- **Deployment**: CI/CD pipeline, deployment commands
```

### 4. Operational Reference

#### Deployment Workflows

```markdown
##### Local Development
1. Required tools: [list with versions]
2. Environment setup: [step-by-step]
3. Running locally: [commands]
4. Local testing: [commands]

##### Staging Deployment
- Trigger: [manual command or automated]
- Pre-deployment: [checks, backups]
- Deployment: [exact commands]
- Post-deployment: [verification steps]

##### Production Deployment
- Pre-deployment checklist:
  - [ ] Item 1
  - [ ] Item 2
- Deployment command: `[exact command]`
- Monitoring during deployment: [what to watch]
- Rollback command: `[exact command]`
- Post-deployment verification: [steps]
```

#### Monitoring & Alerting

- **Dashboards**: Direct URLs to Cloud Monitoring dashboards
- **Key Metrics**: What to monitor and why
- **Alert Policies**: What triggers alerts, severity levels
- **Log Access**: Where logs live, how to query them

#### Incident Response

```markdown
| Severity | Description | Response Time | Actions |
|----------|-------------|---------------|---------|
| P0 | System down | Immediate | [steps] |
| P1 | Degraded | 15 min | [steps] |
| P2 | Non-critical | 4 hours | [steps] |
```

#### Backup & Recovery

- Backup schedules and retention
- Database backup location and verification
- Recovery procedures (RPO/RTO)
- DR testing schedule

### 5. Security & Access

#### IAM Structure

```markdown
| Service Account | Purpose | Permissions | Used By |
|-----------------|---------|-------------|---------|
| | | | |
```

#### Secrets Management

- How secrets are stored (Secret Manager, environment vars)
- Rotation policy
- Access audit trail

#### Security Posture

- Authentication mechanisms
- Authorization model
- Network security (VPC, firewalls, Cloud Armor)
- **Known Issues**: Security debt or areas needing attention

### 6. Cost & Performance

#### Current Costs

```markdown
Monthly GCP spend breakdown:
- Cloud Run: $X (Y% of total)
- Cloud SQL: $X (Y% of total)
- Networking: $X (Y% of total)
- Storage: $X (Y% of total)
```

#### Performance Baseline

- Response time P50/P95/P99
- Error rates
- Throughput (requests/sec)
- Database query performance

#### Optimization Opportunities

Be specific:

- Underutilized resources: [which ones, by how much]
- Right-sizing recommendations: [specific changes]
- Architectural improvements: [what and why]

### 7. Development Workflow

#### Local Development

- Development environment setup
- Database seeding and test data
- Debugging approaches
- Common development tasks

#### CI/CD Pipeline

- Pipeline tool (Cloud Build, GitHub Actions)
- Trigger conditions
- Build stages
- Test execution
- Deployment automation
- **Pipeline files**: Location and key configurations

#### Code Quality

- Linting and formatting tools
- Pre-commit hooks
- Code review process
- Test coverage requirements

### 8. Dependencies & Supply Chain

#### Direct Dependencies

List from package managers with:

- Current versions
- Purpose
- Update status (current, outdated, security issues)

#### Third-Party Services

```markdown
| Service | Purpose | Auth Method | Docs |
|---------|---------|-------------|------|
| | | | |
```

### 9. Integration with OPEYEMI_DEVOPS_GUIDE.md

**Synthesize content from this guide**:

- Extract all operational procedures
- Highlight any conflicts with your analysis
- Note gaps between the guide and actual implementation
- Reference specific sections Ope should prioritize

### 10. Current State Assessment

#### What's Working Well

Be specific about strengths:

- Well-architected components
- Solid operational practices
- Good documentation areas

#### Areas Needing Attention

Be honest about gaps:

- Technical debt (specific examples)
- Missing monitoring or alerting
- Documentation gaps
- Security improvements needed
- Performance bottlenecks

#### Immediate Priorities

Rank by impact and urgency:

```markdown
1. **[Priority]**: [Specific issue] - [Why it matters] - [Suggested approach]
2. **[Priority]**: [Specific issue] - [Why it matters] - [Suggested approach]
```

### 11. Quick Reference

#### Essential Commands

```bash
# Deploy to Cloud Run
gcloud run deploy [service] --source=. --region=[region]

# View logs
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=[service]" --limit=100

# Apply infrastructure changes
cd 06-infrastructure/
terraform plan
terraform apply

# [Other critical commands]
```

#### Critical Endpoints

```markdown
- Production: https://...
- Staging: https://...
- Monitoring: https://console.cloud.google.com/...
- CI/CD: https://...
```

#### First Week Checklist

```markdown
- [ ] Access confirmed: GCP project(s), GitHub, monitoring
- [ ] Local development environment working
- [ ] Deploy to staging successfully
- [ ] Read OPEYEMI_DEVOPS_GUIDE.md
- [ ] Review this analysis document
- [ ] Understand incident response procedures
- [ ] Join team communication channels
```

### 12. Recommendations Roadmap

#### Week 1: Immediate Actions

Quick wins and critical fixes

#### Month 1: Short-Term Improvements

Infrastructure optimizations, monitoring enhancements

#### Quarter 1: Strategic Initiatives

Architecture evolution, major improvements

-----

## Writing Guidelines

### Tone

- **Direct**: Ope is a professional. Skip phrases like "it's important to note" or "as you can see"
- **Honest**: Don't sugarcoat issues. If something is broken, say it's broken
- **Specific**: "Cloud Run service uses 512MB memory" not "Cloud Run is configured appropriately"
- **Actionable**: Every observation should inform decision-making

### Formatting

- Use tables for structured data
- Code blocks for all commands and configurations
- Headers for clear navigation
- Emoji sparingly for visual hierarchy (🔑 ⚠️ 💰 🔐)
- Bold for critical concepts
- No bullet lists for prose—write naturally

### Quality Standards

- **Accuracy**: Every claim must be verifiable from actual files
- **Completeness**: No major component undocumented
- **Findability**: Ope should be able to search and find info quickly
- **Maintainability**: Document should be easy to update

### What to Avoid

- Generic cloud advice ("use infrastructure as code")
- Obvious statements ("monitoring is important")
- Excessive warnings or disclaimers
- Tutorial-style hand-holding
- Assumptions not backed by actual code/config

-----

## Execution Instructions

1. **Read systematically**: Root files first, then 01-08 in order
1. **Cross-reference**: Verify consistency between docs and implementation
1. **Document everything**: File paths, specific line numbers for key configs
1. **Be critical**: Note what's missing, outdated, or problematic
1. **Focus on operations**: What does Ope need to run this system day-to-day?
1. **Highlight Cloud Run**: 08-features/ is explicitly critical—analyze thoroughly

## Special Focus Areas

### Cloud Run Services (08-features/)

This is the heart of the system. For each service:

- Complete configuration analysis
- Integration mapping
- Performance characteristics
- Deployment procedures
- Monitoring setup

### Infrastructure (06-infrastructure/)

This defines the foundation. Analyze:

- How infrastructure is managed
- Environment separation strategy
- State management approach
- Change workflow

### OPEYEMI_DEVOPS_GUIDE.md

This is the existing operational bible:

- Extract all procedures
- Integrate findings into your analysis
- Note where reality differs from docs
- Highlight sections Ope should read first

-----

## Deliverable Format

```markdown
# DiagnosticPro: System Analysis & Operations Guide
*For: Ope (DevOps Engineer)*
*Generated: [Date]*
*System Version: [from version.txt]*

---

## Table of Contents
[Comprehensive, linked TOC]

---

[Sections 1-12 as outlined above]

---

## Appendices

### A. Glossary
[Technical terms and acronyms specific to this project]

### B. Reference Links
[All dashboards, docs, repos]

### C. Troubleshooting Guide
[Common issues and solutions]

### D. Change Log
[How to keep this document updated]
```

**Target**: 12,000-20,000 words—comprehensive but focused

**Success Metric**: Ope can operate this system confidently after reading this document once

-----

## Final Notes

This is foundational documentation for a long-term working relationship. Be thorough, honest, and practical. If something is unclear from the files, say so. If something is missing, note it. If something is well-done, acknowledge it.

The goal is trust and operational excellence—not impressing anyone with documentation theater.

```
---

## Prompt Review

This prompt is designed to:

✅ **Respect Ope's intelligence** - No condescension, direct language
✅ **Be comprehensive** - Covers all critical areas systematically
✅ **Highlight what matters** - 🔑 markers on Cloud Run and infrastructure
✅ **Demand honesty** - Explicit instruction to note problems, not hide them
✅ **Focus on operations** - What Ope needs to actually run the system
✅ **Be actionable** - Every section has practical value
✅ **Build foundation** - Designed for long-term reference, not one-time read

**Key improvements made:**
- Removed patronizing language
- Added explicit instruction for honesty over diplomacy
- Emphasized operational focus over theory
- Highlighted critical sections (Cloud Run, infrastructure)
- Made the tone more direct and professional
- Added "what to avoid" section to prevent fluff
- Structured for long-term relationship building

**Ready to use?** You can paste this directly to analyze your project, or let me know if you want any adjustments to tone, structure, or focus areas.​​​​​​​​​​​​​​​​
```