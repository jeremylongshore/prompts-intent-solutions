## Task Tracking (Beads / bd)
- Use `bd` for ALL tasks/issues (no markdown TODO lists).
- Start of session: `bd ready`
- Create work: `bd create "Title" -p 1 --description "Context + acceptance criteria"`
- Update status: `bd update <id> --status in_progress`
- Finish: `bd close <id> --reason "Done"`
- End of session: `bd sync` (flush/import/export + git sync)
- Manual testing safety:
  - Prefer `BEADS_DIR` to isolate a workspace if needed. (`BEADS_DB` exists but is deprecated.)


# CLAUDE.md


### Beads upgrades
- After upgrading `bd`, run: `bd info --whats-new`
- If `bd info` warns about hooks, run: `bd hooks install`
This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive prompt engineering toolkit containing professional prompt templates for AI-assisted software development and business operations. The repository uses a structured template system with automated validation and category-based organization.

## Architecture

### Template Organization System
Based on **ADR-001: Template System Architecture**, this repository follows a category-first hybrid numbering system:

```
prompts-intent-solutions/
├── prompts/
│   ├── development/       # Software development prompts
│   │   ├── planning/      # PLAN-### templates
│   │   ├── setup/         # SETUP-### templates
│   │   ├── debugging/     # DEBUG-### templates
│   │   ├── features/      # FEAT-### templates
│   │   ├── testing/       # TEST-### templates
│   │   ├── maintenance/   # CLEAN-### templates
│   │   └── security/      # SEC-### templates
│   ├── business/          # Business operations prompts
│   │   ├── marketing/     # MARKET-### templates
│   │   ├── finance/       # FINANCE-### templates
│   │   ├── operations/    # OPS-### templates
│   │   ├── customer-success/  # CS-### templates
│   │   └── people-culture/    # PEOPLE-### templates
│   └── specialized/       # Advanced/domain-specific prompts
│       └── claude-agents/ # 74 Claude Code agent configurations
├── project-specs/         # Project-correlated documents (PRD, ARD, TRD)
├── tools/                 # Validation scripts and automation
├── docs/                  # Architecture decisions and documentation
└── 000-master-systems/    # Master automation workflows
```

### Template Naming Convention
**Format**: `CATEGORY-###-description-MMDDYY.md`

- **CATEGORY**: Template type (PLAN, SETUP, DEBUG, FEAT, TEST, CLEAN, SEC, MARKET, FINANCE, OPS, CS, PEOPLE)
- **###**: Sequential number within category (001, 002, 003...)
- **description**: Kebab-case description (lowercase, hyphens)
- **MMDDYY**: Creation or last major revision date

**Examples**:
- `SETUP-001-ai-assistant-092825.md`
- `DEBUG-003-memory-leak-detection-092825.md`
- `MARKET-001-linkedin-meeting-booker.md`

### Template Structure Requirements
Each template MUST include YAML frontmatter:

```yaml
---
name: descriptive-template-name
description: Brief description of what this template does
model: opus  # or sonnet, haiku, gpt-4, gpt-3.5
---

# Template content with clear prompts
```

## Development Commands

### Validation (Required Before Commits)
```bash
# Run all validation checks
python tools/validate_filenames.py     # Validate naming conventions
python tools/validate_frontmatter.py  # Check YAML frontmatter structure
python tools/validate_structure.py    # Verify repository structure
python tools/check_duplicates.py      # Check for duplicate templates

# Quick validation (all checks at once)
python tools/validate_filenames.py && \
  python tools/validate_frontmatter.py && \
  python tools/validate_structure.py && \
  python tools/check_duplicates.py
```

### Repository Automation
```bash
# Chore and maintenance automation
./tools/automation/development/init-chore-system.sh      # Initialize chore tracking
./tools/automation/development/run-complete-chore.sh     # Execute complete chore workflow
./tools/automation/maintenance/complete-chore.sh         # Finalize chore phase

# Release management
./tools/automation/development/init-release-system.sh    # Initialize release system
./tools/automation/repository/bump-version.sh            # Bump version for release
./tools/automation/repository/create-release.sh          # Create new release
./tools/automation/repository/verify-release-ready.sh    # Verify release readiness
./tools/automation/repository/generate-changelog.sh      # Generate changelog

# Audit and cleanup
./tools/automation/development/run-complete-audit.sh     # Complete repository audit
./tools/automation/repository/archive-artifacts.sh       # Archive old artifacts
```

