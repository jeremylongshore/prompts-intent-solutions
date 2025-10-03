#!/bin/bash
# run-chore.sh - Main chore execution workflow

set -e

echo "╔════════════════════════════════════════╗"
echo "║       EXECUTING CHORE FIXES v2.0      ║"
echo "║    Phase 2: Automated Issue Resolution ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Load helper functions
source ./execute-fix.sh
source ./fix-infrastructure.sh
source ./fix-security.sh
source ./fix-documentation.sh
source ./fix-code.sh
source ./fix-community.sh
source ./manual-fix-handler.sh

# Check for initialized chore system
if [ -z "$CHORE_ID" ]; then
  echo "ERROR: Chore system not initialized!"
  echo "Run: ./init-chore-system.sh"
  exit 1
fi

# Get all open issues with audit labels in this milestone
MILESTONE_ISSUES=$(gh issue list \
  --milestone "$MILESTONE" \
  --state open \
  --label "phase:chore" \
  --json number,title,labels \
  --jq '.[] | select(.labels[] | .name | startswith("audit:")) | .number' 2>/dev/null || echo "")

if [ -z "$MILESTONE_ISSUES" ]; then
  echo "🎉 No chore issues found in milestone: $MILESTONE"
  echo "   All issues may already be resolved!"
  exit 0
fi

ISSUE_COUNT=$(echo "$MILESTONE_ISSUES" | wc -l)
echo "🎯 Found $ISSUE_COUNT issues to process in milestone: $MILESTONE"
echo ""

# Statistics tracking
FIXED_COUNT=0
MANUAL_COUNT=0
ERROR_COUNT=0
START_TIME=$(date +%s)

# Process issues by severity (critical first)
for SEVERITY in "critical" "high" "medium" "low"; do
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Processing $SEVERITY severity issues..."
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  # Get issues with this severity
  SEVERITY_ISSUES=$(gh issue list \
    --milestone "$MILESTONE" \
    --state open \
    --label "phase:chore" \
    --label "severity:$SEVERITY" \
    --json number \
    --jq '.[].number' 2>/dev/null || echo "")

  if [ -z "$SEVERITY_ISSUES" ]; then
    echo "   ✓ No $SEVERITY issues to process"
    continue
  fi

  SEVERITY_COUNT=$(echo "$SEVERITY_ISSUES" | wc -l)
  echo "   📋 Processing $SEVERITY_COUNT $SEVERITY priority issues"

  # Process each issue
  for ISSUE_NUMBER in $SEVERITY_ISSUES; do
    echo ""
    echo "🔧 Processing issue #$ISSUE_NUMBER..."

    # Execute the fix
    if execute_fix "$ISSUE_NUMBER"; then
      FIXED_COUNT=$((FIXED_COUNT + 1))
      echo "   ✅ Successfully fixed issue #$ISSUE_NUMBER"
    else
      # Check if it was marked as manual or error
      if gh issue view "$ISSUE_NUMBER" --json labels --jq '.labels[] | .name' | grep -q "manual-fix"; then
        MANUAL_COUNT=$((MANUAL_COUNT + 1))
        echo "   🔧 Issue #$ISSUE_NUMBER requires manual intervention"
      else
        ERROR_COUNT=$((ERROR_COUNT + 1))
        echo "   ❌ Failed to fix issue #$ISSUE_NUMBER"
      fi
    fi

    # Small delay to avoid rate limiting
    sleep 1
  done

  echo "   ✓ Completed $SEVERITY severity issues"
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Chore Execution Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

echo "⏱️  Total execution time: ${DURATION}s"
echo "📊 Results:"
echo "   ✅ Fixed automatically: $FIXED_COUNT"
echo "   🔧 Requires manual work: $MANUAL_COUNT"
echo "   ❌ Errors encountered: $ERROR_COUNT"
echo "   📝 Total processed: $((FIXED_COUNT + MANUAL_COUNT + ERROR_COUNT))"

# Calculate success rate
if [ $((FIXED_COUNT + MANUAL_COUNT + ERROR_COUNT)) -gt 0 ]; then
  SUCCESS_RATE=$(( (FIXED_COUNT * 100) / (FIXED_COUNT + MANUAL_COUNT + ERROR_COUNT) ))
  echo "   📈 Automation success rate: ${SUCCESS_RATE}%"
fi

# Update TaskWarrior with results
if [ $FIXED_COUNT -gt 0 ]; then
  echo "yes" | task project:$CHORE_ID +CRITICAL done >/dev/null 2>&1 || true
  echo "yes" | task project:$CHORE_ID +HIGH done >/dev/null 2>&1 || true
  echo "yes" | task project:$CHORE_ID +MEDIUM done >/dev/null 2>&1 || true
  echo "yes" | task project:$CHORE_ID +LOW done >/dev/null 2>&1 || true
fi

# Show summary of manual fixes
summarize_manual_fixes

echo ""
if [ $MANUAL_COUNT -gt 0 ]; then
  echo "🔔 Next Steps:"
  echo "   1. Review manual fixes listed above"
  echo "   2. Implement necessary changes"
  echo "   3. Run './verify-fixes.sh' when ready"
  echo "   4. Run './complete-chore.sh' to finalize"
else
  echo "🎉 All issues resolved automatically!"
  echo "   Ready to run './verify-fixes.sh' and './complete-chore.sh'"
fi

echo ""
echo "📋 Chore system execution completed"