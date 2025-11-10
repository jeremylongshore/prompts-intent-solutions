# MASTER DIRECTORY STANDARDS
## Single Source of Truth for All Project Directories

**Last Updated:** 2025-10-16
**Version:** 2.0.0
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

### Format Specification
```
NNN-CC-ABCD-short-description.ext
```

**Components:**
- **NNN** = Zero-padded sequence number (001-999) - enforces chronology
- **CC** = 2-letter category code (PP, AT, DC, TQ, OD, LS, RA, MC, PM, DR, UC, BL, RL, AA, WA, DD, MS)
- **ABCD** = 4-letter document type abbreviation (PROD, ADEC, TASK, MEET, etc.)
- **short-description** = 1–4 words, kebab-case, lowercase
- **ext** = File extension (.md, .pdf, .txt, etc.)

**Example:** `005-PM-TASK-api-endpoints.md`

### Sub-Tasks Format

When a document has multiple related sub-documents:

**Option A - Letter Suffix:**
```
005-PM-TASK-api-endpoints.md
005a-PM-TASK-auth-endpoints.md
005b-PM-TASK-payment-endpoints.md
```

**Option B - Numeric Suffix:**
```
006-PM-RISK-security-audit.md
006-1-PM-RISK-encryption-review.md
006-2-PM-RISK-access-controls.md
```

---

## CATEGORY CODES (2-LETTER)

| Code | Category | Description |
|------|----------|-------------|
| **PP** | Product & Planning | Requirements, roadmaps, business planning |
| **AT** | Architecture & Technical | Technical decisions, system design |
| **DC** | Development & Code | Code documentation, modules, components |
| **TQ** | Testing & Quality | Test plans, QA, bugs, security audits |
| **OD** | Operations & Deployment | DevOps, deployment, infrastructure |
| **LS** | Logs & Status | Status logs, work logs, progress tracking |
| **RA** | Reports & Analysis | Reports, analytics, research findings |
| **MC** | Meetings & Communication | Meeting notes, memos, presentations |
| **PM** | Project Management | Tasks, sprints, backlogs, risks |
| **DR** | Documentation & Reference | Guides, manuals, references, SOPs |
| **UC** | User & Customer | User docs, onboarding, training, feedback |
| **BL** | Business & Legal | Contracts, compliance, policies, legal |
| **RL** | Research & Learning | Research, experiments, POCs, proposals |
| **AA** | After Action & Review | Post-mortems, retrospectives, lessons |
| **WA** | Workflows & Automation | Workflow docs, n8n, automation, webhooks |
| **DD** | Data & Datasets | Data documentation, CSV, SQL, exports |
| **MS** | Miscellaneous | General, drafts, archives, work-in-progress |

---

## DOCUMENT TYPE ABBREVIATIONS (4-LETTER)

#### PP - Product & Planning
| Code | Full Name | Usage |
|------|-----------|-------|
| **PROD** | Product Requirements Document | Core product requirements |
| **PLAN** | Plan/Planning Document | Strategic plans, project plans |
| **RMAP** | Roadmap | Product or project roadmaps |
| **BREQ** | Business Requirements Document | Business-level requirements |
| **FREQ** | Functional Requirements Document | Functional specifications |
| **SOWK** | Statement of Work | Project scope and deliverables |
| **KPIS** | Key Performance Indicators | Success metrics definition |
| **OKRS** | Objectives and Key Results | Goal-setting framework |

#### AT - Architecture & Technical
| Code | Full Name | Usage |
|------|-----------|-------|
| **ADEC** | Architecture Decision Record | Technical decision documentation |
| **ARCH** | Technical Architecture Document | System architecture specs |
| **DSGN** | Design Document/Specification | Detailed design specs |
| **APIS** | API Documentation | API specifications |
| **SDKS** | SDK Documentation | Software development kit docs |
| **INTG** | Integration Documentation | Integration guides and specs |
| **DIAG** | Diagram/Visual Documentation | Architecture diagrams |

#### DC - Development & Code
| Code | Full Name | Usage |
|------|-----------|-------|
| **DEVN** | Development Notes | Developer notes and annotations |
| **CODE** | Code Documentation | Code-level documentation |
| **LIBR** | Library Documentation | Library usage and APIs |
| **MODL** | Module Documentation | Module specifications |
| **COMP** | Component Documentation | Component specs and usage |
| **UTIL** | Helper/Utility Documentation | Utility function documentation |

#### TQ - Testing & Quality
| Code | Full Name | Usage |
|------|-----------|-------|
| **TEST** | Test Plan/Strategy | Overall testing strategy |
| **CASE** | Test Case Documentation | Specific test cases |
| **QAPL** | Quality Assurance Plan | QA strategy and process |
| **BUGR** | Bug Report/Analysis | Bug documentation |
| **PERF** | Performance Testing | Performance test results |
| **SECU** | Security Audit/Testing | Security assessments |
| **PENT** | Penetration Test Results | Pentest findings |

