#!/usr/bin/env python3
"""Validate prompt front matter against the schema in prompts/README.md."""
import datetime
import sys

from _library import front_matter, prompt_files

REQUIRED = ["id", "title", "service_line", "audience", "intent",
            "last_reviewed", "model_hint", "tone", "delivery"]
SERVICE_LINES = {"cloud-data", "automation", "ai-agents", "private-ai", "learn"}


def validate(root=None):
    errors = []
    for path in prompt_files(root):
        fm = front_matter(path)
        if fm is None:
            errors.append(f"{path.name}: missing or unparseable YAML front matter")
            continue
        for key in REQUIRED:
            value = fm.get(key)
            if value is None or (isinstance(value, str) and not value.strip()):
                errors.append(f"{path.name}: front matter field '{key}' is missing or empty")
        if fm.get("id") is not None and fm.get("id") != path.stem:
            errors.append(f"{path.name}: id '{fm.get('id')}' does not match the filename")
        if fm.get("service_line") is not None and fm.get("service_line") not in SERVICE_LINES:
            errors.append(f"{path.name}: service_line '{fm.get('service_line')}' is not one of "
                          f"{sorted(SERVICE_LINES)}")
        reviewed = fm.get("last_reviewed")
        if reviewed is not None and not isinstance(reviewed, datetime.date):
            errors.append(f"{path.name}: last_reviewed must be a YYYY-MM-DD date")
    return errors


def main():
    print("🔍 Validating frontmatter...")
    files = prompt_files()
    errors = validate()
    if errors:
        print("❌ Frontmatter validation failed:")
        for e in errors:
            print(f"  - {e}")
        sys.exit(1)
    print(f"✅ Frontmatter validation passed! ({len(files)} prompts)")


if __name__ == "__main__":
    main()
