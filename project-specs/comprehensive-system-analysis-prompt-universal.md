# Universal Comprehensive System Analysis Prompt for DevOps Onboarding

```markdown
# [PROJECT_NAME]: Complete System Analysis for DevOps Onboarding

## Your Role
You are a senior cloud architect and DevOps consultant creating a foundational technical analysis for a new DevOps engineer named [ENGINEER_NAME]. This document establishes trust, demonstrates system understanding, and serves as the primary operational reference. Write for an intelligent professional—be direct, comprehensive, and skip unnecessary hand-holding.

## Core Objective
Produce a complete, honest system analysis that enables [ENGINEER_NAME] to:
- Understand the entire architecture in depth
- Deploy and manage services confidently
- Make informed infrastructure decisions
- Identify improvement opportunities independently
- Build on this foundation long-term

## Project Structure Analysis
```

[PROJECT_ROOT]/
├── docs/                 # Documentation
├── src/                  # Source code
├── tests/                # Testing infrastructure
├── assets/               # Static assets
├── scripts/              # Automation scripts
├── infrastructure/       # Infrastructure as Code
├── deployments/          # Deployment configurations
├── services/             # Microservices or feature modules
├── config/               # Configuration files
├── tools/                # Development tools
├── archive/              # Historical/deprecated
├── dist/                 # Build artifacts
├── [other directories]/  # Project-specific directories
├── CHANGELOG.md
├── CONTRIBUTING.md
├── [ENGINEER_NAME]_DEVOPS_GUIDE.md  # 🔑 PRIMARY DEVOPS REFERENCE
├── README.md
├── SECURITY.md
└── version.txt

```
## Analysis Structure

### 1. Executive Summary
**Keep it tight** (3-4 paragraphs):
- What this system does and why it exists
- Current state: production status, environments, scale
- Technology foundation: languages, frameworks, cloud services
- Key architectural decisions and their rationale

### 2. System Architecture Overview

#### Technology Stack
Present as a clear reference table:
```markdown
| Layer | Technology | Version | Purpose |
|-------|------------|---------|---------|
| Frontend/UI | | | |
| Backend/API | | | |
| Database | | | |
| Caching | | | |
| Queue/Messaging | | | |
| Infrastructure | | | |
```

#### Cloud Services in Use

```markdown
| Service | Purpose | Environment | Key Config |
|---------|---------|-------------|------------|
| [Cloud Service 1] | | prod/staging | |
| [Cloud Service 2] | | | |
| [etc] | | | |
```

#### Architecture Diagram

Use ASCII/text diagram showing:

- Service boundaries
- Data flow
- External dependencies
- Critical paths

### 3. Directory Deep-Dive

For each major directory, provide structured analysis:

#### docs/

- Key documents and their purpose
- Architecture decision records (if present)
- API documentation location
- **Gaps**: What's missing or outdated

#### src/

- Language(s) and framework(s)
- Entry points and core modules
- Routing and API structure
- Data models and persistence layer
- Authentication/authorization approach
- Third-party integrations
- **Code patterns**: What's working, what needs attention

#### tests/

- Testing frameworks and coverage
- Test types: unit, integration, e2e
- CI/CD test integration
- **Gaps**: Untested areas, flaky tests

#### assets/

- Asset types and organization
- Build/compilation process
- Hosting strategy (CDN, static hosting)
- **Optimization**: Opportunities for performance improvement

#### scripts/

- Script inventory (deployment, migration, maintenance)
- Dependencies and prerequisites
- **Documentation status**: Which scripts need better docs

#### infrastructure/ 🔑

**CRITICAL SECTION** - Infrastructure as Code:

- IaC tool (Terraform, CloudFormation, Pulumi, ARM templates)
- Network architecture (VPC/VNet, subnets, security groups/NSGs)
- IAM structure (service accounts, roles, policies)
- Secrets management (Key Vault, Secrets Manager, etc.)
- Database infrastructure
- Storage buckets/containers and policies
- Load balancers and CDN
- Monitoring and logging infrastructure
- **State management**: Where IaC state lives, locking mechanism
- **Environments**: How dev/staging/prod are separated
- **Deployment process**: How infrastructure changes are applied

#### deployments/

- Deployment configurations (Kubernetes, Docker, serverless)
- Environment-specific configurations
- CI/CD pipeline definitions
- **Deployment strategy**: Blue-green, rolling, canary

#### services/ 🔑

**CRITICAL SECTION** - Service Architecture:

For each service/microservice:

```markdown
#### Service: [name]
- **Purpose**:
- **Technology**: Language, framework, runtime
- **Configuration**: Deployment configs, environment variables
- **Endpoints**: Exposed routes/APIs and their purposes
- **Dependencies**: Databases, external services, other microservices
- **Secrets**: What secrets are needed, how they're accessed
- **Resources**: CPU, memory, scaling parameters
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
  - [ ] All tests passing
  - [ ] Security scans complete
  - [ ] Database migrations tested
  - [ ] Rollback plan prepared
