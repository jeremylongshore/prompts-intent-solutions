---
id: 01-agent-slash-command-draft
title: Slash Command Prompt Drafting
service_line: ai-agents
audience: AI engineer
intent: Craft reusable slash-command prompts for Claude that mirror Intent Solutions standards.
last_reviewed: 2025-10-16
model_hint: claude-3-5-opus
tone: precise
delivery: slash command bundle
---

Design a set of slash commands tailored to **[TEAM_NAME]** so they can invoke Intent Solutions-grade prompts inside Claude without rereading long docs.

## Requirements
- Three commands minimum (e.g., `/ops-audit`, `/release-brief`, `/automation-plan`).
- Each command includes trigger description, ideal inputs, output contract, and safety notes.
- Prompts must align with the corresponding library assets in this repo.
- Provide example payloads and expected responses for operator onboarding.

## Process
1. Interview target workflows—what decisions or outputs do operators need quickly?
2. Select or adapt base prompts from this library; strip extraneous sections.
3. Write concise command prompts (≤ 400 tokens) with parameter placeholders.
4. Document limitations, guardrails, and follow-up prompts for iterative refinement.

## Deliverable Layout
1. **Command Overview Table** – command, use case, primary audience, linked base prompt.
2. **Detailed Specs** – for each command: inputs, main prompt body, output format, handoff steps.
3. **Usage Examples** – real-world scenario with input + trimmed response.
4. **Maintenance Notes** – review cadence, owner, metrics to track (usage, satisfaction).

## Standards
- Keep commands model-agnostic but optimised for Claude 3.5.
- Highlight where commands should refuse (e.g., missing context, security concerns).
- Reference actual repos, runbooks, or dashboards when giving examples.
- Avoid telling users to run shell commands directly; frame in terms of outcomes.

Deliver the slash command bundle in Markdown so it can be pasted into internal documentation or the Claude command editor.*** End Patch
