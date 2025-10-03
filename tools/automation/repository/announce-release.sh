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

task project:$RELEASE_ID +ANNOUNCE done