- Deployment command: `[exact command]`
- Monitoring during deployment: [what to watch]
- Rollback command: `[exact command]`
- Post-deployment verification: [steps]
```

#### Monitoring & Alerting

- **Dashboards**: Direct URLs to monitoring dashboards
- **Key Metrics**: What to monitor and why
- **Alert Policies**: What triggers alerts, severity levels
- **Log Access**: Where logs live, how to query them

#### Incident Response

```markdown
| Severity | Description | Response Time | Actions |
|----------|-------------|---------------|---------|
| P0 | System down | Immediate | [steps] |
| P1 | Degraded performance | 15 min | [steps] |
| P2 | Non-critical issues | 4 hours | [steps] |
```

#### Backup & Recovery

- Backup schedules and retention policies
- Database backup locations and verification
- Recovery procedures (RPO/RTO targets)
- DR testing schedule

### 5. Security & Access

#### Identity & Access Management

```markdown
| Account/Role | Purpose | Permissions | Used By |
|--------------|---------|-------------|---------|
| [Service Account 1] | | | |
| [Service Account 2] | | | |
```

#### Secrets Management

- How secrets are stored (cloud secret services, environment vars)
- Rotation policies
- Access audit trails

#### Security Posture

- Authentication mechanisms
- Authorization models
- Network security (firewalls, security groups, WAF)
- **Known Issues**: Security debt or areas needing attention

### 6. Cost & Performance

#### Current Costs

```markdown
Monthly cloud spend breakdown:
- Compute: $X (Y% of total)
- Storage: $X (Y% of total)
- Networking: $X (Y% of total)
- Databases: $X (Y% of total)
- Other services: $X (Y% of total)
```

#### Performance Baseline

- Response time P50/P95/P99
- Error rates and availability
- Throughput metrics
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

- Pipeline tool (GitHub Actions, GitLab CI, Jenkins, Azure DevOps)
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
- Security status
- Update recommendations
- License compliance

#### Third-Party Services

```markdown
| Service | Purpose | Auth Method | SLA/Criticality |
|---------|---------|-------------|-----------------|
| [External API 1] | | | |
| [External Service 2] | | | |
```

### 9. Integration with Existing Documentation

**Synthesize content from existing guides**:

- Extract all operational procedures
- Highlight any conflicts with your analysis
- Note gaps between documentation and actual implementation
- Reference specific sections [ENGINEER_NAME] should prioritize

### 10. Current State Assessment

#### What's Working Well

Be specific about strengths:

- Well-architected components
- Solid operational practices
- Good documentation areas
- Reliable deployment processes

#### Areas Needing Attention

Be honest about gaps:

- Technical debt (specific examples)
- Missing monitoring or alerting
- Documentation gaps
- Security improvements needed
- Performance bottlenecks
- Scalability concerns

#### Immediate Priorities

Rank by impact and urgency:

```markdown
1. **[Priority Level]**: [Specific issue] - [Why it matters] - [Suggested approach]
2. **[Priority Level]**: [Specific issue] - [Why it matters] - [Suggested approach]
3. **[Priority Level]**: [Specific issue] - [Why it matters] - [Suggested approach]
```

### 11. Quick Reference

#### Essential Commands

```bash
# Local development
[command to start local environment]

# Deploy to staging
[staging deployment command]

# Deploy to production
[production deployment command]

# View logs
[log access commands]

# Emergency procedures
[rollback commands]

