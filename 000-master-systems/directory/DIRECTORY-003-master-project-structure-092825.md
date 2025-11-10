---
name: master-project-directory-structure
description: AI execution prompt to create professional project structure in any repository
model: opus
date: 2025-10-05
---

# Master Project Directory Structure
## AI Execution Prompt for Professional Project Setup

---

## INSTRUCTIONS FOR CLAUDE

When the user asks you to create or apply the master project structure, follow this protocol to build a professional, scalable directory system.

### Your Mission

Transform any repository into a professionally structured project by:
1. Creating the complete standard directory tree
2. Setting up essential files and templates
3. Validating structure compliance
4. Reporting results

**Bottom line:** Create a structure so organized that anyone can navigate it instantly and understand where everything belongs.

---

## STEP 1: ANALYZE CURRENT STATE

Execute:
```bash
pwd  # Show current directory
ls -la  # List all files and folders
find . -type d -maxdepth 2  # Show directory structure
```

Report findings:
```
📊 CURRENT STATE

Directory: /path/to/project
Existing directories: X
Existing files: Y
Missing structure: [list key missing directories]
```

---

## STEP 2: CREATE STANDARD DIRECTORY STRUCTURE

Every project MUST follow this EXACT structure:

```
[PROJECT-NAME]/
├── .github/                      # GitHub configurations
│   ├── workflows/                # GitHub Actions
│   ├── ISSUE_TEMPLATE/           # Issue templates
│   ├── PULL_REQUEST_TEMPLATE.md  # PR template
│   ├── CODEOWNERS                # Code ownership
│   └── scripts/                  # Pipeline scripts
│       ├── audit/                # Audit phase scripts
│       │   ├── init-audit-system.sh
│       │   ├── run-complete-audit.sh
│       │   └── audit-*.sh
│       ├── chore/                # Chore phase scripts
│       │   ├── init-chore-system.sh
│       │   ├── run-complete-chore.sh
│       │   └── fix-*.sh
│       └── release/              # Release phase scripts
│           ├── init-release-system.sh
│           ├── run-complete-release.sh
│           └── deploy-*.sh
│
├── audit-reports/                # LLM-GENERATED REPORTS (TOP LEVEL)
│   ├── 0001-AUDIT-MMDDYY-INITIAL-SCAN.md
│   ├── 0002-AUDIT-MMDDYY-VIOLATIONS-LIST.md
│   ├── 0003-AUDIT-MMDDYY-TASKWARRIOR-COMMANDS.md
│   ├── 0004-CHORE-MMDDYY-FIX-COMMANDS.md
│   ├── 0005-CHORE-MMDDYY-EXECUTION-LOG.md
│   ├── 0006-CHORE-MMDDYY-MANUAL-FIXES-REQUIRED.md
│   ├── 0007-RELEASE-MMDDYY-VALIDATION-RESULTS.md
│   ├── 0008-RELEASE-MMDDYY-METRICS-SUMMARY.md
│   └── 0009-RELEASE-MMDDYY-EXCELLENCE-ACHIEVED.md
│
├── deployment-docs/              # PROJECT DOCUMENTATION (Jeremy's System)
│   ├── 0001-DEBUG-MMDDYY-DESCRIPTION.md
│   ├── 0002-CLEAN-MMDDYY-DESCRIPTION.md
│   ├── 0003-ENT-MMDDYY-DESCRIPTION.md
│   ├── 00-feature-name/         # Feature groupings
│   │   ├── 00-prd-featureName.md
│   │   ├── 00-tasks-featureName.md
│   │   └── 00-adr-featureName.md
│   └── 01-next-feature/
│       ├── 01-prd-nextFeature.md
│       ├── 01-tasks-nextFeature.md
│       └── 01-adr-nextFeature.md
│
├── 01-docs/                      # DOCUMENTATION SUITE
│   ├── architecture/             # System design documents
│   │   ├── ARCHITECTURE.md
│   │   ├── diagrams/
│   │   └── decisions/
│   ├── api/                      # API specifications
│   │   ├── openapi.yaml
│   │   ├── postman/
│   │   └── examples/
│   ├── guides/                   # User/developer guides
│   │   ├── getting-started.md
│   │   ├── installation.md
│   │   └── troubleshooting.md
│   └── meetings/                 # Meeting records
│       └── YYYY-MM-DD-topic.md
│
├── 02-src/                       # SOURCE CODE
│   ├── core/                     # Core business logic
│   ├── features/                 # Feature modules
│   ├── shared/                   # Shared utilities
│   └── vendor/                   # Third-party code
│
├── 03-tests/                     # TEST SUITES
│   ├── unit/                     # Unit tests
│   ├── integration/              # Integration tests
│   ├── e2e/                     # End-to-end tests
│   └── fixtures/                 # Test data
│
├── 04-assets/                    # STATIC ASSETS
│   ├── images/                   # Image resources
│   │   ├── icons/
│   │   ├── screenshots/
│   │   └── branding/
│   ├── data/                     # Data files
│   │   ├── sample/
│   │   └── reference/
│   └── configs/                  # Configuration files
│       ├── development/
│       ├── staging/
│       └── production/
│
├── 05-scripts/                   # AUTOMATION SCRIPTS
│   ├── build/                    # Build scripts
│   │   ├── build-dev.sh
│   │   ├── build-prod.sh
│   │   └── build-docker.sh
│   ├── deploy/                   # Deployment scripts
│   │   ├── deploy-staging.sh
│   │   └── deploy-production.sh
│   └── maintenance/              # Maintenance scripts
│       ├── backup.sh
│       ├── cleanup.sh
│       └── audit.sh
│
├── 06-infrastructure/            # INFRASTRUCTURE AS CODE
│   ├── docker/                   # Container definitions
│   │   ├── Dockerfile
│   │   └── docker-compose.yml
│   ├── kubernetes/               # Orchestration configs
│   │   ├── deployments/
│   │   └── services/
│   └── terraform/                # Infrastructure definitions
│       ├── main.tf
│       └── variables.tf
│
├── 07-releases/                  # RELEASE ARTIFACTS
│   ├── current/                  # Current production
│   │   └── v1.0.0/
│   └── archive/                  # Historical releases
│       └── v0.9.0/
│
├── 99-archive/                   # ARCHIVED ITEMS
│   ├── deprecated/               # Deprecated but preserved
│   ├── legacy/                   # Legacy reference
│   └── cleanup-YYYY-MM-DD/      # Dated cleanups
│
├── README.md                     # Project overview
├── ARCHITECTURE.md               # System architecture
├── CONTRIBUTING.md               # Contribution guide
├── CHANGELOG.md                  # Version history
├── LICENSE                       # License file
├── SECURITY.md                   # Security policy
├── ROADMAP.md                    # Future plans
├── GOVERNANCE.md                 # Decision process
├── .gitignore                    # Git ignore rules
├── .env.example                  # Environment template
└── taskfile.yml                  # TaskWarrior configuration
```

