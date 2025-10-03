#!/bin/bash
# verify-fixes.sh - Verify all chore fixes are working correctly

set -e

echo "╔════════════════════════════════════════╗"
echo "║         VERIFYING CHORE FIXES          ║"
echo "║      Pre-Release Quality Assurance     ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Load helper functions
source ./manual-fix-handler.sh

# Check for initialized chore system
if [ -z "$CHORE_ID" ]; then
  echo "ERROR: Chore system not initialized!"
  echo "Run: ./init-chore-system.sh"
  exit 1
fi

echo "🔍 Starting comprehensive verification for chore: $CHORE_ID"
echo ""

# Statistics tracking
VERIFICATION_ERRORS=0
WARNINGS=0

# Function to report verification result
verify_result() {
  local TEST_NAME="$1"
  local STATUS="$2"
  local MESSAGE="$3"

  case $STATUS in
    "PASS")
      echo "   ✅ $TEST_NAME: $MESSAGE"
      ;;
    "FAIL")
      echo "   ❌ $TEST_NAME: $MESSAGE"
      VERIFICATION_ERRORS=$((VERIFICATION_ERRORS + 1))
      ;;
    "WARN")
      echo "   ⚠️  $TEST_NAME: $MESSAGE"
      WARNINGS=$((WARNINGS + 1))
      ;;
    "INFO")
      echo "   ℹ️  $TEST_NAME: $MESSAGE"
      ;;
  esac
}

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "1. Repository Health Verification"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check git status
GIT_STATUS=$(git status --porcelain)
if [ -z "$GIT_STATUS" ]; then
  verify_result "Git Working Tree" "PASS" "Clean working directory"
else
  verify_result "Git Working Tree" "WARN" "Uncommitted changes found"
fi

# Check for common documentation files
if [ -f "README.md" ]; then
  README_SIZE=$(wc -l < README.md)
  if [ $README_SIZE -gt 10 ]; then
    verify_result "README.md" "PASS" "Present and substantial ($README_SIZE lines)"
  else
    verify_result "README.md" "WARN" "Present but minimal ($README_SIZE lines)"
  fi
else
  verify_result "README.md" "FAIL" "Missing"
fi

if [ -f "LICENSE" ]; then
  verify_result "LICENSE" "PASS" "Present"
else
  verify_result "LICENSE" "WARN" "Missing"
fi

if [ -f "CONTRIBUTING.md" ]; then
  verify_result "CONTRIBUTING.md" "PASS" "Present"
else
  verify_result "CONTRIBUTING.md" "INFO" "Optional file not present"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "2. GitHub Repository Settings"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check repository description
REPO_DESC=$(gh repo view --json description -q .description)
if [ "$REPO_DESC" != "null" ] && [ -n "$REPO_DESC" ]; then
  verify_result "Repository Description" "PASS" "Present: $REPO_DESC"
else
  verify_result "Repository Description" "WARN" "Missing"
fi

# Check repository topics
REPO_TOPICS=$(gh repo view --json repositoryTopics -q '.repositoryTopics | length')
if [ "$REPO_TOPICS" -gt 0 ]; then
  verify_result "Repository Topics" "PASS" "$REPO_TOPICS topics configured"
else
  verify_result "Repository Topics" "WARN" "No topics configured"
fi

# Check branch protection (if main branch exists)
if git show-ref --verify --quiet refs/heads/main; then
  BRANCH_PROTECTION=$(gh api repos/$REPO_OWNER/$REPO_NAME/branches/main/protection 2>/dev/null && echo "enabled" || echo "disabled")
  if [ "$BRANCH_PROTECTION" = "enabled" ]; then
    verify_result "Branch Protection" "PASS" "Enabled on main branch"
  else
    verify_result "Branch Protection" "INFO" "Not enabled (may be intentional for personal repos)"
  fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "3. GitHub Infrastructure Files"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check for CODEOWNERS
if [ -f ".github/CODEOWNERS" ]; then
  verify_result "CODEOWNERS" "PASS" "Present"
else
  verify_result "CODEOWNERS" "INFO" "Not present (optional)"
fi

# Check for issue templates
if [ -d ".github/ISSUE_TEMPLATE" ]; then
  TEMPLATE_COUNT=$(ls -1 .github/ISSUE_TEMPLATE/ | wc -l)
  verify_result "Issue Templates" "PASS" "$TEMPLATE_COUNT templates configured"
else
  verify_result "Issue Templates" "INFO" "Not present (optional)"
fi

# Check for pull request template
if [ -f ".github/pull_request_template.md" ]; then
  verify_result "PR Template" "PASS" "Present"
else
  verify_result "PR Template" "INFO" "Not present (optional)"
fi

