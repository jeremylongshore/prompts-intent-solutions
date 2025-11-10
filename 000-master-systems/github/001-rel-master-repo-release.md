---
name: master-github-repo-release
description: Complete GitHub release system that validates fixes, bumps version, generates changelog, tags, creates release, and deploys with synced documentation
model: opus
date: 2025-10-08
---

# GitHub Repository Release System

**Phase: Release Pipeline**

---

## RELEASE WORKFLOW

### 1. Verification
- **Confirm all critical and high issues** for the milestone are closed
- **Run test suite and security scans** to ensure quality
- **Ensure no uncommitted changes** remain in the repository

### 2. Version Management
- **Determine bump type** (major, minor, patch) based on merged changes
- **Increment version number** to next sequential release
- **Commit updated version file(s)** (package.json, version.txt, etc.)

### 3. Changelog Generation
- **Build changelog entry** for the new version with:
  - Release date
  - Audit ID or milestone reference
  - Categories: security, documentation, infrastructure, code quality, community
  - Metrics: number of fixes, manual fixes, critical issues closed
- **Update CHANGELOG.md** (prepend new entry at top - newest first)
- **Commit changelog update**

### 4. README & Documentation Sync
- **Cross-check README.md, docs site, and reference files** for version references
- **Update as needed** to reflect the new release
- **Commit updated documentation**

### 5. Tag & Release
- **Create annotated Git tag** `vX.Y.Z` with release notes from changelog
- **Push tag to repository**
- **Create GitHub release** with title, notes, and linked milestone

### 6. Deployment
- **Trigger deployment** based on repository type:
  - NPM publish if public package
  - Docker build and push if container
  - GitHub Actions deploy workflow if defined
  - Update documentation site if docs/ directory exists

### 7. Announcement
- **Open a release announcement issue** summarizing highlights
- **Pin announcement**
- **Optionally create a discussion post** in "Announcements" category

### 8. Archive & Schedule
- **Archive audit/milestone artifacts** under `.github/audits/`
- **Commit archive to repo**
- **Schedule next audit** with new GitHub issue

---

## GUARANTEES

- **Sequential correctness**: Version bump and tag always follow previous release in proper semantic order
- **Consistency**: All references (README, changelog, docs, release notes) match the current release number
- **Audit trail**: Every release includes archived artifacts and linked milestone closure
- **Automation ready**: Each phase can be executed as standalone or end-to-end without manual handoff

---

## IMPLEMENTATION CHECKLIST

### Pre-Release Verification
```bash
# Verify all critical issues closed
gh issue list --milestone "vX.Y.Z" --label "priority:critical" --state open

# Run tests
npm test || pytest || make test

# Check for uncommitted changes
git status --porcelain
```

### Version Bump
```bash
# Determine bump type from commits
# Look for: BREAKING CHANGE (major), feat: (minor), fix: (patch)

# Update version
npm version patch -m "chore: bump version to %s"
# OR
echo "X.Y.Z" > version.txt && git add version.txt && git commit -m "chore: bump version to X.Y.Z"
```

### Changelog Update
```bash
# Generate changelog entry
cat >> CHANGELOG.md << 'EOF'
## [X.Y.Z] - YYYY-MM-DD

### Security
- Fixed critical vulnerability in authentication

### Documentation
- Updated API reference
- Added migration guide

### Infrastructure
- Improved CI/CD pipeline
- Updated dependencies

### Code Quality
- Refactored core modules
- Improved test coverage to 95%

**Metrics:**
- Issues fixed: 12
- Manual fixes required: 2
- Critical issues closed: 3
EOF

# Commit changelog
git add CHANGELOG.md
git commit -m "docs: update changelog for vX.Y.Z"
```

### Documentation Sync
```bash
# Update version references in README
sed -i 's/Version: [0-9.]\+/Version: X.Y.Z/' README.md

# Update docs site version
sed -i 's/"version": "[^"]*"/"version": "X.Y.Z"/' docs/package.json

# Commit docs updates
git add README.md docs/
git commit -m "docs: sync version references to vX.Y.Z"
```

### Create Tag & Release
```bash
# Create annotated tag
git tag -a vX.Y.Z -m "Release vX.Y.Z

## Highlights
- Feature improvements
- Security fixes
- Performance enhancements

See CHANGELOG.md for complete details."

# Push tag
git push origin vX.Y.Z

# Create GitHub release
gh release create vX.Y.Z \
  --title "Release vX.Y.Z" \
  --notes-file .github/release-notes.md \
  --latest
```

