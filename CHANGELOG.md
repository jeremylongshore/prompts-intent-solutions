# Changelog

All notable changes to this project will be documented in this file.
Format: Newest entries on TOP (reverse chronological order).

## [Unreleased]

### Changed

- Applied MASTER DIRECTORY STANDARDS to repository structure
- Updated README.md and CLAUDE.md with directory standards references
- Reorganized CHANGELOG.md to newest-first format
- Archived legacy multi-folder prompt catalog under `99-Archive/legacy-prompts/`
- Introduced flat operator-grade prompt library aligned to Intent Solutions service lines
- Replaced GitHub Pages site with dark, operator-first design fed by generated metadata
- Added `tools/generate_prompt_catalog.py` to keep site data in sync with prompt front matter
- Adopted alphabet-index numeric prefixes (`01-`, `03-`, `12-`, `15-`) across prompt IDs and filenames for consistent ordering

## [2.0.1] - 2026-09-25

### Changes since v2.0.0

- chore: release v2.0.1 [skip ci] (b91e1cc)
- docs(master-systems): add the terminal UI design master prompt (#11) (f2f0776)

## [2.0.0] - 2026-09-20

### Changes since v1.0.1

- chore: release v2.0.0 [skip ci] (61d05dc)
- fix(ci): make the release workflow parse and make template validation check the library that exists (#9) (584599b)
- ci(deps): move GitHub actions off the node20 runtime before its removal (#7) (db3d1a2)
- chore(funding): add Ko-fi alongside the existing funding sources (576d584)
- docs(readme): add the Ko-fi support badge (c8ea004)
- docs(doc-filing): add cluster-archetype standard (§3.1.2) — what a nested folder must be (d3d4598)
- docs(doc-filing): sync master to canonical v4.4, drop byte-identical rule, archive v3.0 (4af3cfb)
- bd init: initialize beads issue tracking (f54d525)
- chore: update FUNDING.yml with GitHub Sponsors + Buy Me a Coffee (eb25544)
- chore: update FUNDING.yml with GitHub Sponsors + Buy Me a Coffee (223c318)
- chore: add GitHub Sponsors funding button (b8c503d)
- docs: migrate document filing standard from 6767 to 000-* prefix (v4.3) (75bca9e)
- docs: add Beads upgrade note (whats-new + hooks) (f07147d)
- chore: add Beads (bd) workflow + ignore beads source clone (380b2ab)
- refactor: rebuild prompt library for operator-first experience (683b422)
- chore: enable automatic releases on every push (d15365f)
- chore: add global release workflow (7e9b21e)
- ci(deps): bump actions/checkout from 4 to 5 (#6) (b6c9040)
- ci(deps): bump DavidAnson/markdownlint-cli2-action from 13 to 20 (#5) (ffab31f)
- ci(deps): bump actions/setup-python from 4 to 6 (#4) (d9bf73d)

## [1.0.1] - 2025-10-02

### 🎯 Major Repository Transformation

This release represents a complete overhaul of the repository structure, organization, and presentation.

### 🏗️ Infrastructure & Organization

- **Complete directory restructure** - Organized 60+ prompt templates into logical categories
- **Removed date suffixes** - Cleaned all filenames from `CATEGORY-###-description-MMDDYY.md` to `CATEGORY-###-description.md`
- **Shell script organization** - Moved 25+ automation scripts from root to `tools/automation/`
- **Root directory cleanup** - Reduced to 8 essential files only
- **Fixed naming collisions** - Resolved PEOPLE-004 duplicate → PEOPLE-005

### 📁 New Structure

- `prompts/development/` - 37 software development templates (planning, setup, debugging, features, testing, security, maintenance)
- `prompts/business/` - 26 business operation templates (marketing, finance, operations, customer-success, people-culture)
- `prompts/specialized/` - Advanced prompts and 74 Claude Code agent configurations
- `tools/automation/` - Organized automation scripts by purpose (repository, development, maintenance)
- `docs/` - Documentation and GitHub Pages site

### 🌐 GitHub Pages Site

- **Professional monospace design** - Inspired by [the-monospace-web](https://github.com/owickstrom/the-monospace-web)
- **Live catalog** - Browse prompts at <https://jeremylongshore.github.io/prompts-intent-solutions/>
- **Mobile responsive** - Dark mode support and clean navigation
- **Proper attributions** - Credits to original design and agent sources

### 🤖 Claude Code Integration

- **74 professional agent configurations** - Imported from [wshobson/agents](https://github.com/wshobson/agents)
- **Comprehensive catalog** - All agents properly documented and categorized
- **Development specialists** - Language-specific, security, architecture, and business experts

### 📚 Documentation Excellence

- **Comprehensive READMEs** - Navigation guides for each category
- **Usage instructions** - Clear examples and best practices
- **Success metrics** - Real performance data (73% complaint turnaround, 94% collection rate)
- **Professional presentation** - Enterprise-grade organization

### 🔧 Template Quality

- **Battle-tested prompts** - Real-world usage with proven metrics
- **Clean naming** - Professional, consistent file organization
- **YAML frontmatter** - Structured metadata for all templates
- **Growth-ready** - Architecture scales to 1000+ prompts

### 🗑️ Cleanup & Fixes

- **Removed duplicates** - Eliminated redundant and conflicting files
- **Fixed validation** - Updated scripts for new naming conventions
- **Artifact cleanup** - Removed temporary files and build artifacts
- **Git synchronization** - Directory structure matches repository perfectly

### 📊 Impact Metrics

- **150+ prompt templates** organized and optimized
- **74 Claude Code agents** prominently featured
- **25+ automation scripts** properly categorized
- **Production-ready structure** ready for serious use
- **Professional presentation** with industry-standard organization

### 👏 Contributors

- Repository transformation and organization
- GitHub Pages design implementation
- Claude Code agent integration
- Comprehensive documentation system

---

*This release transforms a good prompt collection into a professional-quality prompt engineering toolkit.*
