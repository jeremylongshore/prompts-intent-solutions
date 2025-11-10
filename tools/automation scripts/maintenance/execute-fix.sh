#!/bin/bash
# execute-fix.sh - Processes and fixes a GitHub issue

execute_fix() {
  local ISSUE_NUMBER="$1"
  local ISSUE_DATA=$(gh issue view $ISSUE_NUMBER --json title,body,labels)
  local TITLE=$(echo "$ISSUE_DATA" | jq -r '.title')
  local CATEGORY=$(echo "$ISSUE_DATA" | jq -r '.labels[] | select(.name | startswith("audit:")) | .name' | sed 's/audit://')
  local SEVERITY=$(echo "$ISSUE_DATA" | jq -r '.labels[] | select(.name | startswith("severity:")) | .name' | sed 's/severity://')

  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Fixing #$ISSUE_NUMBER: $TITLE"
  echo "Category: $CATEGORY | Severity: $SEVERITY"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  # Create TaskWarrior task for this fix
  TASK_ID=$(task add project:$CHORE_ID +FIX.$CATEGORY -- "Fix #$ISSUE_NUMBER: $TITLE" 2>&1 | grep -o '[0-9]\+')
  echo "yes" | task $TASK_ID start >/dev/null 2>&1

  # Update GitHub issue
  gh issue edit $ISSUE_NUMBER --add-label "phase:chore" >/dev/null 2>&1
  gh issue comment $ISSUE_NUMBER --body "🤖 Chore bot processing fix..." >/dev/null 2>&1

  # Route to specific fix handler based on category
  case $CATEGORY in
    "infra")
      fix_infrastructure_issue "$ISSUE_NUMBER" "$TITLE"
      ;;
    "security")
      fix_security_issue "$ISSUE_NUMBER" "$TITLE"
      ;;
    "docs")
      fix_documentation_issue "$ISSUE_NUMBER" "$TITLE"
      ;;
    "code")
      fix_code_issue "$ISSUE_NUMBER" "$TITLE"
      ;;
    "community")
      fix_community_issue "$ISSUE_NUMBER" "$TITLE"
      ;;
    *)
      echo "Unknown category: $CATEGORY"
      manual_fix_required "$ISSUE_NUMBER" "$TITLE"
      return 1
      ;;
  esac

  # Mark task complete if fix succeeded
  if [ $? -eq 0 ]; then
    echo "yes" | task $TASK_ID done >/dev/null 2>&1
    echo "✓ Fixed issue #$ISSUE_NUMBER"
    return 0
  else
    echo "⚠️  Manual intervention required for #$ISSUE_NUMBER"
    return 1
  fi
}