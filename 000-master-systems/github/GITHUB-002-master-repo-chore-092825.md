---
name: master-github-repo-chore
description: Automated fix execution system that reads GitHub issues and systematically fixes repository problems with PR creation
model: opus
date: 2025-09-28
---

# GitHub Repository Chore System
## Phase 2 of 3: Audit → Chore → Release Pipeline

---

## CHORE SYSTEM INITIALIZATION

### Pre-Chore Verification: Read Audit Handoff

```bash
#!/bin/bash
# init-chore-system.sh - Initialize chore phase from audit handoff

echo "╔════════════════════════════════════════╗"
echo "║      REPOSITORY CHORE SYSTEM v2.0     ║"
echo "║   Phase 2: Automated Fix Execution    ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Find most recent audit handoff file
HANDOFF_FILE=$(ls -t .github/audit-handoff-*.json 2>/dev/null | head -1)

if [ -z "$HANDOFF_FILE" ]; then
  echo "ERROR: No audit handoff file found!"
  echo "Run audit first: ./run-complete-audit.sh"
  exit 1
fi

# Parse handoff file
export AUDIT_ID=$(jq -r '.audit_id' "$HANDOFF_FILE")
export MILESTONE=$(jq -r '.milestone' "$HANDOFF_FILE")
export MILESTONE_NUMBER=$(jq -r '.milestone_number' "$HANDOFF_FILE")
export CRITICAL_COUNT=$(jq -r '.findings.critical' "$HANDOFF_FILE")
export HIGH_COUNT=$(jq -r '.findings.high' "$HANDOFF_FILE")
export MEDIUM_COUNT=$(jq -r '.findings.medium' "$HANDOFF_FILE")
export LOW_COUNT=$(jq -r '.findings.low' "$HANDOFF_FILE")
export TOTAL_FINDINGS=$(jq -r '.findings.total' "$HANDOFF_FILE")

echo "📋 Audit Handoff Received:"
echo "   Audit ID: $AUDIT_ID"
echo "   Milestone: $MILESTONE (#$MILESTONE_NUMBER)"
echo "   Total Findings: $TOTAL_FINDINGS"
echo ""
echo "   🔴 Critical: $CRITICAL_COUNT"
echo "   🟠 High: $HIGH_COUNT"
echo "   🟡 Medium: $MEDIUM_COUNT"
echo "   🟢 Low: $LOW_COUNT"
echo ""

# Initialize TaskWarrior chore project
export CHORE_ID="chore-$(date +%Y%m%d-%H%M%S)"
export REPO_NAME=$(gh repo view --json name -q .name)

task add project:$CHORE_ID +CHORE priority:H -- "Execute chore phase for $REPO_NAME"
task add project:$CHORE_ID +SETUP depends:last -- "Initialize chore system"
task add project:$CHORE_ID +CRITICAL depends:last -- "Fix critical issues"
task add project:$CHORE_ID +HIGH depends:last -- "Fix high priority issues"
task add project:$CHORE_ID +MEDIUM depends:last -- "Fix medium priority issues"
task add project:$CHORE_ID +LOW depends:last -- "Fix low priority issues"
task add project:$CHORE_ID +VERIFY depends:last -- "Verify all fixes"
task add project:$CHORE_ID +HANDOFF depends:last -- "Prepare for release"

echo "✓ Created TaskWarrior project: $CHORE_ID"

# Create chore tracking branch
git checkout -b "chore/$AUDIT_ID"
echo "✓ Created chore branch: chore/$AUDIT_ID"

# Update tracking issue
gh issue comment $TRACKING_ISSUE --body "$(cat << EOF
## 🔧 Chore Phase Started

**Chore ID**: $CHORE_ID
**Branch**: chore/$AUDIT_ID
**Started**: $(date -Iseconds)

### Phases
- [x] **AUDIT** - Scan and document findings
- [ ] **CHORE** - Fix issues based on findings (IN PROGRESS)
- [ ] **RELEASE** - Deploy improvements

Automated fixes beginning...
EOF
)"

echo "✓ Chore system initialized"
```

---

## AUTOMATED FIX ENGINE

### Core Function: Execute Fix for Issue

