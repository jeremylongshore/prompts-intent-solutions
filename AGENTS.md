# Repository Guidelines

## Project Structure & Module Organization
- `prompts/` holds the core library grouped into `business/`, `development/`, and `specialized/`; use the `CATEGORY-###-slug.md` pattern with YAML front matter.
- `01-Docs/` stores operational manuals using `NNN-DOC-*` numbering—update the matching doc when processes change.
- `000-master-systems/` captures standards and GitHub automation references; review these before creating new directories or workflows.
- `tools/` contains Python validators and shell automation; place new scripts in the existing domain structure and document them in `tools/README.md`.
- `99-Archive/` houses deprecated assets; move superseded prompts here instead of deleting when historical context matters.

## Build, Test, and Development Commands
- `python -m pip install --upgrade pip pyyaml` provisions the dependency required by local validators.
- `python tools/validate_filenames.py` enforces naming rules and category placement.
- `python tools/validate_frontmatter.py` checks required metadata for prompt templates and agent configs.
- `python tools/validate_structure.py` verifies the repository layout against master directory standards.
- `python tools/check_duplicates.py` prevents duplicated prompt IDs, names, or descriptions.

## Coding Style & Naming Conventions
- Markdown must pass `markdownlint-cli2` (runs in CI); keep lines under ~100 characters and use ATX headings with fenced code blocks plus info strings.
- Maintain leading YAML front matter (`name`, `description`, `model`, etc.) on every prompt or agent file.
- Apply kebab-case for filenames inside category folders, PascalCase for top-level directories, and chronological prefixes (`NNN-`) for docs.

## Testing Guidelines
- Treat the validator scripts as the pre-PR test suite; run the full command list above and note results in the PR checklist.
- Add new validation logic under `tools/` and update `tools/README.md` with invocation examples.
- No unit tests exist today; mirror the GitHub Action locally when troubleshooting failures.

## Commit & Pull Request Guidelines
- Follow Conventional Commit prefixes (`docs: add onboarding prompt`, `ci(deps): bump actions/checkout to v5`) to align with existing history and automation.
- Reference related work with `Fixes #123` in the PR body and complete every checkbox in the template, noting skipped validations.
- Provide before/after screenshots or rendered snippets for Markdown that changes layout, especially catalog pages.
- Request review from listed CODEOWNERS when modifying prompt templates, validation scripts, or automation workflows.

## Security & Configuration Tips
- Exclude secrets or client-identifying data from prompts; see `01-Docs/002-DOC-security.md` for redaction guidance and disclosure requirements.
- Validate new automation against `000-master-systems/github/GITHUB-005-error-resolution-system-092825.md` before wiring it into CI or release scripts.

## Landing the Plane (Session Completion)

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `git push` succeeds.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   git pull --rebase
   bd sync
   git push
   git status  # MUST show "up to date with origin"
   ```
5. **Clean up** - Clear stashes, prune remote branches
6. **Verify** - All changes committed AND pushed
7. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds

<!-- BEGIN BEADS INTEGRATION -->
## Issue Tracking with bd (beads)

**IMPORTANT**: This project uses **bd (beads)** for ALL issue tracking. Do NOT use markdown TODOs, task lists, or other tracking methods.

### Why bd?

- Dependency-aware: Track blockers and relationships between issues
- Git-friendly: Dolt-powered version control with native sync
- Agent-optimized: JSON output, ready work detection, discovered-from links
- Prevents duplicate tracking systems and confusion

### Quick Start

**Check for ready work:**

```bash
bd ready --json
```

**Create new issues:**

```bash
bd create "Issue title" --description="Detailed context" -t bug|feature|task -p 0-4 --json
bd create "Issue title" --description="What this issue is about" -p 1 --deps discovered-from:bd-123 --json
```

**Claim and update:**

```bash
bd update <id> --claim --json
bd update bd-42 --priority 1 --json
```

**Complete work:**

```bash
bd close bd-42 --reason "Completed" --json
```

### Issue Types

- `bug` - Something broken
- `feature` - New functionality
- `task` - Work item (tests, docs, refactoring)
- `epic` - Large feature with subtasks
- `chore` - Maintenance (dependencies, tooling)

### Priorities

- `0` - Critical (security, data loss, broken builds)
- `1` - High (major features, important bugs)
- `2` - Medium (default, nice-to-have)
- `3` - Low (polish, optimization)
- `4` - Backlog (future ideas)

### Workflow for AI Agents

1. **Check ready work**: `bd ready` shows unblocked issues
2. **Claim your task atomically**: `bd update <id> --claim`
3. **Work on it**: Implement, test, document
4. **Discover new work?** Create linked issue:
   - `bd create "Found bug" --description="Details about what was found" -p 1 --deps discovered-from:<parent-id>`
5. **Complete**: `bd close <id> --reason "Done"`

### Auto-Sync

bd automatically syncs via Dolt:

- Each write auto-commits to Dolt history
- Use `bd dolt push`/`bd dolt pull` for remote sync
- No manual export/import needed!

### Important Rules

- ✅ Use bd for ALL task tracking
- ✅ Always use `--json` flag for programmatic use
- ✅ Link discovered work with `discovered-from` dependencies
- ✅ Check `bd ready` before asking "what should I work on?"
- ❌ Do NOT create markdown TODO lists
- ❌ Do NOT use external issue trackers
- ❌ Do NOT duplicate tracking systems

For more details, see README.md and docs/QUICKSTART.md.

## Landing the Plane (Session Completion)

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `git push` succeeds.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   git pull --rebase
   bd sync
   git push
   git status  # MUST show "up to date with origin"
   ```
5. **Clean up** - Clear stashes, prune remote branches
6. **Verify** - All changes committed AND pushed
7. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds

<!-- END BEADS INTEGRATION -->
