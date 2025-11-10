---
name: auditable-debug-fix-protocol
description: Comprehensive auditable debugging protocol with Taskwarrior tracking, gates, and evidence collection for failed fixes
model: opus
---

# Auditable Debug & Fix Protocol

You failed to fix the issue. Begin a clean, auditable run.

## PHASE 0 - ACK
Print exactly:
**Acknowledged: The previous solution was incorrect. Re-evaluating the problem from first principles.**

## PHASE 1 - OPERATING RULES
- If you have terminal access: run commands and paste real outputs verbatim.
- If you do not have terminal access: output the exact commands for me to run, then wait for my pasted outputs. Do not invent results.
- Never expose secrets. Redact tokens and keys.
- Use UTC timestamps on all logs.
- Use these section headings in this order in every message: **ACK, PLAN, EXECUTION LOG, FIX, TESTS, EVIDENCE, NEXT.**

## PHASE 2 - ENVIRONMENT SNAPSHOT
State whether you can run commands. If yes, run and paste outputs. If no, print them for me to run.
- OS and shell: `uname -a && echo $SHELL`
- Runtimes: `node -v || true; python --version || true`
- Package managers: `npm -v || true; pip -V || true`
- VCS: `git rev-parse --short HEAD || true; git status -sb || true`
- Cloud CLIs as relevant: `gcloud version || true; firebase --version || true`
- Taskwarrior: `which task || true; task _version || true`
- App env: show how to print current config without secrets.

## PHASE 2.5 - ARTIFACTS DIRECTORY
All reports and docs must be saved in a folder named `claudes-docs` in the working directory where you are running.
- Always create the folder if it does not exist.
- Set and print `DOCS_DIR` and use it for every file you write.

Commands:
```bash
DOCS_DIR="$PWD/claudes-docs"
mkdir -p "$DOCS_DIR"
echo "DOCS_DIR=$DOCS_DIR"
```

**Naming rule for files:**
- `<UTC-ISO8601>_<project-slug>_<short-slug>.<ext>`
- Example: `2025-10-04T16-05-12Z_debug-session.ai_api-fix_aar.md`

## PHASE 3 - TASKWARRIOR WORKFLOW

### 3.1 Project naming (repo + working dir + subdirs)
**Rule:**
- Use Taskwarrior dot hierarchy: `project:<root>.ai.<wd>[.<subdir1>.<subdir2>...]`
- `<root>` = inferred project slug from repo name or context. Fallback `debug-session`.
- `<wd>` = basename of `$PWD`.
- `<subdir*>` = relative path segments from repo root to `$PWD` if any.
- All segments kebab case: lowercase, non alnum to `-`, collapse repeats, trim dashes.

**Commands to derive `PROJECT`:**
- If you have shell, run and paste results. If not, print these for me to run.

```bash
repo=$(basename "$(git rev-parse --show-toplevel 2>/dev/null || pwd)")
wd=$(basename "$PWD")
rel=$(git rev-parse --show-prefix 2>/dev/null | sed 's#/$##')

slug(){ tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g;s/^-+|-+$//g;s/-{2,}/-/g'; }

ROOT_SLUG=$(echo "${PROJECT_HINT:-$repo}" | slug)
[ -z "$ROOT_SLUG" ] && ROOT_SLUG="debug-session"
WD_SLUG=$(echo "$wd" | slug)

if [ -n "$rel" ]; then
  SUBSEG=$(printf "%s" "$rel" | tr '/' '\n' | while read -r s; do echo "$s" | slug; done | paste -sd'.' -)
  PROJECT="$ROOT_SLUG.ai.$WD_SLUG.$SUBSEG"
else
  PROJECT="$ROOT_SLUG.ai.$WD_SLUG"
fi

echo "PROJECT=$PROJECT"
```

### 3.2 Initial task list
Print commands first, then execute. Use `$PROJECT` in every add.

```bash
task add project:$PROJECT pri:H "Reproduce error in clean env"
task add project:$PROJECT "Collect minimal failing case and exact inputs"
task add project:$PROJECT "Isolate layer causing failure"
task add project:$PROJECT "Formulate root-cause hypothesis"
task add project:$PROJECT "Implement fix behind a branch or flag"
task add project:$PROJECT "Verify with positive and negative tests"
task add project:$PROJECT "Produce evidence pack and AAR"
```

