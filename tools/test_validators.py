#!/usr/bin/env python3
"""Each validator must reject a bad library. Until 2026-09 all of them passed on
an empty scan; these cases keep that from coming back. Run: python tools/test_validators.py"""
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import check_duplicates  # noqa: E402
import validate_filenames  # noqa: E402
import validate_frontmatter  # noqa: E402
import validate_structure  # noqa: E402

GOOD = """---
id: {id}
title: A prompt
service_line: learn
audience: operators
intent: do one job
last_reviewed: 2026-01-01
model_hint: claude
tone: direct
delivery: markdown
---

# Body
"""


def library(tmp, prompts, index_ids=None):
    root = Path(tmp)
    (root / "prompts").mkdir()
    for name, body in prompts.items():
        (root / "prompts" / name).write_text(body, encoding="utf-8")
    ids = index_ids if index_ids is not None else [n[:-3] for n in prompts]
    rows = "\n".join(f"| `{i}` | t | s | u |" for i in ids)
    (root / "prompts" / "README.md").write_text(f"| ID | T | S | U |\n|----|---|---|---|\n{rows}\n", encoding="utf-8")
    return root


class Validators(unittest.TestCase):
    def test_empty_library_is_refused_not_passed(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = library(tmp, {})
            for mod in (validate_filenames, validate_frontmatter, check_duplicates):
                with self.assertRaises(SystemExit) as ctx:
                    mod.validate(root)
                self.assertEqual(ctx.exception.code, 1, mod.__name__)

    def test_clean_library_passes_everything(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = library(tmp, {"12-learn-thing.md": GOOD.format(id="12-learn-thing")})
            self.assertEqual(validate_filenames.validate(root), [])
            self.assertEqual(validate_frontmatter.validate(root), [])
            self.assertEqual(check_duplicates.validate(root), [])

    def test_bad_filenames_are_named(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = library(tmp, {"Learn_Thing.md": GOOD.format(id="Learn_Thing"),
                                 "1-learn-thing.md": GOOD.format(id="1-learn-thing")})
            self.assertEqual(len(validate_filenames.validate(root)), 2)

    def test_front_matter_defects_are_each_reported(self):
        good = GOOD.format(id="12-learn-thing")
        cases = {
            "missing block": "# no front matter\n",
            "missing field": good.replace("tone: direct\n", ""),
            "empty field": good.replace("tone: direct", "tone: ''"),
            "id mismatch": good.replace("id: 12-learn-thing", "id: something-else"),
            "bad service line": good.replace("service_line: learn", "service_line: marketing"),
            "bad date": good.replace("2026-01-01", "last spring"),
        }
        for label, body in cases.items():
            with tempfile.TemporaryDirectory() as tmp:
                root = library(tmp, {"12-learn-thing.md": body})
                self.assertTrue(validate_frontmatter.validate(root), label)

    def test_duplicate_ids_and_index_drift(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = library(tmp, {"12-learn-a.md": GOOD.format(id="12-learn-a"),
                                 "12-learn-b.md": GOOD.format(id="12-learn-a")})
            self.assertTrue(any("Duplicate" in e for e in check_duplicates.validate(root)))
        with tempfile.TemporaryDirectory() as tmp:
            root = library(tmp, {"12-learn-a.md": GOOD.format(id="12-learn-a")}, index_ids=["12-learn-gone"])
            errors = check_duplicates.validate(root)
            self.assertTrue(any("not listed" in e for e in errors))
            self.assertTrue(any("does not exist" in e for e in errors))

    def test_structure_reports_what_is_missing(self):
        with tempfile.TemporaryDirectory() as tmp:
            errors = validate_structure.validate(tmp)
            self.assertIn("Missing required directory: prompts", errors)
            self.assertIn("Missing required file: prompts/README.md", errors)

    def test_the_real_repository_is_clean(self):
        for mod in (validate_filenames, validate_frontmatter, validate_structure, check_duplicates):
            self.assertEqual(mod.validate(), [], mod.__name__)


if __name__ == "__main__":
    unittest.main(verbosity=1)
