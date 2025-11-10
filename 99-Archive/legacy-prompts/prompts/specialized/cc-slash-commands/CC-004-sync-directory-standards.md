---
name: sync-directory-standards
description: Sync master directory standards and create compliant structure in any project
model: sonnet
---

# Sync Directory Standards

Pull master directory standards from single source of truth and apply to current project.

## What This Does

1. **Syncs master standards** - Copies `MASTER-DIRECTORY-STANDARDS.md` to current project
2. **Creates structure** - Builds entire standard directory tree
3. **Generates templates** - Creates README.md, CLAUDE.md, .gitignore if missing
4. **Ensures compliance** - Guarantees project matches universal standards

## Quick Execution

```bash
# Run sync script
bash ~/projects/prompts-intent-solutions/000-master-systems/directory/sync-standards.sh
```

Or manually:

```bash
# 1. Copy master standards
cp ~/projects/prompts-intent-solutions/000-master-systems/directory/MASTER-DIRECTORY-STANDARDS.md ./.directory-standards.md

# 2. Create structure
mkdir -p .github .vscode
mkdir -p claudes-docs/{reports,audits,analysis,plans,tasks,logs,misc}
mkdir -p 01-Docs/{architecture,api,guides,meetings}
mkdir -p 02-Src/{core,features,shared,vendor}
mkdir -p 03-Tests/{unit,integration,e2e}
mkdir -p 04-Assets/{images,data,configs}
mkdir -p 05-Scripts/{build,deploy,maintenance}
mkdir -p 06-Infrastructure/{docker,kubernetes,terraform}
mkdir -p 07-Releases/{current,archive}
mkdir -p 99-Archive/{deprecated,legacy}

# 3. Verify
ls -la
```

## Master Standards Summary

### File Naming
- **Format:** `kebab-case` (all lowercase, hyphens)
- **Dates:** `YYYY-MM-DD`
- **Versions:** `name-YYYY-MM-DD-v1.ext`

**Examples:**
```
✅ project-report-2024-10-04.pdf
✅ api-integration-guide.md
❌ Project Report.pdf
❌ API_integration_guide.md
```

### Directory Naming
- **Main:** `PascalCase` with number prefix (01-Docs, 02-Src)
- **Subdirectories:** `kebab-case` (api-docs, user-guides)

**Examples:**
```
✅ 01-Docs/api-documentation/
✅ 02-Src/core-services/
❌ docs/API_Documentation/
```

### Standard Structure
```
[PROJECT-ROOT]/
├── .github/
├── claudes-docs/          # Claude-created docs
│   ├── reports/
│   ├── audits/
│   ├── analysis/
│   ├── plans/
│   ├── tasks/
│   ├── logs/
│   └── misc/
├── 01-Docs/              # Documentation
├── 02-Src/               # Source code
├── 03-Tests/             # Tests
├── 04-Assets/            # Static assets
├── 05-Scripts/           # Automation
├── 06-Infrastructure/    # IaC
├── 07-Releases/          # Releases
├── 99-Archive/           # Archive
├── README.md
├── CLAUDE.md
├── .gitignore
└── .directory-standards.md
```

## Compliance Checklist

After syncing, verify:

```
□ .directory-standards.md exists
□ All required directories created
□ README.md exists
□ CLAUDE.md exists
□ .gitignore configured
□ No files loose in root
□ All names follow kebab-case
□ Structure matches master
```

## Use Cases

**New Project:**
- Run sync immediately after `git init`
- Starts with perfect structure

**Existing Project:**
- Run sync to bring up to current standards
- Adds missing directories
- Updates standards documentation

**Multi-Project Consistency:**
- Run in every project directory
- Ensures all projects follow same rules
- Single source of truth

## Forbidden Patterns (Auto-Prevented)

```
❌ spaces in names.txt
❌ ALLCAPS.TXT
❌ mixed_Case-names.md
❌ Files loose in root (except approved)
❌ Depth > 4 levels
❌ .env files committed
```

## Master File Location

**Authority:** `~/projects/prompts-intent-solutions/000-master-systems/directory/MASTER-DIRECTORY-STANDARDS.md`

This is the SINGLE SOURCE OF TRUTH. All projects sync from this file.

## Re-Sync Protocol

Run sync again whenever:
- Master standards are updated
- Starting work in a project
- After major restructuring
- When onboarding new team members

```bash
# Quick re-sync
bash ~/projects/prompts-intent-solutions/000-master-systems/directory/sync-standards.sh
```

## Validation

Check compliance:

```bash
# Check file naming in root
find . -maxdepth 1 -type f ! -name ".*" -exec basename {} \; | grep -v "^[a-z0-9-]*\.[a-z0-9]*$" && echo "❌ Naming violations" || echo "✅ Compliant"

# Check directory structure
ls -d */ 2>/dev/null | grep -v "^[0-9][0-9]-[A-Z]" | grep -v "^claudes-docs" | grep -v "^\." && echo "❌ Structure violations" || echo "✅ Compliant"
```

## Benefits

- **Consistency:** All projects follow same structure
- **Onboarding:** New devs find everything where expected
- **Efficiency:** No time wasted searching for files
- **Professional:** Impresses stakeholders, auditors
- **Scalable:** Works for projects of any size

---

**Run this in every project directory to maintain universal standards.**
