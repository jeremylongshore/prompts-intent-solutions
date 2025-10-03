---
name: professional-release-workflow
description: Comprehensive repository release management system for transforming development work into professionally documented, properly versioned releases
model: opus
date: 2025-09-28
---

# Professional Repository Release System

Execute the following comprehensive workflow to create professionally documented, properly versioned repository releases.

---

## Phase 1: Work Analysis and Categorization

Examine all uncommitted changes and recently committed work to understand the scope of modifications. You will analyze the changed files, identify the nature of changes (features, fixes, documentation, performance, refactoring), and determine the appropriate version bump according to semantic versioning principles.

Review the diff for each changed file and categorize changes into:
- Breaking changes that require major version increment
- New features that require minor version increment
- Bug fixes and patches that require patch version increment
- Documentation improvements that enhance user experience
- Performance optimizations that improve efficiency
- Refactoring that improves code quality without changing behavior

## Phase 2: Commit Message Generation

Generate properly formatted Conventional Commits for all uncommitted work. Each commit must follow the exact specification with type, optional scope, description, optional body, and optional footer. Structure commits to tell a coherent story of the development work.

For each logical unit of work, create commit commands following this pattern:

```bash
# Conventional Commit Format
git add [specific files for this change]
git commit -m "type(scope): description

Detailed explanation of what changed and why. This provides context
for future developers understanding the evolution of the codebase.

Fixes #issue-number
BREAKING CHANGE: description if applicable"
```

Commit types to use:
- `feat`: New feature for the user
- `fix`: Bug fix for the user
- `docs`: Documentation only changes
- `style`: Changes that do not affect the meaning of the code
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `perf`: Code change that improves performance
- `test`: Adding missing tests or correcting existing tests
- `chore`: Changes to the build process or auxiliary tools

## Phase 3: Changelog Generation and Enhancement

Generate a comprehensive CHANGELOG.md update that follows Keep a Changelog principles. The changelog must be human-readable, focusing on what changed from the user's perspective rather than technical implementation details.

Structure the changelog entry as:

```markdown
## [Version Number] - YYYY-MM-DD

### Added
- New features that were added to the project

### Changed
- Changes in existing functionality

### Deprecated
- Features that will be removed in upcoming releases

### Removed
- Features that were removed in this release

### Fixed
- Bug fixes

### Security
- Security improvements or vulnerability fixes

### Performance
- Performance improvements with metrics where available

### Documentation
- Documentation improvements and additions

### Developer Experience
- Improvements for contributors and developers

### Under the Hood
- Technical improvements not directly visible to users
```

Include specific issue and PR references for traceability. Write descriptions that explain the value to users, not just what changed technically.

## Phase 4: Release Notes Creation

Compose compelling release notes that will generate excitement and clearly communicate value. The release notes must include:

Executive summary (2-3 sentences) that captures the essence of the release and its primary value proposition. This summary should be suitable for social media sharing and immediately convey why users should upgrade.

Highlights section featuring the top 3-5 most impactful changes with brief explanations of their benefits. Each highlight should explain what problem it solves or what new capability it enables.

Detailed changes organized by category with links to relevant documentation, examples, or demonstrations. Include code examples for new features showing before and after usage patterns.

Migration guide for any breaking changes with step-by-step instructions and code examples showing exactly how to update from the previous version.

Acknowledgments section thanking contributors with GitHub handles properly linked. Special recognition for first-time contributors to encourage continued participation.

## Phase 5: Version Tagging and Annotation

Create a properly annotated git tag that includes version number and release summary. The tag annotation should contain enough information to understand the release without referring to other documentation.

```bash
# Create annotated tag with comprehensive message
git tag -a v[X.Y.Z] -m "Release version X.Y.Z

Summary: [One line summary of the release]

Highlights:
• [Top feature or fix]
• [Second important change]
• [Third important change]

This release includes [N] commits from [M] contributors.
Full changelog: [URL to changelog]
Migration guide: [URL if applicable]"

# Sign the tag for security if GPG is configured
git tag -s v[X.Y.Z] -m "..."
```

## Phase 6: Documentation Synchronization

Update all documentation to reflect the changes in this release. This includes:

README.md updates:
- Version badges to reflect new version
- Installation instructions if dependencies changed
- Usage examples for new features
- API documentation for interface changes
- Performance metrics if improvements were made

API documentation updates for any interface changes with clear deprecation notices for removed features and migration paths for breaking changes.

Example code updates throughout the documentation to use new features and best practices introduced in this release.

Configuration file templates reflecting new options or changed defaults with inline comments explaining each option.

## Phase 7: GitHub Release Creation

Compose the GitHub release that will appear prominently on the repository page. Structure the release to maximize engagement and clarity:

```markdown
# Release Title: v[X.Y.Z] - [Memorable Release Name]

## 🎉 What's New

[Compelling 2-3 sentence summary of why this release matters]

## ✨ Highlights

### 🚀 [Feature Name]
[Brief description of the feature and its impact]
```example
// Example of how to use the new feature
const result = newFeature({ option: 'value' });
```

### 🐛 [Major Fix]
[Description of what was broken and is now fixed]

### ⚡ [Performance Improvement]
[Metrics showing the improvement: "30% faster startup time"]

## 📋 Full Changelog

[Complete categorized list of all changes]

## 📦 Installation

```bash
# npm
npm install package@latest

