---
name: install-release-workflow-all-repos
description: Mega prompt to discover all repos, install standardized release workflow, create PRs, and generate CSV summary
model: opus
date: 2025-10-08
---

# MEGA PROMPT — Install Full Release Workflow In All Repos

**Purpose:** Use this mega prompt in Claude Code to install the full release workflow into every repo you own/manage. It discovers repos, writes the YAML, commits via PR by default, and prints a CSV summary.

---

## OVERVIEW

You are Claude Code in a shell with `git`, `gh`, `jq`. Perform the steps exactly. Stop on error. Print terse logs.

---

## INPUTS

### Configuration Variables

```bash
# Orgs to scan
ORGS=("your-org-1" "your-org-2")

# Optional explicit repos owner/name to add
EXTRA_REPOS=("owner/repo1" "owner/repo2")

# Filters
INCLUDE_REGEX=".*"                      # e.g., "diagnostic|hustle"
EXCLUDE_REGEX="(archive|deprecated)"

# Behavior
OVERWRITE_EXISTING="false"              # "true" to replace existing workflow
CREATE_PR="true"                        # "false" to commit directly to default branch
PR_BRANCH="automation/add-release-workflow"
COMMIT_MESSAGE="chore: add global release workflow"
PR_TITLE="Add global release workflow"
PR_BODY="Installs standardized .github/workflows/release.yml."

# Auth and identity
git config user.name  "release-bot"
git config user.email "release-bot@users.noreply.github.com"
gh auth status
```

---

## REPO DISCOVERY

```bash
set -euo pipefail
ROOT="$(pwd)/_install-release-workflow"; rm -rf "$ROOT"; mkdir -p "$ROOT"; cd "$ROOT"

> repos.txt
for ORG in "${ORGS[@]}"; do
  gh repo list "$ORG" --limit 1000 --json name,owner,isArchived,isFork,isDisabled \
  | jq -r '.[] | select(.isArchived==false and .isFork==false and .isDisabled==false)
            | "\(.owner.login)/\(.name)"' >> repos.txt
done
for R in "${EXTRA_REPOS[@]}"; do echo "$R" >> repos.txt; done

sort -u repos.txt | grep -E "$INCLUDE_REGEX" | grep -Ev "$EXCLUDE_REGEX" > targets.txt
echo "Targets:"; nl -ba targets.txt
```

---

## WORKFLOW CONTENT TO INSTALL

