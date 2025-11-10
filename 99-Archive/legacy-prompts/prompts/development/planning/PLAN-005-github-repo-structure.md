---
name: github-repo-structure-plan
description: Complete GitHub repository structure plan with filing system integration and Task Warrior setup
model: opus
complexity: advanced
date: 2025-09-28
---

# 🏗️ GitHub Repository Structure Plan

**Date:** September 28, 2025
**Tmux Session:** prompts
**Project:** Jeremy's Prompt Engineering Repository

---

## 🎯 Repository Overview

**Repository Name:** `prompt-engineering-toolkit`
**Purpose:** Comprehensive prompt engineering resource with audited prompts, standardized templates, and community contribution framework
**Target:** Individual developers, teams, and enterprise users

## 📁 Complete Directory Structure

```
prompt-engineering-toolkit/
├── README.md                          # Main repository overview
├── CLAUDE.md                          # AI assistant instructions
├── CONTRIBUTING.md                    # Contribution guidelines
├── CODE_OF_CONDUCT.md                 # Community standards
├── LICENSE                            # MIT License
├── .github/                           # GitHub configuration
│   ├── workflows/                     # CI/CD pipelines
│   │   ├── validate-filing-system.yml
│   │   ├── quality-check.yml
│   │   ├── deploy-docs.yml
│   │   └── community-validation.yml
│   ├── ISSUE_TEMPLATE/               # Issue templates
│   │   ├── bug_report.md
│   │   ├── feature_request.md
│   │   ├── prompt_submission.md
│   │   └── template_request.md
│   └── PULL_REQUEST_TEMPLATE.md      # PR template
├── docs/                             # Documentation site
│   ├── index.md                      # Documentation home
│   ├── getting-started.md            # Quick start guide
│   ├── filing-system.md              # Filing system documentation
│   ├── templates/                    # Template documentation
│   │   ├── basic-task.md
│   │   ├── complex-workflow.md
│   │   ├── research.md
│   │   ├── troubleshooting.md
│   │   └── setup.md
│   ├── examples/                     # Usage examples
│   │   ├── beginner-examples.md
│   │   ├── advanced-examples.md
│   │   └── enterprise-examples.md
│   ├── best-practices.md             # Prompt engineering best practices
│   ├── community/                    # Community resources
│   │   ├── contributors.md
│   │   ├── showcase.md
│   │   └── testimonials.md
│   └── api/                          # API documentation
│       ├── overview.md
│       └── endpoints.md
├── templates/                        # Core prompt templates
│   ├── README.md                     # Template overview
│   ├── 01-basic-task-template.md     # Basic task template
│   ├── 02-complex-workflow-template.md # Complex workflow template
│   ├── 03-research-template.md       # Research template
│   ├── 04-troubleshooting-template.md # Troubleshooting template
│   ├── 05-setup-template.md          # Setup template
│   ├── examples/                     # Template examples
│   │   ├── basic-task-examples/
│   │   ├── complex-workflow-examples/
│   │   ├── research-examples/
│   │   ├── troubleshooting-examples/
│   │   └── setup-examples/
│   └── customization/                # Customization guides
│       ├── variables.md
│       ├── styling.md
│       └── extensions.md
├── prompts/                          # Jeremy's audited prompt collection
│   ├── README.md                     # Collection overview
│   ├── index.json                    # Machine-readable index
│   ├── setup/                        # Setup prompts
│   │   ├── 001-SETUP-AI_ASSISTANT-092825.md
│   │   ├── 002-SETUP-COMPACT_MODE-092825.md
│   │   ├── 003-SETUP-N8N_WORKFLOWS-092825.md
│   │   ├── 004-SETUP-N8N_WORKFLOWS_V2-092825.md
│   │   └── 005-SETUP-RESEARCH_DEEPSEEK-092825.md
│   ├── debug/                        # Debugging prompts
│   │   └── 001-DEBUG-BUG_DEBUGGING-092825.md
│   ├── clean/                        # Maintenance prompts
│   │   └── 001-CLEAN-EOD_SWEEP-092825.md
│   ├── plan/                         # Planning prompts
│   │   ├── 001-PLAN-FILING_SYSTEM-092825.md
│   │   └── 002-PLAN-MARKETING_STRATEGY-092825.md
│   └── metadata/                     # Prompt metadata
│       ├── tags.json
│       ├── categories.json
│       └── performance-metrics.json
├── community/                        # Community contributions
│   ├── README.md                     # Contribution process
│   ├── submissions/                  # Submitted prompts (pending review)
│   ├── validated/                    # Community-validated prompts
│   └── showcase/                     # Featured community examples
├── tools/                            # Automation and utilities
│   ├── README.md                     # Tools overview
│   ├── validators/                   # Validation scripts
│   │   ├── filing-system-validator.py
│   │   ├── template-validator.py
│   │   └── quality-checker.py
│   ├── generators/                   # Code generators
│   │   ├── prompt-generator.py
│   │   ├── index-generator.py
│   │   └── docs-generator.py
│   ├── taskwarrior/                  # Task Warrior integration
│   │   ├── setup.sh                  # TW setup script
│   │   ├── aliases.taskrc            # TW aliases for prompts project
│   │   └── import-tasks.py           # Task import utility
│   └── api/                          # API implementation
│       ├── server.py
│       ├── endpoints/
│       └── data/
├── examples/                         # Real-world examples
│   ├── README.md                     # Examples overview
│   ├── beginner/                     # Beginner-friendly examples
│   │   ├── simple-coding-assistant.md
│   │   ├── research-helper.md
│   │   └── writing-assistant.md
│   ├── intermediate/                 # Intermediate examples
│   │   ├── project-management.md
│   │   ├── data-analysis.md
│   │   └── content-creation.md
│   ├── advanced/                     # Advanced examples
│   │   ├── ai-agent-orchestration.md
│   │   ├── enterprise-workflow.md
│   │   └── custom-frameworks.md
│   └── enterprise/                   # Enterprise use cases
│       ├── governance-framework.md
│       ├── quality-assurance.md
│       └── team-collaboration.md
├── research/                         # Research and analysis
│   ├── README.md                     # Research overview
│   ├── audit-reports/                # Prompt audit results
│   │   └── 2025-09-28-comprehensive-audit.md
│   ├── performance-analysis/         # Performance studies
│   ├── best-practices-research/      # Best practices studies
│   └── industry-analysis/            # Industry trend analysis
└── scripts/                          # Build and deployment scripts
    ├── build.sh                      # Site build script
    ├── deploy.sh                     # Deployment script
    ├── validate.sh                   # Validation script
    └── setup.sh                      # Repository setup script
```

