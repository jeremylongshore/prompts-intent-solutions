# 🚀 Prompt Engineering Toolkit

[![Template Validation](https://github.com/jeremylongshore/prompts/actions/workflows/template-validation.yml/badge.svg)](https://github.com/jeremylongshore/prompts/actions/workflows/template-validation.yml)
[![GitHub issues](https://img.shields.io/github/issues/jeremylongshore/prompts)](https://github.com/jeremylongshore/prompts/issues)
[![GitHub stars](https://img.shields.io/github/stars/jeremylongshore/prompts)](https://github.com/jeremylongshore/prompts/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A comprehensive collection of professional prompt templates for AI-assisted software development, organized by category and use case.

## 🎯 Quick Start

### For Complete Beginners
```bash
# 1. Clone the repository
git clone https://github.com/jeremylongshore/prompts.git
cd prompts

# 2. Browse templates by category
ls -la planning/ setup/ debugging/ features/

# 3. Copy a template and customize it
cp setup/SETUP-001-ai-assistant-092825.md my-project-setup.md
```

### For Developers
```bash
# Fork and contribute
git clone https://github.com/YOUR_USERNAME/prompts.git
cd prompts

# Validate your templates
python .github/scripts/validate-templates.py

# Create new template following naming convention
# CATEGORY-###-description-MMDDYY.md
```

## 📁 Template Categories

| Category | Purpose | Templates | Use Cases |
|----------|---------|-----------|-----------|
| **[PLAN](planning/)** | Strategic planning & architecture | 🏗️ System design, project planning | Architecture decisions, feature planning |
| **[SETUP](setup/)** | Configuration & initialization | ⚙️ Environment setup, tool config | Project bootstrapping, tool configuration |
| **[DEBUG](debugging/)** | Problem diagnosis & troubleshooting | 🐛 Error analysis, performance issues | Bug fixing, performance optimization |
| **[FEAT](features/)** | Feature development & enhancement | ✨ New functionality, improvements | Feature development, enhancement requests |
| **[TEST](testing/)** | Testing & validation | 🧪 Test strategies, QA processes | Test planning, quality assurance |
| **[CLEAN](maintenance/)** | Maintenance & optimization | 🧹 Code cleanup, refactoring | Code refactoring, technical debt |
| **[SEC](security/)** | Security-focused prompts | 🔒 Security audits, threat analysis | Security reviews, vulnerability assessment |

## 🔥 Featured Templates

### 🌟 Most Popular
- **[SETUP-001: AI Assistant Prompts](setup/SETUP-001-ai-assistant-092825.md)** - Comprehensive guidance prompts for different user experience levels
- **[PLAN-001: Filing System](planning/PLAN-001-filing-system-092825.md)** - Repository organization and structure planning
- **[DEBUG-001: Bug Debugging](debugging/DEBUG-001-bug-debugging-092825.md)** - Systematic bug analysis and resolution

### 🆕 Recently Added
- **[ADR-001: Template System Architecture](ADR-001-TEMPLATE_SYSTEM_ARCHITECTURE-092825.md)** - Architectural decision record for template organization

## 🚀 Usage Examples

### Using a Template
1. **Find your template**: Browse by category or search by use case
2. **Copy the content**: Use the raw GitHub link or clone locally
3. **Customize**: Replace placeholders with your specific details
4. **Run with AI**: Use with Claude, ChatGPT, or your preferred AI assistant

### Example Workflow
```bash
# 1. Need to set up a new project?
cat setup/SETUP-001-ai-assistant-092825.md

# 2. Copy the "Complete Beginner Prompt" section
# 3. Customize with your project details
# 4. Paste into your AI assistant
# 5. Follow the step-by-step guidance
```

## 🏗️ Template Structure

Each template follows this structure:

```yaml
---
name: template-name
description: Brief description of what this template does
model: recommended-ai-model (opus, sonnet, gpt-4, etc.)
---

# Template Content
Clear, actionable prompts with:
- Specific context and constraints
- Step-by-step instructions
- Expected outcomes
- Usage examples
```

## 🤝 Contributing

We welcome contributions! Here's how to add your own templates:

### Quick Contribution
1. **Use our template**: [Submit via GitHub Issue](https://github.com/jeremylongshore/prompts/issues/new?template=template_submission.yml)
2. **Follow naming convention**: `CATEGORY-###-description-MMDDYY.md`
3. **Include testing notes**: Which AI models you've tested with

### Development Contribution
```bash
# 1. Fork and clone
git clone https://github.com/YOUR_USERNAME/prompts.git

# 2. Create feature branch
git checkout -b template/new-awesome-template

# 3. Add your template following the naming convention
# Example: FEAT-004-api-integration-100125.md

# 4. Validate locally
python .github/scripts/validate-templates.py

# 5. Submit PR
git add . && git commit -m "feat: add API integration template"
git push origin template/new-awesome-template
```

### Contribution Guidelines
- ✅ Follow [naming convention](#naming-convention)
- ✅ Include YAML frontmatter
- ✅ Test with at least one AI model
- ✅ Provide clear usage examples
- ✅ No sensitive information

## 📋 Naming Convention

Templates follow this pattern: `CATEGORY-###-description-MMDDYY.md`

- **CATEGORY**: One of PLAN, SETUP, DEBUG, FEAT, TEST, CLEAN, SEC
- **###**: Sequential number within category (001, 002, 003...)
- **description**: Kebab-case description (lowercase, hyphens)
- **MMDDYY**: Creation or last major revision date

### Examples
- ✅ `SETUP-001-ai-assistant-092825.md`
- ✅ `FEAT-003-api-integration-100125.md`
- ❌ `My Template.md`
- ❌ `template_001.md`

## 🎓 Learning Resources

### For Beginners
- **[Complete Beginner Guide](setup/SETUP-001-ai-assistant-092825.md#-complete-beginner-prompt)** - Start here if you're new to AI-assisted development
- **[Quick Help Prompts](setup/SETUP-001-ai-assistant-092825.md#-quick-help-prompts)** - Common questions and solutions

### For Teams
- **[Team Setup Guide](setup/SETUP-001-ai-assistant-092825.md#-team-setup-prompt)** - Rolling out to your organization
- **[Governance Templates](docs/)** - CONTRIBUTING.md, SECURITY.md templates

### For Advanced Users
- **[Template Creation Guide](setup/SETUP-001-ai-assistant-092825.md#-template-creation-prompt)** - Build your own templates
- **[Architecture Decisions](ADR-001-TEMPLATE_SYSTEM_ARCHITECTURE-092825.md)** - How this system is designed

## 🔧 Advanced Features

### Automated Validation
All templates are automatically validated for:
- ✅ Naming convention compliance
- ✅ YAML frontmatter structure
- ✅ Content quality metrics
- ✅ No duplicate templates

### GitHub Integration
- 🤖 **Auto-validation**: PRs automatically validated
- 📋 **Issue templates**: Standardized bug reports and feature requests
- 🏷️ **Auto-labeling**: Templates automatically categorized
- 📊 **Quality metrics**: Template usage and effectiveness tracking

### Search & Discovery
```bash
# Find templates by keyword
grep -r "API" . --include="*.md"

# List all templates in a category
ls setup/

# Find templates by date
ls *-092825.md
```

## 📊 Repository Stats

- **Total Templates**: 15+ and growing
- **Categories**: 7 main categories
- **Contributors**: Open for contributions
- **Last Updated**: September 28, 2025

## 🗺️ Roadmap

### Phase 1: Foundation ✅
- [x] Core template structure
- [x] GitHub automation
- [x] Validation system

### Phase 2: Growth 🚧
- [ ] 50+ community templates
- [ ] Advanced search features
- [ ] Template metrics dashboard

### Phase 3: Scale 📅
- [ ] API endpoints for programmatic access
- [ ] Integration with popular AI tools
- [ ] Template marketplace

## 📞 Support

### Quick Help
- 🐛 **Bug reports**: [Create issue](https://github.com/jeremylongshore/prompts/issues/new?template=bug_report.yml)
- ✨ **Feature requests**: [Request feature](https://github.com/jeremylongshore/prompts/issues/new?template=feature_request.yml)
- 📝 **New templates**: [Submit template](https://github.com/jeremylongshore/prompts/issues/new?template=template_submission.yml)

### Community
- 💬 **Discussions**: [GitHub Discussions](https://github.com/jeremylongshore/prompts/discussions)
- 📧 **Contact**: [Create issue](https://github.com/jeremylongshore/prompts/issues)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by the growing AI-assisted development community
- Built with feedback from developers, product managers, and DevOps engineers
- Powered by Claude, ChatGPT, and other AI assistants

---

**Made with ❤️ for the AI-assisted development community**

*Last updated: September 28, 2025*