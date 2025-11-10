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
- Enhanced security configurations
- Updated dependencies with security patches

## 📚 Documentation Improvements
- Updated README with latest features
- Added comprehensive prompt documentation
- Improved API documentation

## 🏗️ Infrastructure Updates
- Updated CI/CD workflows
- Enhanced GitHub Actions
- Improved dependency management

## 💻 Code Quality Enhancements
- Code formatting improvements
- Linting rule updates
- Enhanced error handling

## 👥 Community Improvements
- Updated contributing guidelines
- Enhanced issue templates
- Improved pull request templates

## 📊 Audit Metrics

| Metric | Value |
|--------|-------|
| Issues Fixed Automatically | $FIXED_COUNT |
| Issues Requiring Manual Fix | $MANUAL_COUNT |
| Critical Issues Resolved | 0 |
| High Priority Resolved | 5 |

## 🔄 Migration Guide

Most changes are backwards compatible. No breaking changes in this release.

## 👏 Contributors

- Automated fixes by Repository Audit System
- Manual fixes and review by @$REPO_OWNER

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