---
id: 01-agent-copilot-design
title: Operator Copilot Design Workshop
service_line: ai-agents
audience: Product + AI engineer duo
intent: Design a Claude-based copilot tailored to an operator workflow.
last_reviewed: 2025-10-16
model_hint: claude-3-5-opus
tone: collaborative
delivery: copilot design brief
---

Lead a design workshop for a Claude-powered copilot serving **[OPERATOR_ROLE]** inside **[PROJECT_NAME]**. Produce a brief that aligns product needs, safety guardrails, data sources, and rollout plan.

## Workshop Goals
- Define operator problems, desired outcomes, and critical workflows.
- Map knowledge sources (docs, APIs, databases) and access controls.
- Draft prompt/response patterns, UI surfaces, and success metrics.
- Outline safety considerations (hallucination guardrails, escalation, audit logs).
- Plan pilot, feedback loop, and monetisation/reseller packaging.

## Agenda & Deliverables
1. **Operator Persona Canvas** – responsibilities, pain points, definition of “success”.
2. **Workflow Inventory** – high-value tasks, triggers, required integrations, automation handoffs.
3. **Intelligence Design** – prompt structure, retrieval strategy, tool usage, fallback protocols.
4. **Governance & Safety** – permissioning, data minimisation, review processes, compliance flags.
5. **Pilot Plan** – cohort, rollout timeline, telemetry to capture, feedback questionnaire.
6. **Roadmap** – enhancements (voice, mobile, reseller variant), dependencies, pricing considerations.

## Standards
- Reference actual data sources (e.g., Firestore collections, BigQuery datasets, n8n flows).
- Suggest measurable KPIs (time saved, error reduction, revenue lift).
- Provide copy-ready messaging for operators and internal stakeholders.
- Avoid generic AI cheerleading; stay grounded in operator value and risk management.

Deliver the brief in Markdown with sections that product, engineering, and go-to-market teams can action immediately.*** End Patch