```bash
WORKFLOW_PATH=".github/workflows/release.yml"
WORKFLOW_CONTENT='
name: Release

on:
  workflow_dispatch:
    inputs:
      bump:
        description: "major | minor | patch | auto"
        default: "auto"
        required: true
      dry_run:
        description: "Do everything except tag/release/publish"
        type: boolean
        default: false
  push:
    paths:
      - ".github/RELEASE_TRIGGER"

permissions:
  contents: write
  issues: write
  discussions: write

concurrency:
  group: release-${{ github.ref }}
  cancel-in-progress: false

jobs:
  release:
    runs-on: ubuntu-latest
    env:
      GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Git identity
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

      - name: Verify readiness
        run: |
          test -z "$(git status --porcelain)" || { echo "Uncommitted changes found"; exit 1; }
          if [ -f package.json ] && jq -e ".scripts.test" package.json >/dev/null; then
            npm ci
            npm test
          fi
          echo "Security scan optional; wire in your tool if needed."

      - name: Determine previous tag
        id: prev
        run: |
          PREV_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
          echo "prev=$PREV_TAG" >> $GITHUB_OUTPUT

      - name: Decide bump
        id: bump
        run: |
          INPUT="${{ github.event.inputs.bump || '' }}"
          if [ "$INPUT" != "" ] && [ "$INPUT" != "auto" ]; then
            echo "type=$INPUT" >> $GITHUB_OUTPUT
            exit 0
          fi
          RANGE="${{ steps.prev.outputs.prev }}..HEAD"
          BRK=$(git log --pretty=%B $RANGE | grep -ciE "BREAKING CHANGE" || true)
          FEAT=$(git log --pretty=%s $RANGE | grep -ciE "^feat(\(|: )" || true)
          if [ "$BRK" -gt 0 ]; then T=major
          elif [ "$FEAT" -gt 0 ]; then T=minor
          else T=patch
          fi
          echo "type=$T" >> $GITHUB_OUTPUT

      - name: Compute next version
        id: ver
        run: |
          PREV="${{ steps.prev.outputs.prev }}"
          PREV="${PREV#v}"
          IFS=. read -r MA MI PA <<EOF
          $PREV
          EOF
          case "${{ steps.bump.outputs.type }}" in
            major) MA=$((MA+1)); MI=0; PA=0 ;;
            minor) MI=$((MI+1)); PA=0 ;;
            patch) PA=$((PA+1)) ;;
            *) echo "Invalid bump"; exit 1 ;;
          esac
          NEW="$MA.$MI.$PA"
          echo "new=$NEW" >> $GITHUB_OUTPUT
          echo "tag=v$NEW" >> $GITHUB_OUTPUT

      - name: Update version files
        run: |
          set -e
          NEW="${{ steps.ver.outputs.new }}"
          touched=0
          if [ -f package.json ]; then
            jq --arg v "$NEW" ".version=\$v" package.json > package.tmp && mv package.tmp package.json
            if [ -f package-lock.json ]; then npm i --package-lock-only >/dev/null 2>&1 || true; fi
            touched=1
          fi
          if [ -f version.txt ]; then echo "$NEW" > version.txt; touched=1; fi
          if [ "$touched" -eq 0 ]; then echo "$NEW" > version.txt; fi
          git add -A
          git commit -m "chore: release v$NEW" || echo "No content change"

      - name: Generate changelog entry
        id: clog
        run: |
          set -e
          NEW="${{ steps.ver.outputs.new }}"
          PREV="${{ steps.prev.outputs.prev }}"
          DATE=$(date +%Y-%m-%d)
          NOTES=$(mktemp)
          {
            echo "# Release v$NEW"
            echo
            echo "**Release Date**: $DATE"
            echo
            echo "## Changes since $PREV"
            echo
            git log --pretty="- %s (%h)" "$PREV"..HEAD
          } > "$NOTES"
          if [ -f CHANGELOG.md ]; then
            tmp=$(mktemp)
            cat "$NOTES" > "$tmp"
            echo -e "\n---\n" >> "$tmp"
            cat CHANGELOG.md >> "$tmp"
            mv "$tmp" CHANGELOG.md
          else
            cp "$NOTES" CHANGELOG.md
          fi
          git add CHANGELOG.md
          git commit -m "docs: update changelog for v$NEW" || echo "No changelog delta"
          echo "notes=$NOTES" >> $GITHUB_OUTPUT

      - name: Sync README version references
        run: |
          NEW="${{ steps.ver.outputs.new }}"
          [ -f README.md ] && sed -i "s/\\bv[0-9]\\+\\.[0-9]\\+\\.[0-9]\\+\\b/v$NEW/g" README.md || true
          git add README.md 2>/dev/null || true
          git commit -m "docs: README version sync v$NEW" || echo "No README delta"

      - name: Create tag and push
        if: ${{ github.event.inputs.dry_run != '"'"'true'"'"' }}
        run: |
          TAG="${{ steps.ver.outputs.tag }}"
          git tag -a "$TAG" -m "Release $TAG"
          git push origin "$TAG"
          git push origin HEAD

      - name: Create GitHub Release
        if: ${{ github.event.inputs.dry_run != '"'"'true'"'"' }}
        run: |
          TAG="${{ steps.ver.outputs.tag }}"
          gh release create "$TAG" \
            --title "$TAG" \
            --notes-file "${{ steps.clog.outputs.notes }}"
'
```

---

## INSTALL ACROSS REPOS

```bash
echo "repo,status,branch,commit_or_pr" > summary.csv

while read -r FULL; do
  echo "==> $FULL"
  OWNER="${FULL%/*}"; NAME="${FULL#*/}"
  DEF_BRANCH=$(gh repo view "$FULL" --json defaultBranchRef -q .defaultBranchRef.name)
  CLONE_DIR="$ROOT/$NAME"
  rm -rf "$CLONE_DIR"
  gh repo clone "$FULL" "$CLONE_DIR" -- -q
  cd "$CLONE_DIR"

  # Check existing
  if [ -f "$WORKFLOW_PATH" ] && [ "$OVERWRITE_EXISTING" != "true" ]; then
    echo "$FULL,skipped-exists,$DEF_BRANCH," >> "$ROOT/summary.csv"
    cd "$ROOT"; continue
  fi

  # Ensure path and write file
  mkdir -p ".github/workflows"
  printf "%s\n" "$WORKFLOW_CONTENT" > "$WORKFLOW_PATH"

  if [ "$CREATE_PR" = "true" ]; then
    git checkout -B "$PR_BRANCH"
    git add "$WORKFLOW_PATH"
    git commit -m "$COMMIT_MESSAGE" || true
    git push -u origin "$PR_BRANCH" || { echo "$FULL,failed-push,$PR_BRANCH," >> "$ROOT/summary.csv"; cd "$ROOT"; continue; }
    PR_URL=$(gh pr create --base "$DEF_BRANCH" --title "$PR_TITLE" --body "$PR_BODY" --fill -R "$FULL" -q .url)
    echo "$FULL,pr-opened,$DEF_BRANCH,$PR_URL" >> "$ROOT/summary.csv"
  else
    git checkout "$DEF_BRANCH" 2>/dev/null || git checkout -B "$DEF_BRANCH"
    git add "$WORKFLOW_PATH"
    git commit -m "$COMMIT_MESSAGE" || true
    COMMIT_SHA=$(git rev-parse --short HEAD)
    git push origin "HEAD:$DEF_BRANCH" || { echo "$FULL,failed-push,$DEF_BRANCH," >> "$ROOT/summary.csv"; cd "$ROOT"; continue; }
    echo "$FULL,committed,$DEF_BRANCH,$COMMIT_SHA" >> "$ROOT/summary.csv"
  fi

  cd "$ROOT"
done < targets.txt

column -s, -t summary.csv | sed 1q; column -s, -t summary.csv
```

