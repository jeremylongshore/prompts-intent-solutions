# Directory & Structure Management
**Category**: Foundation Systems & Project Architecture
**Files**: 5 documents (2 AI execution prompts, 3 reference guides)

---

## 📚 **Documentation Model**

This directory uses a **two-file system**:

1. **REFERENCE DOCS** - Explain what the rules and standards are
   - What naming conventions exist
   - What structure patterns to follow
   - What the standards mean

2. **AI EXECUTION PROMPTS** - Tell Claude how to apply the rules
   - Step-by-step instructions for Claude
   - Commands to execute with results to report
   - Complete workflows from analysis to validation

**Bottom line:** Reference docs are for understanding. Execution prompts are for doing.

---

## 🏗️ **Foundation Systems & Project Architecture**

### **Professional Infrastructure Management**
These documents provide the foundational systems for directory management, project structure, naming conventions, and professional excellence frameworks that support all other operations.

### **AI Execution Prompts** (Claude runs these)

#### **📁 DIRECTORY-001**: Professional Directory System
- **Type**: AI Execution Prompt
- **Purpose**: Transform any directory into professional organization
- **What Claude Does**:
  1. Analyzes current state
  2. Creates standard structure
  3. Moves and renames files
  4. Validates compliance
  5. Reports results
- **Use When**: Organizing messy directories, applying standards to projects

#### **🔍 DIRECTORY-002**: Directory Audit System
- **Type**: AI Execution Prompt
- **Purpose**: Comprehensive directory audit across 6 dimensions
- **What Claude Does**:
  1. Audits naming conventions
  2. Analyzes structure
  3. Checks content organization
  4. Reviews documentation
  5. Measures performance
  6. Assesses security
  7. Generates reports in `claudes-docs/audits/`
- **Use When**: Need deep analysis, audit trail, or transformation roadmap

#### **🏗️ DIRECTORY-003**: Master Project Structure
- **Type**: AI Execution Prompt
- **Purpose**: Create professional project structure in any repository
- **What Claude Does**:
  1. Creates standard directories
  2. Sets up essential files
  3. Updates README and CLAUDE.md
  4. Validates structure
  5. Reports completion
- **Use When**: Starting new project, restructuring existing project

---

### **Reference Guides** (For understanding)

#### **📝 NAMING-001**: File Naming Conventions
- **Type**: Reference Guide
- **Purpose**: Explains all naming conventions (kebab-case, camelCase, PascalCase, snake_case)
- **What It Contains**: Comparison tables, examples, platform considerations
- **Use When**: Need to understand which naming convention to use and why

#### **🗂️ STRUCTURE-001**: Text Repository Structure
- **Type**: Reference Guide
- **Purpose**: Specialized structure for text-based repositories
- **What It Contains**: Prompt repo structures, content organization patterns
- **Use When**: Building documentation sites, prompt repositories, content projects

---

### **Universal Standards** (Single source of truth)

#### **📋 MASTER-DIRECTORY-STANDARDS.md**
- **Type**: Reference Document (Authoritative)
- **Purpose**: Single source of truth for all directory standards
- **What It Contains**:
  - Universal naming rules
  - Standard directory structure
  - Docs file naming (`NNN-abv-description.ext`)
  - Abbreviation table (22 approved abbreviations)
  - Compliance checklist
- **Authority**: All projects must sync from this file

---

## 🚀 **Quick Start Guide**

### **Organize a Messy Directory**
Tell Claude:
> "Use DIRECTORY-001 to organize this directory"

Claude will analyze, create structure, move files, and report results.

### **Audit a Directory**
Tell Claude:
> "Use DIRECTORY-002 to audit this directory"

Claude will perform 6-dimension audit and generate reports in `claudes-docs/audits/`.

### **Start a New Project**
Tell Claude:
> "Use DIRECTORY-003 to create the master project structure"

Claude will create all standard directories and essential files.

