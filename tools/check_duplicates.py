#!/usr/bin/env python3
"""No two prompts share an id, and the index in prompts/README.md lists exactly
the prompts that exist."""
import re
import sys
from collections import Counter
from pathlib import Path

from _library import front_matter, prompt_files

INDEX_ROW = re.compile(r"^\|\s*`([^`]+)`\s*\|", re.M)


def validate(root=None):
    files = prompt_files(root)
    ids = [(front_matter(p) or {}).get("id") or p.stem for p in files]
    errors = [f"Duplicate prompt id: {i} ({n} files)" for i, n in Counter(ids).items() if n > 1]
    index_path = (Path(root) / "prompts" / "README.md") if root else files[0].parent / "README.md"
    if not index_path.is_file():
        return errors + ["prompts/README.md index is missing"]
    indexed = set(INDEX_ROW.findall(index_path.read_text(encoding="utf-8")))
    stems = {p.stem for p in files}
    errors += [f"{s}.md exists but is not listed in prompts/README.md" for s in sorted(stems - indexed)]
    errors += [f"prompts/README.md lists '{s}' but prompts/{s}.md does not exist" for s in sorted(indexed - stems)]
    return errors


def main():
    print("🔍 Checking for duplicate ids and index drift...")
    errors = validate()
    if errors:
        print("❌ Duplicate/index check failed:")
        for e in errors:
            print(f"  - {e}")
        sys.exit(1)
    print("✅ No duplicate ids; the index matches the library.")


if __name__ == "__main__":
    main()
