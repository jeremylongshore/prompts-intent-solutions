#!/bin/bash
# init-audit-system.sh - Creates GitHub milestone and TaskWarrior project

echo "=== INITIALIZING AUDIT SYSTEM ==="

# Set audit configuration
export REPO_NAME=$(gh repo view --json name -q .name)
export REPO_OWNER=$(gh repo view --json owner -q .owner.login)
export AUDIT_DATE=$(date +%Y%m%d)
export AUDIT_ID="audit-$AUDIT_DATE"
export AUDIT_MILESTONE="Audit-$AUDIT_DATE"

echo "Repository: $REPO_NAME"
echo "Audit ID: $AUDIT_ID"

# 1. Create or get GitHub Milestone for this audit
MILESTONE_NUMBER=$(gh api repos/$REPO_OWNER/$REPO_NAME/milestones --jq ".[] | select(.title==\"$AUDIT_MILESTONE\") | .number")

if [ -z "$MILESTONE_NUMBER" ]; then
  MILESTONE_NUMBER=$(gh api \
    --method POST \
    repos/$REPO_OWNER/$REPO_NAME/milestones \
    -f title="$AUDIT_MILESTONE" \
    -f description="Repository audit conducted on $AUDIT_DATE. All findings require review before chore phase." \
    -f due_on="$(date -d '+7 days' -Iseconds)" \
    --jq '.number')
  echo "✓ Created GitHub Milestone #$MILESTONE_NUMBER"
else
  echo "✓ Using existing GitHub Milestone #$MILESTONE_NUMBER"
fi

# 2. Create TaskWarrior audit project
MAIN_TASK=$(task add project:$AUDIT_ID +AUDIT priority:H -- "Complete repository audit for $REPO_NAME" | grep -o '[0-9]\+')
SETUP_TASK=$(task add project:$AUDIT_ID +SETUP depends:$MAIN_TASK -- "Initialize GitHub integration" | grep -o '[0-9]\+')
SCAN_TASK=$(task add project:$AUDIT_ID +SCAN depends:$SETUP_TASK -- "Scan repository infrastructure" | grep -o '[0-9]\+')
ANALYZE_TASK=$(task add project:$AUDIT_ID +ANALYZE depends:$SCAN_TASK -- "Analyze code quality" | grep -o '[0-9]\+')
DOCUMENT_TASK=$(task add project:$AUDIT_ID +DOCUMENT depends:$ANALYZE_TASK -- "Assess documentation" | grep -o '[0-9]\+')
REPORT_TASK=$(task add project:$AUDIT_ID +REPORT depends:$DOCUMENT_TASK -- "Generate findings report" | grep -o '[0-9]\+')
HANDOFF_TASK=$(task add project:$AUDIT_ID +HANDOFF depends:$REPORT_TASK -- "Prepare for chore phase" | grep -o '[0-9]\+')

echo "✓ Created TaskWarrior project: $AUDIT_ID"

# 3. Create audit labels if they don't exist
for LABEL in "audit:security" "audit:docs" "audit:code" "audit:infra" "audit:community" \
             "severity:critical" "severity:high" "severity:medium" "severity:low" \
             "phase:audit" "phase:chore" "phase:release"; do
  gh label create "$LABEL" --force >/dev/null 2>&1
done

echo "✓ Created GitHub labels for tracking"

# 4. Create tracking issue for audit progress
gh issue create \
  --title "🔍 Audit Progress Tracker: $AUDIT_DATE" \
  --label "phase:audit" \
  --milestone "$AUDIT_MILESTONE" \
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
)"

echo "✓ Created tracking issue"
echo ""
echo "=== READY TO START AUDIT ==="
echo "Review: https://github.com/$REPO_OWNER/$REPO_NAME/milestone/$MILESTONE_NUMBER"