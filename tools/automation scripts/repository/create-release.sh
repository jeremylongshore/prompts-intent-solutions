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

echo "✅ Release tag created"
task project:$RELEASE_ID +TAG done