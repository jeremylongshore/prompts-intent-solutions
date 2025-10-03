#!/bin/bash
# fix-documentation.sh - Automated documentation fixes

fix_documentation_issue() {
  local ISSUE_NUMBER="$1"
  local TITLE="$2"

  case "$TITLE" in
    *"README"*)
      echo "→ Enhancing README..."
      if [ ! -f "README.md" ] || [ $(wc -l < "README.md") -lt 20 ]; then
        cat > README.md << EOF
# $REPO_NAME

Professional prompt engineering templates and AI solutions for business optimization.

## Overview

This repository contains a comprehensive collection of prompt templates organized by business function, designed to help professionals leverage AI tools effectively.

## Quick Start

1. Browse the available prompt categories
2. Copy the relevant prompt template
3. Customize for your specific use case
4. Apply with your preferred AI tool

## Structure

- \`marketing-sales/\` - Marketing and sales prompts
- \`finance/\` - Financial analysis and reporting
- \`operations/\` - Operational efficiency prompts
- \`tools/\` - Repository management tools
- \`000-master-systems/\` - Core productivity systems

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.

## License

See [LICENSE](LICENSE) file for details.
EOF
        git add README.md
        git commit -m "fix: Enhance README documentation

Closes #$ISSUE_NUMBER"
        gh issue close $ISSUE_NUMBER --reason completed >/dev/null 2>&1
        return 0
      fi
      ;;

    *"CONTRIBUTING"*)
      echo "→ Creating CONTRIBUTING.md..."
      cat > CONTRIBUTING.md << 'EOF'
# Contributing to Prompts Intent Solutions

We welcome contributions! Please follow these guidelines:

## How to Contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-prompt-template`)
3. Add your prompt template following our structure
4. Commit your changes (`git commit -m 'Add marketing automation prompt'`)
5. Push to the branch (`git push origin feature/new-prompt-template`)
6. Open a Pull Request

## Prompt Template Guidelines

- Use clear, descriptive filenames
- Include proper frontmatter with metadata
- Provide usage examples
- Follow the established directory structure

## Code Style

- Follow existing markdown formatting
- Use consistent naming conventions
- Include date stamps for new templates

## Reporting Issues

Use GitHub Issues to report bugs or request new prompt templates.
EOF
      git add CONTRIBUTING.md
      git commit -m "fix: Add contribution guidelines

Closes #$ISSUE_NUMBER"
      gh issue close $ISSUE_NUMBER --reason completed >/dev/null 2>&1
      return 0
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
      gh issue close $ISSUE_NUMBER --reason completed >/dev/null 2>&1
      return 0
      ;;

    *"CODE_OF_CONDUCT"*)
      echo "→ Adding Code of Conduct..."
      cat > CODE_OF_CONDUCT.md << 'EOF'
# Code of Conduct

## Our Pledge

We pledge to make participation in our project a harassment-free experience for everyone.

## Our Standards

Examples of behavior that contributes to a positive environment:

- Using welcoming and inclusive language
- Being respectful of differing viewpoints
- Gracefully accepting constructive criticism
- Focusing on what is best for the community

## Enforcement

Project maintainers are responsible for clarifying standards and taking appropriate action.

## Contact

Report incidents to: conduct@example.com
EOF
      git add CODE_OF_CONDUCT.md
      git commit -m "fix: Add code of conduct

Closes #$ISSUE_NUMBER"
      gh issue close $ISSUE_NUMBER --reason completed >/dev/null 2>&1
      return 0
      ;;

    *)
      manual_fix_required "$ISSUE_NUMBER" "$TITLE"
      return 1
      ;;
  esac
}