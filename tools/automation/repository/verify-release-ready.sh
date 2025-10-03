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