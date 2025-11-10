#!/bin/bash
# run-complete-audit.sh - Execute full audit with GitHub integration

set -e  # Exit on error

echo "╔════════════════════════════════════════╗"
echo "║     REPOSITORY AUDIT SYSTEM v2.0      ║"
echo "║     Phase 1: Audit → GitHub Issues    ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Initialize
source ./init-audit-system.sh
source ./log-finding.sh

# Run audit phases
echo "=== STARTING AUDIT PHASES ==="

# Infrastructure audit
echo "=== SCANNING INFRASTRUCTURE ==="
task project:$AUDIT_ID +SCAN start

# Check branch protection
PROTECTED=$(gh api repos/$REPO_OWNER/$REPO_NAME/branches/main --jq '.protected' 2>/dev/null || echo "false")
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
SECRETS_ENABLED=$(gh api repos/$REPO_OWNER/$REPO_NAME --jq '.security_and_analysis.secret_scanning.status // "disabled"')
if [ "$SECRETS_ENABLED" != "enabled" ]; then
  log_finding "security" "critical" \
    "Secret scanning disabled" \
    "Repository could contain exposed credentials" \
    "Enable secret scanning in repository settings" \
    "5m"
fi

task project:$AUDIT_ID +SCAN done

# Code quality audit
echo "=== ANALYZING CODE QUALITY ==="
task project:$AUDIT_ID +ANALYZE start

# Check for tests
TEST_DIRS=$(find . -type d -name "test*" -o -name "*test" -o -name "spec" 2>/dev/null | wc -l)
if [ $TEST_DIRS -eq 0 ]; then
  log_finding "code" "high" \
    "No test directory found" \
    "Repository lacks organized testing structure" \
    "Create test directory and add unit tests" \
    "1d"
fi

# Check for linting configuration
LINT_FILES=$(find . -maxdepth 2 -name ".eslintrc*" -o -name ".rubocop*" -o -name "tslint*" 2>/dev/null | wc -l)
if [ $LINT_FILES -eq 0 ]; then
  log_finding "code" "medium" \
    "No linting configuration found" \
    "Code style inconsistencies likely present" \
    "Add linting configuration and pre-commit hooks" \
    "2h"
fi

# Check package vulnerabilities (if package.json exists)
if [ -f "package.json" ]; then
  VULNS=$(npm audit --json 2>/dev/null | jq '.metadata.vulnerabilities.high + .metadata.vulnerabilities.critical' 2>/dev/null || echo "0")
  if [ "$VULNS" -gt 0 ]; then
    log_finding "security" "high" \
      "Package vulnerabilities detected: $VULNS high/critical" \
      "Dependencies contain known security vulnerabilities" \
      "Run npm audit fix and update dependencies" \
      "1h"
  fi
fi

task project:$AUDIT_ID +ANALYZE done

# Documentation audit
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

# Complete audit
echo "=== COMPLETING AUDIT ==="
task project:$AUDIT_ID +REPORT start

# Count findings by severity
CRITICAL=$(gh issue list --milestone "$AUDIT_MILESTONE" --label "severity:critical" --json number --jq '. | length')
HIGH=$(gh issue list --milestone "$AUDIT_MILESTONE" --label "severity:high" --json number --jq '. | length')
MEDIUM=$(gh issue list --milestone "$AUDIT_MILESTONE" --label "severity:medium" --json number --jq '. | length')
LOW=$(gh issue list --milestone "$AUDIT_MILESTONE" --label "severity:low" --json number --jq '. | length')
TOTAL=$((CRITICAL + HIGH + MEDIUM + LOW))

# Create handoff file for chore phase
cat > ".github/audit-handoff-$AUDIT_ID.json" << EOF
{
  "audit_id": "$AUDIT_ID",
  "repo": "$REPO_NAME",
  "milestone": "$AUDIT_MILESTONE",
  "milestone_number": $MILESTONE_NUMBER,
  "tracking_issue": $TRACKING_ISSUE,
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

task project:$AUDIT_ID +REPORT done
task project:$AUDIT_ID +HANDOFF done

echo ""
echo "==================================="
echo "       AUDIT COMPLETE              "
echo "==================================="
echo ""
echo "📊 Total Findings: $TOTAL"
echo "🔗 Review at: https://github.com/$REPO_OWNER/$REPO_NAME/milestone/$MILESTONE_NUMBER"
echo ""
echo "AUDIT PIPELINE STATUS:"
echo "✅ Audit Phase    - COMPLETE"
echo "⏸️  Review Phase   - READY (Review findings in GitHub)"
echo "🔒 Chore Phase    - LOCKED (Unlocks after review)"
echo "🔒 Release Phase  - LOCKED (Unlocks after chore)"