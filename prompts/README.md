---
title: Intent Solutions Prompt Library
generated: 2025-10-16
---

# Intent Solutions Prompt Library

Operator-grade prompts curated for Intent Solutions engagements. Each asset aligns with our service lines (Private AI, AI Agents, Automation, Cloud & Data, Learn) and follows the same front-matter schema.

| ID | Title | Service Line | Primary Use |
|----|-------|--------------|-------------|
| `15-ops-devops-system-analysis` | Operator-Grade System Analysis | Cloud & Data | Build the definitive operations guide for a live platform. |
| `15-ops-github-release-runbook` | Operator Release Runbook | Cloud & Data | Prepare audit-ready GitHub release documentation and comms. |
| `03-cloud-architecture-due-diligence` | Cloud Architecture Due Diligence | Cloud & Data | Evaluate infrastructure fitness for scale, security, cost. |
| `03-cloud-observability-audit` | Observability & Reliability Audit | Cloud & Data | Diagnose telemetry coverage and incident readiness. |
| `03-cloud-security-hardening` | Cloud Security Hardening Playbook | Cloud & Data | Produce prioritized hardening plan with compliance mapping. |
| `01-auto-n8n-flow-upgrade` | n8n Workflow Resilience Upgrade | Automation | Refactor automations for reliability and reseller packaging. |
| `01-auto-incident-escalation` | Automation-Assisted Incident Escalation | Automation | Design blended human/automation escalation workflow. |
| `01-agent-copilot-design` | Operator Copilot Design Workshop | AI Agents | Blueprint a Claude-based copilot tailored to operator workflows. |
| `01-agent-slash-command-draft` | Slash Command Prompt Drafting | AI Agents | Create reusable slash-command prompts tied to this library. |
| `01-ai-private-model-rollout` | Private Model Rollout Plan | Private AI | Launch private models with safety, observability, and training. |
| `12-learn-operator-onboarding` | Operator Onboarding Curriculum | Learn | Build a two-week enablement plan for new operators. |
| `12-learn-master-doc-filing` | Master Documentation Filing System | Learn | Maintain sequential documentation discipline across engagements. |
| `12-learn-prompt-retrospective` | Prompt Retrospective Workshop | Learn | Run continuous improvement workshop for the library. |

## Front Matter Schema

```yaml
---
id: unique-slug
title: Human-readable name
service_line: cloud-data | automation | ai-agents | private-ai | learn
audience: primary reader
intent: one-sentence job to be done
last_reviewed: YYYY-MM-DD
model_hint: claude-3-5-sonnet
tone: descriptor
delivery: expected deliverable format
---
```

## Usage Guidelines
- Prompts assume operator-first tone, evidence-backed outputs, and Vertex-first security commitments.
- Remove or adapt sections that do not match your project, but keep the structure to maintain quality.
- Update `last_reviewed` whenever you refresh facts, metrics, or links.
- Archive superseded prompts under `99-Archive/legacy-prompts/` with an AAR note.
- Maintain the alphabetical index prefix (`01-`, `03-`, `12-`, etc.) so files stay ordered across tools.

## Contributing
1. Duplicate the template from this README.
2. Align content with one of the service lines.
3. Ensure no shell commands are embedded—describe workflows instead.
4. Add the prompt to the table above and update GitHub Pages data (see `/site` once generated).
5. Run markdown linting and submit PR with before/after summary plus screenshots of rendered prompt if relevant.

Questions? Reach out via `jeremy@intentsolutions.io` or open an issue.*** End Patch