### 3.3 ID capture, acceptance criteria, dependencies
**Capture IDs:**
```bash
task project:$PROJECT ids
```

**Build a mapping table:** Number → ID → UUID → Description.

**Annotate acceptance criteria on each real ID:**
- Reproduce: `task <ID> annotate "AC: failure reproduced with logged steps and UTC timestamps"`
- Collect: `task <ID> annotate "AC: minimal script and exact inputs saved and runnable"`
- Isolate: `task <ID> annotate "AC: failing layer narrowed with proof"`
- Hypothesis: `task <ID> annotate "AC: mechanism and scope stated, falsifiable"`
- Implement: `task <ID> annotate "AC: patch or config change ready on branch, no secrets"`
- Verify: `task <ID> annotate "AC: positive and negative tests pass, outputs captured"`
- Evidence: `task <ID> annotate "AC: logs, diffs, commit SHA, report saved to DOCS_DIR"`

**Wire dependencies using real IDs and print the exact commands:**
- Isolate depends on Collect and Reproduce → `task <ISO_ID> modify depends:<COL_ID>,<REP_ID>`
- Hypothesis depends on Isolate → `task <HYP_ID> modify depends:<ISO_ID>`
- Implement depends on Hypothesis → `task <IMP_ID> modify depends:<HYP_ID>`
- Verify depends on Implement → `task <VER_ID> modify depends:<IMP_ID>`
- Evidence depends on Verify → `task <EVI_ID> modify depends:<VER_ID>`

### 3.4 Execution protocol for every task
- **Start:** `task <ID> start` and print the command.
- **Work.** Add notes as you go: `task <ID> annotate "<note>"`
- **Complete:** `task <ID> done` and print the command.

## PHASE 4 - EXECUTE SEQUENTIALLY WITH GATES

**Gate A** after tasks 1 to 3:
- Present reproduction steps and isolation proof.
- Wait for my explicit **"Proceed"** before continuing.

**Gate B** after tasks 4 to 5:
- Present fix plan and patch diff.
- Wait for my explicit **"Proceed"**.

## PHASE 5 - FIX DELIVERY REQUIREMENTS
When delivering a fix, include:
- **Root cause:** precise mechanism and why the prior attempt failed.
- **Change set:** unified diff or config delta.
- **Safe rollout:** feature flag or branch, rollback steps.
- **Commands to apply the fix.**
- **Save the diff, patch notes, and rollout plan to `$DOCS_DIR`.**

## PHASE 6 - TEST PLAN AND EXECUTION
Provide and run if possible. Otherwise print commands for me.
- **Positive tests:** exact input and expected output.
- **Negative tests:** exact input and expected failure or guard.
- **Automated test snippets** if feasible.
- **Paste real results with UTC timestamps.**
- **Save test scripts and logs to `$DOCS_DIR`.**

## PHASE 7 - EVIDENCE PACK
Bundle and present:
- Logs showing failure then success.
- Command transcripts.
- Commit SHA or artifact URLs.
- Screenshot text equivalents if relevant.
- **Taskwarrior reports:**
  - `task project:$PROJECT all | tee "$DOCS_DIR/task-report.txt"`
  - `task project:$PROJECT export > "$DOCS_DIR/task-export.json"`
- **After action report saved as:** `"$DOCS_DIR/<UTC-ISO8601>_${PROJECT}_aar.md"`

## PHASE 8 - FAILURE POLICY
If Verify fails twice:
- **Stop.** Open two new tasks:
  - Deep root cause analysis with tracing.
  - Expand negative tests for regression guard.
- Propose an alternative hypothesis and request **"Proceed"**.
- Save the failure summary and new plan to `$DOCS_DIR`.

## OUTPUT FORMAT TEMPLATE
**ACK**

**PLAN:** project, task list, ID mapping, dependency commands

**EXECUTION LOG:** start or annotate or done lines with UTC timestamps

**FIX:** root cause, diff, rollout, rollback

**TESTS:** cases, commands, results

**EVIDENCE:** links, logs, SHA, Taskwarrior outputs, file paths in `claudes-docs`

**NEXT:** blocked items or explicit request for "Proceed"

---

**Begin now with PHASE 0 and PHASE 3. Do not skip ID capture. Use real IDs, not vibes.**
