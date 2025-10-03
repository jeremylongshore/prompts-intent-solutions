# Tools & Automation

Repository automation scripts and validation tools.

## Automation Scripts

### [Repository Management](automation/repository/)
Scripts for repository lifecycle management:
- `bump-version.sh` - Version management
- `create-release.sh` - Release creation
- `generate-changelog.sh` - Automated changelog generation
- `announce-release.sh` - Release announcements
- `archive-artifacts.sh` - Artifact management
- `deploy-release.sh` - Deployment automation
- `verify-release-ready.sh` - Release readiness checks

### [Development Automation](automation/development/)
Development workflow automation:
- `init-audit-system.sh` - Initialize audit tracking
- `init-chore-system.sh` - Initialize chore management
- `init-release-system.sh` - Initialize release system
- `run-chore.sh` - Execute development chores
- `run-complete-audit.sh` - Complete repository audits
- `run-complete-chore.sh` - Complete chore workflows

### [Maintenance & Fixes](automation/maintenance/)
Repository maintenance and problem resolution:
- `complete-chore.sh` - Finalize chore phases
- `execute-fix.sh` - Execute specific fixes
- `fix-code.sh` - Code-related issue fixes
- `fix-community.sh` - Community-related fixes
- `fix-documentation.sh` - Documentation fixes
- `fix-infrastructure.sh` - Infrastructure fixes
- `fix-security.sh` - Security issue fixes
- `manual-fix-handler.sh` - Manual intervention handler
- `verify-fixes.sh` - Verify applied fixes
- `log-finding.sh` - Issue logging
- `schedule-next-audit.sh` - Audit scheduling

## Validation Tools

### [Template Validation](validation/)
Quality assurance for prompt templates:
- `validate_filenames.py` - Filename convention validation
- `validate_frontmatter.py` - YAML frontmatter validation
- `validate_structure.py` - Repository structure validation
- `check_duplicates.py` - Duplicate detection

## Usage

### Running Validation
```bash
# Run all validation checks
cd tools/validation/
python validate_filenames.py
python validate_frontmatter.py
python validate_structure.py
python check_duplicates.py
```

### Automation Workflows
```bash
# Repository management
./tools/automation/repository/bump-version.sh
./tools/automation/repository/create-release.sh

# Development workflows
./tools/automation/development/run-complete-audit.sh

# Maintenance operations
./tools/automation/maintenance/fix-documentation.sh
```

All scripts maintain repository quality and automate routine operations.