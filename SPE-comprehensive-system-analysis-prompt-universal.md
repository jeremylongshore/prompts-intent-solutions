# Universal Operator-Grade System Analysis Prompt for DevOps Onboarding

```markdown
# [PROJECT_NAME]: Operator-Grade System Analysis & Operations Playbook

## Your Role
You are the Intent Solutions senior cloud architect and DevOps consultant tasked with producing the definitive operational guide for the incoming DevOps engineer, [ENGINEER_NAME]. Lead with an operator-first mindset: stay practical, protect data privacy, and optimise for hands-on maintainers across Google Cloud, Vertex AI, n8n, and automation surfaces. Write for an experienced professional—concise, candid, and evidence-based.

## Core Objective
Deliver a complete, verifiable analysis that equips [ENGINEER_NAME] to:
- Understand architecture, data flows, and business value end-to-end
- Deploy, monitor, and troubleshoot services without supervision
- Prioritise improvements using quantified impact and risk
- Communicate system status credibly to operators and stakeholders
- Map work to Intent Solutions offerings (Private AI, AI Agents, Automation, Cloud & Data, Learn) for cross-team leverage
- Evolve the platform responsibly over the next 12 months

## Brand & Service Alignment Cues
Capture signals that connect this system to Intent Solutions’ portfolio:
- Operator-first delivery: highlight how workflows support real users, frontline teams, and resellers
- Vertex-first security: document privacy posture, guardrails, and compliance hooks (Vertex AI, IAM, data boundaries)
- Automation strategy: identify n8n, MCP, or custom workflow assets and their reliability
- Education & reuse: note where Start AI Tools or Hustle research content can reinforce onboarding or customer experience
- Commercial readiness: call out licensing, SLAs, and packaged services that align with intent solutions resellers

## Project Structure Analysis
Document the actual repository layout. Cross-check against `MASTER-DIRECTORY-STANDARDS.md`. If the scaffold diverges, inventory every top-level directory, justify its role, and propose renames or consolidations backed by impact. Include investigative notes on assets that should be archived or removed, with rationale suitable for the audit after-action review (AAR).
```

[PROJECT_ROOT]/
├── docs/                 # Documentation (ADR, runbooks, onboarding)
├── src/                  # Application source by domain/module
├── tests/                # Automated test suites and fixtures
├── assets/               # Static assets, design systems, media
├── scripts/              # Operational tooling (migrations, maintenance)
├── infrastructure/       # Infrastructure as Code, manifests, modules
├── deployments/          # Environment-specific deployment configs
├── services/             # Microservices or feature modules
├── config/               # Environment + shared configuration
├── tools/                # Developer utilities, CLIs, generators
├── automation/           # n8n flows, MCP handlers, playbooks (if present)
├── archive/              # Deprecated/legacy components
├── dist/                 # Build artifacts or release bundles
├── [other directories]/  # Project-specific structures (explain purpose)
├── CHANGELOG.md
├── CONTRIBUTING.md
├── [ENGINEER_NAME]_devops_guide.md  # 🔑 Primary DevOps reference (create if absent)
├── README.md
├── SECURITY.md
└── version.txt

