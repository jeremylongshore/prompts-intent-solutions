---
name: directory-audit-transformation-system
description: AI execution prompt for comprehensive directory audit and transformation with TaskWarrior tracking
model: opus
date: 2025-10-05
---

# Directory Audit & Transformation System
## AI Execution Prompt for Deep Directory Analysis

---

## INSTRUCTIONS FOR CLAUDE

When the user asks you to audit or deeply analyze a directory, follow this comprehensive protocol to assess current state, identify issues, and provide actionable transformation plan.

### Your Mission

Perform a complete professional audit of the directory including:
1. Comprehensive analysis across 7 dimensions
2. Generate detailed reports in `claudes-docs/audits/`
3. Create TaskWarrior tracking for remediation
4. Provide actionable transformation roadmap

---

## STEP 1: INITIALIZE AUDIT SYSTEM

Execute:
```bash
# Show current directory
pwd

# Get current date for report naming
date +%Y-%m-%d

# Create audit directory in claudes-docs
mkdir -p claudes-docs/audits
```

Report: "✅ Audit system initialized in claudes-docs/audits/"

---

## STEP 2: AUDIT DIMENSION 1 - NAMING CONVENTIONS

### Analyze

Execute:
```bash
# Find files with spaces
find . -maxdepth 2 -name "* *" -type f ! -path "./.git/*"

# Find files with underscores
find . -maxdepth 2 -name "*_*" -type f ! -path "./.git/*"

# Find files with uppercase
find . -maxdepth 2 -name "*[A-Z]*" -type f ! -path "./.git/*" ! -name "README.md" ! -name "CLAUDE.md" ! -name "LICENSE" ! -name "CHANGELOG.md"

# Count total violations
find . -maxdepth 2 -type f \( -name "* *" -o -name "*_*" -o -name "*[A-Z]*" \) ! -path "./.git/*" | wc -l
```

### Create Report

Save to `claudes-docs/audits/YYYY-MM-DD_naming-violations-audit.md`:

```markdown
# Naming Convention Violations Audit

**Date:** YYYY-MM-DD
**Directory:** [path]
**Auditor:** Claude AI

## Summary

Total violations found: X files

## Violations by Type

### Files with Spaces (X files)
- "Project Report.pdf" → should be "project-report.pdf"
- "Meeting Notes.docx" → should be "meeting-notes.docx"

### Files with Underscores (X files)
- "api_documentation.md" → should be "api-documentation.md"
- "user_data.json" → should be "user-data.json"

### Files with Mixed Case (X files)
- "UserSettings.json" → should be "user-settings.json"
- "APIResponse.ts" → should be "api-response.ts"

## Remediation Plan

1. Rename X files to kebab-case
2. Estimated time: X minutes
3. Risk: Low (file references may need updating)

## TaskWarrior Commands

task add project:dir-audit +NAMING "Fix X naming violations"
```

---

## STEP 3: AUDIT DIMENSION 2 - DIRECTORY STRUCTURE

### Analyze

Execute:
```bash
# Show directory tree
tree -L 3 -d

# Or if tree not available:
find . -maxdepth 3 -type d ! -path "./.git/*" | sort

# Count depth violations (>4 levels)
find . -type d | awk -F/ 'NF > 5' | wc -l

# Find files in root
find . -maxdepth 1 -type f ! -name ".*" ! -name "README.md" ! -name "CLAUDE.md" ! -name "LICENSE" ! -name "CHANGELOG.md" ! -name ".directory-standards.md"
```

### Create Report

Save to `claudes-docs/audits/YYYY-MM-DD_structure-analysis-audit.md`:

```markdown
# Directory Structure Analysis

**Date:** YYYY-MM-DD

## Current Structure

[paste tree output]

## Issues Identified

### Missing Standard Directories
- ❌ 01-Docs/ not found
- ❌ 02-Src/ not found
- ✅ .github/ exists

### Depth Violations
- X directories exceed 4-level depth
- Deepest path: [path] (X levels)

### Files in Root
- X files found in root (should be in subdirectories)
- List: [files]

## Compliance Score

Structure compliance: X/10

## Remediation Plan

1. Create standard directory structure
2. Move X files from root to proper locations
3. Flatten deep nesting

## TaskWarrior Commands

task add project:dir-audit +STRUCTURE "Create standard directory structure"
task add project:dir-audit +STRUCTURE "Move X root files to proper locations"
```

---

## STEP 4: AUDIT DIMENSION 3 - CONTENT ORGANIZATION

### Analyze

Execute:
```bash
# Find all documentation files
find . -name "*.md" -o -name "*.pdf" -o -name "*.docx" | grep -v ".git" | grep -v "node_modules"

# Find duplicate files (by name)
find . -type f ! -path "./.git/*" -exec basename {} \; | sort | uniq -d

# Find large files (>10MB)
find . -type f -size +10M ! -path "./.git/*"

# Find temp files
find . -name "*.tmp" -o -name "*.cache" -o -name "*.bak" -o -name "*~"
```

### Create Report