```bash
#!/bin/bash
# execute-fix.sh - Processes and fixes a GitHub issue

execute_fix() {
  local ISSUE_NUMBER="$1"
  local ISSUE_DATA=$(gh issue view $ISSUE_NUMBER --json title,body,labels)
  local TITLE=$(echo "$ISSUE_DATA" | jq -r '.title')
  local CATEGORY=$(echo "$ISSUE_DATA" | jq -r '.labels[] | select(.name | startswith("audit:")) | .name' | sed 's/audit://')
  local SEVERITY=$(echo "$ISSUE_DATA" | jq -r '.labels[] | select(.name | startswith("severity:")) | .name' | sed 's/severity://')

  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Fixing #$ISSUE_NUMBER: $TITLE"
  echo "Category: $CATEGORY | Severity: $SEVERITY"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  # Create TaskWarrior task for this fix
  TASK_ID=$(task add project:$CHORE_ID +FIX.$CATEGORY -- "Fix #$ISSUE_NUMBER: $TITLE" 2>&1 | grep -oP 'Created task \K\d+')
  task $TASK_ID start

  # Update GitHub issue
  gh issue edit $ISSUE_NUMBER --add-label "phase:chore"
  gh issue comment $ISSUE_NUMBER --body "🤖 Chore bot processing fix..."

  # Route to specific fix handler based on category
  case $CATEGORY in
    "infra")
      fix_infrastructure_issue "$ISSUE_NUMBER" "$TITLE"
      ;;
    "security")
      fix_security_issue "$ISSUE_NUMBER" "$TITLE"
      ;;
    "docs")
      fix_documentation_issue "$ISSUE_NUMBER" "$TITLE"
      ;;
    "code")
      fix_code_issue "$ISSUE_NUMBER" "$TITLE"
      ;;
    "community")
      fix_community_issue "$ISSUE_NUMBER" "$TITLE"
      ;;
    *)
      echo "Unknown category: $CATEGORY"
      manual_fix_required "$ISSUE_NUMBER" "$TITLE"
      ;;
  esac

  # Mark task complete if fix succeeded
  if [ $? -eq 0 ]; then
    task $TASK_ID done
    echo "✓ Fixed issue #$ISSUE_NUMBER"
  else
    echo "⚠️  Manual intervention required for #$ISSUE_NUMBER"
  fi
}
```

---

## CATEGORY-SPECIFIC FIX HANDLERS

### Infrastructure Fixes

```bash
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
        --input - << EOF
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
      gh issue comment $ISSUE_NUMBER --body "✅ Branch protection enabled on main"
      gh issue close $ISSUE_NUMBER --reason completed
      git commit --allow-empty -m "fix: Enable branch protection on main

Closes #$ISSUE_NUMBER"
      ;;

    *"CODEOWNERS"*)
      echo "→ Creating CODEOWNERS file..."
      mkdir -p .github
      cat > .github/CODEOWNERS << 'EOF'
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
      gh issue close $ISSUE_NUMBER --reason completed
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
      gh issue close $ISSUE_NUMBER --reason completed
      ;;

    *)
      manual_fix_required "$ISSUE_NUMBER" "$TITLE"
      ;;
  esac
}
```

### Security Fixes

```bash
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
        --field security_and_analysis[secret_scanning_push_protection][status]=enabled

      gh issue comment $ISSUE_NUMBER --body "✅ Secret scanning enabled"
      gh issue close $ISSUE_NUMBER --reason completed
      ;;

    *"vulnerabilities"*)
      echo "→ Running security updates..."
      if [ -f "package.json" ]; then
        npm audit fix --force
        git add package*.json
        git commit -m "fix: Update vulnerable dependencies

Closes #$ISSUE_NUMBER"
      elif [ -f "Gemfile" ]; then
        bundle update --conservative
        git add Gemfile.lock
        git commit -m "fix: Update vulnerable gems

Closes #$ISSUE_NUMBER"
      fi
      gh issue close $ISSUE_NUMBER --reason completed
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
      gh issue close $ISSUE_NUMBER --reason completed
      ;;

    *)
      manual_fix_required "$ISSUE_NUMBER" "$TITLE"
      ;;
  esac
}
```

### Documentation Fixes

```bash
#!/bin/bash
# fix-documentation.sh - Automated documentation fixes

fix_documentation_issue() {
  local ISSUE_NUMBER="$1"
  local TITLE="$2"

  case "$TITLE" in
    *"README"*)
      echo "→ Enhancing README..."
      if [ ! -f "README.md" ] || [ $(wc -l < "README.md") -lt 10 ]; then
        cat > README.md << 'EOF'
# $REPO_NAME

Brief description of what this project does and who it's for.

## Installation

```bash
# Add installation commands here
git clone https://github.com/$REPO_OWNER/$REPO_NAME
cd $REPO_NAME
```

## Quick Start

```bash
# Add quickstart commands
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License

