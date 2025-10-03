---
name: master-github-operating-instructions
description: Complete operating manual for the GitHub repository automation pipeline (Audit → Chore → Release)
model: opus
date: 2025-09-28
---

# Complete Operating Instructions
## GitHub Repository Automation Pipeline (Audit → Chore → Release)

---

## 🚀 QUICK START (TL;DR)

```bash
# One-time setup
gh auth login
brew install task
git clone your-repo && cd your-repo

# Run the pipeline (monthly)
./run-complete-audit.sh     # Day 1: Find issues
# Review issues in GitHub
./run-complete-chore.sh     # Day 2: Fix issues
# Review and merge PR
./run-complete-release.sh   # Day 3: Ship fixes
```

---

## 📋 PREREQUISITES

### Required Tools
```bash
# 1. GitHub CLI (required)
brew install gh             # Mac
sudo apt install gh         # Linux
gh auth login              # Authenticate once

# 2. TaskWarrior (required)
brew install task          # Mac
sudo apt install taskwarrior # Linux

# 3. jq (required for JSON parsing)
brew install jq            # Mac
sudo apt install jq        # Linux

# 4. Git (obviously)
git --version              # Should be 2.0+
```

### Repository Setup
```bash
# Navigate to your repository
cd /path/to/your-repo

# Ensure you're on main branch
git checkout main
git pull origin main

# Create scripts directory
mkdir -p .github/scripts
cd .github/scripts
```

---

## 📝 INITIAL SETUP

### Step 1: Create the Script Files

Give this prompt to Claude/ChatGPT:

> **PROMPT FOR LLM:**
> "I need you to create bash script files for the GitHub automation pipeline. For each script in the audit, chore, and release phases, create the complete executable file with all functions. Start with these core scripts:
>
> 1. init-audit-system.sh
> 2. run-complete-audit.sh
> 3. init-chore-system.sh
> 4. run-complete-chore.sh
> 5. init-release-system.sh
> 6. run-complete-release.sh
>
> Make each script executable with proper error handling and clear output messages."

### Step 2: Make Scripts Executable
```bash
# After creating all scripts
chmod +x *.sh

# Verify scripts are ready
ls -la *.sh
```

### Step 3: Configure Repository Settings
```bash
# Enable required GitHub features
gh repo edit --enable-issues --enable-wiki
gh repo edit --enable-discussions  # Optional

# Create labels if they don't exist
for label in "audit:security" "audit:docs" "audit:code" "audit:infra" \
             "severity:critical" "severity:high" "severity:medium" "severity:low" \
             "phase:audit" "phase:chore" "phase:release"; do
  gh label create "$label" || true
done
```

---

## 🔍 PHASE 1: AUDIT

### When to Run
- Monthly (recommended)
- After major changes
- Before major releases
- When onboarding new team members

### How to Run
```bash
# Start the audit
./run-complete-audit.sh

# What happens:
# 1. Creates GitHub milestone "Audit-YYYYMMDD"
# 2. Scans repository for issues
# 3. Creates GitHub issue for each finding
# 4. Generates audit summary
# 5. Creates handoff file for chore phase
```

### What to Review
After audit completes, review findings:
```bash
# View all findings
gh issue list --milestone "Audit-$(date +%Y%m%d)"

# View critical issues only
gh issue list --milestone "Audit-$(date +%Y%m%d)" --label "severity:critical"

# View audit summary (pinned issue)
gh issue list --label "audit-summary" --limit 1
```

### Decision Points
- **Critical issues found?** → Fix manually before proceeding
- **Too many issues?** → Prioritize and defer low priority
- **Unclear findings?** → Add comments to issues for clarity

### Supplemental LLM Prompts

> **PROMPT: Custom Audit Checks**
> "I need to add custom audit checks for [SPECIFIC NEED]. Create a bash script function that:
> 1. Checks for [CONDITION]
> 2. Uses the log_finding function to create GitHub issues
> 3. Integrates with the existing audit framework
>
> Context: [Describe your specific requirements]"

> **PROMPT: Audit Analysis**
> "Here are my audit findings: [PASTE ISSUE LIST]
>
> Please:
> 1. Group them by risk level
> 2. Identify quick wins vs long-term fixes
> 3. Suggest priority order for fixing
> 4. Estimate total effort required"