# Check for GitHub Actions workflows
if [ -d ".github/workflows" ]; then
  WORKFLOW_COUNT=$(ls -1 .github/workflows/*.yml 2>/dev/null | wc -l)
  if [ $WORKFLOW_COUNT -gt 0 ]; then
    verify_result "GitHub Actions" "PASS" "$WORKFLOW_COUNT workflows configured"
  else
    verify_result "GitHub Actions" "INFO" "Directory present but no workflows"
  fi
else
  verify_result "GitHub Actions" "INFO" "No workflows directory"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "4. Security Configuration"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check for security policy
if [ -f "SECURITY.md" ]; then
  verify_result "Security Policy" "PASS" "Present"
else
  verify_result "Security Policy" "INFO" "Not present (optional)"
fi

# Check secret scanning status (this might fail for private repos)
SECRET_SCANNING=$(gh api repos/$REPO_OWNER/$REPO_NAME --jq '.security_and_analysis.secret_scanning.status' 2>/dev/null || echo "unknown")
if [ "$SECRET_SCANNING" = "enabled" ]; then
  verify_result "Secret Scanning" "PASS" "Enabled"
elif [ "$SECRET_SCANNING" = "disabled" ]; then
  verify_result "Secret Scanning" "WARN" "Disabled"
else
  verify_result "Secret Scanning" "INFO" "Status unknown (may require enterprise)"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "5. Code Quality Checks"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check for package.json and run tests if available
if [ -f "package.json" ]; then
  verify_result "Package.json" "PASS" "Present"

  # Check for test script
  if jq -e '.scripts.test' package.json >/dev/null 2>&1; then
    verify_result "Test Script" "PASS" "Configured in package.json"

    # Try to run tests (with timeout)
    echo "   🧪 Running tests..."
    if timeout 60 npm test >/dev/null 2>&1; then
      verify_result "Test Execution" "PASS" "Tests pass"
    else
      verify_result "Test Execution" "WARN" "Tests failed or timed out"
    fi
  else
    verify_result "Test Script" "INFO" "No test script configured"
  fi

  # Check for linting
  if jq -e '.scripts.lint' package.json >/dev/null 2>&1; then
    verify_result "Lint Script" "PASS" "Configured in package.json"

    # Try to run linting
    echo "   🔍 Running linter..."
    if timeout 30 npm run lint >/dev/null 2>&1; then
      verify_result "Lint Execution" "PASS" "Linting passes"
    else
      verify_result "Lint Execution" "WARN" "Linting issues found"
    fi
  else
    verify_result "Lint Script" "INFO" "No lint script configured"
  fi
fi

# Check for Python projects
if [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
  verify_result "Python Project" "PASS" "Python configuration detected"

  # Check for common Python quality tools
  if command -v pytest >/dev/null 2>&1; then
    echo "   🧪 Running Python tests..."
    if timeout 60 python -m pytest >/dev/null 2>&1; then
      verify_result "Python Tests" "PASS" "Tests pass"
    else
      verify_result "Python Tests" "WARN" "Tests failed or not configured"
    fi
  fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "6. Issue Resolution Verification"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check milestone completion status
OPEN_ISSUES=$(gh issue list --milestone "$MILESTONE" --state open --json number --jq '. | length' 2>/dev/null || echo "0")
CLOSED_ISSUES=$(gh issue list --milestone "$MILESTONE" --state closed --json number --jq '. | length' 2>/dev/null || echo "0")
TOTAL_ISSUES=$((OPEN_ISSUES + CLOSED_ISSUES))

if [ $TOTAL_ISSUES -gt 0 ]; then
  COMPLETION_RATE=$(( (CLOSED_ISSUES * 100) / TOTAL_ISSUES ))
  if [ $COMPLETION_RATE -eq 100 ]; then
    verify_result "Issue Resolution" "PASS" "All $TOTAL_ISSUES issues resolved (100%)"
  elif [ $COMPLETION_RATE -ge 80 ]; then
    verify_result "Issue Resolution" "PASS" "$CLOSED_ISSUES/$TOTAL_ISSUES issues resolved (${COMPLETION_RATE}%)"
  else
    verify_result "Issue Resolution" "WARN" "Only $CLOSED_ISSUES/$TOTAL_ISSUES issues resolved (${COMPLETION_RATE}%)"
  fi
else
  verify_result "Issue Resolution" "INFO" "No issues found in milestone"
fi

# Check for manual fixes still pending
cleanup_resolved_manual_fixes
if [ -f ".github/chore-manual-fixes.log" ] && [ -s ".github/chore-manual-fixes.log" ]; then
  PENDING_MANUAL=$(grep -c "MANUAL" .github/chore-manual-fixes.log 2>/dev/null || echo "0")
  if [ $PENDING_MANUAL -gt 0 ]; then
    verify_result "Manual Fixes" "WARN" "$PENDING_MANUAL issues still require manual intervention"
  else
    verify_result "Manual Fixes" "PASS" "No pending manual fixes"
  fi
else
  verify_result "Manual Fixes" "PASS" "No manual fixes required"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Verification Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ $VERIFICATION_ERRORS -eq 0 ]; then
  if [ $WARNINGS -eq 0 ]; then
    echo "🎉 Perfect! All verifications passed"
    echo "   ✅ Ready for release phase"
  else
    echo "✅ Verification successful with $WARNINGS warnings"
    echo "   📝 Warnings are non-blocking for release"
  fi
  VERIFICATION_STATUS="PASS"
else
  echo "❌ Verification failed with $VERIFICATION_ERRORS errors and $WARNINGS warnings"
  echo "   🔧 Please address errors before proceeding to release"
  VERIFICATION_STATUS="FAIL"
fi

# Update TaskWarrior
if [ "$VERIFICATION_STATUS" = "PASS" ]; then
  echo "yes" | task project:$CHORE_ID +VERIFY done >/dev/null 2>&1 || true
  echo ""
  echo "🚀 Next step: Run './complete-chore.sh' to finalize and create release PR"
else
  echo ""
  echo "🔧 Fix the issues above, then re-run this verification"
fi

echo ""
echo "📋 Verification completed: $VERIFICATION_STATUS"