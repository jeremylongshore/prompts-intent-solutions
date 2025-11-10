---
name: text-repository-structure
description: Reference guide for text-based repository structure - optimized for prompts, documentation, and content
model: opus
date: 2025-10-05
---

# Text-Based Repository Structure
## Reference Guide for Prompt and Content Repositories

**Note:** This is a REFERENCE document explaining text repository organization. For AI execution prompts to create this structure, see:
- `DIRECTORY-003-master-project-structure-092825.md` - Create project structure
- `MASTER-DIRECTORY-STANDARDS.md` - Universal standards

---

## MASTER STRUCTURE FOR TEXT REPOSITORIES

```
[PROMPT-REPO-NAME]/
├── audit-reports/                # LLM audit outputs (same as always)
│   └── [Sequential reports...]
│
├── 00-templates/                 # Master templates and boilerplates
│   ├── prompt-template.md        # Base template for new prompts
│   ├── category-template.md      # Template for new categories
│   ├── example-template.md       # Template for examples
│   └── validation-template.md    # Template for testing prompts
│
├── 01-system-prompts/            # Core system instructions
│   ├── 00-master-system/         # Primary system prompts
│   │   ├── 00-base-instructions.md
│   │   ├── 01-personality-config.md
│   │   └── 02-capability-definitions.md
│   ├── 01-specialized-systems/   # Role-specific systems
│   │   ├── developer-system.md
│   │   ├── analyst-system.md
│   │   └── writer-system.md
│   └── README.md                 # How to use system prompts
│
├── 02-task-prompts/              # Action-oriented prompts
│   ├── 00-analysis/              # Analysis tasks
│   │   ├── code-review.md
│   │   ├── data-analysis.md
│   │   └── system-audit.md
│   ├── 01-generation/            # Content generation
│   │   ├── documentation.md
│   │   ├── test-creation.md
│   │   └── report-writing.md
│   ├── 02-transformation/        # Data/text transformation
│   │   ├── format-conversion.md
│   │   ├── language-translation.md
│   │   └── code-refactoring.md
│   └── 03-automation/            # Automation workflows
│       ├── ci-cd-setup.md
│       ├── task-scheduling.md
│       └── workflow-creation.md
│
├── 03-domain-prompts/            # Industry/domain specific
│   ├── 00-engineering/
│   │   ├── backend-development.md
│   │   ├── frontend-development.md
│   │   └── devops-operations.md
│   ├── 01-business/
│   │   ├── financial-analysis.md
│   │   ├── market-research.md
│   │   └── strategic-planning.md
│   ├── 02-creative/
│   │   ├── content-writing.md
│   │   ├── storytelling.md
│   │   └── brand-messaging.md
│   └── 03-academic/
│       ├── research-assistance.md
│       ├── paper-writing.md
│       └── citation-formatting.md
│
├── 04-chain-prompts/             # Multi-step workflows
│   ├── 00-audit-chore-release/  # Your pipeline
│   │   ├── 01-audit-phase.md
│   │   ├── 02-chore-phase.md
│   │   └── 03-release-phase.md
│   ├── 01-development-cycle/
│   │   ├── 01-requirements.md
│   │   ├── 02-implementation.md
│   │   └── 03-testing.md
│   └── README.md                 # How chains work
│
├── 05-examples/                  # Real-world examples
│   ├── 00-successful-outputs/    # What worked well
│   │   ├── example-audit-report.md
│   │   └── example-generated-code.md
│   ├── 01-failed-attempts/       # What didn't work (learning)
│   │   └── anti-patterns.md
│   └── 02-comparisons/           # Different approaches
│       └── prompt-variations.md
│
├── 06-components/                # Reusable prompt parts
│   ├── instructions/             # Instruction snippets
│   │   ├── output-formatting.md
│   │   ├── error-handling.md
│   │   └── validation-rules.md
│   ├── contexts/                 # Context setups
│   │   ├── role-definitions.md
│   │   ├── capability-specs.md
│   │   └── constraint-lists.md
│   └── examples/                 # Example snippets
│       ├── input-examples.md
│       └── output-examples.md
│
├── 07-collections/               # Curated prompt sets
│   ├── starter-pack/             # Beginner essentials
│   ├── professional-suite/       # Business ready
│   ├── developer-toolkit/        # Engineering focused
│   └── creative-bundle/          # Creative work
│
├── 08-testing/                   # Prompt validation
│   ├── test-cases/               # Input/output pairs
│   │   ├── system-prompt-tests.md
│   │   └── task-prompt-tests.md
│   ├── benchmarks/               # Performance metrics
│   │   └── response-quality.md
│   └── validation-scripts/       # Testing tools
│       └── prompt-validator.md
│
├── 09-research/                  # Prompt engineering R&D
│   ├── experiments/              # What you're trying
│   │   └── YYYY-MM-DD-experiment.md
│   ├── findings/                 # What you learned
│   │   └── best-practices.md
│   └── literature/               # External research
│       └── papers-and-articles.md
│
├── 99-archive/                   # Old/deprecated prompts
│   ├── deprecated/               # No longer used
│   ├── legacy/                   # Historical reference
│   └── failed/                   # Didn't work out
│
├── README.md                     # Repository overview
├── CHANGELOG.md                  # Version history
├── CONTRIBUTING.md               # How to contribute prompts
├── PROMPT-STYLE-GUIDE.md        # Writing standards
├── TESTING-GUIDE.md             # How to test prompts
├── INDEX.md                     # Searchable prompt index
└── GLOSSARY.md                  # Term definitions
```

