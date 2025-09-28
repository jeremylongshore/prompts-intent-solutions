#!/usr/bin/env python3
"""
Validate filename conventions per ADR-001 specifications.
Format: CATEGORY-###-description-MMDDYY.md
"""

import os
import re
import sys
from pathlib import Path

# Valid categories per ADR-001
VALID_CATEGORIES = [
    'PLAN', 'SETUP', 'DEBUG', 'FEAT', 'TEST', 'CLEAN', 'SEC'
]

# Filename pattern: CATEGORY-###-description-MMDDYY.md
FILENAME_PATTERN = re.compile(r'^([A-Z]+)-(\d{3})-([a-z0-9-]+)-(\d{6})\.md$')

# Project spec pattern: ###-TYPE-description-MMDDYY.md
PROJECT_SPEC_PATTERN = re.compile(r'^(\d{3})-(PRD|ARD|TRD)-([a-z0-9-]+)-(\d{6})\.md$')

def validate_template_filename(filepath, category_dir):
    """Validate template filename in category directories."""
    filename = os.path.basename(filepath)

    match = FILENAME_PATTERN.match(filename)
    if not match:
        return f"Invalid filename format: {filename} (expected: CATEGORY-###-description-MMDDYY.md)"

    category, number, description, date = match.groups()

    # Check category matches directory
    expected_category = {
        'planning': 'PLAN',
        'setup': 'SETUP',
        'debugging': 'DEBUG',
        'features': 'FEAT',
        'testing': 'TEST',
        'cleaning': 'CLEAN',
        'security': 'SEC'
    }.get(category_dir)

    if category != expected_category:
        return f"Category mismatch: {filename} in {category_dir}/ (expected {expected_category}-)"

    # Validate number format
    if not number.isdigit() or len(number) != 3:
        return f"Invalid number format: {number} (expected: 001, 002, etc.)"

    # Validate date format (basic check)
    if not date.isdigit() or len(date) != 6:
        return f"Invalid date format: {date} (expected: MMDDYY)"

    return None

def validate_project_spec_filename(filepath):
    """Validate project spec filename in project-specs directory."""
    filename = os.path.basename(filepath)

    match = PROJECT_SPEC_PATTERN.match(filename)
    if not match:
        return f"Invalid project spec format: {filename} (expected: ###-TYPE-description-MMDDYY.md)"

    number, doc_type, description, date = match.groups()

    # Validate document type
    if doc_type not in ['PRD', 'ARD', 'TRD']:
        return f"Invalid document type: {doc_type} (expected: PRD, ARD, or TRD)"

    return None

def validate_filenames():
    """Validate all template filenames in the repository."""
    errors = []

    # Category directories
    category_dirs = ['planning', 'setup', 'debugging', 'features', 'testing', 'cleaning', 'security']

    for category_dir in category_dirs:
        if os.path.isdir(category_dir):
            for filename in os.listdir(category_dir):
                if filename.endswith('.md'):
                    filepath = os.path.join(category_dir, filename)
                    error = validate_template_filename(filepath, category_dir)
                    if error:
                        errors.append(error)

    # Project specs directory
    if os.path.isdir('project-specs'):
        for filename in os.listdir('project-specs'):
            if filename.endswith('.md'):
                filepath = os.path.join('project-specs', filename)
                error = validate_project_spec_filename(filepath)
                if error:
                    errors.append(error)

    return errors

def main():
    """Main validation function."""
    print("🔍 Validating filename conventions...")

    errors = validate_filenames()

    if errors:
        print("❌ Filename validation failed:")
        for error in errors:
            print(f"  - {error}")
        sys.exit(1)
    else:
        print("✅ Filename validation passed!")

if __name__ == "__main__":
    main()