Save to `claudes-docs/audits/YYYY-MM-DD_content-organization-audit.md`:

```markdown
# Content Organization Audit

**Date:** YYYY-MM-DD

## Documentation Files

Total found: X files
Locations: X different directories

### Scattered Documentation
- ./notes/ (X files)
- ./docs/ (X files)
- ./documentation/ (X files)
- ./guides/ (X files)

**Issue:** Documentation should be consolidated in `01-Docs/`

## Duplicate Files

- file.txt found in 3 locations
- [list duplicates]

## Large Files

- large-video.mp4 (500MB) - should be external
- database-dump.sql (200MB) - should be in data storage

## Temporary Files

- X temp files found (should be cleaned)

## Remediation Plan

1. Consolidate docs to 01-Docs/
2. Remove X duplicate files
3. Move large files to external storage
4. Clean X temp files

## TaskWarrior Commands

task add project:dir-audit +CONTENT "Consolidate documentation to 01-Docs"
task add project:dir-audit +CONTENT "Remove duplicate files"
task add project:dir-audit +CONTENT "Clean temporary files"
```

---

## STEP 5: AUDIT DIMENSION 4 - DOCUMENTATION COMPLETENESS

### Analyze

Execute:
```bash
# Check for required docs
ls -la README.md CLAUDE.md LICENSE CHANGELOG.md .gitignore 2>/dev/null || echo "Missing files"

# Check README content
[ -f "README.md" ] && wc -l README.md || echo "README.md missing"

# Check CLAUDE.md content
[ -f "CLAUDE.md" ] && wc -l CLAUDE.md || echo "CLAUDE.md missing"
```

### Create Report

Save to `claudes-docs/audits/YYYY-MM-DD_documentation-completeness-audit.md`:

```markdown
# Documentation Completeness Audit

**Date:** YYYY-MM-DD

## Required Root Files

- ✅ README.md (X lines)
- ❌ CLAUDE.md (missing)
- ✅ LICENSE (present)
- ❌ CHANGELOG.md (missing)
- ✅ .gitignore (configured)

## Documentation Quality

### README.md
- Length: X lines
- Sections present: X/7
- Missing: Installation, Usage, Contributing
- Quality score: X/10

### Missing Documentation
- CLAUDE.md (AI assistant instructions)
- CHANGELOG.md (version history)
- CONTRIBUTING.md (contribution guidelines)

## Remediation Plan

1. Create CLAUDE.md with directory standards
2. Create CHANGELOG.md
3. Enhance README.md with missing sections

## TaskWarrior Commands

task add project:dir-audit +DOCS "Create CLAUDE.md"
task add project:dir-audit +DOCS "Create CHANGELOG.md"
task add project:dir-audit +DOCS "Enhance README.md"
```

---

## STEP 6: AUDIT DIMENSION 5 - PERFORMANCE METRICS

### Analyze

Execute:
```bash
# Total size
du -sh .

# File count
find . -type f ! -path "./.git/*" | wc -l

# Directory count
find . -type d ! -path "./.git/*" | wc -l

# Largest files
find . -type f ! -path "./.git/*" -exec du -h {} + | sort -rh | head -10

# node_modules size (if exists)
[ -d "node_modules" ] && du -sh node_modules
```

### Create Report

Save to `claudes-docs/audits/YYYY-MM-DD_performance-metrics-audit.md`:

```markdown
# Performance & Efficiency Metrics

**Date:** YYYY-MM-DD

## Size Metrics

- Total size: X MB
- File count: X files
- Directory count: X directories
- Average file size: X KB

## Largest Files

1. file1.ext - X MB
2. file2.ext - X MB
[list top 10]

## Performance Impact

- Git clone time: ~X seconds
- IDE load time: ~X seconds
- Search speed: X ms per query

## Optimization Opportunities

- node_modules: X MB (consider .gitignore)
- Large binaries: X MB (move to external storage)
- Duplicate files: X MB (can be deduplicated)

## Remediation Plan

1. Remove node_modules from git (if committed)
2. Move large files to external storage
3. Clean duplicate files

## TaskWarrior Commands

task add project:dir-audit +PERFORMANCE "Optimize repository size"
task add project:dir-audit +PERFORMANCE "Configure .gitignore for large files"
```

---

## STEP 7: AUDIT DIMENSION 6 - SECURITY & COMPLIANCE

### Analyze

Execute:
```bash
# Find .env files
find . -name ".env*" -type f

# Find potential secrets
grep -r "API_KEY\|SECRET\|PASSWORD\|TOKEN" . 2>/dev/null | grep -v ".git" | head -20

# Find committed dependencies
ls -la node_modules package-lock.json yarn.lock 2>/dev/null

# Check .gitignore
cat .gitignore 2>/dev/null || echo ".gitignore missing"
```

### Create Report

Save to `claudes-docs/audits/YYYY-MM-DD_security-compliance-audit.md`:

