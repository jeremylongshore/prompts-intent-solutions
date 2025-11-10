#!/usr/bin/env python3
"""
Generate docs/data/prompts.json from prompt front matter.

Usage:
    python tools/generate_prompt_catalog.py
"""

from __future__ import annotations

import json
import pathlib
from typing import Any, Dict, List

import yaml


ROOT = pathlib.Path(__file__).resolve().parents[1]
PROMPT_DIR = ROOT / "prompts"
OUTPUT_PATH = ROOT / "docs" / "data" / "prompts.json"


def load_prompt_metadata(path: pathlib.Path) -> Dict[str, Any]:
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---"):
        raise ValueError(f"{path} missing front matter")
    _, fm, _ = text.split("---", 2)
    data = yaml.safe_load(fm)
    return {
        "id": data.get("id"),
        "title": data.get("title"),
        "service_line": data.get("service_line"),
        "audience": data.get("audience"),
        "intent": data.get("intent"),
        "delivery": data.get("delivery"),
        "file": path.stem,
    }


def main() -> None:
    records: List[Dict[str, Any]] = []
    for path in sorted(PROMPT_DIR.glob("*.md")):
        if path.name.lower() == "readme.md":
            continue
        records.append(load_prompt_metadata(path))

    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_PATH.write_text(json.dumps(records, indent=2) + "\n", encoding="utf-8")
    print(f"Wrote {len(records)} prompt entries to {OUTPUT_PATH.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
