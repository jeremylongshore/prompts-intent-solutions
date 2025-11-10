---
name: professional-directory-excellence-system
description: AI execution prompt to transform any messy directory into professional organization
model: opus
date: 2025-10-05
---

# Professional Directory Excellence System
## AI Execution Prompt for Directory Transformation

---

## INSTRUCTIONS FOR CLAUDE

When the user asks you to organize, clean up, or apply standards to a directory, follow this protocol:

### Your Mission

Transform the current directory into a beautifully organized, professional workspace by:
1. Analyzing current state
2. Applying MASTER DIRECTORY STANDARDS
3. Executing changes
4. Reporting results

**Bottom line:** Make this directory so organized that anyone looking at it immediately recognizes professional-grade work.

---

## STEP 1: ANALYZE CURRENT STATE

Execute these commands and report findings:

```bash
pwd  # Show current directory
ls -la  # List all files and folders
find . -maxdepth 3 -type f | head -20  # Show file structure
```

**Look for:**
- Files with spaces, underscores, or mixed case
- Files scattered in root directory
- Missing standard directories (01-Docs, 02-Src, etc.)
- Docs in multiple random locations
- Deep nesting (>4 levels)
- Temp files (.tmp, .cache, .bak)

**Report format:**
```
📊 CURRENT STATE ANALYSIS

Directory: /path/to/project
Total files: X
Total directories: Y

❌ Issues Found:
- 23 files with naming violations
- 12 files loose in root
- Docs scattered across 5 locations
- Max depth: 7 levels (should be ≤4)
- No standard structure present

✅ What's Good:
- README.md exists
- .gitignore configured
```

---

## STEP 2: COPY STANDARDS FILE

Execute:
```bash
cp ~/projects/prompts-intent-solutions/000-master-systems/directory/MASTER-DIRECTORY-STANDARDS.md ./.directory-standards.md
```

Confirm: "✅ Standards file copied to project"

---

## STEP 3: CREATE STANDARD STRUCTURE

Execute these mkdir commands:
```bash
mkdir -p .github .vscode
mkdir -p claudes-docs/{reports,audits,analysis,plans,tasks,logs,misc}
mkdir -p 01-Docs
mkdir -p 02-Src/{core,features,shared,vendor}
mkdir -p 03-Tests/{unit,integration,e2e}
mkdir -p 04-Assets/{images,data,configs}
mkdir -p 05-Scripts/{build,deploy,maintenance}
mkdir -p 06-Infrastructure/{docker,kubernetes,terraform}
mkdir -p 07-Releases/{current,archive}
mkdir -p 99-Archive/{deprecated,legacy}
```

Execute these touch commands for missing root files:
```bash
[ ! -f "README.md" ] && touch README.md
[ ! -f "CLAUDE.md" ] && touch CLAUDE.md
[ ! -f ".gitignore" ] && touch .gitignore
[ ! -f "CHANGELOG.md" ] && touch CHANGELOG.md
```

Report: "✅ Standard directory structure created"

---

## STEP 4: IDENTIFY FILES TO MOVE

Scan for files that need relocation:

```bash
# Find all markdown files not in 01-Docs
find . -name "*.md" -type f ! -path "./01-Docs/*" ! -path "./.git/*" ! -name "README.md" ! -name "CLAUDE.md" ! -name "CHANGELOG.md" ! -name "LICENSE"

# Find source code not in 02-Src
find . -name "*.js" -o -name "*.ts" -o -name "*.py" | grep -v "02-Src" | grep -v "node_modules"

# Find test files not in 03-Tests
find . -name "*.test.*" -o -name "*.spec.*" | grep -v "03-Tests"
```

**Create a relocation plan:**
```
📋 RELOCATION PLAN

Documentation → 01-Docs/:
- ./notes/meeting-2024-10-01.md → 01-Docs/001-mtg-kickoff-2024-10-01.md
- ./docs/architecture.md → 01-Docs/002-adr-initial-architecture.md
- ./planning/roadmap.pdf → 01-Docs/003-pln-q4-roadmap.pdf

Source Code → 02-Src/:
- ./utils/helper.js → 02-Src/shared/helper.js
- ./api/server.js → 02-Src/core/server.js

Tests → 03-Tests/:
- ./test/api.test.js → 03-Tests/integration/api.test.js

Total files to move: X
```

**Ask user:** "Ready to proceed with moving these files? (yes/no)"

---

## STEP 5: EXECUTE RELOCATION

For each file in the plan:

```bash
mv "old/path/file.md" "01-Docs/NNN-abv-new-name.md"
```

**Naming rules for docs:**
- Format: `NNN-abv-description.ext`
- Number chronologically (001, 002, 003...)
- Use approved abbreviations (adr, prd, mtg, aar, tsk, etc.)
- kebab-case for description

**Report progress:**
```
🔄 MOVING FILES

✅ Moved: notes/meeting.md → 01-Docs/001-mtg-kickoff-2024-10-01.md
✅ Moved: architecture.md → 01-Docs/002-adr-initial-architecture.md
✅ Moved: helper.js → 02-Src/shared/helper.js

Progress: 15/23 files relocated
```

---

## STEP 6: FIX NAMING VIOLATIONS

Find and fix files with bad names:

```bash
# Find files with spaces
find . -maxdepth 2 -name "* *" -type f

# Find files with underscores
find . -maxdepth 2 -name "*_*" -type f

# Find files with uppercase
find . -maxdepth 2 -name "*[A-Z]*" -type f
```