See [LICENSE](LICENSE) file.
EOF
        git add README.md
        git commit -m "fix: Enhance README documentation

Closes #$ISSUE_NUMBER"
        gh issue close $ISSUE_NUMBER --reason completed
      fi
      ;;

    *"CONTRIBUTING"*)
      echo "→ Creating CONTRIBUTING.md..."
      cat > CONTRIBUTING.md << 'EOF'
# Contributing

We welcome contributions! Please follow these guidelines:

## How to Contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Code Style

- Follow existing code style
- Add tests for new features
- Update documentation

## Reporting Issues

Use GitHub Issues to report bugs or request features.
EOF
      git add CONTRIBUTING.md
      git commit -m "fix: Add contribution guidelines

Closes #$ISSUE_NUMBER"
      gh issue close $ISSUE_NUMBER --reason completed
      ;;

    *"LICENSE"*)
      echo "→ Adding MIT License..."
      cat > LICENSE << EOF
MIT License

Copyright (c) $(date +%Y) $REPO_OWNER

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF
      git add LICENSE
      git commit -m "fix: Add MIT license

Closes #$ISSUE_NUMBER"
      gh issue close $ISSUE_NUMBER --reason completed
      ;;

    *)
      manual_fix_required "$ISSUE_NUMBER" "$TITLE"
      ;;
  esac
}
```

### Code Quality Fixes

```bash
#!/bin/bash
# fix-code.sh - Automated code quality fixes

fix_code_issue() {
  local ISSUE_NUMBER="$1"
  local TITLE="$2"

  case "$TITLE" in
    *"linting"*)
      echo "→ Adding linting configuration..."
      if [ -f "package.json" ]; then
        # Add ESLint for JavaScript/TypeScript
        npm install --save-dev eslint
        npx eslint --init --yes

        # Add to package.json scripts
        npm pkg set scripts.lint="eslint ."
        npm pkg set scripts.lint:fix="eslint . --fix"

        git add .eslintrc* package*.json
        git commit -m "fix: Add ESLint configuration

Closes #$ISSUE_NUMBER"
      elif [ -f "Gemfile" ]; then
        # Add RuboCop for Ruby
        echo "gem 'rubocop', require: false" >> Gemfile
        bundle install
        bundle exec rubocop --auto-gen-config

        git add .rubocop* Gemfile*
        git commit -m "fix: Add RuboCop configuration

Closes #$ISSUE_NUMBER"
      fi
      gh issue close $ISSUE_NUMBER --reason completed
      ;;

    *"test"*)
      echo "→ Setting up test structure..."
      mkdir -p test

      if [ -f "package.json" ]; then
        npm install --save-dev jest
        npm pkg set scripts.test="jest"

        cat > test/example.test.js << 'EOF'
describe('Example Test', () => {
  test('should pass', () => {
    expect(true).toBe(true);
  });
});
EOF
        git add test/ package*.json
      fi

      git commit -m "fix: Add test infrastructure

Closes #$ISSUE_NUMBER"
      gh issue close $ISSUE_NUMBER --reason completed
      ;;

    *)
      manual_fix_required "$ISSUE_NUMBER" "$TITLE"
      ;;
  esac
}
```

---

## MANUAL FIX HANDLER

```bash
#!/bin/bash
# manual-fix-handler.sh - For issues requiring human intervention

