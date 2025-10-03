#!/bin/bash
# manual-fix-handler.sh - Handles issues requiring manual intervention

manual_fix_required() {
  local ISSUE_NUMBER="$1"
  local TITLE="$2"

  echo "⚠️  Manual intervention required for: $TITLE"

  # Update GitHub issue with manual intervention notice
  gh issue comment $ISSUE_NUMBER --body "🔧 **Manual Fix Required**

This issue requires human intervention and cannot be automatically resolved.

**Next Steps:**
1. Review the issue details
2. Implement the necessary changes
3. Test the fix
4. Close the issue when resolved

**Assigned to repository maintainers for manual resolution.**" >/dev/null 2>&1

  # Add manual-fix label
  gh issue edit $ISSUE_NUMBER --add-label "manual-fix" >/dev/null 2>&1

  # Create TaskWarrior task for manual follow-up
  MANUAL_TASK=$(task add project:$CHORE_ID +MANUAL priority:H -- "Manual fix required: #$ISSUE_NUMBER - $TITLE" 2>&1 | grep -o '[0-9]\+')

  # Log the manual intervention requirement
  echo "$(date -Iseconds) | MANUAL | #$ISSUE_NUMBER | $TITLE | Task: $MANUAL_TASK" >> .github/chore-manual-fixes.log

  echo "   📝 Created manual task: $MANUAL_TASK"
  echo "   🏷️  Added 'manual-fix' label to issue"
  echo "   📋 Logged in .github/chore-manual-fixes.log"

  return 1
}

# Function to check for manual fixes that might now be automatable
check_automatable_fixes() {
  echo "🔍 Checking for previously manual fixes that might now be automatable..."

  if [ ! -f ".github/chore-manual-fixes.log" ]; then
    echo "   ℹ️  No manual fixes log found"
    return 0
  fi

  local MANUAL_COUNT=0
  local RETRY_COUNT=0

  while IFS='|' read -r timestamp status issue_num title task_id; do
    # Trim whitespace
    issue_num=$(echo "$issue_num" | xargs)
    title=$(echo "$title" | xargs)

    # Skip if not a manual fix or already resolved
    if [[ "$status" != *"MANUAL"* ]]; then
      continue
    fi

    MANUAL_COUNT=$((MANUAL_COUNT + 1))

    # Check if issue is still open
    ISSUE_STATE=$(gh issue view "$issue_num" --json state -q .state 2>/dev/null)
    if [ "$ISSUE_STATE" = "CLOSED" ]; then
      echo "   ✓ Issue $issue_num already resolved"
      continue
    fi

    # Try to determine if this might now be automatable
    case "$title" in
      *"README"* | *"CONTRIBUTING"* | *"LICENSE"* | *"CODE_OF_CONDUCT"*)
        echo "   🔄 Issue $issue_num might now be automatable: $title"
        RETRY_COUNT=$((RETRY_COUNT + 1))
        ;;
      *"branch protection"* | *"CODEOWNERS"* | *"CI/CD"*)
        echo "   🔄 Issue $issue_num might now be automatable: $title"
        RETRY_COUNT=$((RETRY_COUNT + 1))
        ;;
      *"Secret scanning"* | *"SECURITY.md"* | *"vulnerabilities"*)
        echo "   🔄 Issue $issue_num might now be automatable: $title"
        RETRY_COUNT=$((RETRY_COUNT + 1))
        ;;
    esac

  done < .github/chore-manual-fixes.log

  echo "   📊 Manual fixes: $MANUAL_COUNT total, $RETRY_COUNT potentially automatable"

  if [ $RETRY_COUNT -gt 0 ]; then
    echo "   💡 Consider re-running the chore system to attempt automation of these fixes"
  fi
}

# Function to clean up resolved manual fixes
cleanup_resolved_manual_fixes() {
  echo "🧹 Cleaning up resolved manual fixes..."

  if [ ! -f ".github/chore-manual-fixes.log" ]; then
    return 0
  fi

  local CLEANED=0
  local TEMP_LOG=$(mktemp)

  while IFS='|' read -r timestamp status issue_num title task_id; do
    # Trim whitespace
    issue_num=$(echo "$issue_num" | xargs)

    # Check if issue is still open
    ISSUE_STATE=$(gh issue view "$issue_num" --json state -q .state 2>/dev/null)
    if [ "$ISSUE_STATE" = "CLOSED" ]; then
      # Mark TaskWarrior task as done if it exists
      task_id=$(echo "$task_id" | xargs | sed 's/Task: //')
      if [ -n "$task_id" ] && task info "$task_id" >/dev/null 2>&1; then
        echo "yes" | task "$task_id" done >/dev/null 2>&1
      fi
      CLEANED=$((CLEANED + 1))
    else
      # Keep the entry
      echo "$timestamp|$status|$issue_num|$title|$task_id" >> "$TEMP_LOG"
    fi

  done < .github/chore-manual-fixes.log

  mv "$TEMP_LOG" .github/chore-manual-fixes.log

  echo "   ✓ Cleaned up $CLEANED resolved manual fixes"
}

# Function to summarize manual fix status
summarize_manual_fixes() {
  echo ""
  echo "📋 Manual Fix Summary"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  if [ ! -f ".github/chore-manual-fixes.log" ]; then
    echo "   ✓ No manual fixes required"
    return 0
  fi

  local TOTAL_MANUAL=0
  local OPEN_MANUAL=0

  while IFS='|' read -r timestamp status issue_num title task_id; do
    issue_num=$(echo "$issue_num" | xargs)
    TOTAL_MANUAL=$((TOTAL_MANUAL + 1))

    ISSUE_STATE=$(gh issue view "$issue_num" --json state -q .state 2>/dev/null)
    if [ "$ISSUE_STATE" = "OPEN" ]; then
      OPEN_MANUAL=$((OPEN_MANUAL + 1))
    fi

  done < .github/chore-manual-fixes.log

  echo "   Total manual fixes logged: $TOTAL_MANUAL"
  echo "   Still requiring attention: $OPEN_MANUAL"

  if [ $OPEN_MANUAL -gt 0 ]; then
    echo ""
    echo "   🔧 Outstanding manual fixes:"
    while IFS='|' read -r timestamp status issue_num title task_id; do
      issue_num=$(echo "$issue_num" | xargs)
      title=$(echo "$title" | xargs)

      ISSUE_STATE=$(gh issue view "$issue_num" --json state -q .state 2>/dev/null)
      if [ "$ISSUE_STATE" = "OPEN" ]; then
        echo "      • #$issue_num: $title"
      fi

    done < .github/chore-manual-fixes.log
    echo ""
    echo "   💡 These issues require manual review and implementation"
  fi
}