## 🏷️ Filing System Implementation

### Naming Convention Enforcement
```bash
# Pattern: ####-PHASE-MMDDYY-DESCRIPTION.md
# Example: 0015-SETUP-092825-AI_ASSISTANT_CONFIGURATION.md

# Automated validation in .github/workflows/validate-filing-system.yml
```

### Phase Categories
| Phase | Directory | Purpose |
|-------|-----------|---------|
| **SETUP** | `prompts/setup/` | System initialization and configuration |
| **DEBUG** | `prompts/debug/` | Problem diagnosis and fixes |
| **CLEAN** | `prompts/clean/` | Maintenance and optimization |
| **PLAN** | `prompts/plan/` | Strategic planning and documentation |
| **TEST** | `prompts/test/` | Testing documentation and results |
| **FEAT** | `prompts/feat/` | New feature development |
| **SEC** | `prompts/sec/` | Security implementations and audits |

### Automated File Validation
```yaml
# .github/workflows/validate-filing-system.yml
name: Filing System Validation
on: [push, pull_request]
jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Validate Naming Convention
        run: python tools/validators/filing-system-validator.py
      - name: Check Sequential Numbering
        run: python tools/validators/sequence-checker.py
      - name: Validate Metadata
        run: python tools/validators/metadata-validator.py
```

## 🔧 Task Warrior Integration

### Repository-Specific Configuration

