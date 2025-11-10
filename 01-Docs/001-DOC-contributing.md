# Contributing to Prompts Intent Solutions

Thank you for your interest in contributing! This guide will help you get started quickly and ensure your contributions align with our project standards.

## 🚀 Quick Start (10-minute path to first green PR)

1. **Fork and clone**
   ```bash
   git clone https://github.com/your-username/prompts-intent-solutions.git
   cd prompts-intent-solutions
   ```

2. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes** (see guidelines below)

4. **Test your changes**
   ```bash
   python tools/validate_structure.py
   python tools/validate_filenames.py
   python tools/check_duplicates.py
   ```

5. **Commit and push**
   ```bash
   git add .
   git commit -m "feat: add new prompt template for X"
   git push origin feature/your-feature-name
   ```

6. **Open a Pull Request** using our template

## 📋 Development Setup

### Prerequisites
- Git
- Python 3.8+
- A text editor or IDE

### Local Development
```bash
# Clone your fork
git clone https://github.com/your-username/prompts-intent-solutions.git
cd prompts-intent-solutions

# Install development dependencies (if any)
pip install pyyaml  # For validation scripts

# Run validation checks
python tools/validate_structure.py
```

## 📝 Contribution Guidelines

### What We're Looking For
- **Prompt templates** following our naming convention
- **Documentation improvements**
- **Validation tools** and automation
- **Bug fixes** and quality improvements
- **Good first issues** for new contributors

### File Organization
Follow our [STRUCTURE.md](STRUCTURE.md) guidelines:

```
├── planning/           # PLAN-### templates
├── setup/             # SETUP-### templates
├── debugging/         # DEBUG-### templates
├── features/          # FEAT-### templates
├── testing/           # TEST-### templates
├── cleaning/          # CLEAN-### templates
├── security/          # SEC-### templates
└── project-specs/     # Project-correlated docs (PRD, ARD, TRD)
```

### Naming Convention
**Format:** `CATEGORY-###-description-MMDDYY.md`

- **CATEGORY** = PLAN, SETUP, DEBUG, FEAT, TEST, CLEAN, SEC
- **###** = Sequential within category (001, 002, 003...)
- **description** = kebab-case description
- **MMDDYY** = Creation/last major revision date

### Template Structure
All prompt templates must include YAML frontmatter:

```yaml
---
name: descriptive-template-name
description: Brief description of what this template does
model: opus  # or sonnet, haiku, gpt-4, gpt-3.5
---

# Template content here
```

## 🔍 Code Standards

### Commit Messages
We use [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add new debugging template for API issues
fix: correct filename validation regex
docs: update contributing guidelines
chore: update validation scripts
```

### Pull Request Process
1. **Link to an issue** - All PRs should reference an issue
2. **Update documentation** - If you change functionality, update docs
3. **Add tests** - For validation logic, add test cases
4. **Pass all checks** - Validation scripts must pass
5. **Get review** - Wait for maintainer review

### Review Checklist
- [ ] Follows naming convention
- [ ] Includes proper frontmatter
- [ ] Passes validation scripts
- [ ] Updates documentation if needed
- [ ] Includes tests for new validation logic
- [ ] Commit messages follow conventional format

## 🏷️ Issue Labels

| Label | Description |
|-------|-------------|
| `good first issue` | Perfect for new contributors |
| `bug` | Something isn't working |
| `enhancement` | New feature or improvement |
| `docs` | Documentation updates |
| `template` | New prompt template |
| `validation` | Validation tool improvements |
| `needs-discussion` | Requires community input |
| `help wanted` | We'd love community help |

## 🤝 Community Guidelines

### Code of Conduct
We follow the [Contributor Covenant](CODE_OF_CONDUCT.md). Be kind, inclusive, and professional.

### Getting Help
- **Questions?** Open a [Question issue](.github/ISSUE_TEMPLATE/question.md)
- **Stuck?** Check existing issues or start a discussion
- **Ideas?** Open a [Feature Request](.github/ISSUE_TEMPLATE/feature.md)

### Response Times
- **New issues**: Labeled within 24 hours
- **Pull requests**: Review within 24-48 hours
- **Security reports**: Response within 24 hours

## 🎯 Good First Issues

Looking to contribute? Check out issues labeled `good first issue`:
- Add new prompt templates
- Improve documentation
- Fix validation edge cases
- Create example usage guides

## 🔄 Release Process

1. **Create PR** with your changes
2. **Get approval** from maintainers
3. **Merge to main** triggers automated checks
4. **Release** happens automatically with semantic versioning

## 📞 Contact

- **Maintainer**: [@jeremylongshore](https://github.com/jeremylongshore)
- **Security issues**: See [SECURITY.md](SECURITY.md)
- **General questions**: Open an issue

---

**Thank you for contributing to Prompts Intent Solutions!** 🙏

Your contributions help build a better prompt engineering ecosystem for everyone.