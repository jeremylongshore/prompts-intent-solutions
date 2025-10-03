#!/bin/bash
# init-chore-system.sh - Initialize chore phase from audit handoff

echo "╔════════════════════════════════════════╗"
echo "║      REPOSITORY CHORE SYSTEM v2.0     ║"
echo "║   Phase 2: Automated Fix Execution    ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Find most recent audit handoff file
HANDOFF_FILE=$(ls -t .github/audit-handoff-*.json 2>/dev/null | head -1)

if [ -z "$HANDOFF_FILE" ]; then
  echo "ERROR: No audit handoff file found!"
  echo "Run audit first: ./run-complete-audit.sh"
  exit 1
fi

# Parse handoff file
export AUDIT_ID=$(jq -r '.audit_id' "$HANDOFF_FILE")
export MILESTONE=$(jq -r '.milestone' "$HANDOFF_FILE")
export MILESTONE_NUMBER=$(jq -r '.milestone_number' "$HANDOFF_FILE")
export CRITICAL_COUNT=$(jq -r '.findings.critical' "$HANDOFF_FILE")
export HIGH_COUNT=$(jq -r '.findings.high' "$HANDOFF_FILE")
export MEDIUM_COUNT=$(jq -r '.findings.medium' "$HANDOFF_FILE")
export LOW_COUNT=$(jq -r '.findings.low' "$HANDOFF_FILE")
export TOTAL_FINDINGS=$(jq -r '.findings.total' "$HANDOFF_FILE")

echo "📋 Audit Handoff Received:"
echo "   Audit ID: $AUDIT_ID"
echo "   Milestone: $MILESTONE (#$MILESTONE_NUMBER)"
echo "   Total Findings: $TOTAL_FINDINGS"
echo ""
echo "   🔴 Critical: $CRITICAL_COUNT"
echo "   🟠 High: $HIGH_COUNT"
echo "   🟡 Medium: $MEDIUM_COUNT"
echo "   🟢 Low: $LOW_COUNT"
echo ""

# Initialize TaskWarrior chore project
export CHORE_ID="chore-$(date +%Y%m%d-%H%M%S)"
export REPO_NAME=$(gh repo view --json name -q .name)
export REPO_OWNER=$(gh repo view --json owner -q .owner.login)

# Create TaskWarrior chore project
MAIN_TASK=$(task add project:$CHORE_ID +CHORE priority:H -- "Execute chore phase for $REPO_NAME" | grep -o '[0-9]\+')
SETUP_TASK=$(task add project:$CHORE_ID +SETUP depends:$MAIN_TASK -- "Initialize chore system" | grep -o '[0-9]\+')
CRITICAL_TASK=$(task add project:$CHORE_ID +CRITICAL depends:$SETUP_TASK -- "Fix critical issues" | grep -o '[0-9]\+')
HIGH_TASK=$(task add project:$CHORE_ID +HIGH depends:$CRITICAL_TASK -- "Fix high priority issues" | grep -o '[0-9]\+')
MEDIUM_TASK=$(task add project:$CHORE_ID +MEDIUM depends:$HIGH_TASK -- "Fix medium priority issues" | grep -o '[0-9]\+')
LOW_TASK=$(task add project:$CHORE_ID +LOW depends:$MEDIUM_TASK -- "Fix low priority issues" | grep -o '[0-9]\+')
VERIFY_TASK=$(task add project:$CHORE_ID +VERIFY depends:$LOW_TASK -- "Verify all fixes" | grep -o '[0-9]\+')
HANDOFF_TASK=$(task add project:$CHORE_ID +HANDOFF depends:$VERIFY_TASK -- "Prepare for release" | grep -o '[0-9]\+')

echo "✓ Created TaskWarrior project: $CHORE_ID"

# Create chore tracking branch
git checkout -b "chore/$AUDIT_ID" 2>/dev/null || git checkout "chore/$AUDIT_ID"
echo "✓ Created/switched to chore branch: chore/$AUDIT_ID"

echo "✓ Chore system initialized"