### Targeted Fixes
```bash
# Category-specific fix scripts
./tools/automation/maintenance/fix-code.sh               # Fix code-related issues
./tools/automation/maintenance/fix-documentation.sh      # Fix documentation issues
./tools/automation/maintenance/fix-infrastructure.sh     # Fix infrastructure issues
./tools/automation/maintenance/fix-security.sh           # Fix security issues
./tools/automation/maintenance/fix-community.sh          # Fix community-related issues

# Manual intervention
./tools/automation/maintenance/manual-fix-handler.sh     # Handle manual fixes
./tools/automation/maintenance/execute-fix.sh            # Execute specific fixes
./tools/automation/maintenance/verify-fixes.sh           # Verify applied fixes
```

## Automated Validation System

### GitHub Actions Pipeline
Located in `.github/workflows/template-validation.yml`, the pipeline runs on:
- Every push to `main` or `develop` branches
- Every pull request to `main`

**Validation Steps**:
1. Filename convention validation
2. YAML frontmatter structure validation
3. Repository structure verification
4. Duplicate template detection
5. Markdown syntax validation (markdownlint)

### Pre-commit Requirements
All validation scripts MUST pass before committing:
1. Filenames follow `CATEGORY-###-description-MMDDYY.md` convention
2. YAML frontmatter is properly formatted with required fields
3. No duplicate templates exist
4. Repository structure is maintained
5. All markdown files pass linting

## Contributing Workflow

### Adding New Templates
1. **Choose correct category** based on template purpose:
   - Development: `prompts/development/{planning|setup|debugging|features|testing|maintenance|security}/`
   - Business: `prompts/business/{marketing|finance|operations|customer-success|people-culture}/`
   - Specialized: `prompts/specialized/`

2. **Follow naming convention**: `CATEGORY-###-description-MMDDYY.md`
   - Find next sequential number in category
   - Use kebab-case for description
   - Use current date in MMDDYY format

3. **Include YAML frontmatter** with required fields:
   ```yaml
   ---
   name: template-name
   description: What this template does
   model: opus  # or sonnet, haiku, gpt-4, gpt-3.5
   ---
   ```

4. **Run validation checks**:
   ```bash
   python tools/validate_filenames.py
   python tools/validate_frontmatter.py
   python tools/validate_structure.py
   python tools/check_duplicates.py
   ```

5. **Create feature branch and submit PR**:
   ```bash
   git checkout -b template/new-template-name
   git add .
   git commit -m "feat: add new template for X"
   git push origin template/new-template-name
   ```

### Template Development Best Practices
- Test templates with multiple AI models before submitting
- Include clear problem statement and context
- Provide specific, actionable instructions
- Document expected outcomes and deliverables
- Include usage examples and test cases
- Specify compatible AI model recommendations

## Key Validation Scripts

### Primary Validators (tools/)
- **`validate_filenames.py`**: Enforces naming convention across all categories
- **`validate_structure.py`**: Ensures required directories and files exist
- **`validate_frontmatter.py`**: Validates YAML frontmatter structure
- **`check_duplicates.py`**: Prevents duplicate templates

### Automation Tools (tools/automation/)
- **`development/`**: Initialization scripts for chores, audits, releases
- **`maintenance/`**: Fix execution, verification, and completion scripts
- **`repository/`**: Release management, versioning, changelog generation

## Template Categories

### Development Templates (`prompts/development/`)
- **PLAN**: Strategic planning, architecture, project roadmaps (8 templates)
- **SETUP**: Environment config, tool initialization (8 templates)
- **DEBUG**: Error analysis, performance diagnosis (5 templates)
- **FEAT**: New functionality, feature enhancements (3 templates)
- **TEST**: Test strategies, QA processes (3 templates)
- **CLEAN**: Code cleanup, refactoring, technical debt (4 templates)
- **SEC**: Security audits, threat analysis, compliance (4 templates)

### Business Templates (`prompts/business/`)
- **MARKET**: LinkedIn outreach, email campaigns, social media (5 templates)
- **FINANCE**: Invoice automation, cash flow forecasting (4 templates)
- **OPS**: Process documentation, vendor negotiation, meetings (5 templates)
- **CS**: Complaint resolution, support tickets, churn prevention (6 templates)
- **PEOPLE**: Hiring optimization, performance reviews, retention (5 templates)

