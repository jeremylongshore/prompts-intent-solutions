#!/usr/bin/env python3
"""Validate the repository layout the library actually uses.

This used to require the 2025-09 category folders (`planning/`, `setup/`, ...),
`STRUCTURE.md` and an ADR that the 2025-11 rebuild deleted, so it failed on
every run for ten months.
"""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
REQUIRED_DIRECTORIES = ["prompts", "tools", "000-master-systems"]
REQUIRED_FILES = ["README.md", "CHANGELOG.md", "version.txt", ".gitignore", "prompts/README.md"]


def validate(root=None):
    base = Path(root) if root else ROOT
    errors = [f"Missing required directory: {d}" for d in REQUIRED_DIRECTORIES if not (base / d).is_dir()]
    errors += [f"Missing required file: {f}" for f in REQUIRED_FILES if not (base / f).is_file()]
    return errors


def main():
    print("🔍 Validating repository structure...")
    errors = validate()
    if errors:
        print("❌ Structure validation failed:")
        for e in errors:
            print(f"  - {e}")
        sys.exit(1)
    print("✅ Repository structure validation passed!")


if __name__ == "__main__":
    main()
