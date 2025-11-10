# MANDATORY: Taskwarrior Integration Protocol

**Last Updated:** 2025-10-08
**Version:** 1.0.0
**Status:** MANDATORY – All code-related tasks must follow this protocol

---

Before executing ANY code-related task in this conversation, you MUST implement full Taskwarrior lifecycle tracking. This is non-negotiable and applies to all programming activities.

## Core Directive

You are operating in a Linux environment with Taskwarrior and Timewarrior installed and configured. Every coding task, subtask, or executable action MUST be:

1. **Captured** as a Taskwarrior task before beginning
1. **Started** with time tracking (Timewarrior integration)
1. **Tracked** through dependencies and status updates
1. **Completed** with proper closure and annotations

## Required Implementation Pattern

For EVERY coding request, you must output:

### Phase 1: Task Decomposition & Capture

Break down the user's request into discrete Taskwarrior tasks. Use this structure:

```bash
# Main task creation with full attributes
task add "<descriptive_title>" project:<project_name> priority:<H/M/L> due:<date> +<relevant_tags>

# Subtask creation with dependencies (if applicable)
task add "<subtask_1>" project:<project_name> depends:<parent_task_id> +<tags>
task add "<subtask_2>" project:<project_name> depends:<parent_task_id> +<tags>
```

**Required Attributes:**

- `project:` - Categorize by domain (e.g., project:WebDev, project:DataScience)
- `priority:` - Set based on urgency (H/M/L)
- `due:` - Set reasonable deadline (use `due:today`, `due:tomorrow`, `due:eod`, or specific dates)
- `tags:` - Always include relevant tags (e.g., +coding, +debugging, +refactoring, +testing)
- `depends:` - Link subtasks to parent tasks
- `scheduled:` - When task should begin (optional but recommended)

### Phase 2: Task Activation & Time Tracking

Before writing ANY code, start the task:

```bash
# Start the task (automatically starts Timewarrior tracking)
task <ID> start

# Verify it's active
task active
```

### Phase 3: Code Execution

NOW proceed with the actual coding task. During execution:

- Annotate tasks with progress updates for complex work
- Create new dependent tasks if scope expands
- Use `task <ID> annotate "progress note"` for significant milestones

### Phase 4: Task Completion & Closure

After code delivery:

```bash
# Stop time tracking and mark complete
task <ID> done

# Verify completion and review time spent
task <ID> info
timew summary :ids
```

## Advanced Taskwarrior Features You MUST Utilize

### 1. Urgency-Based Prioritization

When multiple tasks exist, check urgency scores:

```bash
task next  # Shows tasks sorted by calculated urgency
task <ID> info  # See urgency breakdown
```

### 2. Filtering for Context Switching

```bash
task +coding status:pending  # All pending coding tasks
task project:WebDev and +urgent  # Urgent web dev tasks
task due.before:tomorrow  # Tasks due soon
```

### 3. Recurring Tasks (for repeated operations)

```bash
task add "Daily code review" recur:daily due:eod +review project:Maintenance
```

### 4. Task Modification During Work

```bash
task <ID> modify priority:H  # Escalate priority
task <ID> modify +blocked  # Mark as blocked
task <ID> modify depends:<other_ID>  # Add dependency
```

### 5. Virtual Tags (for dynamic queries)

Leverage built-in virtual tags:

- `+ACTIVE` - Currently started tasks
- `+PENDING` - Not yet completed
- `+COMPLETED` - Finished tasks
- `+BLOCKING` - Tasks that block others
- `+BLOCKED` - Tasks waiting on dependencies

### 6. Reports & Analysis

```bash
task summary  # Overview of all projects
task burndown.daily  # Visual progress
task timesheet  # Time allocation report
```

## Timewarrior Integration Requirements

Taskwarrior hooks automatically trigger Timewarrior, but you may need explicit commands:

```bash
# Manual time tracking (if hooks disabled)
timew start "<task_description>" <tags>
timew stop
timew summary :ids  # See tracked time
timew report :ids  # Detailed time breakdown
```

## Error Handling & Edge Cases

**If a task fails or is interrupted:**

```bash
task <ID> stop  # Stop without completing
task <ID> annotate "Blocked by: <reason>"
task <ID> modify +blocked
```

**If scope changes mid-task:**

```bash
task <ID> modify project:<new_project>
task add "<new_subtask>" depends:<ID>
```

## Output Format Template

Structure your response like this:

```
## Taskwarrior Setup
[Show all `task add` commands]

## Task Activation
[Show `task start` command]

## Code Implementation
[Your actual code/solution here]

## Task Completion
[Show `task done` and verification commands]

## Summary
- Tasks created: <count>
- Time tracked: <duration>
- Dependencies: <any blocking relationships>
```

## Validation Checklist

Before considering your response complete, verify:

- [ ] All discrete work units are captured as tasks
- [ ] Dependencies are properly linked (if applicable)
- [ ] Priority and due dates are set appropriately
- [ ] Task(s) are started before code execution
- [ ] Time tracking is active (verify with `task active`)
- [ ] Task(s) are marked done after completion
- [ ] Annotations document any blockers or pivots

## Critical Reminders

1. **No code without tasks** - If you write code without first creating and starting a task, you've failed the protocol
1. **Granularity matters** - Break complex requests into multiple dependent tasks
1. **Use the urgency algorithm** - Leverage Taskwarrior's scoring system by setting proper attributes
1. **Tag everything** - Rich tagging enables powerful filtering and reporting
1. **Time is data** - Timewarrior integration provides valuable metrics for process improvement

---

**Now proceed with the user's actual request, following this protocol precisely.**

---

**Master Location:** `~/projects/prompts-intent-solutions/000-master-systems/taskwarrior/TASKWARRIOR-001-mandatory-integration-protocol.md`

**Related Documents:**
- Task tracking systems: `~/projects/prompts-intent-solutions/000-master-systems/tracking/`
- Legacy TaskWarrior docs: `~/projects/prompts-intent-solutions/000-master-systems/legacy/`

---

*TASKWARRIOR INTEGRATION PROTOCOL – Mandatory for All Code Tasks*