### Specialized Templates (`prompts/specialized/`)
- **Claude Code Agents**: 74 professional AI agent configurations
- **Automation Systems**: Complex multi-step workflows
- **Industry Solutions**: Domain-specific templates

## Architecture Decisions

Key architectural decisions documented in `docs/`:
- **`ADR-001-TEMPLATE_SYSTEM_ARCHITECTURE-092825.md`**: Core template organization system
- **`STRUCTURE.md`**: Directory structure and naming conventions
- **`FILING-SYSTEM.md`**: Repository organization principles
- **`MIGRATION.md`**: Migration guides for template reorganization

## Project Metadata

- **Current Version**: 1.0.1 (see `version.txt`)
- **Total Templates**: 150+ across all categories
- **Claude Code Agents**: 74 professional configurations
- **Validation Level**: Automated CI/CD pipeline with 5 validation checks
- **License**: MIT License
- **Web Catalog**: https://jeremylongshore.github.io/prompts-intent-solutions/

## Directory Standards

This project follows `.directory-standards.md` for structure and file naming.

### Key Standards
- **Store all docs in `01-Docs/`** using `NNN-abv-description.ext` format (see abbreviation table in standards file)
- **Maintain strict chronological order** for documentation files
- **Prompts directory** (`prompts/`) is the core product - organize by category (development/business/specialized)
- **File naming**: kebab-case for files, PascalCase for main directories
- **CHANGELOG.md**: Newest entries on TOP (reverse chronological)
- **000-master-systems/**: Do NOT modify without explicit permission

### Documentation Filing
- Use approved abbreviations: prd, adr, tsk, mtg, log, etc. (120+ in standards file)
- Format: `001-adr-initial-architecture.md`, `002-prd-core-features.md`
- Subdirectories: Use letters/numbers for sub-tasks (005a, 005b or 006-1, 006-2)

## Critical Rules

### File Creation Policy
1. **NEVER create files without explicit permission**
2. **ALWAYS prefer editing existing files over creating new ones**
3. **NEVER create documentation files unless explicitly requested**
4. **ALWAYS use proper directory structure** - no scattered files in root
5. **NEVER create test/temp files** - use existing test directories
6. **NEVER modify 000-master-systems/** without explicit permission

### Validation Requirements
1. All templates MUST follow naming convention
2. All templates MUST include valid YAML frontmatter
3. All validation scripts MUST pass before committing
4. No duplicate templates allowed
5. Repository structure MUST be maintained

### Commit Standards
Follow [Conventional Commits](https://www.conventionalcommits.org/):
```
feat: add new debugging template for API issues
fix: correct filename validation regex
docs: update contributing guidelines
chore: update validation scripts
```

## Dependencies

### Python Requirements
- **Python 3.8+**: For validation scripts
- **PyYAML**: YAML frontmatter parsing
  ```bash
  pip install pyyaml
  ```

### CI/CD Dependencies
- **GitHub Actions**: Automated validation pipeline
- **markdownlint**: Markdown syntax validation
- **Python validation scripts**: Custom template validation

## Common Tasks

### Find Next Template Number
```bash
# For development templates
ls -1 prompts/development/planning/ | grep "PLAN-" | sort | tail -1
ls -1 prompts/development/debugging/ | grep "DEBUG-" | sort | tail -1

# For business templates
ls -1 prompts/business/marketing/ | grep "MARKET-" | sort | tail -1
ls -1 prompts/business/finance/ | grep "FINANCE-" | sort | tail -1
```

### Test Single Template
```bash
# Read template to verify frontmatter
head -20 prompts/development/setup/SETUP-001-ai-assistant-092825.md

# Validate specific category
python tools/validate_filenames.py
```

### Check Template Duplicates
```bash
python tools/check_duplicates.py
```

## Support and Resources

- **Contributing Guide**: See `CONTRIBUTING.md` for detailed contribution process
- **Security Policy**: See `SECURITY.md` for vulnerability reporting
- **Issue Templates**: `.github/ISSUE_TEMPLATE/` for bug reports, features, questions
- **Web Catalog**: https://jeremylongshore.github.io/prompts-intent-solutions/
- **Maintainer**: [@jeremylongshore](https://github.com/jeremylongshore)

---

**Last Updated**: 2025-10-04
**Status**: ✅ Production-ready with comprehensive validation
