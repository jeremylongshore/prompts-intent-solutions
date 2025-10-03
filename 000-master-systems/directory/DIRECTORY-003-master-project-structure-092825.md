---
name: master-project-directory-structure
description: The Universal Standard for All Projects - definitive directory structure for Fortune 500-level organization
model: opus
date: 2025-09-28
---

# Master Project Directory Structure™
## The Universal Standard for All Projects

---

## DEFINITIVE PROJECT STRUCTURE

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

## WORKFLOW EXECUTION ORDER

### 1. Directory Excellence (First)
```bash
# Clean up file system
./run-directory-audit.sh      # Analyze structure
./run-directory-chore.sh      # Fix naming/organization
./run-directory-release.sh    # Validate excellence
```

### 2. GitHub Repository Audit (Second)
```bash
# Enhance repository
./.github/scripts/audit/run-complete-audit.sh     # Find issues
./.github/scripts/chore/run-complete-chore.sh     # Fix issues
./.github/scripts/release/run-complete-release.sh # Deploy fixes
```

### 3. Continuous Excellence
```bash
# Monthly maintenance
task project:excellence recur:monthly -- "Run excellence pipeline"
```

---

## INITIALIZATION COMMANDS

### New Project Setup
```bash
#!/bin/bash
# setup-project-structure.sh

PROJECT_NAME="$1"
DATE=$(date +%m%d%y)

echo "Initializing Master Structure for: $PROJECT_NAME"

# Create all directories
mkdir -p {audit-reports,deployment-docs,.github/{scripts/{audit,chore,release},workflows}}
mkdir -p {01-docs/{architecture,api,guides,meetings},02-src/{core,features,shared,vendor}}
mkdir -p {03-tests/{unit,integration,e2e,fixtures},04-assets/{images,data,configs}}
mkdir -p {05-scripts/{build,deploy,maintenance},06-infrastructure/{docker,kubernetes,terraform}}
mkdir -p {07-releases/{current,archive},99-archive/{deprecated,legacy}}

# Create essential files
touch README.md ARCHITECTURE.md CONTRIBUTING.md CHANGELOG.md LICENSE
touch SECURITY.md ROADMAP.md GOVERNANCE.md .gitignore .env.example

# Create first audit report
cat > audit-reports/0001-AUDIT-${DATE}-STRUCTURE-INITIALIZED.md << EOF
# 0001-AUDIT-${DATE}-STRUCTURE-INITIALIZED.md

**Date**: $(date +%Y-%m-%d)
**Phase**: AUDIT
**Status**: ✅ COMPLETE

## Description
Master directory structure initialized for $PROJECT_NAME

## Structure Created
- All numbered directories (01-docs through 99-archive)
- audit-reports/ for LLM output
- deployment-docs/ for project documentation
- .github/scripts/ for pipeline automation

---
**Created**: $(date -Iseconds)
EOF

# Initialize TaskWarrior
task add project:${PROJECT_NAME}-${DATE} +MASTER priority:H -- "Initialize $PROJECT_NAME excellence"

echo "✅ Master structure created!"
echo "📁 Directories: $(find . -type d | wc -l)"
echo "📄 Files: $(find . -type f | wc -l)"
echo "📊 First report: audit-reports/0001-AUDIT-${DATE}-STRUCTURE-INITIALIZED.md"
```

---

## VALIDATION CHECKLIST

### Directory Structure Compliance
```bash
# Check all required directories exist
for dir in audit-reports deployment-docs 01-docs 02-src 03-tests 04-assets 05-scripts 06-infrastructure 07-releases 99-archive; do
  [ -d "$dir" ] && echo "✅ $dir" || echo "❌ Missing: $dir"
done

# Verify no files in root (except allowed)
ls -la | grep -v "^d" | grep -v "README\|LICENSE\|CONTRIBUTING\|CHANGELOG\|ARCHITECTURE\|SECURITY\|GOVERNANCE\|ROADMAP\|\.git\|\.env"

# Check report numbering sequence
ls audit-reports/*.md | sed 's/.*\/\([0-9]\{4\}\).*/\1/' | sort -n | awk '$1!=p+1{print "Gap at: "p+1}{p=$1}'
```

---

## BENEFITS OF THIS SYSTEM

1. **Universal Consistency**: Every project identical structure
2. **LLM-Friendly**: Clear location for all generated reports
3. **Audit Trail**: Complete chronological history
4. **GitHub Integration**: Pipeline scripts organized by phase
5. **TaskWarrior Tracking**: Everything tracked and measurable
6. **Scalable**: Works for 10 files or 10,000 files
7. **Professional**: Fortune 500-level organization
8. **No Confusion**: Everyone knows where everything goes

---

## THE POWER OF THIS STRUCTURE

When someone opens ANY of your projects, they see:
- Identical, professional organization
- Clear separation of concerns
- Obvious location for everything
- Complete audit trail
- Professional documentation
- Enterprise-grade structure

**This isn't just organization—it's operational excellence that scales infinitely.**

---

## QUICK REFERENCE

| What | Where | Format |
|------|-------|--------|
| LLM Reports | `/audit-reports/` | ####-PHASE-MMDDYY-DESC.md |
| Project Docs | `/deployment-docs/` | ####-PHASE-MMDDYY-DESC.md |
| Pipeline Scripts | `/.github/scripts/[phase]/` | verb-noun.sh |
| Source Code | `/02-src/` | Standard language conventions |
| Tests | `/03-tests/` | test-[feature].js |
| Documentation | `/01-docs/` | kebab-case.md |
| Archives | `/99-archive/` | cleanup-YYYY-MM-DD/ |

**This structure is your competitive advantage. Implement it everywhere.**

---
*Updated: September 28, 2025*