### Deploy
```bash
# NPM package
npm publish

# Docker image
docker build -t myorg/myapp:X.Y.Z .
docker push myorg/myapp:X.Y.Z
docker tag myorg/myapp:X.Y.Z myorg/myapp:latest
docker push myorg/myapp:latest

# GitHub Pages docs
cd docs && npm run build && cd ..
git add docs/dist
git commit -m "docs: deploy vX.Y.Z documentation"
git push
```

### Announcement
```bash
# Create announcement issue
gh issue create \
  --title "🎉 Release vX.Y.Z" \
  --body "We're excited to announce vX.Y.Z!

## Highlights
- New feature X
- Security improvements
- Performance enhancements

See the [full changelog](CHANGELOG.md) for details.

Upgrade: \`npm install mypackage@X.Y.Z\`" \
  --label "announcement"

# Pin the issue
gh issue pin <issue-number>
```

### Archive
```bash
# Create archive directory
mkdir -p .github/audits/vX.Y.Z/

# Archive artifacts
cp CHANGELOG.md .github/audits/vX.Y.Z/changelog.md
gh issue list --milestone "vX.Y.Z" --json number,title,state > .github/audits/vX.Y.Z/issues.json
gh pr list --search "milestone:vX.Y.Z" --json number,title,mergedAt > .github/audits/vX.Y.Z/prs.json

# Commit archive
git add .github/audits/vX.Y.Z/
git commit -m "chore: archive vX.Y.Z release artifacts"
git push
```

### Schedule Next Audit
```bash
# Create next audit issue
gh issue create \
  --title "Audit: Quarterly Repository Health Check" \
  --body "Scheduled repository audit for next quarter.

## Scope
- Security vulnerabilities
- Dependency updates
- Code quality improvements
- Documentation gaps

**Scheduled for:** $(date -d '+90 days' +%Y-%m-%d)" \
  --label "audit,scheduled" \
  --milestone "Next Quarter"
```

---

## AUTOMATION INTEGRATION

### GitHub Actions Workflow
```yaml
name: Release Pipeline

on:
  workflow_dispatch:
    inputs:
      bump_type:
        description: 'Version bump type'
        required: true
        type: choice
        options:
          - patch
          - minor
          - major

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'

      - name: Verify Tests Pass
        run: npm test

      - name: Bump Version
        run: npm version ${{ inputs.bump_type }} -m "chore: bump version to %s"

      - name: Generate Changelog
        run: |
          # Your changelog generation logic here
          git add CHANGELOG.md
          git commit -m "docs: update changelog for release"

      - name: Create Tag & Release
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          VERSION=$(node -p "require('./package.json').version")
          git tag -a "v$VERSION" -m "Release v$VERSION"
          git push origin "v$VERSION"
          gh release create "v$VERSION" --generate-notes --latest

      - name: Deploy
        run: npm publish
        env:
          NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }}
```

---

## SINGLE-PAGE CHECKLIST VERSION

Copy this to `.github/RELEASE_CHECKLIST.md`:

```markdown
# Release Checklist

## Pre-Release
- [ ] All critical/high issues closed for milestone
- [ ] Tests pass: `npm test`
- [ ] No uncommitted changes: `git status`

## Version & Changelog
- [ ] Determine bump type (major/minor/patch)
- [ ] Update version: `npm version <type>`
- [ ] Update CHANGELOG.md (newest on top)
- [ ] Commit changelog: `git commit -m "docs: update changelog"`

## Documentation
- [ ] Update README.md version references
- [ ] Update docs site version
- [ ] Commit docs: `git commit -m "docs: sync version to vX.Y.Z"`

## Release
- [ ] Create tag: `git tag -a vX.Y.Z -m "Release notes"`
- [ ] Push tag: `git push origin vX.Y.Z`
- [ ] Create GitHub release: `gh release create vX.Y.Z`

## Deploy
- [ ] Publish package (npm/docker/etc.)
- [ ] Deploy documentation site
- [ ] Verify deployment successful

## Announce
- [ ] Create announcement issue
- [ ] Pin announcement
- [ ] Optional: Discussion post

## Archive
- [ ] Archive artifacts to `.github/audits/vX.Y.Z/`
- [ ] Commit archive
- [ ] Schedule next audit issue
```

---

**This is the single authoritative GitHub release prompt: tight, linear, verifiable, and self-contained.**

---

**Master Location:** `~/projects/prompts-intent-solutions/000-master-systems/github/001-rel-master-repo-release.md`

**Related Documents:**
- Repository audit: `001-aud-master-repo-audit.md`
- Repository chore: `002-tsk-master-repo-chore.md`

---

*GITHUB RELEASE SYSTEM – Complete Release Pipeline*