```

## Analysis Structure

### 1. Executive Summary
Deliver 3–4 tightly written paragraphs covering:
- Business purpose, core capabilities, and user value (reference customer logos or verticals where possible)
- Current operational status (environments, uptime targets, release cadence, user load)
- Technology foundation (languages, frameworks, infra providers) with rationale for key decisions
- Immediate strengths, risks, strategic considerations, and how they align with Intent Solutions’ operator-first delivery promises

### 2. Operator & Customer Journey
- Describe primary personas (operators, external customers, reseller partners, automation bots).
- Map the end-to-end journey: awareness → onboarding → core workflows → support/feedback → renewal.
- Highlight critical touchpoints (UI flows, API endpoints, notifications, physical interactions) and dependencies that affect the experience.
- Document friction points, known complaints, SLAs, and success metrics (CSAT, retention, time-to-value).
- Summarise how engineering decisions help or hinder the journey, including any disconnects between intent and actual behaviour.
- Surface opportunities for education content or automation that improves the journey (Start AI Tools guides, n8n playbooks, etc.).

### 3. System Architecture Overview

#### Technology Stack
Present as a reference table with real versions and links to manifest files or lockfiles.
```markdown
| Layer | Technology | Version | Source of Truth | Purpose | Owner |
|-------|------------|---------|-----------------|---------|-------|
| Frontend/UI | | | | | |
| Backend/API | | | | | |
| Database | | | | | |
| Caching | | | | | |
| Queue/Messaging | | | | | |
| Infrastructure | | | | | |
| Observability | | | | | |
| Security | | | | | |
| AI/ML | | | | | |
```

#### Environment Matrix
```markdown
| Environment | Purpose | Hosting | Data Source | Release Cadence | IaC Source | Notes |
|-------------|---------|---------|-------------|-----------------|------------|-------|
| local | | | | | | |
| dev | | | | | | |
| staging | | | | | | |
| prod | | | | | | |
| [others] | | | | | | |
```

#### Cloud & Platform Services
```markdown
| Service | Purpose | Environment(s) | Key Config | Cost/Limits | Owner | Vendor Risk |
|---------|---------|----------------|------------|-------------|-------|-------------|
| Vertex AI | | | | | | |
| GCP (Cloud Run, GKE, etc.) | | | | | | |
| n8n Cloud / Self-hosted | | | | | | |
| [Cloud Service] | | | | | | |
```

#### Architecture Diagram
Render an ASCII/text diagram showing:
- Core services/modules, boundaries, and external integrations
- Data ingress/egress, synchronous vs. asynchronous flows
- Automation surfaces (n8n workflows, MCP handlers, scheduler jobs)
- Critical paths, failure domains, high-availability mechanisms
- Edge cases: third-party webhooks, reseller integrations, compliance pipelines

### 4. Directory Deep-Dive
For each major directory, include purpose, key files, operational considerations, owner, and gaps. Reference specific file paths and line numbers where meaningful.

#### docs/
- Summarise runbooks, ADRs, onboarding guides, compliance docs, and reseller collateral.
- Call out stale or missing artefacts (e.g., absent architecture diagrams, outdated SOPs).
- Note documentation ownership, update cadence, and alignment with master directory naming conventions.

#### src/
- Identify primary language(s), frameworks, runtime versions, and module boundaries.
- Document entry points (e.g., `src/index.ts`, `main.py`), routing patterns, and domain-driven structure.
- Detail domain models, persistence layer, data validation, caching strategy, and observability hooks.
- Describe authentication/authorization, feature flags, error handling, and tenant segregation.
- Highlight third-party integrations (OEM APIs, payment providers, telematics feeds) and resilience considerations.
- **Code patterns**: Spotlight exemplary patterns, and flag refactoring targets with concrete remediation strategies.

#### tests/
- List frameworks (Jest, pytest, Go test, etc.) and helper tooling (test containers, fixtures).
- Categorise coverage (unit, integration, contract, e2e) with approximate percentages and trends.
- Explain CI integration, data management, and flaky-test triage.
- **Gaps**: Name untested modules, missing regression suites, or manual QA dependencies.

#### assets/
- Describe asset types (design systems, translations, telemetry schemas) and versioning strategy.
- Document build/optimisation pipelines, CDN/static hosting choices, and cache-control posture.
- **Optimisation**: Identify performance or accessibility improvements (compression, lazy loading, a11y checks).

#### scripts/
- Inventory automation scripts by purpose (migrations, data repair, operational utilities).
- Capture dependencies, required environment variables, safety rails, and dry-run options.
- Note documentation status and whether scripts conform to Intent Solutions naming and audit expectations.

#### infrastructure/ 🔑
Provide a deep, IaC-focused breakdown:
- Tools and structure (Terraform workspaces, Pulumi stacks, Helm charts, Kustomize overlays).
- Network topology (VPC/VNet, subnets, routing tables, NAT, firewalls, service mesh).
- Identity and access (IAM roles, service accounts, workload identity, SSO, policy-as-code).
- Secrets management lifecycle (Secret Manager, Vault, encrypted config, rotation cadence).
- Compute resources (GKE clusters, Cloud Run services, serverless functions, VM scale sets).
- Data stores (SQL/NoSQL engines, replication, backups, encryption, retention).
- Storage buckets, lifecycle rules, egress controls, customer data boundaries.
- Load balancing, CDN, API gateways, ingress controllers, WAF rules.
- Observability stack (Cloud Logging, Cloud Monitoring, Prometheus, Datadog) and alert routing.
- **State management**: Terraform state location, locking, drift detection, break-glass protocol.
- **Environment separation**: Promotion flow, config differences, compliance sign-offs.
- **Change process**: Branching model, review/approval gates, deployment automation, rollback contracts.

#### deployments/
- Document deployment descriptors (Helm charts, K8s manifests, ECS task defs, serverless configs).
- Explain environment-specific overrides, secrets injection, configuration templating, and flag management.
- Detail release strategies (blue/green, rolling, canary, feature flags) and rollback mechanisms.

#### services/ 🔑
For each service/microservice/serverless function:
```markdown
#### Service: [Name]
- **Purpose**: Business capability delivered; tie to customer or operator outcome
- **Technology Stack**: Language, framework, runtime, build system, container image
- **Configuration**: Key environment variables (with sources), config files, secrets, feature flags
- **Interfaces**: REST/GraphQL endpoints, events, queues, cron jobs, automations
- **Dependencies**: Datastores, external APIs, internal services (protocols, auth methods)
- **Scaling Profile**: Resource requests/limits, autoscaling policies, concurrency controls
- **Resilience**: Timeouts, retries, circuit breakers, health checks, failover behaviour
- **Observability**: Logs, metrics, traces, dashboards, alert thresholds, SLO owners
- **Security Controls**: AuthN/Z patterns, data classification, compliance obligations
- **Deployment Flow**: CI pipeline jobs, manual steps, approval gates, rollback commands or playbooks
- **Known Issues**: Bugs, performance hot spots, tech debt, ownership gaps, incident history
```

### 5. Automation & Agent Surfaces
- **n8n / Workflow Automations**: Inventory flows, triggers, failure handling, manual overrides, and ownership. Note credential storage, audit logs, and how changes are promoted.
- **MCP / Integration Gateways**: Document connectors, scopes, rate limits, and dependency graph for downstream systems.
- **AI Agents & Slash Commands**: Capture purpose, personas served, and runtime context (Claude, GPT, internal tooling). Ensure prompts link back to this playbook and adhere to operator-first guardrails.
- **Automation Debt**: Flag brittle automations, missing tests, or undocumented manual steps that risk production stability.
- **Reuse Opportunities**: Identify automation components that can become packaged offerings for resellers or Start AI Tools curricula.

### 6. Operational Reference

#### Deployment Workflows
Provide step-by-step, evidence-backed overviews. Reference canonical scripts, pipelines, or runbooks instead of inventing new commands.
```markdown
##### Local Development
1. Prerequisites (tool versions, accounts, feature flags)
2. Environment setup (dotfiles, env vars, secrets retrieval, seeded data)
3. Service start-up process (docker-compose, tilt, package scripts) with source links
4. Local verification (smoke tests, UI checklists, contract tests)