#### OD - Operations & Deployment
| Code | Full Name | Usage |
|------|-----------|-------|
| **OPNS** | Operations Documentation | Operational procedures |
| **DEPL** | Deployment Guide/Log | Deployment instructions |
| **INFR** | Infrastructure Documentation | Infrastructure specs |
| **CONF** | Configuration Documentation | Config file documentation |
| **ENVR** | Environment Setup | Environment configuration |
| **RELS** | Release Notes | Version release notes |
| **CHNG** | Change Log/Management | Change documentation |
| **INCD** | Incident Report | Incident documentation |
| **POST** | Post-Mortem/Incident Analysis | Incident analysis |

#### LS - Logs & Status
| Code | Full Name | Usage |
|------|-----------|-------|
| **LOGS** | Status Log/Journal | General status logging |
| **WORK** | Work Log/Session Notes | Daily work logs |
| **PROG** | Progress Report | Progress documentation |
| **STAT** | Status Report/Update | Status updates |
| **CHKP** | Checkpoint/Milestone Log | Milestone tracking |

#### RA - Reports & Analysis
| Code | Full Name | Usage |
|------|-----------|-------|
| **REPT** | General Report | Standard reports |
| **ANLY** | Analysis/Research Report | Analytical findings |
| **AUDT** | Audit Report | Audit results |
| **REVW** | Review Document | Review findings |
| **RCAS** | Root Cause Analysis | Problem analysis |
| **DATA** | Data Analysis | Data analysis reports |
| **METR** | Metrics Report | Metrics and KPIs |
| **BNCH** | Benchmark Results | Performance benchmarks |

#### MC - Meetings & Communication
| Code | Full Name | Usage |
|------|-----------|-------|
| **MEET** | Meeting Notes/Minutes | Meeting documentation |
| **AGND** | Agenda | Meeting agendas |
| **ACTN** | Action Items | Action item tracking |
| **SUMM** | Summary/Executive Summary | High-level summaries |
| **MEMO** | Memo/Communication | Internal memos |
| **PRES** | Presentation | Presentation materials |
| **WKSP** | Workshop Notes | Workshop documentation |

#### PM - Project Management
| Code | Full Name | Usage |
|------|-----------|-------|
| **TASK** | Task Breakdown/List | Task documentation |
| **BKLG** | Backlog | Product/sprint backlog |
| **SPRT** | Sprint Plan/Notes | Sprint planning docs |
| **RETR** | Retrospective | Sprint retrospectives |
| **STND** | Standup Notes | Daily standup logs |
| **RISK** | Risk Register/Assessment | Risk documentation |
| **ISSU** | Issue Tracker/Log | Issue tracking |

#### DR - Documentation & Reference
| Code | Full Name | Usage |
|------|-----------|-------|
| **REFF** | Reference Material/Guide | Reference documentation |
| **GUID** | User Guide/Handbook | User guides |
| **MANL** | Manual | Operation manuals |
| **FAQS** | FAQ Document | Frequently asked questions |
| **GLOS** | Glossary | Term definitions |
| **SOPS** | Standard Operating Procedure | Procedural documentation |
| **TMPL** | Template | Document templates |
| **CHKL** | Checklist | Process checklists |

#### UC - User & Customer
| Code | Full Name | Usage |
|------|-----------|-------|
| **USER** | User Documentation | End-user documentation |
| **ONBD** | Onboarding Guide | User onboarding materials |
| **TRNG** | Training Materials | Training documentation |
| **FDBK** | Feedback/User Feedback | User feedback logs |
| **SURV** | Survey Results | Survey data and analysis |
| **INTV** | Interview Notes/Transcripts | Interview documentation |
| **PERS** | Persona Documentation | User personas |

#### BL - Business & Legal
| Code | Full Name | Usage |
|------|-----------|-------|
| **CNTR** | Contract/Agreement | Legal contracts |
| **NDAS** | Non-Disclosure Agreement | Confidentiality agreements |
| **LICN** | License Documentation | Licensing information |
| **CMPL** | Compliance Documentation | Compliance records |
| **POLI** | Policy Document | Company policies |
| **TERM** | Terms & Conditions | Terms documentation |
| **PRIV** | Privacy Documentation | Privacy policies |

#### RL - Research & Learning
| Code | Full Name | Usage |
|------|-----------|-------|
| **RSRC** | Research Notes | Research documentation |
| **LERN** | Learning/Study Notes | Study materials |
| **EXPR** | Experiment/POC Documentation | Proof of concept docs |
| **PROP** | Proposal | Project proposals |
| **WHIT** | Whitepaper | Technical whitepapers |
| **CSES** | Case Study | Case study documentation |