---

## STEP 3: CREATE CORE DIRECTORIES

Execute these mkdir commands:
```bash
# GitHub integrations
mkdir -p .github/workflows .github/ISSUE_TEMPLATE .github/scripts/{audit,chore,release}

# Claude documentation
mkdir -p claudes-docs/{reports,audits,analysis,plans,tasks,logs,misc}

# Numbered project directories
mkdir -p 01-Docs/{architecture,api,guides,meetings}
mkdir -p 02-Src/{core,features,shared,vendor}
mkdir -p 03-Tests/{unit,integration,e2e,fixtures}
mkdir -p 04-Assets/{images,data,configs}
mkdir -p 05-Scripts/{build,deploy,maintenance}
mkdir -p 06-Infrastructure/{docker,kubernetes,terraform}
mkdir -p 07-Releases/{current,archive}
mkdir -p 99-Archive/{deprecated,legacy}
```

Report: "✅ Standard directory structure created"

---

## STEP 4: CREATE ESSENTIAL ROOT FILES

Execute:
```bash
# Create missing root files
[ ! -f "README.md" ] && touch README.md
[ ! -f "CLAUDE.md" ] && touch CLAUDE.md
[ ! -f "ARCHITECTURE.md" ] && touch ARCHITECTURE.md
[ ! -f "CONTRIBUTING.md" ] && touch CONTRIBUTING.md
[ ! -f "CHANGELOG.md" ] && touch CHANGELOG.md
[ ! -f "SECURITY.md" ] && touch SECURITY.md
[ ! -f ".gitignore" ] && touch .gitignore
[ ! -f ".env.example" ] && touch .env.example
```

Report: "✅ Essential root files created"

---

## STEP 5: UPDATE README.md

If README.md is empty or missing project structure section, add:

