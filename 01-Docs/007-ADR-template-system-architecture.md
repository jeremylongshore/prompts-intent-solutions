# ADR-001: Template System Architecture

**Date:** 2025-09-28
**Status:** Accepted
**Context:** Prompt Engineering Toolkit Development

---

## Context

We need to establish a systematic architecture for organizing and managing prompt templates within the prompt engineering toolkit. The current state shows multiple organizational approaches being used simultaneously, creating confusion and inefficiency.

## Problem Statement

1. **Inconsistent numbering** - Same numbers used across different categories (001-PLAN, 001-DEBUG, 001-SETUP)
2. **Mixed organizational paradigms** - Global vs category-specific numbering
3. **Unclear template categorization** - No clear taxonomy for prompt types
4. **Scalability concerns** - Current ad-hoc system won't scale to hundreds of templates

## Decision

Implement a **hybrid categorized-numbering system** with the following architecture:

### 1. Category-First Organization
```
prompts/
├── planning/
│   ├── PLAN-001-filing-system-092825.md
│   ├── PLAN-002-marketing-strategy-092825.md
├── setup/
│   ├── SETUP-001-ai-assistant-092825.md
│   ├── SETUP-002-compact-mode-092825.md
├── debugging/
│   ├── DEBUG-001-bug-analysis-092825.md
├── features/
│   ├── FEAT-001-new-feature-092825.md
```

### 2. Template Naming Convention
**Format:** `CATEGORY-###-description-MMDDYY.md`

- **CATEGORY** = Primary template type (PLAN, SETUP, DEBUG, FEAT, etc.)
- **###** = Sequential within category (001, 002, 003...)
- **description** = Kebab-case description
- **MMDDYY** = Creation/last major revision date

### 3. Primary Categories
| Category | Purpose | Example Use Cases |
|----------|---------|------------------|
| **PLAN** | Strategic planning and architecture | System design, project planning |
| **SETUP** | Configuration and initialization | Environment setup, tool configuration |
| **DEBUG** | Problem diagnosis and troubleshooting | Error analysis, performance issues |
| **FEAT** | Feature development and enhancement | New functionality, improvements |
| **TEST** | Testing and validation | Test strategies, QA processes |
| **CLEAN** | Maintenance and optimization | Code cleanup, refactoring |
| **SEC** | Security-focused prompts | Security audits, threat analysis |

### 4. Cross-References for Projects
For project-correlated documents (PRD, ARD, TRD):
```
project-specs/
├── 001-PRD-user-authentication-092825.md     # Project #1
├── 001-ARD-user-authentication-092825.md     # Same project
├── 001-TRD-user-authentication-092825.md     # Same project
├── 002-PRD-payment-system-092825.md          # Project #2
```
**Number = Project ID**, not sequence ID.

## Consequences

### Positive
- **Clear mental model** - Category-first matches developer thinking patterns
- **Scalable** - Each category can grow independently
- **Findable** - Easy to locate templates by use case
- **Maintainable** - Clear ownership and organization boundaries
- **Flexible** - Can add new categories without disrupting existing structure

### Negative
- **Migration effort** - Existing files need reorganization
- **Learning curve** - Team needs to adopt new conventions
- **Potential duplication** - Some templates might fit multiple categories

## Implementation Plan

1. **Phase 1:** Create directory structure with primary categories ✅
2. **Phase 2:** Migrate existing templates to new structure
3. **Phase 3:** Create template validation tools
4. **Phase 4:** Document and train team on new system

## Alternatives Considered

1. **Global sequential numbering** - Rejected due to poor developer UX
2. **Flat file structure** - Rejected due to scalability concerns
3. **Pure directory-based** - Rejected due to loss of chronological context

---

**Template system architecture decision to support scalable prompt engineering toolkit development.**