##### Staging Deployment
- Trigger (branch merge, manual job, chatops, release train)
- Pre-flight checks (CI status, schema diffs, config drift, feature toggles)
- Deployment execution (pipeline/job names, automation scripts, approvals)
- Post-deploy validation (synthetic checks, analytics, stakeholder sign-off)
- Rollback plan (commands/playbooks, data reversal steps, communication)

##### Production Deployment
- Pre-deployment checklist:
  - [ ] CI pipeline green (build/tests/security scans)
  - [ ] Database migrations rehearsed and backed up
  - [ ] Feature toggles and kill switches reviewed
  - [ ] Rollback + comms plan approved
- Deployment window and communications (change calendar, on-call, incident bridge)
- Deployment execution (pipeline references, release manager responsibilities)
- Monitoring focus (dashboards, business KPIs, error budgets)
- Rollback protocol (automation, manual steps, verification checklist)
- Post-deployment review (observability audit, retro triggers, documentation updates)
```

#### Monitoring & Alerting
- List dashboards with URLs, owning teams, and primary metrics.
- Document key SLIs/SLOs (latency, availability, throughput) and alert thresholds.
- Explain logging/trace strategy (centralised logging, retention, correlation IDs, sampling).
- Outline on-call expectations, escalation paths, tooling (PagerDuty, Opsgenie, Slack), and communication cadence.

#### Incident Response
```markdown
| Severity | Definition | Response Time | Roles | Immediate Actions | Communication |
|----------|------------|---------------|-------|-------------------|---------------|
| P0 | System-wide outage | Immediate | Incident commander, comms lead, SMEs | [playbook link] | Status page, exec brief, reseller alert |
| P1 | Critical degradation | 15 min | | | |
| P2 | Partial impact | 1 hour | | | |
| P3 | Minor issues | Next business day | | | |
```
Reference existing runbooks, postmortem templates, pager rotations, and tooling.

#### Backup & Recovery
- Enumerate backup jobs (frequency, coverage, retention, encryption, validation).
- Describe verification routines (restore tests, checksum validation, disaster drills).
- Define RPO/RTO targets per service and current adherence.
- Provide disaster recovery procedures (region failover, cold backup activation, IaC rebuild path).

### 7. Security, Compliance & Access

#### Identity & Access Management
```markdown
| Account/Role | Purpose | Permissions | Provisioning Process | MFA | Used By |
|--------------|---------|-------------|----------------------|-----|---------|
| [Service Account] | | | | | |
| [Human Role] | | | | | |
```
- Note least-privilege gaps, access review cadence, and compliance checkpoints (SOC2, HIPAA, right-to-repair data rules).

#### Secrets Management
- Storage mechanism, lifecycle, rotation policy, access audit trails, and break-glass procedure.
- Any manual secrets handling (call out risks and remediation steps).
- Compliance requirements (Vertex AI guardrails, data residency, customer SLAs) and current status.

#### Security Posture
- Authentication flows, authorization models, encryption in transit/at rest.
- Network segmentation, firewall rules, WAF, DDoS mitigation, zero-trust controls.
- Security tooling (SAST, DAST, dependency scanning, container scanning) and findings backlog.
- **Known Issues**: Enumerate vulnerabilities, compensating controls, remediation owners, and due dates.

### 8. Cost & Performance

#### Current Costs
Provide latest monthly cost breakdown with source (billing export, FinOps dashboard).
```markdown
Monthly Cloud Spend:
- Compute: $X (Y% of total) – [service/provider]
- Storage: $X (Y% of total)
- Networking & Egress: $X (Y% of total)
- Databases & Managed Services: $X (Y% of total)
- Observability & Security: $X (Y% of total)
- Vertex AI & ML Ops: $X (Y% of total)
- Third-Party SaaS: $X (Y% of total)
```

#### Performance Baseline
- Include P50/P95/P99 latency, throughput, error budgets, saturation metrics, and trend lines.
- Summarise load testing results, scaling inflection points, and capacity planning horizon.
- Note business KPIs tied to system performance (conversion, retention, SLA adherence, reseller commitments).

#### Optimisation Opportunities
- Quantify right-sizing candidates, committed use discounts, storage tiering, and automation ROI.
- Recommend architectural improvements (caching, partitioning, batching, vector search, offline processing) with expected impact.
- Identify cost/performance trade-offs, decision owners, and dependencies.

### 9. Development Workflow

#### Local Development
- Standard dev environment (OS, tooling, containerisation, dotfiles) and bootstrap scripts.
- Database seeding, fixtures, third-party sandbox integration, and secrets sourcing.
- Debugging toolchain (profilers, trace viewers, feature flag toggles, impersonation workflows).
- Common tasks (feature branch flow, migrations, dependency updates, localisation).

#### CI/CD Pipeline
- Pipeline platform (GitHub Actions, GitLab CI, Jenkins, Azure DevOps) and high-level flow.
- Trigger matrix (branch, tag, PR) and required checks or approvals.
- Stage-by-stage breakdown (build → test → security → deploy) with file references.
- Artifact management (images, packages), promotion logic, governance gates, and change control.
- Compliance outputs (test coverage, SBOM, security reports, release notes).

#### Code Quality
- Linting/formatting tools, configuration files, enforcement level (pre-commit, CI).
- Static analysis, dependency scanning, licence checks, code smell monitors.
- Code review process (approvals required, reviewer rotation, checklist).
- Coverage targets, quality gates, and outstanding tech debt initiatives.

### 10. Dependencies & Supply Chain

#### Direct Dependencies
- Summarise package manifests (npm, pip, go.mod, requirements, Cargo) with notable libraries.
- Document critical version pins, security advisories, update cadence, and compatibility blockers.
- Note build tools, compilers, language runtimes, container base images, and image hardening posture.

#### Third-Party Services
```markdown
| Service | Purpose | Data Shared | Auth Method | SLA/Criticality | Renewal | Owner |
|---------|---------|-------------|-------------|-----------------|---------|-------|
| [External API] | | | | | | |
| [SaaS Tool] | | | | | | |
```
- Include contract/renewal notes, access controls, contingency plans, and reseller obligations.

### 11. Integration with Existing Documentation
- Cross-reference current docs, runbooks, ADRs, onboarding guides, and reseller assets; cite specific sections.
- Reconcile discrepancies between documentation and implementation, noting required updates.
- Identify undocumented procedures and propose owners/timelines to fill gaps.
- Provide a prioritised reading list for [ENGINEER_NAME], explaining why each source matters.
- Flag opportunities to publish sanitized learnings to Start AI Tools or internal knowledge bases.

### 12. Current State Assessment

#### What's Working Well
- List resilient architecture choices, reliable processes, and high-performing teams/components.
- Use evidence (uptime, incident metrics, deployment frequency, customer outcomes) to support claims.

#### Areas Needing Attention
- Detail tech debt, reliability issues, missing observability, security exposures, or automation fragility.
- Highlight personnel/process gaps (e.g., absent runbooks, unclear ownership, brittle manual steps).
- Include operator or customer pain points tied to technical causes.

#### Immediate Priorities
Rank actionable items with urgency, impact, owners, and next steps.
```markdown
1. **[High/Medium/Low]** – [Specific issue] • Impact: [customer/system/business impact] • First Action: [ticket, spike, PoC] • Owner: [name/team]
2. **[High/Medium/Low]** – ...
3. **[High/Medium/Low]** – ...
```

### 13. Quick Reference

#### Operational Command Map
Document the canonical commands or pipelines, their source, and intended operators. Reference existing scripts instead of inventing new ones.
```markdown
| Capability | Command/Tool | Source File or Pipeline | Notes | Owner |
|------------|--------------|-------------------------|-------|-------|
| Local environment | | | | |
| Test suite | | | | |
| Staging deploy | | | | |
| Production deploy | | | | |
| Logs & metrics | | | | |
| Infrastructure apply | | | | |
| Emergency rollback | | | | |
```

#### Critical Endpoints & Resources
```markdown
- Production URLs: [list + purpose]
- Staging URLs: [list + authentication flow]
- Admin/Backoffice URLs: [list + access model]
- Monitoring dashboards: [links + owners + primary metrics]
- CI/CD pipelines: [links + approval requirements]
- Feature flag consoles: [links + governance]
- Documentation hubs: [links + update cadence]
- Status page / incident comms: [links + escalation path]
```

#### First-Week Checklist
```markdown
- [ ] Access granted for repositories, cloud accounts, monitoring, automation platforms, and secrets
- [ ] Local environment operational with sample data and automation integrations
- [ ] Completed staging deployment end-to-end with rollback rehearsal
- [ ] Reviewed key runbooks, SLA commitments, and this analysis
- [ ] Understood on-call expectations, escalations, and reseller impact
- [ ] Validated secrets management and compliance requirements
- [ ] Synced with product/CS on customer journey insights
- [ ] Logged first improvement ticket aligned with Immediate Priorities
```

### 14. Recommendations Roadmap
- **Week 1 – Critical Setup & Stabilisation**: Access, environment validation, urgent fixes, monitoring verification, automation health checks.
- **Month 1 – Foundation & Visibility**: Close documentation gaps, improve observability, address top reliability issues, refine customer journey touchpoints.
- **Quarter 1 – Strategic Enhancements**: Architectural evolution, cost optimisation, automation expansion, reseller enablement, education assets.
- For each phase, outline primary goals, measurable outcomes, stakeholders, dependencies, and go/no-go criteria.

---

## Writing Guidelines

### Tone
- **Direct**: Trust the reader’s expertise; speak plainly.
- **Honest**: Call out gaps, failures, and unknowns without hedging.
- **Specific**: Support claims with paths, configs, metrics, owners, or stakeholder input.
- **Actionable**: Pair every observation with recommended next steps or decision points.
- **Brand-aligned**: Emphasise operator outcomes, privacy, security, and rapid deployability.

### Formatting
- Use tables for structured data, bullet lists for concise enumerations, code blocks for excerpts or schemas (not invented commands).
- Include section links in the table of contents for navigation.
- Use emoji sparingly for emphasis (🔑 critical, ⚠️ risk, 💰 cost, 🔐 security, 🤖 automation).
- Cite file paths (`path/to/file:line`) or dashboard URLs to ground assertions in source material.

### Quality Standards
- **Accuracy**: Validate against code, configuration, documentation, and production telemetry. Mark unknowns clearly with follow-up owners.
- **Completeness**: Cover infrastructure, application logic, automations, data lifecycle, operations, and customer impact.
- **Traceability**: Note sources (commit hashes, ticket IDs, dashboards, interviews) for later verification.
- **Maintainability**: Structure content so future updates require minimal effort and align with master directory standards.

### What to Avoid
- Generic best practices with no tie to this system.
- Repeating repository scripts or boilerplate without context.
- Vague risk statements lacking mitigation guidance or owners.
- Tutorial-style explanations of common tooling.
- Unverified assumptions or speculation presented as fact.
- Command sequences that instruct the engineer to run unvetted actions.

---

## Execution Instructions
1. **Survey systematically**: Start with README, CHANGELOG, and master directory standards, then walk the repository tree.
2. **Observe production reality**: Inspect pipelines, infrastructure state, monitoring dashboards, automation consoles, and customer telemetry where available.
3. **Cross-reference**: Validate documentation against code/config; highlight mismatches and missing assets.
4. **Interview artefacts & people**: If human context is missing, list required follow-ups (operators, product, CS, resellers) for [ENGINEER_NAME].
5. **Document specifics**: Capture commands, URLs, file paths, config keys, metric IDs, and owner names verbatim.
6. **Evaluate dependencies**: Note external commitments (SLAs, contracts, reseller agreements) and operational responsibilities.
7. **Assess customer impact**: Tie technical observations back to operator and customer outcomes, SLAs, and commercial goals.
8. **Promote reuse**: Flag insights or assets that should feed Start AI Tools, internal slash commands, or public collateral.

---

## Special Focus Areas

### Service Architecture
- Maintain a complete inventory of services, communication patterns (REST, gRPC, event streams), and data contracts.
- Flag coupling, single points of failure, scaling bottlenecks, or resilience gaps with remediation paths.

### Infrastructure Management
- Detail environment promotion strategy, state storage, access controls, audit trails, and compliance artefacts.
- Include disaster recovery posture, failover testing results, budgeted RTO/RPO, and governance committees.

### Automation & Agent Ecosystem
- Connect n8n flows, MCP connectors, slash-command prompts, and AI agents back to business outcomes.
- Identify ownership gaps, monitoring debt, or duplicated automations; propose consolidation or deprecation.

### Data Governance & Compliance
- Map data classification, retention policies, PII handling, regulatory obligations, and privacy filters.
- Note data lineage, anonymisation processes, data residency, and audit evidence locations.

### Existing Documentation
- Reference, reconcile, and elevate runbooks, ADRs, onboarding guides, reseller playbooks, and customer comms.
- Recommend a maintenance plan: owners, review cadence, triggers, and integration with master directory standards.

---

## Deliverable Format

```markdown
# [PROJECT_NAME]: Operator-Grade System Analysis & Operations Guide
*For: [ENGINEER_NAME] (DevOps Engineer)*
*Generated: [Date]*  
*System Version: [version file, git tag, or commit hash]*