---

## 🔧 PHASE 2: CHORE

### Prerequisites
- Audit phase must be complete
- Review audit findings in GitHub
- Ensure you have necessary permissions

### How to Run
```bash
# Start automated fixes
./run-complete-chore.sh

# What happens:
# 1. Reads audit milestone
# 2. Processes issues by severity (critical → low)
# 3. Attempts automated fixes
# 4. Creates PR with all changes
# 5. Flags issues needing manual work
```

### Manual Intervention Required
Some issues can't be automatically fixed. When you see:
```
⚠️ Manual fix required for: #123
```

Do this:
```bash
# View the issue
gh issue view 123

# Fix manually, then commit
git add [fixed-files]
git commit -m "fix: [description]

Closes #123"

# Continue chore process
./run-complete-chore.sh --continue
```

### Review the Pull Request
```bash
# View the PR
gh pr view

# Review changes locally
gh pr checkout [PR-NUMBER]
git diff main...HEAD

# If satisfied, merge
gh pr merge --merge
```

### Supplemental LLM Prompts

> **PROMPT: Custom Fix Handler**
> "I have a GitHub issue that needs automated fixing:
> Issue: [PASTE ISSUE CONTENT]
>
> Create a bash function for fix-[category].sh that:
> 1. Detects this specific issue type
> 2. Implements the fix automatically
> 3. Commits with proper message
> 4. Closes the issue
>
> The fix should follow the existing pattern in the chore system."

> **PROMPT: Complex Manual Fix**
> "I need to manually fix issue #[NUMBER] which says: [ISSUE DESCRIPTION]
>
> Provide:
> 1. Step-by-step commands to implement the fix
> 2. Tests to verify the fix works
> 3. Commit message following Conventional Commits
> 4. Any configuration files needed"

---

## 🚀 PHASE 3: RELEASE

### Prerequisites
- Chore PR must be merged
- All critical issues resolved
- Tests passing on main branch

### How to Run
```bash
# Start release process
./run-complete-release.sh

# What happens:
# 1. Verifies PR is merged
# 2. Bumps version (major/minor/patch)
# 3. Generates changelog
# 4. Creates GitHub release
# 5. Deploys (if configured)
# 6. Archives audit artifacts
# 7. Schedules next audit
```

### Deployment Configuration
Before first release, configure deployment:

```bash
# For NPM packages
npm init -y
npm config set registry https://registry.npmjs.org/
npm login

# For Docker
docker login
echo "DOCKER_REPO=your-docker-hub-username/repo-name" >> .env

# For GitHub Pages
gh repo edit --enable-pages
```

### Release Verification
```bash
# Verify release was created
gh release list --limit 1

# View release notes
gh release view

# Check deployment status
gh workflow view deploy --log  # If using GitHub Actions
```

### Supplemental LLM Prompts

> **PROMPT: Custom Deployment**
> "My repository is a [TYPE: Node.js app/Python package/Docker service/etc].
>
> Create deployment commands for deploy-release.sh that:
> 1. Build production artifacts
> 2. Run deployment tests
> 3. Deploy to [PLATFORM: AWS/Azure/Heroku/etc]
> 4. Verify deployment success
> 5. Rollback on failure"

> **PROMPT: Release Notes Enhancement**
> "Here are the issues fixed in this release: [PASTE ISSUE LIST]
>
> Write professional release notes that:
> 1. Highlight the most important changes
> 2. Group by user impact (not technical categories)
> 3. Include migration instructions if needed
> 4. Thank contributors appropriately"

---

## 📊 MONITORING & METRICS

### View Pipeline Status
```bash
# Current audit status
task project:audit-$(date +%Y%m%d)

# Chore progress
task project:chore-* burndown

# Overall metrics
task summary
task stats
```

### Generate Reports

> **PROMPT: Executive Summary**
> "Generate an executive summary from this pipeline data:
> - Audit findings: [COUNT]
> - Fixed automatically: [COUNT]
> - Manual fixes: [COUNT]
> - Time taken: [HOURS]
> - Version released: [VERSION]
>
> Format for non-technical stakeholders."