# yarn
yarn add package@latest

# Direct download
wget https://github.com/org/repo/releases/download/vX.Y.Z/package.tar.gz
```

## 🔄 Upgrading

[Instructions for upgrading from previous version]

## 🙏 Acknowledgments

Special thanks to our contributors:
@contributor1 @contributor2 @contributor3

Welcome to our first-time contributors! 🎊
@new-contributor1 @new-contributor2

## 📊 Release Metrics

- 📝 [N] Commits
- 👥 [M] Contributors
- 🐛 [X] Issues Closed
- ⭐ [Y] New Features
- 🔧 [Z] Bug Fixes
```

## Phase 8: Pre-Release Verification Checklist

Before pushing the release, verify:

```bash
# Verification commands to run

# 1. All tests pass
npm test || yarn test || make test

# 2. Build succeeds
npm run build || yarn build || make build

# 3. Linting passes
npm run lint || yarn lint || make lint

# 4. Documentation builds
npm run docs:build || yarn docs:build

# 5. Version numbers are consistent across:
grep -r "version" package.json
grep -r "version" README.md
grep -r "version" docs/

# 6. CHANGELOG.md is updated with current date
head -n 5 CHANGELOG.md

# 7. No sensitive information in commits
git diff HEAD~10..HEAD | grep -E "(password|secret|token|key)="

# 8. All contributors are credited
git log --format='%aN' v[PREVIOUS]..HEAD | sort -u
```

## Phase 9: Push and Publish Sequence

Execute the release with proper ordering to ensure consistency across all platforms:

```bash
#!/bin/bash
# Professional Release Script

VERSION="X.Y.Z"
BRANCH="main"

# Step 1: Commit all changes
git add .
git commit -m "chore(release): prepare v${VERSION} release

- Updated CHANGELOG.md
- Bumped version numbers
- Synchronized documentation
- Updated dependencies"

# Step 2: Create and push tag
git tag -a "v${VERSION}" -m "Release version ${VERSION}"
git push origin ${BRANCH}
git push origin "v${VERSION}"

# Step 3: Publish to package registry if applicable
npm publish || cargo publish || gem push

# Step 4: Create GitHub release via CLI or API
gh release create "v${VERSION}" \
  --title "v${VERSION} - [Release Name]" \
  --notes-file RELEASE_NOTES.md \
  --latest

# Step 5: Update documentation site if applicable
npm run docs:deploy || mkdocs gh-deploy

# Step 6: Announce release
echo "Release v${VERSION} complete!"
echo "- GitHub Release: https://github.com/org/repo/releases/tag/v${VERSION}"
echo "- Changelog: https://github.com/org/repo/blob/main/CHANGELOG.md"
echo "- Documentation: https://docs.example.com"
```

## Phase 10: Post-Release Communication

Generate announcement templates for various channels:

**Twitter/Social Media Announcement:**
```
🚀 Version X.Y.Z is here!

✨ [Top feature in 5 words]
🐛 [Major fix in 5 words]
⚡ [Performance gain as percentage]

📖 Full release notes: [link]
```

**Discord/Slack Announcement:**
```
@everyone Version X.Y.Z has been released!

**What's New:**
• [Feature 1]
• [Feature 2]
• [Bug fixes]

**Upgrade:** `npm install package@latest`
**Release Notes:** [link]
```

**Email Newsletter Template:**
```
Subject: [Project] v.X.Y.Z Released - [Main Feature/Improvement]

Hi everyone,

We're excited to announce version X.Y.Z with [key improvement].

[2-3 paragraphs about the release highlights]

Read the full release notes: [link]

Thanks to all our contributors!
```

## Output Requirements

When executing this workflow, provide:

1. **Exact git commands** to run in sequence
2. **File contents** for CHANGELOG.md updates
3. **Complete release notes** ready to paste into GitHub
4. **Version number** based on semantic versioning rules
5. **Commit messages** following Conventional Commits
6. **Verification checklist** with actual commands to run
7. **Migration guide** if breaking changes exist
8. **Social media announcements** ready to post

## Quality Standards

Every release must achieve these standards:

- **Clarity**: Someone unfamiliar with the project can understand what changed and why
- **Completeness**: Every change is documented with appropriate detail
- **Professionalism**: Grammar, spelling, and formatting are impeccable
- **Accessibility**: Documentation works for users of all skill levels
- **Attractiveness**: Release notes generate excitement and interest
- **Traceability**: Every change links to relevant issues, PRs, or commits
- **Reproducibility**: Version tags allow exact state recreation

## Emergency Release Procedures

For critical security fixes:
1. **Immediate Assessment**: Determine severity and affected versions
2. **Expedited Process**: Skip non-critical documentation updates
3. **Security Advisory**: Draft vulnerability disclosure
4. **Coordinated Release**: Notify maintainers of dependent projects
5. **Post-Release**: Full documentation update within 24 hours