---

## NAMING CONVENTIONS FOR TEXT REPOS

### Prompt Files

| Type | Format | Example |
|------|--------|---------|
| System prompts | `kebab-case.md` | `master-system.md` |
| Task prompts | `action-object.md` | `analyze-code.md` |
| Chain prompts | `##-phase-name.md` | `01-audit-phase.md` |
| Examples | `example-description.md` | `example-api-docs.md` |
| Components | `component-type.md` | `output-formatting.md` |

### Version Control for Prompts

```
prompts/
├── code-review.md           # Current version
├── versions/                # Version history
│   ├── code-review-v1.0.md # Original
│   ├── code-review-v1.1.md # Minor update
│   └── code-review-v2.0.md # Major revision
```

---

## PROMPT FILE STRUCTURE TEMPLATE

Every prompt file should follow this structure:

```markdown
# [Prompt Name]

## Metadata
- **Version**: 1.0.0
- **Author**: [Your Name]
- **Created**: YYYY-MM-DD
- **Updated**: YYYY-MM-DD
- **Category**: [System/Task/Domain/Chain]
- **Tags**: [tag1, tag2, tag3]
- **Tested With**: [GPT-4, Claude, etc.]

## Purpose
[What this prompt accomplishes]

## Context Required
[What information needs to be provided]

## Prompt
```
[The actual prompt text goes here]
```

## Usage Example
```
Input: [Example input]
Expected Output: [What you should get]
```

## Parameters
- `[VARIABLE]`: Description of what to replace

## Notes
- Performance considerations
- Known limitations
- Best practices

## Changelog
- v1.0.0 (YYYY-MM-DD): Initial version
```

---

## ORGANIZATION BY USE CASE

### For AI Development Teams

```
ai-prompts/
├── 01-model-instructions/     # How to instruct models
├── 02-fine-tuning/           # Training examples
├── 03-evaluation/            # Testing prompts
├── 04-production/            # Deployed prompts
└── 05-monitoring/            # Performance tracking
```

### For Content Creation

```
content-prompts/
├── 01-ideation/              # Brainstorming
├── 02-drafting/              # Initial creation
├── 03-editing/               # Revision prompts
├── 04-optimization/          # SEO, readability
└── 05-distribution/          # Social, email
```

### For Business Operations

```
business-prompts/
├── 01-analysis/              # Data, market, competitive
├── 02-strategy/              # Planning, roadmaps
├── 03-communication/         # Internal, external
├── 04-documentation/         # Processes, policies
└── 05-automation/            # Workflow, efficiency
```

---

