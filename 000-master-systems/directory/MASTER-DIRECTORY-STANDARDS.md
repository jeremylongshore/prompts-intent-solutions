# MASTER DIRECTORY STANDARDS
## Single Source of Truth for All Project Directories

**Last Updated:** 2025-10-06
**Version:** 1.2.0
**Status:** AUTHORITATIVE – All projects must sync from this file

---

## PURPOSE

This is the universal MASTER directory standards file.
All projects, regardless of type or domain, must sync from this single source of truth.
No exceptions. Use this file to create order in disorganized projects.

**Note:** This is a REFERENCE document. For AI execution prompts, see `DIRECTORY-001-professional-directory-system-100525.md`.

---

## UNIVERSAL NAMING RULES

### Files
- **kebab-case only** (all lowercase, hyphens)
- **Dates** = `YYYY-MM-DD`
- **Versions** = `name-YYYY-MM-DD-v1.ext` or `name-v1.2.3.ext`
- **No spaces, underscores, or special characters**

**Examples:**
```
✅ user-authentication.service.ts
✅ api-integration-guide-2024-10-05.md
✅ deployment-config-v2.json

❌ User Authentication.service.ts
❌ API_integration_guide.md
❌ deployment config v2.json
```

### Directories
- **Main** = PascalCase (e.g., `01-Docs`)
- **Sub** = kebab-case (e.g., `api-docs`)
- **Ordered prefixes** = `01-`, `02-`, etc.

---

## STANDARD DIRECTORY STRUCTURE

```
[PROJECT-ROOT]/
├── .github/                    # GitHub workflows, templates, configs
├── .vscode/                    # VS Code settings (optional)
├── claudes-docs/               # Claude-created documentation (FLAT, no subdirectories)
├── 01-Docs/                    # All documentation here (FLAT, no subdirectories)
├── 02-Src/                     # Source code
│   ├── core/                   # Core business logic
│   ├── features/               # Feature modules
│   ├── shared/                 # Shared utilities
│   └── vendor/                 # Third-party code
├── 03-Tests/                   # Test suites
│   ├── unit/                   # Unit tests
│   ├── integration/            # Integration tests
│   └── e2e/                    # End-to-end tests
├── 04-Assets/                  # Static assets
│   ├── images/                 # Image resources
│   ├── data/                   # Data files
│   └── configs/                # Configuration files
├── 05-Scripts/                 # Automation scripts
│   ├── build/                  # Build scripts
│   ├── deploy/                 # Deployment scripts
│   └── maintenance/            # Maintenance scripts
├── 06-Infrastructure/          # Infrastructure as Code
│   ├── docker/                 # Container definitions
│   ├── kubernetes/             # Orchestration configs
│   └── terraform/              # Infrastructure definitions
├── 07-Releases/                # Release artifacts
│   ├── current/                # Current production
│   └── archive/                # Historical releases
├── 99-Archive/                 # Archived items
│   ├── deprecated/             # Deprecated but preserved
│   └── legacy/                 # Legacy reference
├── .gitignore                  # Git ignore rules
├── README.md                   # Project overview
├── CLAUDE.md                   # Claude Code instructions
├── CHANGELOG.md                # Version history (NEWEST on top)
└── LICENSE                     # License file
```

---

## DOCS FILE NAMING STANDARD

### Format

```
NNN-abv-short-description.ext
```

- **NNN** = Zero-padded sequence number (chronology enforced)
- **abv** = Approved abbreviation from table below
- **short-description** = 1–4 words, kebab-case
- **ext** = File extension

### Sub-Tasks

When a document has multiple related sub-documents:

```
005-tsk-api-endpoints.md
005a-tsk-auth-endpoints.md
005b-tsk-payment-endpoints.md

006-rsk-security-audit.md
006-1-rsk-encryption-review.md
006-2-rsk-access-controls.md
```

---

## UNIVERSAL ABBREVIATION TABLE (COMPLETE)

### Product & Planning
| Abv | Meaning |
|-----|---------|
| prd | Product Requirements Document |
| pln | Plan/Planning Document |
| rmp | Roadmap |
| brd | Business Requirements Document |
| frd | Functional Requirements Document |
| sow | Statement of Work |
| kpi | Key Performance Indicators |
| okr | Objectives and Key Results |

### Architecture & Technical Decisions
| Abv | Meaning |
|-----|---------|
| adr | Architecture Decision Record |
| tad | Technical Architecture Document |
| dsg | Design Document/Specification |
| api | API Documentation |
| sdk | SDK Documentation |
| int | Integration Documentation |
| dia | Diagram/Visual Documentation |

### Development & Code
| Abv | Meaning |
|-----|---------|
| dev | Development Notes |
| cod | Code Documentation |
| lib | Library Documentation |
| mod | Module Documentation |
| cmp | Component Documentation |
| hlp | Helper/Utility Documentation |

