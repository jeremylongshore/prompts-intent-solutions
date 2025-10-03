# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive prompt engineering toolkit containing professional prompt templates for AI-assisted software development. The repository uses a structured template system with automated validation and categorized organization.

## Project Architecture

### Template Organization System
The repository follows a category-first organization based on **ADR-001: Template System Architecture**:

```
prompts-intent-solutions/
├── planning/           # PLAN-### templates - Strategic planning & architecture
├── setup/             # SETUP-### templates - Configuration & initialization
├── debugging/         # DEBUG-### templates - Problem diagnosis & troubleshooting
├── features/          # FEAT-### templates - Feature development & enhancement
├── testing/           # TEST-### templates - Testing & validation
├── cleaning/          # CLEAN-### templates - Maintenance & optimization
├── security/          # SEC-### templates - Security-focused prompts
├── project-specs/     # Project-correlated docs (PRD, ARD, TRD)
├── business/          # Business-focused templates (marketing, finance, operations)
├── tools/             # Validation scripts and automation tools
├── docs/              # Architecture decisions and documentation
└── scripts/           # Automation and workflow scripts
```

### Template Naming Convention
**Format**: `CATEGORY-###-description-MMDDYY.md`

- **CATEGORY**: One of PLAN, SETUP, DEBUG, FEAT, TEST, CLEAN, SEC
- **###**: Sequential number within category (001, 002, 003...)
- **description**: Kebab-case description (lowercase, hyphens)
- **MMDDYY**: Creation or last major revision date

Examples:
- ✅ `SETUP-001-ai-assistant-092825.md`
- ✅ `DEBUG-003-memory-leak-detection-092825.md`
- ✅ `FEAT-004-api-integration-100125.md`

### Template Structure
Each template must include YAML frontmatter:

```yaml
---
name: descriptive-template-name
description: Brief description of what this template does
model: opus  # or sonnet, haiku, gpt-4, gpt-3.5
---

# Template content with clear prompts
```

## Development Commands

### Validation and Quality Checks
```bash
# Run all validation checks (required before commits)
python tools/validate_filenames.py     # Validate naming conventions
python tools/validate_frontmatter.py  # Check YAML frontmatter structure
python tools/validate_structure.py    # Verify repository structure
python tools/check_duplicates.py      # Check for duplicate templates

# Quick validation (all checks)
python -m pip install pyyaml
python tools/validate_filenames.py && python tools/validate_frontmatter.py && python tools/validate_structure.py && python tools/check_duplicates.py
```

### Repository Management Scripts
```bash
# Chore and maintenance automation
./init-chore-system.sh                # Initialize chore tracking system
./run-complete-chore.sh               # Execute complete chore workflow
./complete-chore.sh                   # Finalize chore phase

# Release management
./init-release-system.sh              # Initialize release system
./bump-version.sh                     # Bump version for release
./create-release.sh                   # Create new release
./verify-release-ready.sh             # Verify release readiness

# Audit and cleanup
./run-complete-audit.sh               # Complete repository audit
./archive-artifacts.sh                # Archive old artifacts
./generate-changelog.sh               # Generate changelog
```

### Manual Fixes and Troubleshooting
```bash
# Targeted fix scripts
./fix-code.sh                         # Fix code-related issues
./fix-documentation.sh                # Fix documentation issues
./fix-infrastructure.sh               # Fix infrastructure issues
./fix-security.sh                     # Fix security issues
./fix-community.sh                    # Fix community-related issues

# Manual intervention
./manual-fix-handler.sh               # Handle manual fixes
./execute-fix.sh                      # Execute specific fixes
./verify-fixes.sh                     # Verify applied fixes
```

## Automated Validation System

### GitHub Actions Pipeline
- **Template Validation**: Runs on every push and PR
- **Filename Convention Check**: Validates naming patterns
- **YAML Frontmatter Validation**: Ensures proper structure
- **Repository Structure Check**: Verifies required directories
- **Duplicate Detection**: Prevents duplicate templates
- **Markdown Linting**: Validates markdown syntax

### Pre-commit Requirements
Before committing changes, ensure:
1. All validation scripts pass
2. Templates follow naming convention
3. YAML frontmatter is properly formatted
4. No duplicate templates exist
5. Repository structure is maintained

## Contributing Workflow

### Adding New Templates
1. **Choose correct category** based on template purpose
2. **Follow naming convention**: `CATEGORY-###-description-MMDDYY.md`
3. **Include YAML frontmatter** with required fields
4. **Run validation checks** before committing
5. **Create feature branch** and submit PR

### Template Development Process
```bash
# 1. Create feature branch
git checkout -b template/new-awesome-template

# 2. Add template following naming convention
# Example: FEAT-004-api-integration-100125.md

# 3. Validate locally
python tools/validate_filenames.py
python tools/validate_frontmatter.py

# 4. Test template with AI models
# Verify functionality with intended AI assistant

# 5. Submit PR
git add . && git commit -m "feat: add API integration template"
git push origin template/new-awesome-template
```

## Key Validation Scripts

### Primary Validators
- **`tools/validate_filenames.py`**: Enforces naming convention across all categories
- **`tools/validate_structure.py`**: Ensures required directories and files exist
- **`tools/validate_frontmatter.py`**: Validates YAML frontmatter structure
- **`tools/check_duplicates.py`**: Prevents duplicate templates

### Automation Tools
- **`tools/task_automation.py`**: Template automation helpers
- **CI/CD Integration**: Automatic validation on GitHub Actions

## Business Template Categories

The repository includes specialized business-focused templates:

- **Marketing & Sales**: LinkedIn outreach, email campaigns, product descriptions
- **Operations**: Meeting summaries, process documentation, vendor negotiation
- **Customer Success**: Complaint resolution, support responses, churn prevention
- **Finance**: Invoice follow-ups, financial reports, cash flow forecasting
- **People & Culture**: Hiring optimization, performance reviews, job descriptions

## Template Quality Standards

### Required Elements
- Clear problem statement and context
- Specific, actionable instructions
- Expected outcomes and deliverables
- Usage examples and test cases
- Compatible AI model recommendations

### Best Practices
- Test templates with multiple AI models
- Include error handling and edge cases
- Provide clear customization instructions
- Document template limitations and scope
- Include real-world usage examples

## Architecture Decisions

Key architectural decisions are documented in:
- **`docs/ADR-001-TEMPLATE_SYSTEM_ARCHITECTURE-092825.md`**: Core template organization
- **`docs/STRUCTURE.md`**: Directory structure and naming conventions
- **`docs/FILING-SYSTEM.md`**: Repository organization principles

## Dependencies and Requirements

### Development Dependencies
- **Python 3.8+**: For validation scripts
- **PyYAML**: YAML frontmatter parsing
- **Git**: Version control and branching

### CI/CD Dependencies
- **GitHub Actions**: Automated validation
- **markdownlint**: Markdown syntax validation
- **Python validation scripts**: Custom template validation

## Project Metadata

- **Total Templates**: 15+ and growing across all categories
- **Validation Level**: Automated CI/CD pipeline
- **Architecture**: Category-first hybrid numbering system
- **License**: MIT License
- **Maintainer**: Jeremy Longshore (@jeremylongshore)

This repository implements a scalable, maintainable system for prompt engineering templates with comprehensive validation and automated quality assurance.