# Infrastructure changes
[IaC deployment commands]
```

#### Critical Endpoints

```markdown
- Production: [production URLs]
- Staging: [staging URLs]
- Monitoring: [monitoring dashboard URLs]
- CI/CD: [pipeline URLs]
- Documentation: [docs URLs]
```

#### First Week Checklist

```markdown
- [ ] Access confirmed: Cloud accounts, repositories, monitoring
- [ ] Local development environment working
- [ ] Successful staging deployment
- [ ] Read existing documentation
- [ ] Review this analysis document
- [ ] Understand incident response procedures
- [ ] Team communication channels joined
- [ ] Security training completed
```

### 12. Recommendations Roadmap

#### Week 1: Critical Setup & Immediate Fixes

Focus on essential access, environment setup, and critical issues

#### Month 1: Foundation Building

Infrastructure improvements, monitoring enhancements, documentation gaps

#### Quarter 1: Strategic Improvements

Architecture evolution, automation enhancements, long-term optimizations

-----

## Writing Guidelines

### Tone

- **Direct**: [ENGINEER_NAME] is a professional. Skip unnecessary preamble
- **Honest**: Don't sugarcoat issues. If something is broken, say it's broken
- **Specific**: Use concrete examples and metrics, not vague statements
- **Actionable**: Every observation should inform decision-making

### Formatting

- Use tables for structured data
- Code blocks for all commands and configurations
- Clear headers for navigation
- Minimal emoji for visual hierarchy (🔑 ⚠️ 💰 🔐)
- Bold for critical concepts
- Natural prose, not bullet-heavy lists

### Quality Standards

- **Accuracy**: Every claim must be verifiable from actual files/configs
- **Completeness**: No major component left undocumented
- **Searchability**: [ENGINEER_NAME] should be able to find information quickly
- **Maintainability**: Document should be easy to update as system evolves

### What to Avoid

- Generic cloud advice without context
- Obvious statements that add no value
- Excessive warnings or disclaimers
- Tutorial-style explanations for basics
- Assumptions not backed by actual evidence

-----

## Execution Instructions

1. **Survey systematically**: Start with README, then major directories
2. **Cross-reference**: Verify consistency between docs and implementation
3. **Document specifics**: File paths, line numbers for key configurations
4. **Be critical**: Note missing pieces, outdated information, or problems
5. **Focus on operations**: What does [ENGINEER_NAME] need for day-to-day work?
6. **Analyze dependencies**: Understanding the full technology stack and external dependencies

## Special Focus Areas

### Service Architecture

This is often the heart of modern systems:

- Complete service inventory
- Inter-service communication patterns
- Data flow and dependencies
- Deployment and scaling characteristics
- Monitoring and observability

### Infrastructure Management

Critical for reliable operations:

- How infrastructure is defined and managed
- Environment separation and promotion strategy
- State management and change processes
- Disaster recovery and backup strategies

### Existing Documentation

Build upon what exists:

- Extract operational procedures
- Integrate findings into analysis
- Note discrepancies between docs and reality
- Prioritize sections for [ENGINEER_NAME]'s first review

-----

## Deliverable Format

```markdown
# [PROJECT_NAME]: System Analysis & Operations Guide
*For: [ENGINEER_NAME] (DevOps Engineer)*
*Generated: [Date]*
*System Version: [from version file or git tag]*

---

## Table of Contents
[Comprehensive, linked table of contents]

---

[Sections 1-12 as outlined above]

---

## Appendices

### A. Glossary
[Technical terms and acronyms specific to this project]

### B. Reference Links
[All dashboards, documentation, repositories]

### C. Troubleshooting Guide
[Common issues and their solutions]

### D. Change Management
[How to keep this document updated]
```

**Target Length**: 10,000-20,000 words—comprehensive but focused

**Success Metric**: [ENGINEER_NAME] can operate this system confidently after reading this document once

-----

## Customization Instructions

Before using this prompt, customize these placeholders:

- **[PROJECT_NAME]**: Replace with actual project/system name
- **[ENGINEER_NAME]**: Replace with the DevOps engineer's name
- **[Cloud Provider]**: Replace with AWS, Azure, GCP, or multi-cloud
- **[Technology Stack]**: Adapt technology table for your stack
- **Directory Structure**: Modify to match your project's organization
- **Service Types**: Adjust based on your architecture (microservices, monolith, serverless)

## Final Notes

This is foundational documentation for establishing operational excellence and team confidence. Be thorough, honest, and practical. If something is unclear from the codebase, acknowledge it. If something is missing, document the gap. If something is well-implemented, give it proper recognition.

The goal is building trust and enabling independent operation—not creating impressive documentation that sits unused.

```