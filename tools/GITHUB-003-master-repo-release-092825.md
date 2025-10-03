---
name: master-github-repo-release
description: Complete release deployment system that verifies fixes, creates releases, and deploys improvements with full documentation
model: opus
date: 2025-09-28
---

# GitHub Repository Release System
## Phase 3 of 3: Audit → Chore → Release Pipeline

---

## RELEASE SYSTEM INITIALIZATION

### Pre-Release Verification: Read Chore Handoff

```bash
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

# Verify PR is merged
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
```

---

## RELEASE VERIFICATION

### Verify All Critical Issues Closed

```bash
#!/bin/bash
# verify-release-ready.sh - Ensure repository is ready for release

echo "=== VERIFYING RELEASE READINESS ==="
task project:$RELEASE_ID +VERIFY start

# Check for open critical/high issues
CRITICAL_OPEN=$(gh issue list --milestone "$MILESTONE" --label "severity:critical" --state open --json number --jq '. | length')
HIGH_OPEN=$(gh issue list --milestone "$MILESTONE" --label "severity:high" --state open --json number --jq '. | length')

if [ $CRITICAL_OPEN -gt 0 ] || [ $HIGH_OPEN -gt 0 ]; then
  echo "⚠️  WARNING: Open high-priority issues remain!"
  echo "   Critical: $CRITICAL_OPEN"
  echo "   High: $HIGH_OPEN"
  echo ""
  echo "Continue anyway? (y/N)"
  read -r CONTINUE
  if [ "$CONTINUE" != "y" ]; then
    echo "Release aborted. Fix remaining issues first."
    exit 1
  fi
fi

# Run test suite
echo "→ Running test suite..."
if [ -f "package.json" ] && grep -q '"test"' package.json; then
  npm test || {
    echo "❌ Tests failed! Fix before release."
    exit 1
  }
elif [ -f "Makefile" ] && grep -q '^test:' Makefile; then
  make test || {
    echo "❌ Tests failed! Fix before release."
    exit 1
  }
fi

# Check for uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
  echo "❌ Uncommitted changes detected!"
  git status --short
  echo "Commit or stash changes before release."
  exit 1
fi

# Security scan
echo "→ Running security scan..."
if [ -f "package.json" ]; then
  npm audit --audit-level=critical || {
    echo "⚠️  Critical vulnerabilities found"
    echo "Consider fixing before release"
  }
fi

echo "✅ Release verification complete"
task project:$RELEASE_ID +VERIFY done
```

---

## VERSION MANAGEMENT

### Automatic Version Bumping

```bash
#!/bin/bash
# bump-version.sh - Intelligently bump version based on changes

echo "=== BUMPING VERSION ==="
task project:$RELEASE_ID +VERSION start

# Determine version bump type based on fixes
determine_version_bump() {
  local BREAKING_CHANGES=0
  local FEATURES=0
  local FIXES=$FIXED_COUNT

  # Check commit messages for breaking changes
  git log $MERGE_COMMIT --format=%B | grep -i "BREAKING CHANGE" && BREAKING_CHANGES=1

  # Check for feature additions
  git log $MERGE_COMMIT --format=%B | grep -i "^feat:" && FEATURES=$((FEATURES+1))

  if [ $BREAKING_CHANGES -gt 0 ]; then
    echo "major"
  elif [ $FEATURES -gt 0 ] || [ $MANUAL_COUNT -gt 5 ]; then
    echo "minor"
  else
    echo "patch"
  fi
}

BUMP_TYPE=$(determine_version_bump)
echo "Version bump type: $BUMP_TYPE"

# Get current version
if [ -f "package.json" ]; then
  CURRENT_VERSION=$(jq -r '.version // "0.0.0"' package.json)

  # Use npm version to bump
  npm version $BUMP_TYPE --no-git-tag-version
  NEW_VERSION=$(jq -r '.version' package.json)

  git add package.json package-lock.json 2>/dev/null
  git commit -m "chore: bump version to $NEW_VERSION"

elif [ -f "version.txt" ]; then
  CURRENT_VERSION=$(cat version.txt)
  # Simple semantic version bumping
  IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

  case $BUMP_TYPE in
    major)
      NEW_VERSION="$((MAJOR+1)).0.0"
      ;;
    minor)
      NEW_VERSION="$MAJOR.$((MINOR+1)).0"
      ;;
    patch)
      NEW_VERSION="$MAJOR.$MINOR.$((PATCH+1))"
      ;;
  esac

  echo "$NEW_VERSION" > version.txt
  git add version.txt
  git commit -m "chore: bump version to $NEW_VERSION"

else
  # No version file, create one
  NEW_VERSION="1.0.0"
  echo "$NEW_VERSION" > version.txt
  git add version.txt
  git commit -m "chore: initialize version at $NEW_VERSION"
fi

export NEW_VERSION
echo "✅ Version bumped: $CURRENT_VERSION → $NEW_VERSION"
task project:$RELEASE_ID +VERSION done
```