For each violation:
```bash
mv "Old File Name.pdf" "old-file-name.pdf"
mv "API_Documentation.md" "api-documentation.md"
mv "UserData.json" "user-data.json"
```

**Report:**
```
🔧 FIXING NAMING VIOLATIONS

✅ Renamed: "Project Report.pdf" → "project-report.pdf"
✅ Renamed: "API_docs.md" → "api-docs.md"
✅ Renamed: "UserSettings.json" → "user-settings.json"

Fixed: 23 naming violations
```

---

## STEP 7: UPDATE ROOT FILES

### Update README.md

Add this section if missing:
```markdown
## Directory Standards

This project follows professional directory standards.
See `.directory-standards.md` for full details.
All documentation is stored in `01-Docs/` using the `NNN-abv-description.ext` format.
```

### Update CLAUDE.md

Add this section if missing:
```markdown
## Directory Standards

Follow `.directory-standards.md` for structure and file naming.
- Store all docs in `01-Docs/`
- Use `NNN-abv-description.ext` format with approved abbreviations
- Maintain strict chronological order
```

### Update .gitignore

Ensure it includes:
```
node_modules/
*.log
.env
.DS_Store
claudes-docs/
```

**Report:** "✅ Root files updated with directory standards"

---

## STEP 8: VALIDATE COMPLIANCE

Run compliance checks:

```bash
# Check standards file exists
ls -la .directory-standards.md

# Check required directories exist
ls -d claudes-docs 01-Docs 02-Src 03-Tests 04-Assets 99-Archive

# Check required root files
ls -la README.md CLAUDE.md .gitignore

# Check for remaining naming violations
find . -maxdepth 1 -type f -name "* *" -o -name "*_*"

# Check docs naming
find 01-Docs -type f | head -10
```

**Generate compliance report:**
```
✅ COMPLIANCE REPORT

□ ✅ .directory-standards.md exists
□ ✅ All required directories created
□ ✅ Required root files present
□ ✅ No naming violations in root
□ ✅ Docs follow NNN-abv-description format
□ ✅ README.md references standards
□ ✅ CLAUDE.md references standards
□ ✅ Max depth ≤ 4 levels
□ ✅ No secrets exposed

Score: 9/9 - FULLY COMPLIANT ✨
```

---

## STEP 9: FINAL REPORT

Generate transformation summary:

```
🎉 DIRECTORY TRANSFORMATION COMPLETE

📊 RESULTS:
- Files organized: 47
- Naming violations fixed: 23
- Directories created: 12
- Docs consolidated: 15 files → 01-Docs/ (chronological)
- Structure depth: 7 levels → 3 levels
- Compliance score: 9/9 ✅

⏱️ TIME SAVED:
- Before: 2-5 minutes to find any file
- After: 5-10 seconds to find any file
- 89% improvement in file discovery

💼 PROFESSIONAL IMPACT:
- ✅ Ready for client/investor review
- ✅ New team members can navigate instantly
- ✅ Passes professional standards audit
- ✅ Scalable structure for growth

📁 STRUCTURE:
[PROJECT-ROOT]/
├── .directory-standards.md ✅
├── 01-Docs/ (15 files, chronological) ✅
├── 02-Src/ (organized by feature) ✅
├── 03-Tests/ (organized by type) ✅
├── 04-Assets/ ✅
├── 99-Archive/ ✅
├── README.md (updated) ✅
├── CLAUDE.md (updated) ✅
└── .gitignore (configured) ✅

🎯 NEXT STEPS:
1. Review 01-Docs/ to ensure all docs are numbered correctly
2. Review README.md and customize project description
3. Commit changes: git add . && git commit -m "Apply professional directory standards"
4. Share with team

Your directory is now professional-grade! 🚀
```

---

## REFERENCE: APPROVED ABBREVIATIONS

When renaming docs in 01-Docs/, use these:

| Abv  | What It Means                    |
|------|----------------------------------|
| adr  | Architecture Decision            |
| prd  | Product Requirements             |
| mtg  | Meeting Notes                    |
| aar  | After Action Report              |
| log  | Log / Journal                    |
| tsk  | Task Breakdown                   |
| rsk  | Risk Register                    |
| pln  | Planning / Roadmap               |
| api  | API Documentation                |
| sec  | Security Audit                   |
| test | Test Plan / Results              |

---

## TROUBLESHOOTING

**If user says directory is still messy:**
- Re-run STEP 1 to analyze what was missed
- Check for hidden files: `ls -la`
- Check deeper levels: `find . -type f | grep -v ".git"`

**If files have complex names:**
- Ask user for clarification on what the file is
- Use best judgment for abbreviation
- When in doubt, use `ref` (reference material)

**If structure already partially exists:**
- Merge with existing structure
- Don't duplicate directories
- Move files to existing directories

---

## VERSION HISTORY

- **1.0.6** (2025-10-05) – Converted to AI execution prompt, removed bash scripts
- **1.0.5** (2025-10-05) – Added comprehensive steps
- **1.0.4** (2025-10-05) – Added validation
- **1.0.3** (2025-10-05) – Added docs naming
- **1.0.2** (2025-10-05) – Simplified structure
- **1.0.1** (2025-10-05) – Universal version
- **1.0.0** (2025-10-04) – Initial release

---

*Professional Directory Excellence System – Transform chaos into professional organization*