### Track Improvement Over Time
```bash
# View historical audits
ls -la .github/audits/

# Compare audit results
for dir in .github/audits/*/; do
  echo "Audit: $(basename $dir)"
  jq '.issues_fixed, .manual_required' "$dir/summary.json"
done
```

---

## 🔥 TROUBLESHOOTING

### Common Issues and Fixes

#### 1. "No audit handoff file found"
```bash
# Check if audit was completed
ls -la .github/audit-handoff-*.json

# If missing, re-run audit
./run-complete-audit.sh
```

#### 2. "PR not merged" error
```bash
# Check PR status
gh pr list

# Merge the PR
gh pr merge [PR-NUMBER] --merge
```

#### 3. "Tests failing"
```bash
# Skip tests temporarily (not recommended)
SKIP_TESTS=true ./run-complete-release.sh

# Or fix tests first
npm test  # See what's failing
# Fix issues
git add . && git commit -m "fix: test issues"
```

#### 4. TaskWarrior issues
```bash
# Reset TaskWarrior if needed
task rc.confirmation:no delete project:audit-$(date +%Y%m%d)
task rc.confirmation:no delete project:chore-*
```

### Debug Mode
```bash
# Run any script in debug mode
bash -x ./run-complete-audit.sh

# Or add to script
set -x  # Enable debug
set +x  # Disable debug
```

### Supplemental Debug Prompts

> **PROMPT: Debug Script Error**
> "My script is failing with this error: [PASTE ERROR]
>
> The script section is: [PASTE RELEVANT CODE]
>
> Please:
> 1. Explain what's wrong
> 2. Provide the corrected code
> 3. Add error handling to prevent future issues"

---

## ⚡ ADVANCED USAGE

### Scheduled Automation
```bash
# Add to crontab for monthly runs
crontab -e

# Add this line (runs 1st of each month at 2 AM)
0 2 1 * * cd /path/to/repo && ./run-complete-audit.sh
```

### Partial Runs
```bash
# Run only specific severity
SEVERITY_FILTER="critical" ./run-complete-chore.sh

# Run only specific category
CATEGORY_FILTER="security" ./run-complete-audit.sh

# Dry run (no changes)
DRY_RUN=true ./run-complete-chore.sh
```

### Custom Workflows

> **PROMPT: Custom Pipeline**
> "I want to modify the pipeline to:
> - [CUSTOM REQUIREMENT 1]
> - [CUSTOM REQUIREMENT 2]
>
> Create modified versions of the relevant scripts that implement these changes while maintaining compatibility with the rest of the pipeline."

### Integration with CI/CD
```yaml
# .github/workflows/monthly-audit.yml
name: Monthly Audit
on:
  schedule:
    - cron: '0 0 1 * *'
  workflow_dispatch:

jobs:
  audit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup tools
        run: |
          sudo apt-get update
          sudo apt-get install -y taskwarrior jq
      - name: Run audit
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          ./run-complete-audit.sh
```

---

## 📚 REFERENCE

### Environment Variables
```bash
# Optional configuration
export AUDIT_SCOPE="full"           # full|security|docs|code
export FIX_STRATEGY="aggressive"    # aggressive|conservative
export RELEASE_TYPE="production"    # production|staging|development
export SKIP_TESTS="false"          # true|false
export DRY_RUN="false"             # true|false
```

### File Structure Created
```
.github/
├── scripts/                 # All pipeline scripts
│   ├── run-complete-audit.sh
│   ├── run-complete-chore.sh
│   └── run-complete-release.sh
├── audits/                  # Archived audit results
│   └── audit-YYYYMMDD/
│       ├── summary.json
│       ├── tasks-*.json
│       └── handoff files
├── audit-handoff-*.json    # Current audit → chore
├── chore-handoff-*.json    # Current chore → release
└── manual-fixes-required.txt
```

### Key Commands Reference
```bash
# GitHub CLI
gh issue list --milestone "Audit-YYYYMMDD"
gh pr view
gh pr merge
gh release create

# TaskWarrior
task project:audit-YYYYMMDD
task burndown
task summary
```

---
*Updated: September 28, 2025*