---

## CHANGELOG GENERATION

### Generate Release Notes from Fixes

```bash
#!/bin/bash
# generate-changelog.sh - Create comprehensive changelog

echo "=== GENERATING CHANGELOG ==="
task project:$RELEASE_ID +CHANGELOG start

# Generate changelog content
CHANGELOG_CONTENT=$(cat << EOF
# Release v$NEW_VERSION

**Release Date**: $(date +"%Y-%m-%d")
**Audit ID**: $AUDIT_ID
**Total Improvements**: $FIXED_COUNT

## 🎯 Summary

This release includes $FIXED_COUNT automated fixes from repository audit $AUDIT_ID, improving security, documentation, code quality, and infrastructure.

## 🔒 Security Fixes
$(gh issue list --milestone "$MILESTONE" --label "audit:security" --state closed --json number,title --jq '.[] | "- #\(.number): \(.title)"')

## 📚 Documentation Improvements
$(gh issue list --milestone "$MILESTONE" --label "audit:docs" --state closed --json number,title --jq '.[] | "- #\(.number): \(.title)"')

## 🏗️ Infrastructure Updates
$(gh issue list --milestone "$MILESTONE" --label "audit:infra" --state closed --json number,title --jq '.[] | "- #\(.number): \(.title)"')

## 💻 Code Quality Enhancements
$(gh issue list --milestone "$MILESTONE" --label "audit:code" --state closed --json number,title --jq '.[] | "- #\(.number): \(.title)"')

## 👥 Community Improvements
$(gh issue list --milestone "$MILESTONE" --label "audit:community" --state closed --json number,title --jq '.[] | "- #\(.number): \(.title)"')

## 📊 Audit Metrics

| Metric | Value |
|--------|-------|
| Issues Fixed Automatically | $FIXED_COUNT |
| Issues Requiring Manual Fix | $MANUAL_COUNT |
| Critical Issues Resolved | $(gh issue list --milestone "$MILESTONE" --label "severity:critical" --state closed --json number --jq '. | length') |
| High Priority Resolved | $(gh issue list --milestone "$MILESTONE" --label "severity:high" --state closed --json number --jq '. | length') |

## 🔄 Migration Guide

Most changes are backwards compatible. The following may require attention:

$([ $BREAKING_CHANGES -gt 0 ] && echo "- Review breaking changes below" || echo "- No breaking changes")
$([ -f ".github/manual-fixes-required.txt" ] && echo "- Manual fixes may be needed for some features" || echo "")

## 👏 Contributors

- Automated fixes by Repository Audit System
- Manual fixes and review by @$REPO_OWNER

## 📝 Full Audit Report

View the complete audit trail:
- [Audit Milestone](https://github.com/$REPO_OWNER/$REPO_NAME/milestone/$MILESTONE_NUMBER)
- [Chore PR #$PR_NUMBER](https://github.com/$REPO_OWNER/$REPO_NAME/pull/$PR_NUMBER)

---
*Generated automatically by Release System*
EOF
)

# Update CHANGELOG.md
if [ -f "CHANGELOG.md" ]; then
  # Prepend to existing changelog
  echo "$CHANGELOG_CONTENT" > CHANGELOG.tmp
  echo "" >> CHANGELOG.tmp
  echo "---" >> CHANGELOG.tmp
  echo "" >> CHANGELOG.tmp
  cat CHANGELOG.md >> CHANGELOG.tmp
  mv CHANGELOG.tmp CHANGELOG.md
else
  echo "$CHANGELOG_CONTENT" > CHANGELOG.md
fi

git add CHANGELOG.md
git commit -m "docs: update changelog for v$NEW_VERSION"

echo "✅ Changelog generated"
task project:$RELEASE_ID +CHANGELOG done
```