```markdown
## Project Structure

This project follows the Master Project Directory Structure for professional organization:

- `claudes-docs/` - Claude-created documentation and reports
- `01-Docs/` - Project documentation and guides
- `02-Src/` - Source code organized by feature
- `03-Tests/` - Test suites (unit, integration, e2e)
- `04-Assets/` - Static assets and configurations
- `05-Scripts/` - Automation and deployment scripts
- `06-Infrastructure/` - Docker, Kubernetes, Terraform
- `07-Releases/` - Current and archived releases
- `99-Archive/` - Deprecated and legacy code

See `.directory-standards.md` for complete filing system.
```

---

## STEP 6: UPDATE CLAUDE.md

If CLAUDE.md is empty or missing structure section, add:

```markdown
## Directory Structure

This project uses the Master Project Directory Structure:

- All documentation goes in `01-Docs/`
- All source code in `02-Src/` organized by feature
- All tests in `03-Tests/` by type
- Claude-generated docs go in `claudes-docs/` with proper categorization
- File naming: kebab-case for files, PascalCase for main directories

See `.directory-standards.md` for complete standards.
```

---

## STEP 7: UPDATE .gitignore

Ensure .gitignore includes:

```
node_modules/
*.log
.env
.DS_Store
claudes-docs/
dist/
build/
*.tmp
*.cache
.vscode/
.idea/
```

---

## STEP 8: VALIDATE STRUCTURE

Execute validation checks:
```bash
# Check all required directories exist
for dir in claudes-docs 01-Docs 02-Src 03-Tests 04-Assets 05-Scripts 06-Infrastructure 07-Releases 99-Archive; do
  [ -d "$dir" ] && echo "✅ $dir" || echo "❌ Missing: $dir"
done

# Verify root files exist
for file in README.md CLAUDE.md .gitignore; do
  [ -f "$file" ] && echo "✅ $file" || echo "❌ Missing: $file"
done

# Count directories
echo "Total directories: $(find . -type d | wc -l)"
```

Report compliance status.

---

## STEP 9: FINAL REPORT

Generate summary:

```
🎉 MASTER PROJECT STRUCTURE COMPLETE

📊 RESULTS:
- Total directories created: X
- Root files created: Y
- Structure compliance: [FULL/PARTIAL]

📁 STRUCTURE:
[PROJECT-ROOT]/
├── claudes-docs/ ✅
├── 01-Docs/ ✅
├── 02-Src/ ✅
├── 03-Tests/ ✅
├── 04-Assets/ ✅
├── 05-Scripts/ ✅
├── 06-Infrastructure/ ✅
├── 07-Releases/ ✅
├── 99-Archive/ ✅
├── README.md ✅
├── CLAUDE.md ✅
└── .gitignore ✅

🎯 NEXT STEPS:
1. Review README.md and customize project description
2. Add specific build/test commands to documentation
3. Commit structure: git add . && git commit -m "Initialize master project structure"

Your project now has professional-grade organization! 🚀
```

---

## DIRECTORY PURPOSE DEFINITIONS

### Critical Top-Level Directories

#### `audit-reports/` - **LLM Output Storage**
**Purpose**: Store ALL LLM-generated audit, chore, and release reports
**Naming**: ####-PHASE-MMDDYY-DESCRIPTION.md
**Rules**:
- NEVER skip numbers
- ALWAYS at project root
- Chronological ordering
- Read-only after creation

#### `deployment-docs/` - **Project Documentation**
**Purpose**: Human-maintained project documentation
**Naming**: ####-PHASE-MMDDYY-DESCRIPTION.md for reports
**Subdirs**: ##-feature-name/ for grouped docs
**Contains**: PRDs, Tasks, ADRs, deployment reports

#### `.github/scripts/` - **Pipeline Automation**
**Purpose**: Store audit→chore→release pipeline scripts
**Structure**: Separated by phase (audit/, chore/, release/)
**Execution**: Called from project root

---

## FILE NAMING CONVENTIONS

### Universal Rules
1. **Sequential Numbers**: Always increment, never reset (0001, 0002, 0003...)
2. **Date Format**: MMDDYY in filenames (102824), YYYY-MM-DD in documents
3. **Phase Identifiers**: AUDIT, CHORE, RELEASE, DEBUG, CLEAN, ENT, FIX, TEST, FEAT, SEC, DEV
4. **Descriptions**: CAPS-WITH-DASHES for clarity

### By Directory

