---
name: master-github-repo-audit
description: Universal GitHub repository audit system that scans and documents findings as GitHub issues with automated TaskWarrior integration
model: opus
date: 2025-09-28
---

# Universal GitHub Repository Audit System
## Phase 1 of 3: Audit → Chore → Release Pipeline

---

## SYSTEM INITIALIZATION

### Pre-Flight Setup: Configure GitHub Integration

```bash
#!/bin/bash
# REQUIRED: Run this once to setup GitHub CLI
gh auth login
gh repo set-default

# Set audit configuration
export REPO_NAME=$(gh repo view --json name -q .name)
export REPO_OWNER=$(gh repo view --json owner -q .owner.login)
export AUDIT_DATE=$(date +%Y%m%d)
export AUDIT_ID="audit-$AUDIT_DATE"
export AUDIT_MILESTONE="Audit-$AUDIT_DATE"
```

### Step 1: Initialize Audit Infrastructure

```bash
#!/bin/bash
# init-audit-system.sh - Creates GitHub milestone and TaskWarrior project

echo "=== INITIALIZING AUDIT SYSTEM ==="
echo "Repository: $REPO_NAME"
echo "Audit ID: $AUDIT_ID"

# 1. Create GitHub Milestone for this audit
MILESTONE_NUMBER=$(gh api \
  --method POST \
  repos/$REPO_OWNER/$REPO_NAME/milestones \
  -f title="$AUDIT_MILESTONE" \
  -f description="Repository audit conducted on $AUDIT_DATE. All findings require review before chore phase." \
  -f due_on="$(date -d '+7 days' -I)" \
  --jq '.number')

echo "✓ Created GitHub Milestone #$MILESTONE_NUMBER"

# 2. Create TaskWarrior audit project
task add project:$AUDIT_ID +AUDIT priority:H -- "Complete repository audit for $REPO_NAME"
task add project:$AUDIT_ID +SETUP depends:last -- "Initialize GitHub integration"
task add project:$AUDIT_ID +SCAN depends:last -- "Scan repository infrastructure"
task add project:$AUDIT_ID +ANALYZE depends:last -- "Analyze code quality"
task add project:$AUDIT_ID +DOCUMENT depends:last -- "Assess documentation"
task add project:$AUDIT_ID +REPORT depends:last -- "Generate findings report"
task add project:$AUDIT_ID +HANDOFF depends:last -- "Prepare for chore phase"

echo "✓ Created TaskWarrior project: $AUDIT_ID"

# 3. Create audit labels if they don't exist
for LABEL in "audit:security" "audit:docs" "audit:code" "audit:infra" "audit:community" \
             "severity:critical" "severity:high" "severity:medium" "severity:low" \
             "phase:audit" "phase:chore" "phase:release"; do
  gh label create "$LABEL" --force
done

echo "✓ Created GitHub labels for tracking"

# 4. Create tracking issue for audit progress
TRACKING_ISSUE=$(gh issue create \
  --title "🔍 Audit Progress Tracker: $AUDIT_DATE" \
  --label "phase:audit" \
  --milestone "$MILESTONE_NUMBER" \
  --body "$(cat << EOF
# Audit System Initialized

**Audit ID**: $AUDIT_ID
**Milestone**: #$MILESTONE_NUMBER
**Started**: $(date -Iseconds)

## Phases
- [ ] **AUDIT** - Scan and document findings (Current)
- [ ] **CHORE** - Fix issues based on findings
- [ ] **RELEASE** - Deploy improvements

## Real-time Status
Check findings as they're discovered:
- [View All Findings](https://github.com/$REPO_OWNER/$REPO_NAME/milestone/$MILESTONE_NUMBER)
- [Critical Issues](https://github.com/$REPO_OWNER/$REPO_NAME/issues?q=milestone:$AUDIT_MILESTONE+label:severity:critical)

## Commands
\`\`\`bash
# View TaskWarrior progress
task project:$AUDIT_ID

# See all findings
gh issue list --milestone "$AUDIT_MILESTONE"
\`\`\`
EOF
)")

echo "✓ Created tracking issue #$TRACKING_ISSUE"
echo ""
echo "=== READY TO START AUDIT ==="
echo "Tracking URL: https://github.com/$REPO_OWNER/$REPO_NAME/issues/$TRACKING_ISSUE"
```

---

## AUTOMATED FINDING LOGGER

### Core Function: Create GitHub Issue for Each Finding