## SPECIAL CONSIDERATIONS FOR TEXT REPOS

### 1. No Code, But Still Need Structure

Even without code, you need:
- Clear categorization
- Version control
- Testing methodology
- Documentation standards
- Review processes

### 2. Prompt Dependencies

Some prompts depend on others:

```yaml
# prompt-dependencies.yaml
audit-phase:
  requires:
    - master-system-prompt
    - taskwarrior-integration

chore-phase:
  requires:
    - audit-phase
    - fix-automation-prompts

release-phase:
  requires:
    - chore-phase
    - validation-prompts
```

### 3. Prompt Testing Without Code

```markdown
# Test Case Format

## Test: [Test Name]
**Prompt Version**: 1.0.0
**Test Date**: YYYY-MM-DD

### Input
```
[Exact input provided]
```

### Expected Output Criteria
- [ ] Contains required sections
- [ ] Follows specified format
- [ ] Includes all requested information
- [ ] Maintains appropriate tone

### Actual Output
```
[What the LLM produced]
```

### Result
✅ PASS / ❌ FAIL

### Notes
[Any observations]
```

---

## INDEXING AND DISCOVERY

### Master Index Structure

```markdown
# Prompt Repository Index

## By Category
- **System Prompts** (12)
  - [Master System](01-system-prompts/00-master-system/)
  - [Developer System](01-system-prompts/01-specialized/developer.md)

## By Use Case
- **Code Review**
  - [Basic Review](02-task-prompts/00-analysis/code-review.md)
  - [Security Audit](02-task-prompts/00-analysis/security-audit.md)

## By Effectiveness Rating
### ⭐⭐⭐⭐⭐ Five Star (Production Ready)
- [Audit System](04-chain-prompts/00-audit-chore-release/)

### ⭐⭐⭐⭐ Four Star (Reliable)
- [Code Generation](02-task-prompts/01-generation/)

## By Model Optimization
### GPT-4 Optimized
- [List of prompts...]

### Claude Optimized
- [List of prompts...]
```

---

## MAINTENANCE WORKFLOW

### Adding New Prompts

1. **Create from template** (`00-templates/prompt-template.md`)
2. **Place in correct category**
3. **Test with examples**
4. **Document results**
5. **Update index**
6. **Version if replacing existing**

### Prompt Review Process

```bash
# Similar to code review but for prompts
1. Create branch: prompt/new-audit-system
2. Add prompt file with examples
3. Test with multiple inputs
4. Document test results
5. Create PR with test evidence
6. Review and merge
```

---

## KEY DIFFERENCES FROM CODE REPOS

| Aspect | Code Repository | Prompt Repository |
|--------|----------------|-------------------|
| **Main Content** | Source code | Prompt text |
| **"Compilation"** | Build process | Validation testing |
| **"Runtime"** | Execution | LLM interaction |
| **Testing** | Unit/integration tests | Input/output examples |
| **Dependencies** | Libraries/packages | Other prompts/context |
| **Versioning** | Semantic (1.2.3) | Same, but for prompts |
| **Documentation** | Code comments | Usage examples |
| **Output** | Compiled binary | LLM responses |

---

## SUCCESS METRICS FOR TEXT REPOS

### Prompt Quality Metrics

```yaml
Effectiveness:
  - Success rate: 95%
  - User satisfaction: 4.5/5
  - Output consistency: High

Organization:
  - Find time: <30 seconds
  - Categories clear: Yes
  - Examples provided: 100%

Maintenance:
  - Last review: <30 days
  - Version history: Complete
  - Test coverage: >80%
```

---

## APPLYING THIS STRUCTURE

To create a text repository following this structure, use the AI execution prompt:
- `DIRECTORY-003-master-project-structure-092825.md` - Creates complete directory structure

Or manually create the numbered directories and category folders shown in the structure above.

---

## VERSION HISTORY

- **1.0.1** (2025-10-05) – Removed bash script, added reference note for AI execution model
- **1.0.0** (2025-09-28) – Initial text repository structure guide

---

*Text-Based Repository Structure – Reference for Prompt and Content Organization*