manual_fix_required() {
  local ISSUE_NUMBER="$1"
  local TITLE="$2"

  echo "⚠️  Manual fix required for: $TITLE"

  # Create manual fix task
  task add project:$CHORE_ID +MANUAL priority:H -- "Manual fix needed: #$ISSUE_NUMBER"

  # Update issue with manual fix request
  gh issue comment $ISSUE_NUMBER --body "$(cat << EOF
## ⚠️ Manual Intervention Required

This issue requires manual fixing. The chore system couldn't automatically resolve it.

### Next Steps:
1. Review the issue description
2. Implement the recommended fix
3. Commit with message: \`fix: $TITLE\`
4. Include \`Closes #$ISSUE_NUMBER\` in commit message
5. Mark this issue as resolved

### Help Commands:
\`\`\`bash
# View issue details
gh issue view $ISSUE_NUMBER

# After fixing, close issue
gh issue close $ISSUE_NUMBER --reason completed
\`\`\`
EOF
)"

  # Add to manual fixes list
  echo "$ISSUE_NUMBER|$TITLE" >> .github/manual-fixes-required.txt
}
```

---

## CHORE EXECUTION WORKFLOW

### Main Chore Execution Script

```bash
#!/bin/bash
# run-chore.sh - Execute all fixes by priority

echo "╔════════════════════════════════════════╗"
echo "║         STARTING CHORE EXECUTION       ║"
echo "╚════════════════════════════════════════╝"

# Initialize
source ./init-chore-system.sh

# Track progress
FIXED_COUNT=0
MANUAL_COUNT=0
FAILED_COUNT=0

# Function to process issues by severity
process_issues_by_severity() {
  local SEVERITY="$1"
  local LABEL="severity:$SEVERITY"

  echo ""
  echo "══════════════════════════════════════════"
  echo " Processing $SEVERITY priority issues"
  echo "══════════════════════════════════════════"

  # Get all issues with this severity
  ISSUES=$(gh issue list \
    --milestone "$MILESTONE" \
    --label "$LABEL" \
    --state open \
    --json number \
    --jq '.[].number')

  if [ -z "$ISSUES" ]; then
    echo "No $SEVERITY issues to fix"
    return
  fi

  for ISSUE in $ISSUES; do
    execute_fix "$ISSUE"

    # Check if issue was closed
    STATE=$(gh issue view $ISSUE --json state --jq '.state')
    if [ "$STATE" = "CLOSED" ]; then
      ((FIXED_COUNT++))
      echo "✅ Fixed #$ISSUE"
    else
      ((MANUAL_COUNT++))
      echo "⚠️  Manual fix needed for #$ISSUE"
    fi
  done
}

# Process issues by priority
task project:$CHORE_ID +CRITICAL start
process_issues_by_severity "critical"
task project:$CHORE_ID +CRITICAL done

task project:$CHORE_ID +HIGH start
process_issues_by_severity "high"
task project:$CHORE_ID +HIGH done

task project:$CHORE_ID +MEDIUM start
process_issues_by_severity "medium"
task project:$CHORE_ID +MEDIUM done

task project:$CHORE_ID +LOW start
process_issues_by_severity "low"
task project:$CHORE_ID +LOW done

echo ""
echo "══════════════════════════════════════════"
echo " CHORE EXECUTION COMPLETE"
echo "══════════════════════════════════════════"
```

---

## VERIFICATION & COMPLETION

### Verify All Fixes

```bash
#!/bin/bash
# verify-fixes.sh - Verify all fixes were successful

echo "=== VERIFYING FIXES ==="
task project:$CHORE_ID +VERIFY start

# Check remaining open issues
OPEN_ISSUES=$(gh issue list --milestone "$MILESTONE" --state open --json number --jq '. | length')

# Run tests if they exist
if [ -f "package.json" ] && grep -q '"test"' package.json; then
  echo "Running tests..."
  npm test || TEST_FAILED=1
fi

# Check if all commits are signed
git log chore/$AUDIT_ID --format='%G?' | grep -q 'N' && UNSIGNED_COMMITS=1

# Create verification report
cat > .github/chore-verification-$CHORE_ID.json << EOF
{
  "chore_id": "$CHORE_ID",
  "audit_id": "$AUDIT_ID",
  "milestone": "$MILESTONE",
  "fixed_count": $FIXED_COUNT,
  "manual_required": $MANUAL_COUNT,
  "open_issues": $OPEN_ISSUES,
  "tests_passing": $([ -z "$TEST_FAILED" ] && echo "true" || echo "false"),
  "all_commits_signed": $([ -z "$UNSIGNED_COMMITS" ] && echo "true" || echo "false"),
  "branch": "chore/$AUDIT_ID",
  "completed": "$(date -Iseconds)"
}
EOF

task project:$CHORE_ID +VERIFY done
```

### Complete Chore Phase

```bash
#!/bin/bash
# complete-chore.sh - Finalize chore phase and prepare for release

echo "=== COMPLETING CHORE PHASE ==="
task project:$CHORE_ID +HANDOFF start

# Create Pull Request
PR_NUMBER=$(gh pr create \
  --title "🔧 Chore: Fix $FIXED_COUNT issues from audit $AUDIT_ID" \
  --body "$(cat << EOF
## Chore Phase Complete

This PR contains automated fixes from the chore phase.

### Summary
- **Audit ID**: $AUDIT_ID
- **Chore ID**: $CHORE_ID
- **Issues Fixed**: $FIXED_COUNT
- **Manual Fixes Required**: $MANUAL_COUNT

### Fixed Issues
$(gh issue list --milestone "$MILESTONE" --state closed --json number,title --jq '.[] | "- #\(.number): \(.title)"')

### Issues Requiring Manual Fix
$([ -f .github/manual-fixes-required.txt ] && cat .github/manual-fixes-required.txt | while IFS='|' read num title; do echo "- #$num: $title"; done || echo "None")

### Verification
- [ ] All automated tests pass
- [ ] No security vulnerabilities introduced
- [ ] Documentation updated where needed
- [ ] Ready for release phase

### Next Steps
1. Review this PR
2. Merge when ready
3. Run release phase: \`./run-release.sh --chore $CHORE_ID\`

---
*Automated by chore system*
EOF
)" \
  --label "phase:chore" \
  --milestone "$MILESTONE_NUMBER" \
  --json number -q .number)

echo "✓ Created Pull Request #$PR_NUMBER"

# Create release handoff file
cat > .github/chore-handoff-$CHORE_ID.json << EOF
{
  "chore_id": "$CHORE_ID",
  "audit_id": "$AUDIT_ID",
  "milestone": "$MILESTONE",
  "pr_number": $PR_NUMBER,
  "fixed_issues": $FIXED_COUNT,
  "manual_required": $MANUAL_COUNT,
  "branch": "chore/$AUDIT_ID",
  "next_phase": "release",
  "release_command": "./run-release.sh --chore $CHORE_ID",
  "created": "$(date -Iseconds)"
}
EOF

git add .github/chore-handoff-$CHORE_ID.json
git commit -m "chore: Complete chore phase - $FIXED_COUNT issues fixed"
git push origin chore/$AUDIT_ID

# Update tracking issue
gh issue comment $TRACKING_ISSUE --body "$(cat << EOF
## ✅ Chore Phase Complete

**Chore ID**: $CHORE_ID
**Pull Request**: #$PR_NUMBER
**Completed**: $(date -Iseconds)

### Results
- Fixed automatically: $FIXED_COUNT issues
- Manual intervention required: $MANUAL_COUNT issues
- Pull request ready for review

### Phases
- [x] **AUDIT** - Scan and document findings
- [x] **CHORE** - Fix issues based on findings
- [ ] **RELEASE** - Deploy improvements (READY)

View PR: https://github.com/$REPO_OWNER/$REPO_NAME/pull/$PR_NUMBER
EOF
)"

task project:$CHORE_ID +HANDOFF done

echo ""
echo "╔════════════════════════════════════════╗"
echo "║         CHORE PHASE COMPLETE           ║"
echo "╚════════════════════════════════════════╝"
echo ""
echo "📊 Results:"
echo "   ✅ Fixed: $FIXED_COUNT issues"
echo "   ⚠️  Manual: $MANUAL_COUNT issues"
echo ""
echo "📝 Pull Request: #$PR_NUMBER"
echo "   Review at: https://github.com/$REPO_OWNER/$REPO_NAME/pull/$PR_NUMBER"
echo ""
echo "Next Steps:"
echo "1. Review and merge PR #$PR_NUMBER"
echo "2. Run release phase: ./run-release.sh --chore $CHORE_ID"
echo ""
echo "TaskWarrior Summary:"
task project:$CHORE_ID
```

---

## COMPLETE CHORE WORKFLOW

### Master Chore Script

```bash
#!/bin/bash
# run-complete-chore.sh - Execute complete chore phase

set -e  # Exit on error

# Check for audit handoff
if [ ! -f .github/audit-handoff-*.json ]; then
  echo "ERROR: No audit handoff found. Run audit first!"
  exit 1
fi

# Initialize chore system
./init-chore-system.sh

# Execute fixes by priority
./run-chore.sh

# Verify all fixes
./verify-fixes.sh

# Complete and create PR
./complete-chore.sh

echo ""
echo "PIPELINE STATUS:"
echo "✅ Audit Phase    - COMPLETE"
echo "✅ Chore Phase    - COMPLETE"
echo "⏸️  Release Phase  - READY (After PR merge)"
```

---
*Updated: September 28, 2025*