```bash
#!/bin/bash
# log-finding.sh - Creates GitHub issue for any audit finding

log_finding() {
  local CATEGORY="$1"    # security|docs|code|infra|community
  local SEVERITY="$2"    # critical|high|medium|low
  local TITLE="$3"       # Brief description
  local DESCRIPTION="$4" # Detailed finding
  local FIX="$5"        # Recommended remediation
  local EFFORT="$6"     # Estimated effort (e.g., "2h", "1d")

  # Determine priority for TaskWarrior
  case $SEVERITY in
    critical) TW_PRIORITY="H"; DUE="due:today" ;;
    high)     TW_PRIORITY="H"; DUE="due:+2d" ;;
    medium)   TW_PRIORITY="M"; DUE="due:+1w" ;;
    low)      TW_PRIORITY="L"; DUE="" ;;
  esac

  # Create GitHub issue with structured data
  ISSUE_NUMBER=$(gh issue create \
    --title "[$SEVERITY] $TITLE" \
    --milestone "$MILESTONE_NUMBER" \
    --label "audit:$CATEGORY,severity:$SEVERITY,phase:audit" \
    --body "$(cat << EOF
## Audit Finding

**Category**: $CATEGORY
**Severity**: $SEVERITY
**Discovered**: $(date -Iseconds)
**Audit ID**: $AUDIT_ID

### Description
$DESCRIPTION

### Current State
🔴 Non-compliant with repository standards

### Recommended Fix
$FIX

### Estimated Effort
⏱️ $EFFORT

### Automated Actions

#### TaskWarrior Command (for chore phase)
\`\`\`bash
task add project:chore-$REPO_NAME +FIX.$CATEGORY priority:$TW_PRIORITY $DUE -- "Fix: $TITLE"
\`\`\`

#### Verification Criteria
- [ ] Issue has been resolved
- [ ] Tests pass
- [ ] Documentation updated if needed
- [ ] No regression in other areas

---
*This finding will be addressed in the chore phase after audit review*
EOF
)" --json number -q .number)

  echo "✓ Logged finding #$ISSUE_NUMBER: $TITLE"

  # Also create local TaskWarrior task for tracking
  task add project:$AUDIT_ID +FINDING.$CATEGORY -- "Found: $TITLE (#$ISSUE_NUMBER)"
}
```

---

## AUDIT EXECUTION PHASES

### Phase 1: Infrastructure Analysis

```bash
#!/bin/bash
# audit-infrastructure.sh

echo "=== SCANNING INFRASTRUCTURE ==="
task project:$AUDIT_ID +SCAN start

# Check branch protection
PROTECTED=$(gh api repos/$REPO_OWNER/$REPO_NAME/branches/main --jq '.protected')
if [ "$PROTECTED" != "true" ]; then
  log_finding "infra" "high" \
    "Main branch lacks protection rules" \
    "The main branch can be force-pushed or deleted, risking code loss" \
    "Enable branch protection with required reviews and status checks" \
    "30m"
fi

# Check for CODEOWNERS
if [ ! -f ".github/CODEOWNERS" ]; then
  log_finding "infra" "medium" \
    "Missing CODEOWNERS file" \
    "No automatic review assignments for code changes" \
    "Create .github/CODEOWNERS with path-based ownership" \
    "1h"
fi

# Check CI/CD configuration
if [ ! -f ".github/workflows/ci.yml" ] && [ ! -f ".github/workflows/ci.yaml" ]; then
  log_finding "infra" "high" \
    "No CI/CD pipeline configured" \
    "Code changes not automatically tested before merge" \
    "Implement GitHub Actions workflow for testing and validation" \
    "2h"
fi

# Check for secrets scanning
SECRETS_ENABLED=$(gh api repos/$REPO_OWNER/$REPO_NAME --jq '.security_and_analysis.secret_scanning.status')
if [ "$SECRETS_ENABLED" != "enabled" ]; then
  log_finding "security" "critical" \
    "Secret scanning disabled" \
    "Repository could contain exposed credentials" \
    "Enable secret scanning in repository settings" \
    "5m"
fi

task project:$AUDIT_ID +SCAN done
```

### Phase 2: Code Quality Analysis

