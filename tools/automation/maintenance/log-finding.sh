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
  gh issue create \
    --title "[$SEVERITY] $TITLE" \
    --milestone "$AUDIT_MILESTONE" \
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
)"

  echo "✓ Logged finding: $TITLE"

  # Also create local TaskWarrior task for tracking
  task add project:$AUDIT_ID +FINDING.$CATEGORY -- "Found: $TITLE"
}