---

## USAGE

1. **Set configuration**:
   - Update `ORGS` array with your GitHub organizations
   - Optionally add `EXTRA_REPOS` for specific repositories
   - Adjust `INCLUDE_REGEX` and `EXCLUDE_REGEX` filters
   - Set `CREATE_PR="true"` for PR-based installation (recommended)

2. **Run the prompt**: Copy and paste the entire workflow into Claude Code

3. **Review results**: Check the CSV summary for:
   - `pr-opened` - PR created successfully
   - `committed` - Direct commit to default branch
   - `skipped-exists` - Workflow already exists
   - `failed-push` - Push failed (check permissions)

4. **Merge PRs**: Review and merge the created PRs

5. **Activate workflow**: The workflow runs via:
   - **Manual trigger**: GitHub Actions → "Run workflow" button
   - **Automatic trigger**: Commit `.github/RELEASE_TRIGGER` file

---

## WORKFLOW FEATURES

### Automatic Version Bumping
- **Auto-detect**: Scans commits for `BREAKING CHANGE` (major), `feat:` (minor), or defaults to patch
- **Manual override**: Select bump type via workflow dispatch input

### Smart Changelog Generation
- **Automatic**: Generates changelog from commit history since last tag
- **Format**: Newest entries on top (reverse chronological)
- **Preserves existing**: Prepends to existing CHANGELOG.md

### Version File Updates
- **package.json**: Updates version field and regenerates package-lock.json
- **version.txt**: Updates or creates version file
- **README.md**: Auto-updates version references

### Safety Features
- **Dry run mode**: Test without creating tags or releases
- **Concurrency control**: Prevents simultaneous releases
- **Test validation**: Runs tests before releasing (if configured)
- **Clean state check**: Ensures no uncommitted changes

---

## EXAMPLE OUTPUT

```
Targets:
     1  jeremylongshore/prompts-intent-solutions
     2  jeremylongshore/bobs-brain
     3  jeremylongshore/diagnostic-platform

==> jeremylongshore/prompts-intent-solutions
==> jeremylongshore/bobs-brain
==> jeremylongshore/diagnostic-platform

repo                                          status         branch  commit_or_pr
jeremylongshore/prompts-intent-solutions      pr-opened      main    https://github.com/jeremylongshore/prompts-intent-solutions/pull/42
jeremylongshore/bobs-brain                    pr-opened      main    https://github.com/jeremylongshore/bobs-brain/pull/15
jeremylongshore/diagnostic-platform           pr-opened      main    https://github.com/jeremylongshore/diagnostic-platform/pull/8
```

---

## CUSTOMIZATION

### Add NPM Publishing

```yaml
- name: Publish to NPM
  if: ${{ github.event.inputs.dry_run != 'true' }}
  run: npm publish
  env:
    NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }}
```

### Add Docker Publishing

```yaml
- name: Build and Push Docker Image
  if: ${{ github.event.inputs.dry_run != 'true' }}
  run: |
    VERSION="${{ steps.ver.outputs.new }}"
    docker build -t myorg/myapp:$VERSION .
    docker push myorg/myapp:$VERSION
    docker tag myorg/myapp:$VERSION myorg/myapp:latest
    docker push myorg/myapp:latest
  env:
    DOCKER_USERNAME: ${{ secrets.DOCKER_USERNAME }}
    DOCKER_PASSWORD: ${{ secrets.DOCKER_PASSWORD }}
```

### Add Deployment Step

```yaml
- name: Deploy to Production
  if: ${{ github.event.inputs.dry_run != 'true' }}
  run: |
    # Your deployment commands here
    ./scripts/deploy.sh production
  env:
    DEPLOY_KEY: ${{ secrets.DEPLOY_KEY }}
```

---

## TROUBLESHOOTING

### Permission Errors
- Ensure `gh auth status` shows authentication
- Check repo write permissions
- Verify `GITHUB_TOKEN` has required scopes

### Workflow Not Appearing
- Check `.github/workflows/release.yml` exists
- Verify YAML syntax is valid
- Refresh GitHub Actions page

### Version Bump Not Working
- Check commit message format follows conventional commits
- Verify `git describe --tags` returns previous version
- Manually specify bump type via workflow input

### Dry Run Testing
- Always test with `dry_run: true` first
- Verify changelog and version updates look correct
- Check no tags/releases created in dry run mode

---

**Master Location:** `~/projects/prompts-intent-solutions/000-master-systems/github/002-aut-install-release-workflow-all-repos.md`

**Related Documents:**
- Release workflow: `001-rel-master-repo-release.md`
- Repository audit: `001-aud-master-repo-audit.md`

---

*INSTALL RELEASE WORKFLOW – Automated Multi-Repo Deployment*
