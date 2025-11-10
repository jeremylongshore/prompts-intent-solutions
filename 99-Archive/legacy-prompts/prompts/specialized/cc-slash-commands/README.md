# Claude Code Slash Commands

This directory contains prompts and templates for creating and working with Claude Code slash commands.

## Purpose

Claude Code slash commands are custom commands that can be invoked with `/command-name` to automate common tasks and workflows in Claude Code sessions.

## Directory Contents

- **Command Creation Templates** - Prompts for creating new slash commands
- **Command Documentation** - Documentation for existing slash commands
- **Workflow Automation** - Multi-step workflows using slash commands

## Available Commands

### CC-001: Auditable Debug & Fix Protocol
**File:** `CC-001-auditable-debug-fix.md`

Comprehensive auditable debugging protocol for when a fix attempt fails. Implements systematic root-cause analysis with:
- **Taskwarrior integration** - Full task tracking with dependencies and acceptance criteria
- **Execution gates** - Mandatory approval points before proceeding
- **Evidence collection** - All artifacts saved to `claudes-docs/` directory
- **Phased approach** - 8 phases from acknowledgment to after-action report
- **Failure policy** - Automatic escalation after 2 verification failures

**Use when:**
- Previous fix attempt failed
- Need auditable debugging trail
- Working on critical production issues
- Require systematic root-cause analysis
- Need comprehensive evidence for post-mortems

**Key features:**
- Real Taskwarrior IDs (no placeholders)
- UTC timestamps on all logs
- Automated project naming from repo context
- File naming convention: `<UTC-ISO8601>_<project-slug>_<short-slug>.<ext>`
- Mandatory test coverage (positive and negative)
- Rollback procedures for all fixes

---

### CC-002: Prompt Template Generator
**File:** `CC-002-prompt-template-generator.md`

Interactive prompt template generator that creates properly formatted templates from user descriptions. Automates the entire template creation workflow.

**Features:**
- **Interactive workflow** - Asks 5 simple questions to gather requirements
- **Automatic categorization** - Determines correct directory and category
- **Sequential numbering** - Finds next available number in category
- **Filename generation** - Creates properly formatted filename with date
- **YAML frontmatter** - Generates valid frontmatter automatically
- **Validation** - Runs validation scripts to ensure compliance

**Use when:**
- Creating new prompt templates for the repository
- Need to follow repository naming conventions
- Want consistent template structure
- Unsure which category or directory to use

**Workflow:**
1. Describe what you want the prompt to do
2. Select category (DEV, BUSINESS, or SPECIALIZED)
3. Choose AI model (opus, sonnet, haiku, gpt-4)
4. Provide brief description
5. Template is generated, validated, and saved

**Example outputs:**
- `MARKET-006-sales-followup-email-100425.md`
- `DEBUG-006-api-integration-errors-100425.md`
- `CC-003-code-review-automation-100425.md`

---

### CC-003: Organize Claude Documentation
**File:** `CC-003-organize-docs.md`

Automatically find and organize all Claude-created documentation into the `claudes-docs` folder with proper structure and naming conventions.

**Features:**
- **Auto-discovery** - Finds all recently created docs in current directory
- **Smart categorization** - Organizes by type (reports, audits, analysis, plans, tasks, logs)
- **Format enforcement** - Renames files to comply with `<UTC-ISO8601>_<project-slug>_<short-slug>.<ext>`
- **Inventory generation** - Creates INVENTORY.md with all organized files
- **Safe operations** - Never moves files already in claudes-docs, skips .git/ and node_modules/

**Use when:**
- Working directory has scattered documentation files
- Need to organize session outputs
- Want consistent naming across all docs
- Preparing for commit or archive
- End of debugging session

**What it organizes:**
- AAR reports → `claudes-docs/reports/`
- Audit files → `claudes-docs/audits/`
- Analysis docs → `claudes-docs/analysis/`
- Plans/PRDs → `claudes-docs/plans/`
- Task exports → `claudes-docs/tasks/`
- Log files → `claudes-docs/logs/`
- Other docs → `claudes-docs/misc/`

**Naming convention enforced:**
```
2025-10-04T16-05-12Z_project-name_description.md
```

**Run from any directory** - Works in any project, creates structure if missing

---

### CC-004: Sync Directory Standards
**File:** `CC-004-sync-directory-standards.md`

Sync master directory standards from single source of truth and apply to current project. Ensures all projects follow identical naming and structure conventions.

**Features:**
- **Single source of truth** - All projects sync from MASTER-DIRECTORY-STANDARDS.md
- **Auto-structure creation** - Builds entire standard directory tree
- **Template generation** - Creates README.md, CLAUDE.md, .gitignore if missing
- **Instant compliance** - Guarantees project matches universal standards
- **Quick execution** - One command syncs everything

**Use when:**
- Starting new project (run after `git init`)
- Existing project needs standardization
- Master standards have been updated
- Onboarding requires consistent structure
- Multiple confusing directories need alignment

**What it creates:**
```
├── claudes-docs/         # Claude documentation (7 subdirs)
├── 01-Docs/             # Documentation (4 subdirs)
├── 02-Src/              # Source code (4 subdirs)
├── 03-Tests/            # Tests (3 subdirs)
├── 04-Assets/           # Assets (3 subdirs)
├── 05-Scripts/          # Scripts (3 subdirs)
├── 06-Infrastructure/   # IaC (3 subdirs)
├── 07-Releases/         # Releases (2 subdirs)
├── 99-Archive/          # Archive (2 subdirs)
└── Required root files
```

**Naming enforced:**
- Files: `kebab-case` (project-report-2024-10-04.pdf)
- Directories: `PascalCase` main, `kebab-case` subs
- Dates: `YYYY-MM-DD` format only

**Master location:** `~/projects/prompts-intent-solutions/000-master-systems/directory/MASTER-DIRECTORY-STANDARDS.md`

**Quick sync:**
```bash
bash ~/projects/prompts-intent-solutions/000-master-systems/directory/sync-standards.sh
```

## Slash Command Basics

Slash commands in Claude Code:
- Start with `/` (e.g., `/commit`, `/test`, `/deploy`)
- Can accept arguments and parameters
- Execute predefined workflows or prompts
- Can be project-specific or global

## Template Naming Convention

Files in this directory should follow the pattern:
- `CC-###-description-MMDDYY.md` for Claude Code specific templates
- Include YAML frontmatter with `name`, `description`, and `model` fields

## Example Usage

Common slash command use cases:
- `/eod-sweep` - End-of-day repository maintenance
- `/commit` - Intelligent commit message generation
- `/review` - Code review automation
- `/test` - Run test suites with AI analysis
- `/debug-fix` - Auditable debug protocol (CC-001) for failed fixes
- `/create-template` - Interactive prompt template generator (CC-002)
- `/organize-docs` - Organize all Claude docs into claudes-docs/ (CC-003)
- `/sync-standards` - Sync master directory standards (CC-004)

## Resources

- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Slash Command Guide](https://docs.anthropic.com/claude-code/slash-commands)

---

**Status**: ✅ Active directory for Claude Code slash command templates