---

## CREATE RELEASE

### GitHub Release Creation

```bash
#!/bin/bash
# create-release.sh - Create GitHub release with tag

echo "=== CREATING GITHUB RELEASE ==="
task project:$RELEASE_ID +TAG start

# Create and push tag
git tag -a "v$NEW_VERSION" -m "Release v$NEW_VERSION - Automated fixes from audit $AUDIT_ID"
git push origin "v$NEW_VERSION"

# Create GitHub release
RELEASE_URL=$(gh release create "v$NEW_VERSION" \
  --title "v$NEW_VERSION - Audit Improvements" \
  --notes "$CHANGELOG_CONTENT" \
  --target main \
  --json url -q .url)

echo "✅ Created release: $RELEASE_URL"

# Close the audit milestone
gh api --method PATCH \
  repos/$REPO_OWNER/$REPO_NAME/milestones/$MILESTONE_NUMBER \
  -f state=closed

echo "✅ Closed audit milestone"
task project:$RELEASE_ID +TAG done
```

---

## DEPLOYMENT

### Deploy Release

```bash
#!/bin/bash
# deploy-release.sh - Deploy to production/registry

echo "=== DEPLOYING RELEASE ==="
task project:$RELEASE_ID +DEPLOY start

# Deployment based on project type
if [ -f "package.json" ]; then
  # NPM package deployment
  if grep -q '"private": false' package.json; then
    echo "→ Publishing to NPM..."
    npm publish
    echo "✅ Published to NPM"
  fi

elif [ -f "Dockerfile" ]; then
  # Docker image deployment
  echo "→ Building Docker image..."
  docker build -t $REPO_NAME:$NEW_VERSION .
  docker tag $REPO_NAME:$NEW_VERSION $REPO_NAME:latest
  echo "✅ Docker image built"

elif [ -f ".github/workflows/deploy.yml" ]; then
  # Trigger deployment workflow
  echo "→ Triggering deployment workflow..."
  gh workflow run deploy.yml --ref "v$NEW_VERSION"
  echo "✅ Deployment workflow triggered"
fi

# Update GitHub Pages if docs exist
if [ -d "docs" ]; then
  echo "→ Updating documentation site..."
  git checkout gh-pages 2>/dev/null || git checkout -b gh-pages
  cp -r docs/* .
  git add .
  git commit -m "docs: update for v$NEW_VERSION"
  git push origin gh-pages
  git checkout main
  echo "✅ Documentation deployed"
fi

task project:$RELEASE_ID +DEPLOY done
```

---

## ANNOUNCEMENT

### Announce Release

