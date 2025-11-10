#!/bin/bash
# archive-artifacts.sh - Archive audit trail for future reference

echo "=== ARCHIVING AUDIT ARTIFACTS ==="
task project:$RELEASE_ID +ARCHIVE start

# Create archive directory
ARCHIVE_DIR=".github/audits/$AUDIT_ID"
mkdir -p "$ARCHIVE_DIR"

# Move all audit-related files to archive
mv .github/audit-handoff-$AUDIT_ID.json "$ARCHIVE_DIR/" 2>/dev/null
mv .github/chore-handoff-$CHORE_ID.json "$ARCHIVE_DIR/" 2>/dev/null
mv .github/chore-verification-$CHORE_ID.json "$ARCHIVE_DIR/" 2>/dev/null
mv .github/manual-fixes-required.txt "$ARCHIVE_DIR/" 2>/dev/null

# Create audit summary
cat > "$ARCHIVE_DIR/summary.json" << EOF
{
  "audit_id": "$AUDIT_ID",
  "chore_id": "$CHORE_ID",
  "release_id": "$RELEASE_ID",
  "version": "$NEW_VERSION",
  "milestone": "$MILESTONE",
  "pr_number": $PR_NUMBER,
  "issues_fixed": $FIXED_COUNT,
  "manual_required": $MANUAL_COUNT,
  "release_date": "$(date -Iseconds)",
  "release_url": "$RELEASE_URL"
}
EOF

# Export TaskWarrior history
task project:$AUDIT_ID export > "$ARCHIVE_DIR/tasks-audit.json" 2>/dev/null
task project:$CHORE_ID export > "$ARCHIVE_DIR/tasks-chore.json" 2>/dev/null
task project:$RELEASE_ID export > "$ARCHIVE_DIR/tasks-release.json" 2>/dev/null

# Commit archive
git add "$ARCHIVE_DIR"
git commit -m "chore: archive audit $AUDIT_ID artifacts"

echo "✅ Artifacts archived to $ARCHIVE_DIR"
task project:$RELEASE_ID +ARCHIVE done