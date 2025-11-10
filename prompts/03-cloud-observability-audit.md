---
id: 03-cloud-observability-audit
title: Observability & Reliability Audit
service_line: cloud-data
audience: SRE lead
intent: Diagnose observability coverage and reliability posture across the platform.
last_reviewed: 2025-10-16
model_hint: claude-3-5-sonnet
tone: investigative
delivery: audit report
---

Evaluate **[PROJECT_NAME]** like an Intent Solutions SRE parachuted in after a surprise incident. Document how well the platform can detect, respond, and learn from production issues.

## Key Questions
- What signals (logs, metrics, traces, events) do we collect, and where are the blind spots?
- How quickly can operators detect, triage, and mitigate incidents?
- Which services or automations lack health checks, synthetic tests, or runbooks?
- Do SLOs align with customer commitments and reseller obligations?

## Investigation
1. Enumerate monitoring assets (dashboards, alerts, synthetics, error budgets) with links and owners.
2. Trace incident history (PagerDuty, Opsgenie, postmortems) for recurring patterns and MTTR.
3. Inspect code and infrastructure for instrumentation (OpenTelemetry, structured logging, custom metrics).
4. Review automation (n8n, scripts) for alert routing, escalation, and rollback helpers.
5. Compare documented SLOs/SLAs against actual performance and detection quality.

## Report Sections
1. **Signal Coverage Map** – matrix of services × telemetry types with quality scores.
2. **Incident Readiness** – on-call process, playbooks, runbook quality, communication templates.
3. **Gaps & Risks** – ranked list of blind spots, noisy alerts, missing dashboards, or brittle automations.
4. **Improvement Plan** – 30/60/90-day priorities with required tooling, owners, and expected ROI.
5. **Reference Pack** – links to dashboards, alerts, runbooks, and escalation trees for onboarding.

## Standards
- Quantify detection lag, MTTR, and alert reliability wherever possible.
- Highlight automation opportunities (self-healing, auto-remediation, chatops).
- Flag any reliance on tribal knowledge or manual heroics.
- Provide clear acceptance criteria for closing each gap.

Deliver the audit in Markdown, concluding with a readiness score (0–5) and next review date.*** End Patch