#### AA - After Action & Review
| Code | Full Name | Usage |
|------|-----------|-------|
| **AACR** | After Action Report | After-action reviews |
| **LESN** | Lessons Learned | Lessons documentation |
| **PMRT** | Post-Mortem/Incident Review | Incident post-mortems |

#### WA - Workflows & Automation
| Code | Full Name | Usage |
|------|-----------|-------|
| **WFLW** | Workflow Documentation | Workflow specs |
| **N8NS** | n8n Workflow Documentation | n8n-specific workflows |
| **AUTO** | Automation Documentation | Automation scripts/docs |
| **HOOK** | Webhook Documentation | Webhook configuration |

#### DD - Data & Datasets
| Code | Full Name | Usage |
|------|-----------|-------|
| **DSET** | Data Documentation | Dataset documentation |
| **CSVS** | CSV Dataset Documentation | CSV file documentation |
| **SQLS** | SQL/Database Documentation | Database documentation |
| **EXPT** | Data Export Documentation | Export specifications |

#### MS - Miscellaneous
| Code | Full Name | Usage |
|------|-----------|-------|
| **MISC** | Miscellaneous/General | General documents |
| **DRFT** | Draft/Temporary | Draft documents |
| **ARCH** | Archive Notes | Archived materials |
| **OLDV** | Deprecated/Old Version | Deprecated docs |
| **WIPS** | Work in Progress | Work in progress docs |
| **INDX** | Index/Table of Contents | Index files |

---

## EXAMPLE CHRONOLOGY

```
01-Docs/
├── 001-AT-ADEC-initial-architecture.md
├── 002-PP-PROD-core-features.md
├── 003-MC-MEET-kickoff-notes.md
├── 004-PP-PLAN-sprint-1-roadmap.pdf
├── 005-PM-TASK-api-endpoints.md
├── 005a-PM-TASK-auth-endpoints.md
├── 005b-PM-TASK-payment-endpoints.md
├── 006-PM-RISK-data-security.md
├── 007-AT-ADEC-database-choice.md
├── 008-MC-MEET-client-feedback.md
├── 009-AA-AACR-sprint-1-review.md
├── 010-LS-LOGS-error-analysis.txt
├── 011-TQ-TEST-integration-strategy.md
├── 012-OD-DEPL-production-guide.md
├── 013-UC-USER-onboarding-flow.md
├── 014-DR-GUID-api-reference.md
└── 015-RA-ANLY-user-metrics.xlsx
```

### Real-World Examples
```
001-PP-PROD-hustle-mvp-requirements.md
002-AT-ARCH-hustle-system-design.pdf
003-PM-TASK-authentication-implementation.md
004-TQ-SECU-hustle-security-audit.md
005-OD-DEPL-gcp-cloud-run-setup.md
006-MC-MEET-stakeholder-demo-notes.md
007-UC-GUID-parent-user-manual.pdf
008-LS-WORK-october-development-log.md
009-RA-METR-q3-performance-metrics.xlsx
010-AA-LESN-beta-launch-learnings.md
```

### Benefits of This System
- **Instant categorization** - See document type at a glance (PP, AT, PM, etc.)
- **Better searchability** - Search by category code for all related docs
- **Improved sorting** - Documents naturally group by category
- **Scalability** - 17 categories × 120+ types = comprehensive coverage
- **Cross-project consistency** - Same categorization across all projects

---

## README.md REQUIREMENTS

Every `README.md` must contain:

```markdown
## Directory Standards

This project follows the MASTER DIRECTORY STANDARDS.
See `.directory-standards.md` for details.
All documentation is stored in `01-Docs/` using the `NNN-CC-ABCD-description.ext` format.
```

---

## CLAUDE.md REQUIREMENTS

Every `CLAUDE.md` must contain:

```markdown
## Directory Standards

Follow `.directory-standards.md` for structure and file naming.
- Store all docs in `01-Docs/`
- Use format: `NNN-CC-ABCD-description.ext` (category-based naming)
- See `.directory-standards.md` for category codes and document type abbreviations
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
□ Docs files follow NNN-CC-ABCD-description format
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

- **2.0.0** (2025-10-16) – **MAJOR UPDATE**: Category-based naming system is now the ONLY standard
  - Format: `NNN-CC-ABCD-description.ext` (category-based with 4-letter codes)
  - 17 category codes (PP, AT, DC, TQ, OD, LS, RA, MC, PM, DR, UC, BL, RL, AA, WA, DD, MS)
  - 120+ 4-letter document type abbreviations organized by category
  - Removed legacy 3-letter abbreviation format (Format 1) entirely
  - Single unified standard across all projects
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
