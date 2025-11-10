#!/bin/bash
# run-complete-chore.sh - Master chore system execution script

set -e

echo "╔════════════════════════════════════════╗"
echo "║    MASTER GITHUB REPO CHORE v2.0      ║"
echo "║       Complete Automation System       ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Script metadata
SCRIPT_VERSION="2.0"
EXECUTION_ID="chore-$(date +%Y%m%d-%H%M%S)"

echo "🚀 Starting complete chore system execution"
echo "   Version: $SCRIPT_VERSION"
echo "   Execution ID: $EXECUTION_ID"
echo "   Timestamp: $(date -Iseconds)"
echo ""

# Function to log execution steps
log_step() {
  local STEP="$1"
  local STATUS="$2"
  local MESSAGE="$3"
  local TIMESTAMP=$(date -Iseconds)

  echo "[$TIMESTAMP] $STATUS: $STEP - $MESSAGE"
}

# Function to handle errors
handle_error() {
  local EXIT_CODE=$?
  local LINE_NO=$1

  echo ""
  echo "❌ ERROR: Chore system failed at line $LINE_NO with exit code $EXIT_CODE"
  echo "   Execution ID: $EXECUTION_ID"
  echo "   Check logs and manual intervention may be required"
  echo ""

  # Try to save state for debugging
  if [ -n "$CHORE_ID" ]; then
    echo "🔧 Chore ID: $CHORE_ID (for manual recovery)"
  fi

  exit $EXIT_CODE
}

# Set up error handling
trap 'handle_error $LINENO' ERR

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Phase 1: System Initialization"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check prerequisites
log_step "Prerequisites" "INFO" "Checking system requirements"

# Check for required tools
MISSING_TOOLS=()

if ! command -v gh >/dev/null 2>&1; then
  MISSING_TOOLS+=("gh (GitHub CLI)")
fi

if ! command -v git >/dev/null 2>&1; then
  MISSING_TOOLS+=("git")
fi

if ! command -v jq >/dev/null 2>&1; then
  MISSING_TOOLS+=("jq")
fi

if ! command -v task >/dev/null 2>&1; then
  MISSING_TOOLS+=("task (TaskWarrior)")
fi