```bash
#!/bin/bash
# announce-release.sh - Notify about release

echo "=== ANNOUNCING RELEASE ==="
task project:$RELEASE_ID +ANNOUNCE start

# Create announcement issue
ANNOUNCE_ISSUE=$(gh issue create \
  --title "🚀 Released v$NEW_VERSION" \
  --label "announcement,release" \
  --body "$(cat << EOF
# 🚀 Version $NEW_VERSION Released!

We're excited to announce the release of v$NEW_VERSION, which includes $FIXED_COUNT improvements from our automated repository audit.

## Highlights

- 🔒 Enhanced security posture
- 📚 Improved documentation
- 🏗️ Better infrastructure
- 💻 Cleaner code

## Get the Release

- **GitHub Release**: [v$NEW_VERSION](https://github.com/$REPO_OWNER/$REPO_NAME/releases/tag/v$NEW_VERSION)
- **Changelog**: [View Changes](https://github.com/$REPO_OWNER/$REPO_NAME/blob/main/CHANGELOG.md)

## Thank You

This release was made possible by our automated audit and fix system, ensuring continuous improvement of repository quality.

---
*Questions? Reply to this issue or check our [documentation](README.md).*
EOF
)" --json number -q .number)

echo "✅ Created announcement issue #$ANNOUNCE_ISSUE"

# Pin the announcement
gh issue pin $ANNOUNCE_ISSUE

# Create discussion if enabled
if gh api repos/$REPO_OWNER/$REPO_NAME --jq '.has_discussions' | grep -q true; then
  gh api graphql -f query='
    mutation {
      createDiscussion(input: {
        repositoryId: "'$(gh api repos/$REPO_OWNER/$REPO_NAME --jq '.node_id')'",
        title: "Released v'$NEW_VERSION' - '$FIXED_COUNT' Improvements",
        body: "Check out our latest release with automated improvements!",
        categoryId: "'$(gh api graphql -f query='query { repository(owner:"'$REPO_OWNER'", name:"'$REPO_NAME'") { discussionCategories(first:10) { nodes { id name }}}}' --jq '.data.repository.discussionCategories.nodes[] | select(.name=="Announcements") | .id')'"
      }) {
        discussion { id }
      }
    }'
fi

task project:$RELEASE_ID +ANNOUNCE done
```

---

## ARCHIVE & CLEANUP

### Archive Audit Artifacts

```bash
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
task project:$AUDIT_ID export > "$ARCHIVE_DIR/tasks-audit.json"
task project:$CHORE_ID export > "$ARCHIVE_DIR/tasks-chore.json"
task project:$RELEASE_ID export > "$ARCHIVE_DIR/tasks-release.json"

# Commit archive
git add "$ARCHIVE_DIR"
git commit -m "chore: archive audit $AUDIT_ID artifacts"
git push origin main

echo "✅ Artifacts archived to $ARCHIVE_DIR"
task project:$RELEASE_ID +ARCHIVE done
```

### Schedule Next Audit

```bash
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
  --milestone "Next Audit" \
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
```

---

## COMPLETE RELEASE WORKFLOW

### Master Release Script

```bash
#!/bin/bash
# run-complete-release.sh - Execute complete release phase

set -e  # Exit on error

echo "╔════════════════════════════════════════╗"
echo "║         STARTING RELEASE PROCESS       ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Initialize
source ./init-release-system.sh

# Verify ready for release
./verify-release-ready.sh

# Bump version
./bump-version.sh

# Generate changelog
./generate-changelog.sh

# Create GitHub release
./create-release.sh

# Deploy
./deploy-release.sh

# Announce
./announce-release.sh

# Archive
./archive-artifacts.sh

# Schedule next audit
./schedule-next-audit.sh

# Complete all tasks
task project:$RELEASE_ID status:pending done

echo ""
echo "╔════════════════════════════════════════╗"
echo "║         RELEASE COMPLETE! 🎉           ║"
echo "╚════════════════════════════════════════╝"
echo ""
echo "📦 Version Released: v$NEW_VERSION"
echo "🔗 Release URL: $RELEASE_URL"
echo "📊 Issues Fixed: $FIXED_COUNT"
echo "📅 Next Audit: $NEXT_AUDIT_DATE"
echo ""
echo "=== PIPELINE SUMMARY ==="
echo "✅ Audit Phase    - COMPLETE"
echo "✅ Chore Phase    - COMPLETE"
echo "✅ Release Phase  - COMPLETE"
echo ""
echo "=== TASKWARRIOR SUMMARY ==="
task project:$RELEASE_ID
echo ""
echo "🎯 Repository is now compliant with all standards!"
```

---
*Updated: September 28, 2025*