| Directory | Naming Pattern | Example |
|-----------|---------------|---------|
| audit-reports/ | ####-PHASE-MMDDYY-DESC.md | 0001-AUDIT-102824-INITIAL-SCAN.md |
| deployment-docs/ | ####-PHASE-MMDDYY-DESC.md | 0001-DEBUG-102824-CLEANUP-PLAN.md |
| feature folders/ | ##-feature-name/ | 00-user-auth/ |
| PRDs | ##-prd-featureName.md | 00-prd-userAuth.md |
| Tasks | ##-tasks-featureName.md | 00-tasks-userAuth.md |
| ADRs | ##-adr-featureName.md | 00-adr-userAuth.md |
| Scripts | verb-noun.sh | run-audit.sh |
| Configs | environment.config | production.config |

---

## TASKWARRIOR INTEGRATION

### Project Naming Convention
```bash
# Format: [action]-[project]-MMDDYY
project:audit-myapp-102824
project:chore-myapp-102824
project:release-myapp-102824
project:dir-excel-102824
```

### Standard Task Categories
```bash
+AUDIT      # Audit phase tasks
+CHORE      # Fix implementation tasks
+RELEASE    # Deployment tasks
+SECURITY   # Security-related fixes
+DOCS       # Documentation tasks
+STRUCTURE  # Directory structure fixes
+NAMING     # File naming fixes
+CLEANUP    # Archive/removal tasks
```

### Task Hierarchy Template
```bash
# Master project
task add project:myapp-102824 +MASTER priority:H -- "Project Excellence Pipeline"

# Phase dependencies
task add project:myapp-102824 +AUDIT depends:1 -- "Complete audit phase"
task add project:myapp-102824 +CHORE depends:2 -- "Execute chore phase"
task add project:myapp-102824 +RELEASE depends:3 -- "Release improvements"

# Report tracking
task add project:myapp-102824 +REPORTS -- "Generate: 0001-AUDIT-102824-INITIAL-SCAN.md"
```

---

## REFERENCE: DIRECTORY PURPOSE DEFINITIONS

### Core Directories

**`claudes-docs/`** - Claude-created documentation
- `reports/` - After-action reports, summaries
- `audits/` - Audit and review files
- `analysis/` - Analysis and diagnostic docs
- `plans/` - PRDs, planning documents
- `tasks/` - Task exports from TaskWarrior
- `logs/` - Log files and session records
- `misc/` - Everything else

**`01-Docs/`** - Project documentation
- `architecture/` - System design, diagrams, ADRs
- `api/` - API specs, OpenAPI/Swagger
- `guides/` - User and developer guides
- `meetings/` - Meeting notes and records

**`02-Src/`** - Source code
- `core/` - Core business logic
- `features/` - Feature modules
- `shared/` - Shared utilities
- `vendor/` - Third-party code

**`03-Tests/`** - Test suites
- `unit/` - Unit tests
- `integration/` - Integration tests
- `e2e/` - End-to-end tests
- `fixtures/` - Test data

**`04-Assets/`** - Static assets
- `images/` - Icons, screenshots, branding
- `data/` - Sample data, reference data
- `configs/` - Environment configurations

**`05-Scripts/`** - Automation
- `build/` - Build scripts
- `deploy/` - Deployment scripts
- `maintenance/` - Maintenance and cleanup

**`06-Infrastructure/`** - Infrastructure as Code
- `docker/` - Dockerfiles, docker-compose
- `kubernetes/` - K8s deployments, services
- `terraform/` - Terraform definitions

**`07-Releases/`** - Release artifacts
- `current/` - Current production version
- `archive/` - Historical releases

**`99-Archive/`** - Archived materials
- `deprecated/` - Deprecated but preserved
- `legacy/` - Legacy reference code

---

## BENEFITS OF THIS SYSTEM

1. **Universal Consistency**: Every project identical structure
2. **AI-Friendly**: Clear location for all generated reports
3. **Immediate Navigation**: Anyone finds files in seconds
4. **Scalable**: Works for 10 files or 10,000 files
5. **Professional**: Clean, organized, maintainable
6. **No Confusion**: Everyone knows where everything goes

---

## QUICK REFERENCE

| What | Where |
|------|-------|
| Claude Docs | `claudes-docs/` |
| Documentation | `01-Docs/` |
| Source Code | `02-Src/` |
| Tests | `03-Tests/` |
| Assets | `04-Assets/` |
| Scripts | `05-Scripts/` |
| Infrastructure | `06-Infrastructure/` |
| Releases | `07-Releases/` |
| Archive | `99-Archive/` |

---

## VERSION HISTORY

- **1.0.7** (2025-10-05) – Converted to AI execution model, removed bash scripts
- **1.0.0** (2025-09-28) – Initial master structure definition

---

*Master Project Directory Structure – Professional organization for any project*