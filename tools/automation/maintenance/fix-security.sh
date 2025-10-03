#!/bin/bash
# fix-security.sh - Automated security fixes

fix_security_issue() {
  local ISSUE_NUMBER="$1"
  local TITLE="$2"

  case "$TITLE" in
    *"Secret scanning disabled"*)
      echo "→ Enabling secret scanning..."
      gh api --method PATCH \
        repos/$REPO_OWNER/$REPO_NAME \
        --field security_and_analysis[secret_scanning][status]=enabled \
        --field security_and_analysis[secret_scanning_push_protection][status]=enabled >/dev/null 2>&1

      gh issue comment $ISSUE_NUMBER --body "✅ Secret scanning enabled" >/dev/null 2>&1
      gh issue close $ISSUE_NUMBER --reason completed >/dev/null 2>&1
      git commit --allow-empty -m "fix: Enable secret scanning

Closes #$ISSUE_NUMBER"
      return 0
      ;;

    *"vulnerabilities"*)
      echo "→ Running security updates..."
      if [ -f "package.json" ]; then
        npm audit fix --force >/dev/null 2>&1
        git add package*.json
        git commit -m "fix: Update vulnerable dependencies

Closes #$ISSUE_NUMBER"
      elif [ -f "Gemfile" ]; then
        bundle update --conservative >/dev/null 2>&1
        git add Gemfile.lock
        git commit -m "fix: Update vulnerable gems

Closes #$ISSUE_NUMBER"
      fi
      gh issue close $ISSUE_NUMBER --reason completed >/dev/null 2>&1
      return 0
      ;;

    *"SECURITY.md"*)
      echo "→ Creating security policy..."
      cat > SECURITY.md << 'EOF'
# Security Policy

## Reporting Security Vulnerabilities

Please report security vulnerabilities to:
- Email: security@example.com
- Response time: Within 24 hours

Do NOT create public issues for security vulnerabilities.

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| Latest  | :white_check_mark: |
| < 1.0   | :x:                |
EOF
      git add SECURITY.md
      git commit -m "fix: Add security policy

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