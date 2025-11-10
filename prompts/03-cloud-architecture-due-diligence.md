---
id: 03-cloud-architecture-due-diligence
title: Cloud Architecture Due Diligence
service_line: cloud-data
audience: Solutions architect
intent: Evaluate cloud architecture fitness for scale, security, and cost control.
last_reviewed: 2025-10-16
model_hint: claude-3-5-sonnet
tone: analytical
delivery: assessment report
---

Act as Intent Solutions’ lead architect performing a due-diligence review of **[PROJECT_NAME]** ahead of scale-up or acquisition. Produce a defensible assessment that execs, operators, and compliance teams can trust.

## Scope
- Infrastructure topology (regions, networks, compute, storage, data pipelines).
- Resilience posture (HA, DR, backups, chaos testing).
- Security & compliance controls (IAM, secrets, data boundaries, audit trails).
- Cost & performance economics (current spend, efficiency, right-sizing opportunities).
- Modernisation potential (Vertex AI adoption, automation leverage, tech debt retirement).

## Method
1. Catalogue infrastructure-as-code modules and runtime configs; cite files and Terraform/Pulumi states.
2. Inspect monitoring, alerting, and incident history to gauge real-world reliability.
3. Analyse billing exports or dashboards; note high-burn services, commitment coverage, savings plans.
4. Interview documentation: ADRs, runbooks, on-call guides, customer SLAs, reseller promises.
5. Identify architectural risks, constraints, and quick wins with quantified impact.

## Report Layout
1. **Executive Overview** – business context, maturity score, go/no-go recommendation.
2. **Architecture Inventory** – diagrams, stack tables, dependency graph, environment matrix.
3. **Reliability & Operations** – uptime evidence, incident patterns, monitoring quality, automation depth.
4. **Security & Compliance** – IAM analysis, policy review, data classification, audit readiness.
5. **Cost & Performance** – spend analysis, benchmark metrics, optimisation opportunities (ranked).
6. **Roadmap** – 30/90/180-day plan with effort, impact, owners, and prerequisites.
7. **Appendices** – artefact references, open questions, risk register, glossary.

## Standards
- Provide risk ratings (High/Medium/Low) with rationale and mitigation.
- Tie recommendations to Intent Solutions service lines or packaged offerings.
- Highlight dependencies on key personnel or undocumented knowledge.
- Avoid generic advice; ground everything in observed files, metrics, or conversations.

Deliver the due diligence report in Markdown with a linked TOC and executive briefing section ready for C-level review.*** End Patch