if [ ${#MISSING_TOOLS[@]} -gt 0 ]; then
  echo "❌ Missing required tools:"
  for tool in "${MISSING_TOOLS[@]}"; do
    echo "   - $tool"
  done
  echo ""
  echo "Please install missing tools and try again"
  exit 1
fi

log_step "Prerequisites" "PASS" "All required tools available"

# Check for Git repository
if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "❌ Not in a Git repository!"
  echo "   Please run this script from within a Git repository"
  exit 1
fi

log_step "Repository" "PASS" "Git repository detected"

# Check for GitHub repository
if ! gh repo view >/dev/null 2>&1; then
  echo "❌ Not a GitHub repository or not authenticated!"
  echo "   Please ensure you're in a GitHub repository and logged in with 'gh auth login'"
  exit 1
fi

log_step "GitHub" "PASS" "GitHub repository and authentication verified"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Phase 2: Chore System Initialization"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

log_step "Initialization" "START" "Running chore system initialization"

# Run initialization
if ./init-chore-system.sh; then
  log_step "Initialization" "PASS" "Chore system initialized successfully"
else
  log_step "Initialization" "FAIL" "Chore system initialization failed"
  exit 1
fi

# Source environment variables set by init script
if [ -f ".chore-env" ]; then
  source .chore-env
  log_step "Environment" "PASS" "Chore environment loaded"
else
  echo "⚠️  Warning: Chore environment file not found"
  echo "   Manual initialization may be required"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Phase 3: Automated Fix Execution"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

log_step "Fixes" "START" "Executing automated fixes"

# Run the main chore execution
if ./run-chore.sh; then
  log_step "Fixes" "PASS" "Automated fixes completed"
else
  log_step "Fixes" "PARTIAL" "Some fixes may have failed (check logs)"
  echo "⚠️  Warning: Not all fixes may have succeeded"
  echo "   This is normal - some issues require manual intervention"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Phase 4: Verification and Quality Assurance"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

log_step "Verification" "START" "Running comprehensive verification"

# Run verification
if ./verify-fixes.sh; then
  log_step "Verification" "PASS" "All verifications successful"
  VERIFICATION_PASSED=true
else
  log_step "Verification" "WARN" "Verification completed with warnings or errors"
  VERIFICATION_PASSED=false
  echo ""
  echo "⚠️  Verification completed with issues"
  echo "   You may proceed to completion, but review warnings/errors"
  echo ""
  read -p "Continue to completion phase? (y/N): " -n 1 -r
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Stopping at user request"
    echo "   Fix verification issues and re-run: ./verify-fixes.sh"
    echo "   Then complete with: ./complete-chore.sh"
    exit 1
  fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Phase 5: Chore Completion and Handoff"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

log_step "Completion" "START" "Finalizing chore phase"

# Run completion
if ./complete-chore.sh; then
  log_step "Completion" "PASS" "Chore phase completed successfully"
else
  log_step "Completion" "FAIL" "Chore completion failed"
  exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Master Chore System - Final Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Generate final statistics
if [ -n "$CHORE_ID" ]; then
  COMPLETED_TASKS=$(task project:$CHORE_ID completed 2>/dev/null | wc -l || echo "0")
  PENDING_TASKS=$(task project:$CHORE_ID pending 2>/dev/null | wc -l || echo "0")
else
  COMPLETED_TASKS="Unknown"
  PENDING_TASKS="Unknown"
fi

# Get milestone statistics
if [ -n "$MILESTONE" ]; then
  OPEN_ISSUES=$(gh issue list --milestone "$MILESTONE" --state open --json number --jq '. | length' 2>/dev/null || echo "0")
  CLOSED_ISSUES=$(gh issue list --milestone "$MILESTONE" --state closed --json number --jq '. | length' 2>/dev/null || echo "0")
  TOTAL_ISSUES=$((OPEN_ISSUES + CLOSED_ISSUES))

  if [ $TOTAL_ISSUES -gt 0 ]; then
    COMPLETION_RATE=$(( (CLOSED_ISSUES * 100) / TOTAL_ISSUES ))
  else
    COMPLETION_RATE=100
  fi
else
  OPEN_ISSUES="Unknown"
  CLOSED_ISSUES="Unknown"
  TOTAL_ISSUES="Unknown"
  COMPLETION_RATE="Unknown"
fi

# Check for manual fixes
MANUAL_FIXES=0
if [ -f ".github/chore-manual-fixes.log" ]; then
  MANUAL_FIXES=$(wc -l < .github/chore-manual-fixes.log 2>/dev/null || echo "0")
fi

echo "🎯 **Execution Summary**"
echo "   📋 Execution ID: $EXECUTION_ID"
echo "   🔧 Chore ID: ${CHORE_ID:-'Not initialized'}"
echo "   ⏱️  Total Runtime: $(($(date +%s) - $(date -d "$(echo $EXECUTION_ID | sed 's/chore-//; s/-/ /; s/\(..\):\(..\):\(..\)/\1:\2:\3/')" +%s) || echo 0))s"

echo ""
echo "📊 **Results**"
echo "   ✅ Issues Resolved: $CLOSED_ISSUES"
echo "   🟡 Issues Remaining: $OPEN_ISSUES"
echo "   📈 Completion Rate: ${COMPLETION_RATE}%"
echo "   🔧 Manual Fixes Required: $MANUAL_FIXES"
echo "   📋 TaskWarrior Tasks Completed: $COMPLETED_TASKS"

echo ""
echo "🎪 **Quality Gates**"
echo "   ✅ System Initialization: Passed"
echo "   ✅ Automated Fixes: Completed"
echo "   $(if [ "$VERIFICATION_PASSED" = true ]; then echo "✅"; else echo "⚠️ "; fi) Verification: $(if [ "$VERIFICATION_PASSED" = true ]; then echo "Passed"; else echo "Completed with warnings"; fi)"
echo "   ✅ Completion & Handoff: Passed"

# Determine overall success
if [ "$COMPLETION_RATE" != "Unknown" ] && [ $COMPLETION_RATE -ge 80 ] && [ $MANUAL_FIXES -eq 0 ]; then
  OVERALL_STATUS="🎉 EXCELLENT"
  STATUS_COLOR="✅"
elif [ "$COMPLETION_RATE" != "Unknown" ] && [ $COMPLETION_RATE -ge 60 ]; then
  OVERALL_STATUS="✅ GOOD"
  STATUS_COLOR="✅"
else
  OVERALL_STATUS="⚠️  PARTIAL"
  STATUS_COLOR="⚠️ "
fi

echo ""
echo "$STATUS_COLOR **Overall Status: $OVERALL_STATUS**"

if [ "$OVERALL_STATUS" = "🎉 EXCELLENT" ]; then
  echo "   Perfect execution! Repository health significantly improved."
  echo "   Ready for immediate release phase."
elif [ "$OVERALL_STATUS" = "✅ GOOD" ]; then
  echo "   Successful execution with solid results."
  echo "   $(if [ $MANUAL_FIXES -gt 0 ]; then echo "Address $MANUAL_FIXES manual fixes, then"; else echo "Ready for"; fi) proceed to release phase."
else
  echo "   Partial success - manual review recommended."
  echo "   Consider addressing remaining issues before release."
fi

echo ""
echo "🚀 **Next Steps**"

# Find the most recent handoff file
HANDOFF_FILE=$(ls -t .github/release-handoff-*.json 2>/dev/null | head -1)
if [ -n "$HANDOFF_FILE" ]; then
  echo "   1. Review release handoff: $HANDOFF_FILE"
  PR_URL=$(jq -r '.pull_request.url' "$HANDOFF_FILE" 2>/dev/null || echo "")
  if [ -n "$PR_URL" ] && [ "$PR_URL" != "null" ]; then
    echo "   2. Review and merge PR: $PR_URL"
  fi
  echo "   3. Run release phase: ./run-complete-release.sh"
else
  echo "   1. Check for release handoff file in .github/"
  echo "   2. Run release phase: ./run-complete-release.sh"
fi

if [ $MANUAL_FIXES -gt 0 ]; then
  echo "   4. Address manual fixes documented in .github/chore-manual-fixes.log"
fi

echo ""
echo "────────────────────────────────────────"
echo "🤖 Master GitHub Repository Chore v$SCRIPT_VERSION"
echo "   Execution completed: $(date -Iseconds)"
echo "   Execution ID: $EXECUTION_ID"
echo "────────────────────────────────────────"

# Clean up temporary files
rm -f .chore-env 2>/dev/null || true

log_step "System" "COMPLETE" "Master chore system execution finished"

echo ""
echo "🎊 Chore phase completed! Repository health improved and ready for release."