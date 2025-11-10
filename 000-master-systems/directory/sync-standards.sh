#!/bin/bash
# Sync Master Directory Standards to Current Project
# Run this in any project directory to sync standards and create structure

set -e

MASTER_FILE="$HOME/projects/prompts-intent-solutions/000-master-systems/directory/MASTER-DIRECTORY-STANDARDS.md"
LOCAL_FILE=".directory-standards.md"

echo "🔄 Syncing Master Directory Standards..."

# Check if master exists
if [ ! -f "$MASTER_FILE" ]; then
  echo "❌ Master standards file not found at: $MASTER_FILE"
  exit 1
fi

# Copy master to local
cp "$MASTER_FILE" "$LOCAL_FILE"
echo "✅ Copied master standards to $LOCAL_FILE"

# Create standard directory structure
echo "📁 Creating standard directory structure..."

mkdir -p .github .vscode
mkdir -p claudes-docs/{reports,audits,analysis,plans,tasks,logs,misc}
mkdir -p 01-Docs/{architecture,api,guides,meetings}
mkdir -p 02-Src/{core,features,shared,vendor}
mkdir -p 03-Tests/{unit,integration,e2e}
mkdir -p 04-Assets/{images,data,configs}
mkdir -p 05-Scripts/{build,deploy,maintenance}
mkdir -p 06-Infrastructure/{docker,kubernetes,terraform}
mkdir -p 07-Releases/{current,archive}
mkdir -p 99-Archive/{deprecated,legacy}

echo "✅ Directory structure created"

# Create required root files if they don't exist
if [ ! -f "README.md" ]; then
  cat > README.md << 'EOF'
# Project Name

Brief description

## Quick Start

Setup steps here

## Documentation

See `01-Docs/` for full documentation

## Status

Current status and version
EOF
  echo "✅ Created README.md template"
fi

if [ ! -f "CLAUDE.md" ]; then
  cat > CLAUDE.md << 'EOF'
# CLAUDE.md

This file provides guidance to Claude Code when working in this repository.

## Project Overview

[Describe what this project is]

## Directory Structure

This project follows the Master Directory Standards.
See `.directory-standards.md` for complete details.

## Common Commands

[List development commands]

## Important Notes

[Project-specific context for Claude]
EOF
  echo "✅ Created CLAUDE.md template"
fi

if [ ! -f ".gitignore" ]; then
  cat > .gitignore << 'EOF'
# Dependencies
node_modules/
vendor/
__pycache__/

# Environment
.env
.env.local
*.env

# Build outputs
dist/
build/
*.log

# IDE
.vscode/
.idea/

# OS
.DS_Store
Thumbs.db

# Claude docs (uncommit if needed for your project)
claudes-docs/
EOF
  echo "✅ Created .gitignore"
fi

echo ""
echo "🎉 Directory standards synced successfully!"
echo ""
echo "📋 Next steps:"
echo "  1. Review and customize README.md"
echo "  2. Review and customize CLAUDE.md"
echo "  3. Add LICENSE file if needed"
echo "  4. Run 'git add .' to stage new structure"
echo ""
echo "📖 Full standards: cat .directory-standards.md"