### Testing & Quality
| Abv | Meaning |
|-----|---------|
| tst | Test Plan/Strategy |
| tsc | Test Case Documentation |
| qap | Quality Assurance Plan |
| bug | Bug Report/Analysis |
| perf | Performance Testing |
| sec | Security Audit/Testing |
| pen | Penetration Test Results |

### Operations & Deployment
| Abv | Meaning |
|-----|---------|
| ops | Operations Documentation |
| dep | Deployment Guide/Log |
| inf | Infrastructure Documentation |
| cfg | Configuration Documentation |
| env | Environment Setup |
| rel | Release Notes |
| chg | Change Log/Management |
| inc | Incident Report |
| pst | Post-Mortem/Incident Analysis |

### Logs & Status
| Abv | Meaning |
|-----|---------|
| log | Status Log/Journal |
| wrk | Work Log/Session Notes |
| prg | Progress Report |
| sts | Status Report/Update |
| chk | Checkpoint/Milestone Log |

### Reports & Analysis
| Abv | Meaning |
|-----|---------|
| rpt | General Report |
| anl | Analysis/Research Report |
| aud | Audit Report |
| rev | Review Document |
| rca | Root Cause Analysis |
| dat | Data Analysis |
| met | Metrics Report |
| bch | Benchmark Results |

### Meetings & Communication
| Abv | Meaning |
|-----|---------|
| mtg | Meeting Notes/Minutes |
| agd | Agenda |
| act | Action Items |
| sum | Summary/Executive Summary |
| mem | Memo/Communication |
| prs | Presentation |
| wkp | Workshop Notes |

### Project Management
| Abv | Meaning |
|-----|---------|
| tsk | Task Breakdown/List |
| bkl | Backlog |
| spr | Sprint Plan/Notes |
| ret | Retrospective |
| stb | Standup Notes |
| rsk | Risk Register/Assessment |
| iss | Issue Tracker/Log |

### Documentation & Reference
| Abv | Meaning |
|-----|---------|
| ref | Reference Material/Guide |
| gde | User Guide/Handbook |
| man | Manual |
| faq | FAQ Document |
| gls | Glossary |
| sop | Standard Operating Procedure |
| tmp | Template |
| chk | Checklist |

### User & Customer
| Abv | Meaning |
|-----|---------|
| usr | User Documentation |
| onb | Onboarding Guide |
| trn | Training Materials |
| fbk | Feedback/User Feedback |
| sur | Survey Results |
| ivw | Interview Notes/Transcripts |
| per | Persona Documentation |

### Business & Legal
| Abv | Meaning |
|-----|---------|
| ctr | Contract/Agreement |
| nda | Non-Disclosure Agreement |
| lic | License Documentation |
| cmp | Compliance Documentation |
| pol | Policy Document |
| trm | Terms & Conditions |
| prv | Privacy Documentation |

### Research & Learning
| Abv | Meaning |
|-----|---------|
| rsr | Research Notes |
| lrn | Learning/Study Notes |
| exp | Experiment/POC Documentation |
| prp | Proposal |
| wht | Whitepaper |
| cse | Case Study |

### After Action & Retrospectives
| Abv | Meaning |
|-----|---------|
| aar | After Action Report |
| lsn | Lessons Learned |
| pmi | Post-Mortem/Incident Review |

### Workflows & Automation
| Abv | Meaning |
|-----|---------|
| wfl | Workflow Documentation |
| n8n | n8n Workflow Documentation |
| aut | Automation Documentation |
| hok | Webhook Documentation |

### Data & Datasets
| Abv | Meaning |
|-----|---------|
| dta | Data Documentation |
| csv | CSV Dataset Documentation |
| sql | SQL/Database Documentation |
| exp | Data Export Documentation |

### Miscellaneous
| Abv | Meaning |
|-----|---------|
| msc | Miscellaneous/General |
| dft | Draft/Temporary |
| arc | Archive Notes |
| old | Deprecated/Old Version |
| wip | Work in Progress |
| idx | Index/Table of Contents |

---

## EXAMPLE CHRONOLOGY

```
01-Docs/
├── 001-adr-initial-architecture.md
├── 002-prd-core-features.md
├── 003-mtg-kickoff-notes.md
├── 004-pln-sprint-1-roadmap.pdf
├── 005-tsk-api-endpoints.md
├── 005a-tsk-auth-endpoints.md
├── 005b-tsk-payment-endpoints.md
├── 006-rsk-data-security.md
├── 007-adr-database-choice.md
├── 008-mtg-client-feedback.md
├── 009-aar-sprint-1-review.md
└── 010-log-error-analysis.txt
```

---

## README.md REQUIREMENTS

Every `README.md` must contain:

```markdown
## Directory Standards

This project follows the MASTER DIRECTORY STANDARDS.
See `.directory-standards.md` for details.
All documentation is stored in `01-Docs/` using the `NNN-abv-description.ext` format.
```

---

## CLAUDE.md REQUIREMENTS

Every `CLAUDE.md` must contain:

