#!/usr/bin/env python3
"""
Check for duplicate numbering within categories.
"""

import os
import re
import sys
from collections import defaultdict

def check_duplicates():
    """Check for duplicate numbers within each category."""
    errors = []

    # Track numbers by category
    category_numbers = defaultdict(list)

    # Category directories
    category_dirs = ['planning', 'setup', 'debugging', 'features', 'testing', 'cleaning', 'security']

    for category_dir in category_dirs:
        if os.path.isdir(category_dir):
            for filename in os.listdir(category_dir):
                if filename.endswith('.md'):
                    # Extract number from filename
                    match = re.match(r'^[A-Z]+-(\d{3})-', filename)
                    if match:
                        number = match.group(1)
                        category_numbers[category_dir].append((number, filename))

    # Check for duplicates within each category
    for category, number_files in category_numbers.items():
        numbers = [num for num, _ in number_files]
        seen = set()

        for number, filename in number_files:
            if number in seen:
                errors.append(f"Duplicate number {number} in {category}/: {filename}")
            seen.add(number)

    # Check project-specs for duplicate project IDs
    if os.path.isdir('project-specs'):
        project_numbers = defaultdict(list)

        for filename in os.listdir('project-specs'):
            if filename.endswith('.md'):
                match = re.match(r'^(\d{3})-', filename)
                if match:
                    project_id = match.group(1)
                    project_numbers[project_id].append(filename)

        # This is actually OK for project specs - same project ID should have multiple docs
        # Just report for information
        for project_id, files in project_numbers.items():
            if len(files) > 3:  # More than PRD, ARD, TRD
                print(f"ℹ️  Project {project_id} has {len(files)} documents: {', '.join(files)}")

    return errors

def main():
    """Main validation function."""
    print("🔍 Checking for duplicate numbering...")

    errors = check_duplicates()

    if errors:
        print("❌ Duplicate number validation failed:")
        for error in errors:
            print(f"  - {error}")
        sys.exit(1)
    else:
        print("✅ No duplicate numbers found!")

if __name__ == "__main__":
    main()