### **Understand Naming Conventions**
Tell Claude:
> "Read NAMING-001 and explain when to use kebab-case vs snake_case"

### **Learn About Text Repositories**
Tell Claude:
> "Read STRUCTURE-001 and show me the structure for a prompt repository"

---

## 🔄 **Complete Directory Workflow**

### **From Chaos to Professional Organization**
1. **Audit**: Use DIRECTORY-002 to identify all issues
2. **Transform**: Use DIRECTORY-001 to apply standards
3. **Validate**: Claude validates compliance automatically
4. **Document**: All results saved in `claudes-docs/`

### **For New Projects**
1. **Create Structure**: Use DIRECTORY-003 for standard directories
2. **Apply Standards**: Sync MASTER-DIRECTORY-STANDARDS.md
3. **Validate**: Ensure compliance with checklist
4. **Customize**: Add project-specific directories as needed

### **Integration with Other Systems**
- Uses `claudes-docs/` for all AI-generated reports
- Follows universal naming from MASTER-DIRECTORY-STANDARDS.md
- Compatible with GitHub workflows and TaskWarrior tracking

---

## 🎯 **Key Principles**

### **Two-File Model**
- **Reference Docs**: Explain the rules (what to do)
- **Execution Prompts**: Claude applies the rules (how to do it)
- **Result**: You understand the system AND get work done

### **Quality Standards**
- **Consistency**: Standardized naming and structure across all projects
- **Scalability**: Architecture that grows with project complexity
- **Maintainability**: Clear organization for long-term sustainability
- **Professional**: Clean, organized, production-ready

### **AI Execution Model**
- **No Bash Scripts**: Claude runs commands and shows results
- **Step-by-Step**: Clear execution phases with progress reporting
- **Validated Results**: Automatic compliance checking
- **Documented**: All artifacts saved in `claudes-docs/`

---

## 📁 **Standard Directory Structure**

As defined in MASTER-DIRECTORY-STANDARDS.md:

```
[PROJECT-ROOT]/
├── claudes-docs/          # Claude-created docs (7 subdirs)
├── 01-Docs/              # Documentation (NNN-abv-description.ext)
├── 02-Src/               # Source code
├── 03-Tests/             # Tests
├── 04-Assets/            # Assets
├── 05-Scripts/           # Scripts
├── 06-Infrastructure/    # IaC
├── 07-Releases/          # Releases
├── 99-Archive/           # Archive
├── README.md             # Project overview
├── CLAUDE.md             # Claude instructions
└── .directory-standards.md  # Local copy of standards
```

---

## 📝 **Naming Standards Quick Reference**

### **Files**
- Format: `kebab-case` (all lowercase, hyphens)
- Dates: `YYYY-MM-DD`
- Versions: `name-YYYY-MM-DD-v1.ext`

### **Docs in 01-Docs/**
- Format: `NNN-abv-description.ext`
- NNN: Sequential number (001, 002, 003...)
- abv: Approved abbreviation (adr, prd, mtg, aar, etc.)
- See MASTER-DIRECTORY-STANDARDS.md for full abbreviation table

### **Claude Docs in claudes-docs/**
- Format: `<UTC-ISO8601>_<project-slug>_<short-slug>.<ext>`
- Example: `2025-10-04T16-05-12Z_project-name_audit-report.md`

---

## 🎯 **Benefits**

### **For You**
- **Instant Organization**: One command transforms messy directories
- **Consistent Structure**: All projects follow same pattern
- **Audit Trail**: Complete documentation of all changes
- **Professional Quality**: Production-ready organization

### **For Teams**
- **Universal Standards**: Everyone follows same conventions
- **Fast Onboarding**: New members understand structure instantly
- **Clear Communication**: Predictable locations for everything
- **Scalable**: Works for solo projects and large teams

---

**Updated**: 2025-10-05
**Category**: Directory & Structure Management
**Model**: Two-file system (execution prompts + reference guides)