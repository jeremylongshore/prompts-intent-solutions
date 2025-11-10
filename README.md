# Intent Solutions Prompt Library

[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-Live-brightgreen)](https://jeremylongshore.github.io/prompts-intent-solutions/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Operator-grade prompts for Intent Solutions engagements. Every asset mirrors our service lines—Private AI, AI Agents, Automation, Cloud & Data, and Learn—and is written for production operators, resellers, and execs who expect receipts.

**🌐 [Browse the live catalog](https://jeremylongshore.github.io/prompts-intent-solutions/)**  
**📬 [Start a project](mailto:jeremy@intentsolutions.io)**

## Library Snapshot

| Service Line | Flagship Prompt | What it Delivers |
|--------------|----------------|------------------|
| Cloud & Data | [`15-ops-devops-system-analysis`](prompts/15-ops-devops-system-analysis.md) | The definitive operations guide for a platform hand-off. |
| Cloud & Data | [`15-ops-github-release-runbook`](prompts/15-ops-github-release-runbook.md) | Release documentation, deployment plan, and communications pack. |
| Cloud & Data | [`03-cloud-security-hardening`](prompts/03-cloud-security-hardening.md) | Prioritised hardening backlog mapped to compliance frameworks. |
| Automation | [`01-auto-n8n-flow-upgrade`](prompts/01-auto-n8n-flow-upgrade.md) | Resilient n8n workflow blueprint ready for reseller packaging. |
| Automation | [`01-auto-incident-escalation`](prompts/01-auto-incident-escalation.md) | Automation-assisted escalation matrix with communication scripts. |
| AI Agents | [`01-agent-copilot-design`](prompts/01-agent-copilot-design.md) | Claude copilot design brief tied to operator workflows. |
| AI Agents | [`01-agent-slash-command-draft`](prompts/01-agent-slash-command-draft.md) | Slash-command bundle aligned with this library’s standards. |
| Private AI | [`01-ai-private-model-rollout`](prompts/01-ai-private-model-rollout.md) | Safe, observable rollout plan for private models on Vertex/Bedrock. |
| Learn | [`12-learn-operator-onboarding`](prompts/12-learn-operator-onboarding.md) | Two-week enablement curriculum for new operator teams. |
| Learn | [`12-learn-master-doc-filing`](prompts/12-learn-master-doc-filing.md) | Chronological documentation discipline for every deliverable. |
| Learn | [`12-learn-prompt-retrospective`](prompts/12-learn-prompt-retrospective.md) | Workshop to measure, tune, and sunset prompts responsibly. |

See the full index in [`prompts/README.md`](prompts/README.md) or explore via the GitHub Pages site above.

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

## How to Use
1. **Pick the prompt** that matches your engagement or slash command.
2. **Fill in variables** like project name, stakeholders, or severity levels.
3. **Feed into Claude** (or the approved model) and iterate with evidence.
4. **Capture outputs** in `01-Docs/` using the [MASTER DIRECTORY STANDARDS](.directory-standards.md).
5. **Keep numeric prefixes** (`01-`, `03-`, `12-`, `15-`) intact so sorting stays consistent across tooling.
6. **Archive variants** to `99-Archive/legacy-prompts/` once superseded and note the change in an AAR.

## Contributing New Prompts
1. Duplicate the schema above and align to the proper service line.
2. Keep instructions operator-first; describe decisions, not shell commands.
3. Reference real artefacts (file paths, dashboards, tickets) so outputs are verifiable.
4. Update `prompts/README.md`, run `python tools/generate_prompt_catalog.py`, and add the card to the site if needed.
5. Include before/after screenshots or summaries when opening a pull request.

## Directory Standards

This repository follows [`MASTER DIRECTORY STANDARDS`](.directory-standards.md):
- Documentation lives under `01-Docs/` with `NNN-CC-ABCD-description.ext` naming.
- Prompt library is flat under `prompts/` with kebab-case file names.
- Superseded assets move to `99-Archive/legacy-prompts/` with an associated after-action report.

## License

MIT License — see [`LICENSE`](LICENSE).

---

**Intent Solutions** · Operator-first AI systems · [intentsolutions.io](https://intentsolutions.io) · [startaitools.com](https://startaitools.com)
