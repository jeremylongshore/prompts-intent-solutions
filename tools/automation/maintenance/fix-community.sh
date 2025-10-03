#!/bin/bash
# fix-community.sh - Automated community and repository health fixes

fix_community_issue() {
  local ISSUE_NUMBER="$1"
  local TITLE="$2"

  case "$TITLE" in
    *"issue templates"* | *"ISSUE_TEMPLATE"*)
      echo "→ Creating issue templates..."
      mkdir -p .github/ISSUE_TEMPLATE

      cat > .github/ISSUE_TEMPLATE/bug_report.yml << 'EOF'
name: Bug Report
description: File a bug report
title: "[Bug]: "
labels: ["bug", "triage"]
body:
  - type: markdown
    attributes:
      value: |
        Thanks for taking the time to fill out this bug report!
  - type: input
    id: contact
    attributes:
      label: Contact Details
      description: How can we get in touch with you if we need more info?
      placeholder: ex. email@example.com
    validations:
      required: false
  - type: textarea
    id: what-happened
    attributes:
      label: What happened?
      description: Also tell us, what did you expect to happen?
      placeholder: Tell us what you see!
    validations:
      required: true
  - type: dropdown
    id: version
    attributes:
      label: Version
      description: What version are you running?
      options:
        - Latest
        - 1.0.0
        - Other
    validations:
      required: true
EOF

      cat > .github/ISSUE_TEMPLATE/feature_request.yml << 'EOF'
name: Feature Request
description: Suggest an idea for this project
title: "[Feature]: "
labels: ["enhancement"]
body:
  - type: markdown
    attributes:
      value: |
        Thanks for suggesting a new feature!
  - type: textarea
    id: feature-description
    attributes:
      label: Feature Description
      description: A clear and concise description of what you want to happen.
    validations:
      required: true
  - type: textarea
    id: alternatives
    attributes:
      label: Alternatives
      description: A clear and concise description of any alternative solutions you've considered.
    validations:
      required: false
EOF

      git add .github/ISSUE_TEMPLATE/
      git commit -m "fix: Add issue templates

Closes #$ISSUE_NUMBER"
      gh issue close $ISSUE_NUMBER --reason completed >/dev/null 2>&1
      return 0
      ;;

    *"pull request template"* | *"PR template"*)
      echo "→ Creating pull request template..."
      mkdir -p .github
      cat > .github/pull_request_template.md << 'EOF'
# Pull Request

## Description
Brief description of changes

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## Testing
- [ ] Tests pass locally
- [ ] New tests added (if applicable)
- [ ] Manual testing completed

## Checklist
- [ ] Code follows the style guidelines
- [ ] Self-review completed
- [ ] Documentation updated (if needed)
- [ ] No merge conflicts
EOF
      git add .github/pull_request_template.md
      git commit -m "fix: Add pull request template

Closes #$ISSUE_NUMBER"
      gh issue close $ISSUE_NUMBER --reason completed >/dev/null 2>&1
      return 0
      ;;

    *"discussion"* | *"discussions"*)
      echo "→ Enabling GitHub Discussions..."
      gh api --method PATCH \
        repos/$REPO_OWNER/$REPO_NAME \
        --field has_discussions=true >/dev/null 2>&1

      gh issue comment $ISSUE_NUMBER --body "✅ GitHub Discussions enabled" >/dev/null 2>&1
      gh issue close $ISSUE_NUMBER --reason completed >/dev/null 2>&1
      git commit --allow-empty -m "fix: Enable GitHub Discussions

Closes #$ISSUE_NUMBER"
      return 0
      ;;

    *"wiki"*)
      echo "→ Enabling GitHub Wiki..."
      gh api --method PATCH \
        repos/$REPO_OWNER/$REPO_NAME \
        --field has_wiki=true >/dev/null 2>&1

      gh issue comment $ISSUE_NUMBER --body "✅ GitHub Wiki enabled" >/dev/null 2>&1
      gh issue close $ISSUE_NUMBER --reason completed >/dev/null 2>&1
      git commit --allow-empty -m "fix: Enable GitHub Wiki

