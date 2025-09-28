#!/usr/bin/env python3
"""
Validate YAML frontmatter in template files.
"""

import os
import sys
import yaml
import re

REQUIRED_FRONTMATTER_FIELDS = ['name', 'description', 'model']

def validate_frontmatter_file(filepath):
    """Validate frontmatter in a single file."""
    errors = []

    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()

        # Check if file starts with frontmatter
        if not content.startswith('---'):
            return [f"{filepath}: Missing frontmatter"]

        # Extract frontmatter
        parts = content.split('---', 2)
        if len(parts) < 3:
            return [f"{filepath}: Invalid frontmatter format"]

        frontmatter_yaml = parts[1].strip()

        try:
            frontmatter = yaml.safe_load(frontmatter_yaml)
        except yaml.YAMLError as e:
            return [f"{filepath}: Invalid YAML in frontmatter - {e}"]

        if not isinstance(frontmatter, dict):
            return [f"{filepath}: Frontmatter must be a YAML object"]

        # Check required fields
        for field in REQUIRED_FRONTMATTER_FIELDS:
            if field not in frontmatter:
                errors.append(f"{filepath}: Missing required field '{field}'")
            elif not frontmatter[field]:
                errors.append(f"{filepath}: Field '{field}' cannot be empty")

        # Validate specific field formats
        if 'model' in frontmatter:
            valid_models = ['opus', 'sonnet', 'haiku', 'gpt-4', 'gpt-3.5']
            if frontmatter['model'] not in valid_models:
                errors.append(f"{filepath}: Invalid model '{frontmatter['model']}' (valid: {', '.join(valid_models)})")

    except Exception as e:
        errors.append(f"{filepath}: Error reading file - {e}")

    return errors

def validate_frontmatter():
    """Validate frontmatter in all template files."""
    errors = []

    # Find all .md files in template directories
    template_dirs = ['planning', 'setup', 'debugging', 'features', 'testing', 'cleaning', 'security', 'project-specs']

    for directory in template_dirs:
        if os.path.isdir(directory):
            for filename in os.listdir(directory):
                if filename.endswith('.md'):
                    filepath = os.path.join(directory, filename)
                    file_errors = validate_frontmatter_file(filepath)
                    errors.extend(file_errors)

    return errors

def main():
    """Main validation function."""
    print("🔍 Validating frontmatter...")

    errors = validate_frontmatter()

    if errors:
        print("❌ Frontmatter validation failed:")
        for error in errors:
            print(f"  - {error}")
        sys.exit(1)
    else:
        print("✅ Frontmatter validation passed!")

if __name__ == "__main__":
    main()