**File:** `tools/taskwarrior/aliases.taskrc`
```bash
# Prompt Engineering Repository Aliases
alias.prompts=project:prompts and owner:assistant
alias.prompt-review=project:prompts and +review
alias.prompt-dev=project:prompts and +development
alias.prompt-community=project:prompts and +community

# Project-specific UDAs
uda.prompt_phase.label=Phase
uda.prompt_phase.type=string
uda.prompt_phase.values=setup,debug,clean,plan,test,feat,sec

# Default project for this repository
default.project=prompts
```

**Setup Script:** `tools/taskwarrior/setup.sh`
```bash
#!/bin/bash
# Setup Task Warrior for prompt repository

echo "Setting up Task Warrior for prompt engineering repository..."

# Source the aliases
task config include $PWD/tools/taskwarrior/aliases.taskrc

# Create initial project structure
task add "Setup prompt repository structure" project:prompts +setup priority:H
task add "Implement filing system validation" project:prompts +validation priority:M
task add "Create template documentation" project:prompts +docs priority:M

echo "Task Warrior setup complete. Use 'task prompts' to see project tasks."
```

### Task Import Utility
**File:** `tools/taskwarrior/import-tasks.py`
```python
#!/usr/bin/env python3
"""
Import tasks from markdown files into Task Warrior
Reads tasks from deployment-docs/010-TASKS-REPOSITORY_ROLLOUT-092825.md
"""

import subprocess
import re
from pathlib import Path

def import_tasks_from_markdown(filepath):
    """Import tasks from structured markdown file"""
    with open(filepath, 'r') as f:
        content = f.read()

    # Parse tasks from markdown structure
    tasks = parse_task_structure(content)

    # Import into Task Warrior
    for task in tasks:
        cmd = f"task add '{task['description']}' project:prompts owner:assistant priority:{task['priority']} +{task['tag']}"
        subprocess.run(cmd, shell=True)

    print(f"Imported {len(tasks)} tasks into Task Warrior")

def parse_task_structure(content):
    """Parse hierarchical task structure from markdown"""
    # Implementation details...
    pass

if __name__ == "__main__":
    import_tasks_from_markdown("deployment-docs/010-TASKS-REPOSITORY_ROLLOUT-092825.md")
```

## 📊 Quality Control System

### Automated Validation Pipeline
```yaml
# .github/workflows/quality-check.yml
name: Quality Control
on: [push, pull_request]
jobs:
  quality-check:
    runs-on: ubuntu-latest
    steps:
      - name: Prompt Format Validation
        run: python tools/validators/template-validator.py
      - name: Content Quality Check
        run: python tools/validators/quality-checker.py
      - name: Filing System Compliance
        run: python tools/validators/filing-system-validator.py
      - name: Community Standards Check
        run: python tools/validators/community-validator.py
```

### Quality Metrics
- **Template Compliance:** 100% adherence to template structure
- **Filing System:** 100% compliance with naming convention
- **Documentation Coverage:** >95% of features documented
- **Example Coverage:** >3 examples per template
- **Community Validation:** Peer review for all submissions

## 🌐 GitHub Pages Deployment

### Documentation Site Structure
```yaml
# docs/_config.yml
title: "Prompt Engineering Toolkit"
description: "Comprehensive resource for prompt engineering"
theme: minima
plugins:
  - jekyll-sitemap
  - jekyll-feed
  - jekyll-seo-tag

navigation:
  - title: "Getting Started"
    url: "/getting-started/"
  - title: "Templates"
    url: "/templates/"
  - title: "Examples"
    url: "/examples/"
  - title: "Community"
    url: "/community/"
  - title: "API"
    url: "/api/"
```

### Search Integration
```javascript
// Advanced search with Algolia or Lunr.js
const searchConfig = {
  indexName: 'prompt-engineering-toolkit',
  searchFunction: function(helper) {
    // Custom search implementation
  },
  filters: [
    'category',
    'complexity',
    'phase',
    'tags'
  ]
};
```

## 🔗 API Endpoints

### RESTful API Structure
```python
# tools/api/endpoints/
from flask import Flask, jsonify
app = Flask(__name__)

@app.route('/api/prompts')
def list_prompts():
    """List all available prompts with metadata"""
    pass

@app.route('/api/prompts/<prompt_id>')
def get_prompt(prompt_id):
    """Get specific prompt by ID"""
    pass

@app.route('/api/templates')
def list_templates():
    """List all available templates"""
    pass

@app.route('/api/search')
def search_prompts():
    """Search prompts and templates"""
    pass
```