```bash
#!/bin/bash
# audit-code-quality.sh

echo "=== ANALYZING CODE QUALITY ==="
task project:$AUDIT_ID +ANALYZE start

# Check for tests
TEST_DIRS=$(find . -type d -name "test*" -o -name "*test" -o -name "spec" | wc -l)
if [ $TEST_DIRS -eq 0 ]; then
  log_finding "code" "high" \
    "No test directory found" \
    "Repository lacks organized testing structure" \
    "Create test directory and add unit tests" \
    "1d"
fi

# Check for linting configuration
LINT_FILES=$(find . -maxdepth 2 -name ".eslintrc*" -o -name ".rubocop*" -o -name "tslint*" | wc -l)
if [ $LINT_FILES -eq 0 ]; then
  log_finding "code" "medium" \
    "No linting configuration found" \
    "Code style inconsistencies likely present" \
    "Add linting configuration and pre-commit hooks" \
    "2h"
fi

# Check package vulnerabilities (if package.json exists)
if [ -f "package.json" ]; then
  VULNS=$(npm audit --json 2>/dev/null | jq '.metadata.vulnerabilities.high + .metadata.vulnerabilities.critical' || echo "0")
  if [ "$VULNS" -gt 0 ]; then
    log_finding "security" "high" \
      "Package vulnerabilities detected: $VULNS high/critical" \
      "Dependencies contain known security vulnerabilities" \
      "Run npm audit fix and update dependencies" \
      "1h"
  fi
fi

task project:$AUDIT_ID +ANALYZE done
```

### Phase 3: Documentation Assessment

```bash
#!/bin/bash
# audit-documentation.sh

echo "=== ASSESSING DOCUMENTATION ==="
task project:$AUDIT_ID +DOCUMENT start

# Essential documentation files
REQUIRED_DOCS=(
  "README.md:comprehensive README with quickstart"
  "CONTRIBUTING.md:contribution guidelines"
  "LICENSE:open source license"
  "SECURITY.md:security policy and disclosure process"
  "CODE_OF_CONDUCT.md:community code of conduct"
)

for DOC_SPEC in "${REQUIRED_DOCS[@]}"; do
  FILE="${DOC_SPEC%%:*}"
  DESC="${DOC_SPEC##*:}"

  if [ ! -f "$FILE" ]; then
    log_finding "docs" "high" \
      "Missing $FILE" \
      "Repository lacks $DESC" \
      "Create $FILE with $DESC" \
      "1h"
  elif [ $(wc -l < "$FILE") -lt 10 ]; then
    log_finding "docs" "medium" \
      "Inadequate $FILE" \
      "$FILE exists but appears incomplete (less than 10 lines)" \
      "Expand $FILE with comprehensive $DESC" \
      "2h"
  fi
done

task project:$AUDIT_ID +DOCUMENT done
```

---

## AUDIT COMPLETION & HANDOFF

### Generate Audit Summary

