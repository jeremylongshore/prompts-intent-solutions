#!/usr/bin/env python3
"""Validate prompt filenames: `NN-<service>-<slug>.md`, lowercase, hyphenated."""
import sys

from _library import FILENAME_PATTERN, prompt_files


def validate(root=None):
    return [f"{p.name}: expected NN-<service>-<slug>.md (two digits, lowercase, hyphens)"
            for p in prompt_files(root) if not FILENAME_PATTERN.match(p.name)]


def main():
    print("🔍 Validating filename conventions...")
    files = prompt_files()
    errors = validate()
    if errors:
        print("❌ Filename validation failed:")
        for e in errors:
            print(f"  - {e}")
        sys.exit(1)
    print(f"✅ Filename validation passed! ({len(files)} prompts)")


if __name__ == "__main__":
    main()
