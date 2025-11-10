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