```markdown
## Directory Standards

Follow `.directory-standards.md` for structure and file naming.
- Store all docs in `01-Docs/`
- Use `NNN-abv-description.ext` format with approved abbreviations
- Maintain strict chronological order
```

---

## CHANGELOG.md REQUIREMENTS

Every project MUST have `CHANGELOG.md` in the root:

**Format:** Newest entries on TOP (reverse chronological)

```markdown
# CHANGELOG

All notable changes to this project will be documented in this file.

## [Unreleased]
- Feature in progress...

## [1.2.0] - 2025-10-06
### Added
- New authentication system
- API rate limiting

### Changed
- Improved database queries
- Updated dependencies

### Fixed
- Memory leak in background worker

## [1.1.0] - 2025-09-15
### Added
- User profile page
- Email notifications

## [1.0.0] - 2025-08-01
### Added
- Initial release
```

**Key Rules:**
- **NEWEST first** (reverse chronological order)
- Use semantic versioning: `[MAJOR.MINOR.PATCH]`
- Include date: `- YYYY-MM-DD`
- Categories: Added, Changed, Deprecated, Removed, Fixed, Security
- Keep it concise and user-focused

---

## COMPLIANCE CHECKLIST

```
□ .directory-standards.md exists and is current
□ All files follow kebab-case naming
□ All directories follow PascalCase/kebab-case rules
□ Docs files follow NNN-abv-description format
□ README.md references directory standards and docs filing
□ CLAUDE.md references directory standards and docs filing
□ Required root files present (README, CLAUDE, LICENSE, .gitignore, CHANGELOG)
□ CHANGELOG.md exists with newest entries on top (reverse chronological)
□ No forbidden patterns (spaces, underscores, ALLCAPS)
□ No secrets exposed (.env, API keys)
□ Max depth ≤ 4 levels
□ claudes-docs/ is flat (no subdirectories)
```

---

## FORBIDDEN PATTERNS

**NEVER allow these:**

### File Naming
```
❌ spaces in names.txt
❌ ALLCAPS.TXT
❌ mixed_Case-names.md
❌ special!characters@#$.pdf
❌ version_final_FINAL_v2.doc
```

### Directory Structure
```
❌ Files loose in root (except approved list)
❌ Depth > 4 levels
❌ Mixed content types in one folder
❌ Duplicate directories (docs/ and documentation/)
❌ Temp files (.tmp, .cache, .bak)
❌ Subdirectories in 01-Docs/ (keep flat)
❌ Subdirectories in claudes-docs/ (keep flat)
```

### Security
```
❌ .env files committed
❌ API keys in code
❌ Passwords in configs
❌ Private keys anywhere
❌ Secrets in git history
```

---

## SYNC PROTOCOL

### For AI Assistants

When asked to sync or apply these standards to a project:

1. **Copy this standards file** to project as `.directory-standards.md`
2. **Create standard structure** (see directory tree above)
3. **Move files** to correct locations
4. **Rename files** to follow naming conventions
5. **Update README.md and CLAUDE.md** with required sections
6. **Validate** against compliance checklist
7. **Report** what was changed

### For Humans

Use the AI execution prompt: `DIRECTORY-001-professional-directory-system-100525.md`

---

## VERSION HISTORY

- **1.2.0** (2025-10-06) – Added CHANGELOG.md requirement with reverse chronological order (newest on top)
- **1.1.1** (2025-10-06) – **CRITICAL FIX**: Made claudes-docs/ FLAT (no subdirectories), same as 01-Docs/
- **1.1.0** (2025-10-06) – **MAJOR UPDATE**: Expanded abbreviation table from 22 to 120+ abbreviations organized by category
- **1.0.6** (2025-10-05) – Removed bash scripts, converted to AI reference doc
- **1.0.5** (2025-10-05) – Added triage command, remediation protocol, README/CLAUDE references
- **1.0.4** (2025-10-05) – Required README/CLAUDE references to standards
- **1.0.3** (2025-10-05) – Added Docs file naming + abbreviation table
- **1.0.2** (2025-10-05) – Removed Docs subdirectories, flat structure only
- **1.0.1** (2025-10-05) – Universalized version, no project-specific ties
- **1.0.0** (2025-10-04) – Initial master standards

---

## AUTHORITY

This file is the **SINGLE SOURCE OF TRUTH** for all directory organization across all Jeremy Longshore projects.

**No project-specific variations allowed without explicit approval.**

Sync this file to every project. When this file updates, all projects must re-sync.

---

**Questions or proposed changes:** Open issue in prompts-intent-solutions repo

**Master Location:** `~/projects/prompts-intent-solutions/000-master-systems/directory/MASTER-DIRECTORY-STANDARDS.md`

**AI Execution Prompt:** `~/projects/prompts-intent-solutions/000-master-systems/directory/DIRECTORY-001-professional-directory-system-100525.md`

---

*MASTER DIRECTORY STANDARDS – Universal Truth for All Projects*
