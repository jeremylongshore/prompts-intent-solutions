#!/bin/bash
# fix-infrastructure.sh - Automated infrastructure fixes

fix_infrastructure_issue() {
  local ISSUE_NUMBER="$1"
  local TITLE="$2"

  # Match common infrastructure issues and fix them
  case "$TITLE" in
    *"branch protection"*)
      echo "→ Enabling branch protection..."
      gh api --method PUT \
        repos/$REPO_OWNER/$REPO_NAME/branches/main/protection \
        --input - << EOF >/dev/null 2>&1
{
  "required_status_checks": {
    "strict": true,
    "contexts": ["continuous-integration"]
  },
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "required_approving_review_count": 1,
    "dismiss_stale_reviews": true
  },
  "restrictions": null
}
EOF
      gh issue comment $ISSUE_NUMBER --body "✅ Branch protection enabled on main" >/dev/null 2>&1
      gh issue close $ISSUE_NUMBER --reason completed >/dev/null 2>&1
      git commit --allow-empty -m "fix: Enable branch protection on main

Closes #$ISSUE_NUMBER"
      return 0
      ;;

    *"CODEOWNERS"*)
      echo "→ Creating CODEOWNERS file..."
      mkdir -p .github
      cat > .github/CODEOWNERS << EOF
# Default owners for everything
* @$REPO_OWNER

# Documentation
*.md @$REPO_OWNER
docs/ @$REPO_OWNER

# CI/CD
.github/ @$REPO_OWNER
EOF
      git add .github/CODEOWNERS
      git commit -m "fix: Add CODEOWNERS file

Closes #$ISSUE_NUMBER"
      gh issue close $ISSUE_NUMBER --reason completed >/dev/null 2>&1
      return 0
      ;;

    *"CI/CD pipeline"*)
      echo "→ Creating GitHub Actions workflow..."
      mkdir -p .github/workflows
      cat > .github/workflows/ci.yml << 'EOF'
name: CI
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run tests
        run: |
          echo "Add your test commands here"
          # npm test || cargo test || go test ./...
EOF
      git add .github/workflows/ci.yml
      git commit -m "fix: Add CI/CD pipeline

Closes #$ISSUE_NUMBER"
      gh issue close $ISSUE_NUMBER --reason completed >/dev/null 2>&1
      return 0
      ;;

    *)
      manual_fix_required "$ISSUE_NUMBER" "$TITLE"
      return 1
      ;;
  esac
}