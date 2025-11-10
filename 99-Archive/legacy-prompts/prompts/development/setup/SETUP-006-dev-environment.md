---
name: dev-environment-setup
description: Complete development environment setup and configuration for new projects and team onboarding
model: opus
date: 2025-09-28
---

# Development Environment Setup Configuration

You are a development environment specialist who helps developers set up complete, production-ready development environments quickly and correctly.

## Purpose

Configure comprehensive development environments for new projects, team onboarding, or switching between different technology stacks. Ensure consistency, security, and productivity from day one.

## The Setup Prompt

### Complete Development Environment Setup

```
I need to set up a complete development environment for my project. Help me configure everything needed for productive development.

**Project Details:**
- Project type: [web app/mobile app/API/CLI tool/data science/other]
- Primary language: [JavaScript/Python/Java/Go/Rust/C#/PHP/Ruby/other]
- Framework/library: [React/Vue/Angular/Django/Flask/Spring/Express/Next.js/other]
- Database: [PostgreSQL/MySQL/MongoDB/Redis/SQLite/other]
- Cloud platform: [AWS/GCP/Azure/none]

**Current Setup:**
- Operating system: [macOS/Windows/Linux distribution]
- IDE preference: [VS Code/IntelliJ/Vim/other]
- Package manager: [npm/yarn/pip/composer/cargo/other]
- Containerization: [Docker preferred/not needed/unsure]

**Team Context:**
- Team size: [solo/2-5 people/5+ people]
- Experience level: [beginner/intermediate/advanced]
- Existing tools: [what your team already uses]

**Setup Requirements:**
Please help me configure:

1. **Development Tools Installation**
   - Install and configure all necessary development tools
   - Set up version managers (nvm, pyenv, rbenv, etc.)
   - Configure IDE/editor with essential extensions
   - Set up debugging tools and profilers

2. **Environment Configuration**
   - Set up environment variables and configuration files
   - Configure development vs staging vs production environments
   - Set up local database with sample data
   - Configure hot reloading and file watching

3. **Code Quality Tools**
   - Set up linting and formatting (ESLint, Prettier, Black, etc.)
   - Configure pre-commit hooks and git workflows
   - Set up testing framework and test utilities
   - Configure code coverage and quality metrics

4. **Development Workflow**
   - Set up build systems and task runners
   - Configure development servers and proxy settings
   - Set up API mocking and testing tools
   - Configure logging and monitoring for development

5. **Team Collaboration**
   - Set up shared configuration files (.editorconfig, .gitignore)
   - Configure consistent dependency management
   - Set up documentation and code commenting standards
   - Configure team communication tools integration

6. **Security & Best Practices**
   - Set up secret management for development
   - Configure secure communication (HTTPS, certificates)
   - Set up dependency vulnerability scanning
   - Configure access controls and permissions

**Expected Deliverables:**
- Step-by-step installation and configuration instructions
- All necessary configuration files with explanations
- Setup verification commands and health checks
- Troubleshooting guide for common issues
- Team onboarding checklist and documentation
- Environment backup and restoration procedures

**Constraints:**
[Any specific constraints, company policies, or requirements]

Please provide detailed, actionable instructions that I can follow step-by-step to get a fully functional development environment.
```

## Usage Examples

### Web Application Setup
```
Project type: web app
Primary language: JavaScript
Framework: React with TypeScript
Database: PostgreSQL
Cloud platform: AWS
Operating system: macOS
IDE: VS Code
Team size: 5 people
Experience level: intermediate
```

### Python Data Science Setup
```
Project type: data science
Primary language: Python
Framework: FastAPI + Jupyter + pandas
Database: PostgreSQL + Redis
Cloud platform: GCP
Operating system: Linux (Ubuntu)
IDE: VS Code
Team size: 3 people
Experience level: advanced
```

### Mobile Development Setup
```
Project type: mobile app
Primary language: JavaScript
Framework: React Native
Database: SQLite + Firebase
Cloud platform: Firebase
Operating system: Windows
IDE: VS Code
Team size: solo
Experience level: beginner
```

## Expected Outcomes

### Comprehensive Environment
- Fully configured development environment ready for immediate use
- All tools installed and properly integrated
- Consistent configuration across team members
- Automated setup scripts for quick reproduction

### Developer Productivity
- Hot reloading and fast feedback loops configured
- Debugging tools properly set up and functional
- Code quality tools preventing common mistakes
- Efficient workflow for building, testing, and deploying

### Team Consistency
- Shared configuration files ensuring consistency
- Clear documentation for onboarding new team members
- Standardized tools and workflows across the team
- Easy environment reproduction and backup

### Quality Assurance
- Automated testing and code quality checks
- Security best practices implemented from start
- Proper error handling and logging configured
- Performance monitoring and optimization tools ready

## Implementation Notes

### Key Techniques Used
- **Environment Isolation**: Containerization and virtual environments
- **Configuration as Code**: All settings in version-controlled files
- **Automation**: Scripts and tools for repeatable setup
- **Documentation**: Clear instructions and troubleshooting guides

### Why These Choices Work
- **Reduces Setup Time**: Comprehensive checklist prevents missed steps
- **Ensures Consistency**: Standardized approach across team and projects
- **Prevents Issues**: Proper configuration avoids common development problems
- **Enables Productivity**: All tools properly integrated from day one

### Performance Benchmarks
- Environment setup time: < 2 hours for complex stacks
- Team onboarding time: < 1 day with documentation
- Issue resolution time: < 30 minutes with troubleshooting guide
- Development workflow efficiency: 90%+ time spent on actual development

---

**Date Created:** September 28, 2025
**Last Updated:** September 28, 2025