## 🚀 Deployment Strategy

### Phase 1: Foundation (Week 1-2)
- [ ] Repository initialization
- [ ] Basic structure implementation
- [ ] Filing system setup
- [ ] Initial documentation

### Phase 2: Content Migration (Week 3-4)
- [ ] Jeremy's prompt collection migration
- [ ] Template system implementation
- [ ] Quality validation setup
- [ ] Task Warrior integration

### Phase 3: Community Features (Week 5-6)
- [ ] Contribution workflows
- [ ] Review processes
- [ ] Search implementation
- [ ] API development

### Phase 4: Launch (Week 7-8)
- [ ] Documentation completion
- [ ] Example gallery
- [ ] Community onboarding
- [ ] Performance optimization

## 📋 Repository Management

### README.md Template Structure
```markdown
# 🎯 Prompt Engineering Toolkit

> Comprehensive resource for prompt engineering with audited prompts, standardized templates, and community contributions.

## 🚀 Quick Start

1. Browse [Templates](./templates/) for standardized prompt structures
2. Explore [Examples](./examples/) for real-world use cases
3. Check [Jeremy's Collection](./prompts/) for audited prompts
4. Read [Best Practices](./docs/best-practices.md) for optimization tips

## 📋 Filing System

All prompts follow the `####-PHASE-MMDDYY-DESCRIPTION.md` convention:
- Sequential numbering (never reset)
- Phase identification (SETUP, DEBUG, CLEAN, etc.)
- Date tracking for work performed
- Clear descriptive names

## 🤝 Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines on:
- Prompt submission process
- Quality standards
- Review workflows
- Community guidelines

## 🔧 Task Warrior Integration

Setup Task Warrior for this repository:
```bash
./tools/taskwarrior/setup.sh
task prompts  # View project tasks
```

## 📊 Stats

- **Templates:** 5 specialized templates
- **Prompts:** 15+ audited prompts
- **Examples:** 25+ real-world examples
- **Contributors:** Growing community
```

### CLAUDE.md Integration
```markdown
# CLAUDE.md

## Repository Overview
This is Jeremy's comprehensive prompt engineering toolkit repository with:
- Audited prompt collection following ####-PHASE-MMDDYY-DESCRIPTION.md convention
- 5 specialized templates (Basic Task, Complex Workflow, Research, Troubleshooting, Setup)
- Community contribution framework with quality control

## Task Warrior Integration
When working in this repository, use these Task Warrior aliases:
- `task prompts` - View all prompt project tasks
- `task prompt-dev` - Development tasks
- `task prompt-review` - Review tasks
- `task prompt-community` - Community management tasks

## Filing System Rules
ALWAYS follow the naming convention for new prompts:
- Check highest number: `ls -la prompts/ | grep "\.md$" | tail -1`
- Use next sequential number
- Include appropriate phase (SETUP, DEBUG, CLEAN, PLAN, TEST, FEAT, SEC)
- Use work date in MMDDYY format
- Create clear, descriptive names

## Quality Standards
- All prompts must include examples
- Templates must have success criteria
- Documentation must be comprehensive
- Community submissions require peer review
```

---

## ✅ Success Metrics

### Technical Metrics
- **Repository Structure:** 100% implementation of planned structure
- **Filing System:** 100% compliance with naming convention
- **Automation:** 95% of quality checks automated
- **Documentation:** 100% coverage of features and templates

### Community Metrics
- **Contributors:** Target 50+ contributors in first 6 months
- **Submissions:** Target 100+ community prompts in first year
- **Usage:** Target 1000+ repository stars in first year
- **Quality:** Maintain 95%+ approval rate for submissions

### Performance Metrics
- **Search Response:** <200ms for all search queries
- **Site Load Time:** <2s for all documentation pages
- **API Response:** <100ms for all API endpoints
- **Build Time:** <5min for complete site generation

---

**Document Status:** ✅ Complete
**Implementation Ready:** Ready for Phase 1 execution
**Task Warrior Ready:** Tasks available for import via `tools/taskwarrior/import-tasks.py`