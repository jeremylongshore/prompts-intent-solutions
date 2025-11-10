#!/bin/bash
# init-release-system.sh - Initialize release phase from chore handoff

echo "╔════════════════════════════════════════╗"
echo "║      REPOSITORY RELEASE SYSTEM v2.0    ║"
echo "║    Phase 3: Deploy & Document Fixes    ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Find chore handoff file
CHORE_HANDOFF=$(ls -t .github/chore-handoff-*.json 2>/dev/null | head -1)

if [ -z "$CHORE_HANDOFF" ]; then
  echo "ERROR: No chore handoff file found!"
  echo "Complete chore phase first: ./run-complete-chore.sh"
  exit 1
fi

# Parse chore handoff
export CHORE_ID=$(jq -r '.chore_id' "$CHORE_HANDOFF")
export AUDIT_ID=$(jq -r '.audit_id' "$CHORE_HANDOFF")
export MILESTONE=$(jq -r '.milestone' "$CHORE_HANDOFF")
export PR_NUMBER=$(jq -r '.pr_number' "$CHORE_HANDOFF")
export FIXED_COUNT=$(jq -r '.fixed_issues' "$CHORE_HANDOFF")
export MANUAL_COUNT=$(jq -r '.manual_required' "$CHORE_HANDOFF")
export CHORE_BRANCH=$(jq -r '.branch' "$CHORE_HANDOFF")

echo "📋 Chore Handoff Received:"
echo "   Chore ID: $CHORE_ID"
echo "   Audit ID: $AUDIT_ID"
echo "   Pull Request: #$PR_NUMBER"
echo "   Fixed Issues: $FIXED_COUNT"
echo "   Manual Required: $MANUAL_COUNT"
echo ""

# Verify PR is merged (skip if PR_NUMBER is 0)
if [ "$PR_NUMBER" != "0" ]; then
  PR_STATE=$(gh pr view $PR_NUMBER --json state,mergedAt -q '.state')
  if [ "$PR_STATE" != "MERGED" ]; then
    echo "❌ ERROR: PR #$PR_NUMBER is not merged yet!"
    echo "   State: $PR_STATE"
    echo ""
    echo "Please merge the PR first:"
    echo "   gh pr merge $PR_NUMBER --merge"
    exit 1
  fi

  echo "✅ PR #$PR_NUMBER is merged"
  MERGE_COMMIT=$(gh pr view $PR_NUMBER --json mergeCommit -q '.mergeCommit.oid')
  echo "   Merge commit: $MERGE_COMMIT"
else
  echo "✅ No PR to verify (direct to main branch)"
  MERGE_COMMIT=$(git rev-parse HEAD)
  echo "   Current commit: $MERGE_COMMIT"
fi

# Initialize TaskWarrior release project
export RELEASE_ID="release-$(date +%Y%m%d-%H%M%S)"
export REPO_NAME=$(gh repo view --json name -q .name)
export REPO_OWNER=$(gh repo view --json owner -q .owner.login)

task add project:$RELEASE_ID +RELEASE priority:H -- "Execute release for $REPO_NAME"
task add project:$RELEASE_ID +VERIFY depends:last -- "Verify all fixes merged"
task add project:$RELEASE_ID +VERSION depends:last -- "Bump version number"
task add project:$RELEASE_ID +CHANGELOG depends:last -- "Generate changelog"
task add project:$RELEASE_ID +TAG depends:last -- "Create release tag"
task add project:$RELEASE_ID +DEPLOY depends:last -- "Deploy release"
task add project:$RELEASE_ID +ANNOUNCE depends:last -- "Announce release"
task add project:$RELEASE_ID +ARCHIVE depends:last -- "Archive audit artifacts"
task add project:$RELEASE_ID +SCHEDULE depends:last -- "Schedule next audit"

echo "✓ Created TaskWarrior project: $RELEASE_ID"