```bash
#!/bin/bash
# complete-audit.sh - Finalizes audit and prepares for chore phase

echo "=== COMPLETING AUDIT ==="
task project:$AUDIT_ID +REPORT start

# Count findings by severity
CRITICAL=$(gh issue list --milestone "$AUDIT_MILESTONE" --label "severity:critical" --json number --jq '. | length')
HIGH=$(gh issue list --milestone "$AUDIT_MILESTONE" --label "severity:high" --json number --jq '. | length')
MEDIUM=$(gh issue list --milestone "$AUDIT_MILESTONE" --label "severity:medium" --json number --jq '. | length')
LOW=$(gh issue list --milestone "$AUDIT_MILESTONE" --label "severity:low" --json number --jq '. | length')
TOTAL=$((CRITICAL + HIGH + MEDIUM + LOW))

# Create summary issue
SUMMARY_ISSUE=$(gh issue create \
  --title "📊 Audit Summary Report: $AUDIT_DATE" \
  --milestone "$MILESTONE_NUMBER" \
  --label "phase:audit" \
  --pin \
  --body "$(cat << EOF
# Audit Complete: $REPO_NAME

**Audit ID**: $AUDIT_ID
**Date**: $(date -I)
**Total Findings**: $TOTAL

## Findings by Severity

| Severity | Count | Action Required |
|----------|-------|-----------------|
| 🔴 Critical | $CRITICAL | Immediate action |
| 🟠 High | $HIGH | Within 48 hours |
| 🟡 Medium | $MEDIUM | Within 1 week |
| 🟢 Low | $LOW | Next sprint |

## Findings by Category

$(gh issue list --milestone "$AUDIT_MILESTONE" --json labels,title --jq '
  group_by(.labels[] | select(.name | startswith("audit:")) | .name) |
  map({
    category: .[0].labels[] | select(.name | startswith("audit:")) | .name | sub("audit:";""),
    count: length
  }) |
  .[] | "- **\(.category)**: \(.count) issues"
')

## Next Steps

### 1. Review Phase (YOU ARE HERE)
Review all findings in this milestone:
[View All Findings](https://github.com/$REPO_OWNER/$REPO_NAME/milestone/$MILESTONE_NUMBER)

### 2. Chore Phase (After Review)
Run the chore script to automatically fix findings:
\`\`\`bash
# This will be available after review
./run-chore.sh --milestone "$AUDIT_MILESTONE"
\`\`\`

### 3. Release Phase (After Chore)
Deploy improvements after all fixes:
\`\`\`bash
# This will be available after chore completion
./run-release.sh --audit "$AUDIT_ID"
\`\`\`

## TaskWarrior Summary

\`\`\`bash
# Audit tasks completed
task project:$AUDIT_ID status:completed count

# View audit history
task project:$AUDIT_ID all
\`\`\`

## Handoff File Created

A handoff file has been created for the chore phase:
\`\`\`json
{
  "audit_id": "$AUDIT_ID",
  "milestone": "$AUDIT_MILESTONE",
  "milestone_number": $MILESTONE_NUMBER,
  "findings": {
    "critical": $CRITICAL,
    "high": $HIGH,
    "medium": $MEDIUM,
    "low": $LOW
  },
  "next_phase": "chore",
  "created": "$(date -Iseconds)"
}
\`\`\`

---
*Review all findings, then proceed to chore phase*
EOF
)")

# Create handoff file for chore phase
cat > ".github/audit-handoff-$AUDIT_ID.json" << EOF
{
  "audit_id": "$AUDIT_ID",
  "repo": "$REPO_NAME",
  "milestone": "$AUDIT_MILESTONE",
  "milestone_number": $MILESTONE_NUMBER,
  "tracking_issue": $TRACKING_ISSUE,
  "summary_issue": $SUMMARY_ISSUE,
  "findings": {
    "critical": $CRITICAL,
    "high": $HIGH,
    "medium": $MEDIUM,
    "low": $LOW,
    "total": $TOTAL
  },
  "github_query": "milestone:$AUDIT_MILESTONE",
  "next_phase": "chore",
  "chore_start_command": "./run-chore.sh --milestone $AUDIT_MILESTONE",
  "created": "$(date -Iseconds)"
}
EOF

# Commit handoff file
git add ".github/audit-handoff-$AUDIT_ID.json"
git commit -m "Audit complete: $AUDIT_ID - $TOTAL findings documented"
git push

task project:$AUDIT_ID +REPORT done
task project:$AUDIT_ID +HANDOFF done

echo ""
echo "==================================="
echo "       AUDIT COMPLETE              "
echo "==================================="
echo ""
echo "📊 Total Findings: $TOTAL"
echo "🔗 Review at: https://github.com/$REPO_OWNER/$REPO_NAME/milestone/$MILESTONE_NUMBER"
echo "📄 Summary: https://github.com/$REPO_OWNER/$REPO_NAME/issues/$SUMMARY_ISSUE"
echo ""
echo "Next: Review findings, then run chore phase"
```

---

## COMPLETE WORKFLOW EXECUTION

### Master Audit Script

```bash
#!/bin/bash
# run-complete-audit.sh - Execute full audit with GitHub integration

set -e  # Exit on error

echo "╔════════════════════════════════════════╗"
echo "║     REPOSITORY AUDIT SYSTEM v2.0      ║"
echo "║     Phase 1: Audit → GitHub Issues    ║"
echo "╔════════════════════════════════════════╝"
echo ""

# Initialize
source ./init-audit-system.sh

# Run audit phases
./audit-infrastructure.sh
./audit-code-quality.sh
./audit-documentation.sh

# Additional specialized audits
if [ -f "package.json" ]; then
  ./audit-npm-security.sh
fi

if [ -f "Gemfile" ]; then
  ./audit-ruby-security.sh
fi

# Complete and handoff
./complete-audit.sh

echo ""
echo "AUDIT PIPELINE STATUS:"
echo "✅ Audit Phase    - COMPLETE"
echo "⏸️  Review Phase   - READY (Review findings in GitHub)"
echo "🔒 Chore Phase    - LOCKED (Unlocks after review)"
echo "🔒 Release Phase  - LOCKED (Unlocks after chore)"
```

---

## KEY FEATURES FOR CHORE/RELEASE INTEGRATION

### 1. **Handoff File**
The `.github/audit-handoff-$AUDIT_ID.json` file contains everything the chore script needs:
- Milestone number to query issues
- Issue counts by severity
- Audit ID for TaskWarrior continuity

### 2. **GitHub Issues as Source of Truth**
- Each finding is a GitHub issue
- Chore script can query: `gh issue list --milestone "$MILESTONE"`
- Release script can verify: all issues closed before release

### 3. **Phase Labels**
- `phase:audit` - Finding discovered
- `phase:chore` - Being fixed
- `phase:release` - Ready to deploy

### 4. **TaskWarrior Continuity**
- Audit project: `audit-YYYYMMDD`
- Chore project: `chore-repo-name`
- Release project: `release-YYYYMMDD`

---
*Updated: September 28, 2025*