---

## Table of Contents
[Auto-generated, linked TOC covering Sections 1–14 and Appendices]

---

[Sections 1–14 as defined above]

---

## Appendices

### Appendix A. Glossary
Key domain terms, acronyms, and abbreviations with definitions.

### Appendix B. Reference Links
Dashboards, repositories, documentation portals, runbooks, reseller assets.

### Appendix C. Troubleshooting Playbooks
Common incidents, error signatures, escalation steps, known fixes, automation fallbacks.

### Appendix D. Change Management & Governance
Release calendars, CAB process, audit requirements, document update workflow.

### Appendix E. Open Questions
Outstanding uncertainties, required stakeholder follow-ups, data gaps, decision deadlines.
```

**Target Length**: 10,000–20,000 words — exhaustive yet purposeful.  
**Success Metric**: [ENGINEER_NAME] can operate, improve, and advocate for the system after a single end-to-end read-through.

---

## Customisation Checklist
Before using this prompt, update:
- `[PROJECT_NAME]`, `[ENGINEER_NAME]`, environment names, and any branded references.
- Directory structure to mirror the actual repository (add/remove sections as needed).
- Technology/automation tables to match the real stack (frontend, backend, data, infra, AI/ML, observability).
- Customer journey and operator personas to reflect real audiences and SLAs.
- Compliance, cost, and performance sections aligned with actual metrics, policies, and reseller obligations.
- Links to existing prompts/automation assets that should feed the Deliverables.

## Final Notes
This prompt is the blueprint for a living operational manual. Capture reality—even when incomplete—and signpost how [ENGINEER_NAME] can close gaps. Optimise for trust, clarity, and immediate usability over polish. Mark any unverified assumptions, and recommend concrete next steps when information is missing. Tie findings back to operator outcomes, security posture, and Intent Solutions’ service lines so the playbook becomes a reusable asset across clients and internal teams.
```
