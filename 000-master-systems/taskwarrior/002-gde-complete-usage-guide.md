# Taskwarrior Integration Prompt - Complete Usage Guide

**Last Updated:** 2025-10-08
**Version:** 1.0.0
**Status:** COMPREHENSIVE GUIDE – Reference for Taskwarrior integration

---

## Table of Contents

1. [Overview](#overview)
1. [Quick Start](#quick-start)
1. [Usage Patterns](#usage-patterns)
1. [Advanced Scenarios](#advanced-scenarios)
1. [Troubleshooting](#troubleshooting)
1. [Customization](#customization)

-----

## Overview

### What This Prompt Does

This universal integration prompt forces Claude to use Taskwarrior for ALL coding tasks, ensuring:

- **Task tracking** - Every coding activity becomes a trackable task
- **Time accounting** - Automatic Timewarrior integration for time tracking
- **Dependency management** - Complex projects are broken into linked subtasks
- **Workflow transparency** - Complete audit trail of all work performed

### Prerequisites

- Linux environment with Taskwarrior installed
- Timewarrior installed (optional but recommended)
- Basic familiarity with Taskwarrior commands (or willingness to learn!)

-----

## Quick Start

### Method 1: Single-Use Application (Most Common)

Copy the entire Taskwarrior Integration Protocol prompt and paste it before your coding request:

```
[PASTE FULL TASKWARRIOR INTEGRATION PROMPT]

---

Now help me build a Python script that scrapes weather data from NOAA.
```

**Result:** Claude will decompose your request into Taskwarrior tasks, create them, start them, write the code, then complete them.

### Method 2: Conversation-Level Enforcement

For ongoing conversations where you'll make multiple coding requests, use this initialization:

**First Message:**

```
For the duration of this conversation, you are operating under the Taskwarrior Integration Protocol. Every coding task must follow the complete lifecycle:

1. Task decomposition with `task add` (with project:, priority:, due:, tags:)
2. Task activation with `task start`
3. Code implementation
4. Task completion with `task done`

[PASTE FULL TASKWARRIOR INTEGRATION PROMPT]

Confirm you understand and will enforce this protocol for all subsequent requests.
```

**Subsequent Messages:**

```
[TW Protocol Active] - Refactor the weather script to use async/await
```

-----

## Usage Patterns

### Pattern 1: Simple Single-Task Request

**Your Prompt:**

```
[TASKWARRIOR INTEGRATION PROMPT]

---

Create a Bash script that backs up my home directory to /mnt/backup
```

**What Claude Will Do:**

1. Create a single task: `task add "Create backup script" project:DevOps priority:M due:today +scripting +automation`
1. Start the task: `task 1 start`
1. Write the Bash script
1. Complete the task: `task 1 done`
1. Show time summary: `timew summary :ids`

### Pattern 2: Complex Multi-Step Project

**Your Prompt:**

```
[TASKWARRIOR INTEGRATION PROMPT]

---

Build a full REST API with authentication, user management, and a PostgreSQL database using FastAPI
```

**What Claude Will Do:**

1. Create parent task: `task add "Build FastAPI REST API" project:WebDev priority:H due:3days +api +backend`
1. Create subtasks with dependencies:
- Database schema design (depends on parent)
- Authentication system (depends on database)
- User management endpoints (depends on auth)
- API documentation (depends on endpoints)
1. Start first task in dependency chain
1. Implement each component in order
1. Complete tasks sequentially, respecting dependencies

### Pattern 3: Debugging/Investigation Task

**Your Prompt:**

```
[TASKWARRIOR INTEGRATION PROMPT]

---

My Node.js application is crashing with "ECONNREFUSED" - help me debug this
```

**What Claude Will Do:**

1. Create investigation task: `task add "Debug ECONNREFUSED error" project:Debugging priority:H due:today +debugging +nodejs +urgent`
1. Start task
1. Provide debugging steps and code analysis
1. Annotate task with findings: `task 1 annotate "Root cause: PostgreSQL not running"`
1. Complete task with resolution notes

### Pattern 4: Recurring/Maintenance Task

**Your Prompt:**

```
[TASKWARRIOR INTEGRATION PROMPT]

---

Create a script that I need to run weekly to clean up old Docker images
```

**What Claude Will Do:**

1. Create recurring task: `task add "Weekly Docker cleanup" project:Maintenance recur:weekly due:friday +automation +docker`
1. Write the cleanup script
1. Complete the initial instance
1. Note that future instances will auto-generate weekly

-----

## Advanced Scenarios

### Scenario 1: Mid-Task Scope Change

If requirements change while Claude is working:

**You Say:**

```
Actually, also add email notifications when the backup completes
```

**Claude Will:**

1. Modify existing task: `task 1 modify +email +notifications`
1. Create dependent subtask: `task add "Implement email notifications" depends:1 +email`
1. Continue with expanded scope
1. Complete both tasks

### Scenario 2: Blocked Task Handling

If Claude encounters a blocker (missing credentials, API limits, etc.):

**Claude Will:**

1. Stop the task: `task 1 stop`
1. Annotate the blocker: `task 1 annotate "Blocked: Need AWS credentials"`
1. Mark as blocked: `task 1 modify +blocked`
1. Explain what's needed to unblock
1. Wait for your input before resuming

### Scenario 3: Multi-Session Work

For projects spanning multiple conversations:

**Session 1:**

```
[TASKWARRIOR INTEGRATION PROMPT]
---
Start building the e-commerce platform - just the product catalog for now
```

**Session 2 (Later):**

```
Continue the e-commerce platform - now add shopping cart functionality

Before starting, check my pending tasks:
task project:Ecommerce status:pending
```

Claude will integrate new work with existing Taskwarrior tasks.

### Scenario 4: Integration with Your Existing Tasks

If you already have Taskwarrior tasks and want Claude to work within that system:

**Your Prompt:**

```
[TASKWARRIOR INTEGRATION PROMPT]

---

I have task 42 in my Taskwarrior: "Optimize database queries"
Help me complete this task - start it, do the work, and mark it done.
```

**Claude Will:**

1. Use your existing task: `task 42 start`
1. Provide optimization recommendations/code
1. Complete your task: `task 42 done`

-----

## Troubleshooting

### Issue 1: Claude Doesn't Create Tasks Before Coding

**Symptom:** Claude jumps straight to code without running `task add` commands

**Solution:** Re-emphasize the mandate:

```
STOP. You must create Taskwarrior tasks BEFORE writing any code.
Re-read the protocol and start with Phase 1: Task Decomposition.
```

### Issue 2: Tasks Lack Proper Attributes

**Symptom:** Tasks created without `project:`, `priority:`, or `tags:`

**Solution:** Add this to your prompt:

```
CRITICAL: All tasks must include:
- project: (categorize the work)
- priority: (H/M/L based on urgency)
- due: (realistic deadline)
- At least 2 relevant tags
```

### Issue 3: No Time Tracking

**Symptom:** Tasks created but not started (no `task start` command)

**Solution:** Explicitly request:

```
Reminder: Phase 2 requires `task <ID> start` to activate time tracking.
Show me the `task active` output to prove tracking is running.
```

### Issue 4: Tasks Not Completed

**Symptom:** Code is delivered but task remains open

**Solution:** Always end your evaluation with:

```
Now complete the task lifecycle - run `task <ID> done` and show me the summary.
```

-----

## Customization

### Customization 1: Default Project Names

Modify the prompt to use your standard project taxonomy:

**Find this section in the prompt:**

```bash
project:<project_name>
```

**Replace with your naming convention:**

```bash
project:<YourCompany>.<Category>  # e.g., project:Acme.Backend
```

### Customization 2: Adjust Urgency Weights

If you want Claude to emphasize different factors, add this to the prompt:

```
## Custom Urgency Configuration
Before creating tasks, set these urgency weights:
task config urgency.user.tag.urgent.coefficient 12.0
task config urgency.user.tag.critical.coefficient 15.0
task config urgency.age.coefficient 0.0  # Disable age factor
```

### Customization 3: Add Custom Tags

Expand the tagging vocabulary for your workflow:

**Add to the "Required Attributes" section:**

```
- Custom tags: +sprint_current, +architecture, +security, +performance
```

### Customization 4: Team Collaboration Mode

If working in a shared Taskwarrior environment:

**Add this section:**

```
## Team Collaboration Rules
1. Use annotation to claim tasks: `task <ID> annotate "Claimed by: [Your Name]"`
2. Set `+teamwork` tag for tasks that need review
3. Use `depends:` to block team members from duplicate work
```

### Customization 5: Minimal Mode (Fast Iteration)

For rapid prototyping where full tracking is overkill:

**Simplified prompt:**

```
# TASKWARRIOR INTEGRATION - MINIMAL MODE

Create ONE task for this entire request:
task add "[request summary]" project:RapidPrototype priority:M +prototype

Start it: task <ID> start
[Write code]
Done it: task <ID> done

Now proceed with: [YOUR CODING REQUEST]
```

-----

## Integration with Other Tools

### VS Code Integration

Use Taskwarrior extensions to see your tasks while coding:

- Install "Taskwarrior" extension by Alex Lushpai
- Tasks created by Claude appear in your sidebar
- Start/stop directly from VS Code

### CI/CD Pipeline Integration

Create tasks for automated builds:

```
[TASKWARRIOR INTEGRATION PROMPT]
---
Create a GitHub Actions workflow that automatically creates a Taskwarrior task
for each deployment and marks it done on success
```

### Timewarrior Reports

After a work session, analyze time spent:

```
timew summary :ids               # Total time per task
timew report :ids :week          # This week's breakdown
timew tags                       # Most-used tags
```

-----

## Best Practices

### ✅ DO:

- Use the prompt for ALL coding activities (even small ones)
- Review `task next` before starting new work to prioritize properly
- Let tasks accumulate to build a historical record
- Use annotations liberally to document decisions
- Leverage the urgency algorithm by setting proper attributes

### ❌ DON'T:

- Skip the prompt for "quick" tasks (they add up!)
- Let Claude write code before creating tasks
- Forget to complete tasks when work is done
- Ignore the dependency system for related work
- Use generic descriptions ("Fix bug" vs. "Fix OAuth redirect loop")

-----

## Success Metrics

Track these to measure the system's value:

```bash
# Total tasks completed
task count status:completed

# Average task duration
timew summary :ids | grep Total

# Most productive project
task summary

# Task completion rate
task completed status:completed due.before:today
```

-----

## Quick Reference Card

|Scenario              |Command Pattern                                                                  |
|----------------------|---------------------------------------------------------------------------------|
|**Single simple task**|Prepend full prompt → one `task add` → code → `task done`                        |
|**Complex project**   |Prepend full prompt → multiple `task add` with `depends:` → sequential completion|
|**Debugging**         |Priority:H + `+debugging` tag → annotate findings → complete with resolution     |
|**Recurring work**    |Add `recur:daily/weekly/monthly` → first instance completes, rest auto-generate  |
|**Blocked work**      |`task stop` → annotate blocker → `+blocked` tag → resume later                   |
|**Continuing work**   |Reference existing task ID → `task <ID> start` → add code → `task <ID> done`     |

-----

## Support & Further Reading

- **Taskwarrior Docs:** https://taskwarrior.org/docs/
- **Timewarrior Docs:** https://timewarrior.net/docs/
- **Best Practices:** https://taskwarrior.org/docs/best-practices.html
- **Urgency Deep Dive:** See the provided Project Knowledge File on urgency algorithms

-----

**You're now ready to enforce Taskwarrior discipline in all your AI-assisted coding work!**

---

**Master Location:** `~/projects/prompts-intent-solutions/000-master-systems/taskwarrior/TASKWARRIOR-002-complete-usage-guide.md`

**Related Documents:**
- Mandatory protocol: `TASKWARRIOR-001-mandatory-integration-protocol.md`
- Task tracking systems: `~/projects/prompts-intent-solutions/000-master-systems/tracking/`

---

*TASKWARRIOR USAGE GUIDE – Complete Reference for AI Integration*