```markdown
# Security & Compliance Audit

**Date:** YYYY-MM-DD

## Security Issues

### Exposed Secrets
- ❌ .env file found (contains API keys)
- ⚠️  Hardcoded API_KEY in config.js:23
- ⚠️  SECRET found in utils/auth.js:45

### .gitignore Compliance
- Status: [Present/Missing]
- Missing patterns: .env, *.log, node_modules

## Compliance Checks

- ✅ LICENSE file present
- ❌ No security policy (SECURITY.md)
- ✅ No PII detected in code

## Risk Assessment

- **High Risk:** X issues
- **Medium Risk:** X issues
- **Low Risk:** X issues

## Remediation Plan

1. Move .env to .env.example, add .env to .gitignore
2. Remove hardcoded secrets
3. Create SECURITY.md policy
4. Update .gitignore

## TaskWarrior Commands

task add project:dir-audit +SECURITY priority:H "Remove exposed secrets"
task add project:dir-audit +SECURITY "Create SECURITY.md"
task add project:dir-audit +SECURITY "Update .gitignore"
```

---

## STEP 8: GENERATE MASTER AUDIT REPORT

Save to `claudes-docs/audits/YYYY-MM-DD_master-audit-report.md`:

```markdown
# Master Directory Audit Report

**Date:** YYYY-MM-DD
**Directory:** [path]
**Auditor:** Claude AI

## Executive Summary

Overall compliance score: X/100

### Critical Issues (X)
- [List high-priority issues]

### Moderate Issues (X)
- [List medium-priority issues]

### Low Priority (X)
- [List low-priority issues]

## Audit Dimensions Summary

| Dimension | Score | Status |
|-----------|-------|--------|
| Naming Conventions | X/10 | ❌ Needs Work |
| Directory Structure | X/10 | ⚠️  Partial |
| Content Organization | X/10 | ❌ Poor |
| Documentation | X/10 | ⚠️  Incomplete |
| Performance | X/10 | ✅ Good |
| Security | X/10 | ❌ Critical |

## Detailed Reports

1. [Naming Violations](./YYYY-MM-DD_naming-violations-audit.md)
2. [Structure Analysis](./YYYY-MM-DD_structure-analysis-audit.md)
3. [Content Organization](./YYYY-MM-DD_content-organization-audit.md)
4. [Documentation Completeness](./YYYY-MM-DD_documentation-completeness-audit.md)
5. [Performance Metrics](./YYYY-MM-DD_performance-metrics-audit.md)
6. [Security & Compliance](./YYYY-MM-DD_security-compliance-audit.md)

## Transformation Roadmap

### Phase 1: Critical Fixes (Week 1)
- Remove exposed secrets
- Fix security issues
- Update .gitignore

### Phase 2: Structure (Week 2)
- Create standard directory structure
- Move files to proper locations
- Consolidate documentation

### Phase 3: Optimization (Week 3)
- Fix naming violations
- Remove duplicates
- Clean temp files

### Phase 4: Documentation (Week 4)
- Create missing docs
- Enhance README
- Add CLAUDE.md

## TaskWarrior Project Summary

task add project:dir-audit +META "Complete directory transformation"
[Include all sub-tasks from dimension reports]

## Next Steps

1. Review this audit report
2. Prioritize fixes based on severity
3. Execute transformation using DIRECTORY-001 prompt
4. Re-audit after transformation to measure improvement
```

---

## STEP 9: CREATE TASKWARRIOR PROJECT

Generate all TaskWarrior commands:

```bash
# Create master task
task add project:dir-audit +MASTER priority:H "Complete directory audit and transformation"

# Add dimension audits
task add project:dir-audit +AUDIT.NAMING "Audit naming conventions"
task add project:dir-audit +AUDIT.STRUCTURE "Audit directory structure"
task add project:dir-audit +AUDIT.CONTENT "Audit content organization"
task add project:dir-audit +AUDIT.DOCS "Audit documentation completeness"
task add project:dir-audit +AUDIT.PERFORMANCE "Audit performance metrics"
task add project:dir-audit +AUDIT.SECURITY "Audit security and compliance"

# View project
task project:dir-audit list
```

---

## FINAL DELIVERABLES

Present to user:

```
🎯 DIRECTORY AUDIT COMPLETE

📊 Results:
- 6 audit reports generated
- X total issues identified
- Overall score: X/100

📁 Reports Location:
claudes-docs/audits/
├── YYYY-MM-DD_naming-violations-audit.md
├── YYYY-MM-DD_structure-analysis-audit.md
├── YYYY-MM-DD_content-organization-audit.md
├── YYYY-MM-DD_documentation-completeness-audit.md
├── YYYY-MM-DD_performance-metrics-audit.md
├── YYYY-MM-DD_security-compliance-audit.md
└── YYYY-MM-DD_master-audit-report.md

🎯 Next Step:
Review master audit report and run transformation using:
DIRECTORY-001-professional-directory-system-100525.md

📋 TaskWarrior:
task project:dir-audit list
```

---

## VERSION HISTORY

- **1.0.6** (2025-10-05) – Converted to AI execution model, removed bash scripts
- **1.0.0** (2025-09-28) – Initial release

---

*Directory Audit & Transformation System – Professional analysis and actionable roadmap*
