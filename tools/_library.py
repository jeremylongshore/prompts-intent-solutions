"""Shared view of the prompt library for the validators.

The library is the flat `prompts/` directory described in `prompts/README.md`
(files named `NN-<service>-<slug>.md` with YAML front matter). Until 2026-09 the
validators still walked the category folders that the 2025-11 rebuild removed,
found no files, and reported success on nothing. Every validator now goes
through `prompt_files()`, which refuses an empty library.
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PROMPTS_DIR = ROOT / "prompts"
INDEX = PROMPTS_DIR / "README.md"
FILENAME_PATTERN = re.compile(r"^(\d{2})-([a-z0-9]+(?:-[a-z0-9]+)+)\.md$")
FRONT_MATTER = re.compile(r"\A---\n(.*?)\n---\n", re.S)


def prompt_files(root=None):
    """Every prompt in the library, sorted. Exits 1 if there are none: a
    validator that scans zero files must never report success."""
    directory = (Path(root) / "prompts") if root else PROMPTS_DIR
    files = sorted(p for p in directory.glob("*.md") if p.name != "README.md")
    if not files:
        print(f"❌ No prompt files found under {directory}; refusing to pass on an empty library.")
        sys.exit(1)
    return files


def front_matter(path):
    """Parsed front matter dict, or None when the block is absent or not a mapping."""
    import yaml
    match = FRONT_MATTER.match(path.read_text(encoding="utf-8"))
    if not match:
        return None
    try:
        data = yaml.safe_load(match.group(1))
    except yaml.YAMLError:
        return None
    return data if isinstance(data, dict) else None
