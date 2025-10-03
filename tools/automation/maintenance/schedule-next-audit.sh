#!/bin/bash
# schedule-next-audit.sh - Schedule the next audit cycle

echo "=== SCHEDULING NEXT AUDIT ==="
task project:$RELEASE_ID +SCHEDULE start

# Calculate next audit date (30 days from now)
NEXT_AUDIT_DATE=$(date -d "+30 days" +%Y-%m-%d)

# Create reminder issue
REMINDER_ISSUE=$(gh issue create \
  --title "📅 Scheduled Audit: $NEXT_AUDIT_DATE" \
  --label "audit,scheduled" \
  --body "$(cat << EOF
# Scheduled Repository Audit

The next automated audit is scheduled for **$NEXT_AUDIT_DATE**.

## Last Audit Summary
- **Date**: $(date +%Y-%m-%d)
- **Issues Found**: $((FIXED_COUNT + MANUAL_COUNT))
- **Issues Fixed**: $FIXED_COUNT
- **Version Released**: v$NEW_VERSION

## Run Next Audit

When ready, run:
\`\`\`bash
./run-complete-audit.sh
\`\`\`

## Continuous Improvement Metrics

| Audit | Issues Found | Fixed | Release |
|-------|-------------|-------|---------|
| $AUDIT_ID | $((FIXED_COUNT + MANUAL_COUNT)) | $FIXED_COUNT | v$NEW_VERSION |

---
*This issue will be automatically updated when the audit date approaches.*
EOF
)" --json number -q .number)

# Create TaskWarrior task for next audit
task add project:scheduled +AUDIT due:$NEXT_AUDIT_DATE -- "Run repository audit for $REPO_NAME"

echo "✅ Next audit scheduled for $NEXT_AUDIT_DATE"
echo "   Reminder issue: #$REMINDER_ISSUE"

task project:$RELEASE_ID +SCHEDULE done