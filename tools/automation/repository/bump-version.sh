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