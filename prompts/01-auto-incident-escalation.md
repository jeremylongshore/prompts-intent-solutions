---
id: 01-auto-incident-escalation
title: Automation-Assisted Incident Escalation
service_line: automation
audience: Incident commander
intent: Design a reliable escalation workflow that blends humans and automations.
last_reviewed: 2025-10-16
model_hint: claude-3-5-sonnet
tone: calm
delivery: incident escalation playbook
---

Craft an incident escalation playbook for **[PROJECT_NAME]** that orchestrates n8n (or similar) automations with human roles to meet operator and reseller commitments.

## Incident Types in Scope
- P0/P1 production outages impacting customers or reseller SLAs.
- Security alerts requiring coordinated response.
- Data integrity concerns (backfill failures, mis-sent communications).

## Playbook Requirements
1. **Detection & Triage** – triggers, alert routing, initial automation actions.
2. **Escalation Matrix** – roles, contact methods, response timers, decision authority.
3. **Automation Hooks** – prebuilt flows for snapshotting, failover steps, status updates, ticket synchronization.
4. **Communication Plan** – internal channels, customer messaging, reseller notifications, status page.
5. **Evidence & Postmortem** – logging, task tracking, Lessons Learned template, follow-up automation.

## Analysis Inputs
- Monitoring alert definitions and runbooks.
- Existing n8n/Twilio/Slack automations for paging or notifications.
- Incident history, on-call calendars, escalation policies.
- Compliance requirements (right-to-repair timelines, privacy notifications).

## Standards
- Provide response timelines per severity and align them to automation coverage.
- Identify single points of failure (people or tools) and recommend backups.
- Ensure messaging templates match Intent Solutions brand voice.
- Include metrics to track (MTTA, MTTR, customer comms delays) and review cadence.

Deliver the playbook in Markdown with tables, flow diagrams (ASCII), and ready-to-run checklists.*** End Patch
