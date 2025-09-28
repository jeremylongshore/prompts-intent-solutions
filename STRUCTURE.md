# Repository Structure

Based on ADR-001: Template System Architecture

## Directory Organization

```
prompt-engineering-toolkit/
├── planning/           # PLAN-### templates
├── setup/             # SETUP-### templates
├── debugging/         # DEBUG-### templates
├── features/          # FEAT-### templates
├── testing/           # TEST-### templates
├── cleaning/          # CLEAN-### templates
├── security/          # SEC-### templates
├── project-specs/     # Project-correlated docs (PRD, ARD, TRD)
├── docs/             # Documentation and ADRs
├── tools/            # Automation scripts and validation tools
└── README.md         # Project overview
```

## Naming Convention

**Format:** `CATEGORY-###-description-MMDDYY.md`

- **CATEGORY** = Primary template type (PLAN, SETUP, DEBUG, FEAT, etc.)
- **###** = Sequential within category (001, 002, 003...)
- **description** = Kebab-case description
- **MMDDYY** = Creation/last major revision date

## Category Definitions

| Category | Purpose | Directory |
|----------|---------|-----------|
| **PLAN** | Strategic planning and architecture | `/planning/` |
| **SETUP** | Configuration and initialization | `/setup/` |
| **DEBUG** | Problem diagnosis and troubleshooting | `/debugging/` |
| **FEAT** | Feature development and enhancement | `/features/` |
| **TEST** | Testing and validation | `/testing/` |
| **CLEAN** | Maintenance and optimization | `/cleaning/` |
| **SEC** | Security-focused prompts | `/security/` |

## Project-Correlated Documents

For multi-document projects (PRD, ARD, TRD), use project ID numbering:

```
project-specs/
├── 001-PRD-user-authentication-092825.md
├── 001-ARD-user-authentication-092825.md
├── 001-TRD-user-authentication-092825.md
├── 002-PRD-payment-system-092825.md
```

**Number = Project ID**, not sequence ID.

---

**Last Updated:** 2025-09-28