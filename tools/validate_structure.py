#!/usr/bin/env python3
"""
Validate repository directory structure matches ADR-001 specifications.
"""

import os
import sys

REQUIRED_DIRECTORIES = [
    'planning',
    'setup',
    'debugging',
    'features',
    'testing',
    'cleaning',
    'security',
    'project-specs',
    'docs',
    'tools'
]

REQUIRED_FILES = [
    'README.md',
    'STRUCTURE.md',
    '.gitignore',
    'docs/ADR-001-TEMPLATE_SYSTEM_ARCHITECTURE.md'
]

def validate_structure():
    """Validate that required directories and files exist."""
    errors = []

    # Check required directories
    for directory in REQUIRED_DIRECTORIES:
        if not os.path.isdir(directory):
            errors.append(f"Missing required directory: {directory}")

    # Check required files
    for file_path in REQUIRED_FILES:
        if not os.path.isfile(file_path):
            errors.append(f"Missing required file: {file_path}")

    return errors

def main():
    """Main validation function."""
    print("🔍 Validating repository structure...")

    errors = validate_structure()

    if errors:
        print("❌ Structure validation failed:")
        for error in errors:
            print(f"  - {error}")
        sys.exit(1)
    else:
        print("✅ Repository structure validation passed!")

if __name__ == "__main__":
    main()