Closes #$ISSUE_NUMBER"
      return 0
      ;;

    *"sponsor"* | *"funding"*)
      echo "→ Adding funding configuration..."
      mkdir -p .github
      cat > .github/FUNDING.yml << 'EOF'
# These are supported funding model platforms

github: # Replace with up to 4 GitHub Sponsors-enabled usernames e.g., [user1, user2]
patreon: # Replace with a single Patreon username
open_collective: # Replace with a single Open Collective username
ko_fi: # Replace with a single Ko-fi username
tidelift: # Replace with a single Tidelift platform-name/package-name e.g., npm/babel
community_bridge: # Replace with a single Community Bridge project-name e.g., cloud-foundry
liberapay: # Replace with a single Liberapay username
issuehunt: # Replace with a single IssueHunt username
otechie: # Replace with a single Otechie username
lfx_crowdfunding: # Replace with a single LFX Crowdfunding project-name e.g., cloud-foundry
custom: # Replace with up to 4 custom sponsorship URLs e.g., ['link1', 'link2']
EOF
      git add .github/FUNDING.yml
      git commit -m "fix: Add funding configuration

Closes #$ISSUE_NUMBER"
      gh issue close $ISSUE_NUMBER --reason completed >/dev/null 2>&1
      return 0
      ;;

    *"description"* | *"repository description"*)
      echo "→ Adding repository description..."
      # Get current description
      CURRENT_DESC=$(gh repo view --json description -q .description)
      if [ "$CURRENT_DESC" = "null" ] || [ -z "$CURRENT_DESC" ]; then
        # Determine description based on repository contents
        if [ -f "package.json" ]; then
          DESC=$(jq -r '.description // "A JavaScript/Node.js project"' package.json)
        elif [ -f "pyproject.toml" ]; then
          DESC="A Python project"
        elif [ -f "Cargo.toml" ]; then
          DESC="A Rust project"
        elif [ -f "go.mod" ]; then
          DESC="A Go project"
        else
          DESC="An open source project"
        fi

        gh repo edit --description "$DESC" >/dev/null 2>&1
        gh issue comment $ISSUE_NUMBER --body "✅ Added repository description: $DESC" >/dev/null 2>&1
      fi

      gh issue close $ISSUE_NUMBER --reason completed >/dev/null 2>&1
      git commit --allow-empty -m "fix: Add repository description

Closes #$ISSUE_NUMBER"
      return 0
      ;;

    *"topics"* | *"repository topics"*)
      echo "→ Adding repository topics..."
      # Determine topics based on repository contents
      TOPICS=()

      if [ -f "package.json" ]; then
        TOPICS+=("javascript" "nodejs")
      fi
      if [ -f "pyproject.toml" ] || [ -f "setup.py" ]; then
        TOPICS+=("python")
      fi
      if [ -f "Cargo.toml" ]; then
        TOPICS+=("rust")
      fi
      if [ -f "go.mod" ]; then
        TOPICS+=("go" "golang")
      fi
      if [ -d ".github/workflows" ]; then
        TOPICS+=("github-actions" "ci-cd")
      fi
      if [ -f "Dockerfile" ]; then
        TOPICS+=("docker")
      fi
      if [ -f "README.md" ]; then
        TOPICS+=("documentation")
      fi

      # Add default topics if none found
      if [ ${#TOPICS[@]} -eq 0 ]; then
        TOPICS=("open-source")
      fi

      # Convert array to comma-separated string
      TOPICS_STR=$(IFS=','; echo "${TOPICS[*]}")

      gh repo edit --add-topic "${TOPICS[@]}" >/dev/null 2>&1
      gh issue comment $ISSUE_NUMBER --body "✅ Added topics: ${TOPICS_STR}" >/dev/null 2>&1
      gh issue close $ISSUE_NUMBER --reason completed >/dev/null 2>&1
      git commit --allow-empty -m "fix: Add repository topics

Closes #$ISSUE_NUMBER"
      return 0
      ;;

    *)
      manual_fix_required "$ISSUE_NUMBER" "$TITLE"
      return 1
      ;;
  esac
}