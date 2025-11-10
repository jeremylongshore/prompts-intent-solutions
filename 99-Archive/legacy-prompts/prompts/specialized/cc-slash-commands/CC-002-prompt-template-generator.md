---
name: prompt-template-generator
description: Interactive prompt template generator that creates properly formatted templates from user descriptions
model: opus
---

# Prompt Template Generator

I will help you create a properly formatted prompt template for this repository.

## Step 1: Gather Information

Please provide the following information:

**1. What do you want this prompt to do?**
(Describe the purpose and functionality)

**2. What category does this belong to?**
- Development: `PLAN`, `SETUP`, `DEBUG`, `FEAT`, `TEST`, `CLEAN`, `SEC`
- Business: `MARKET`, `FINANCE`, `OPS`, `CS`, `PEOPLE`
- Specialized: `CC` (Claude Code), or other

**3. What AI model is this optimized for?**
- `opus` (most capable, complex tasks)
- `sonnet` (balanced, most tasks)
- `haiku` (fast, simple tasks)
- `gpt-4`, `gpt-3.5` (OpenAI models)

**4. Brief description (one sentence):**

**5. Additional context or requirements:**
(Optional - any specific formatting, examples, or constraints)

---

## Step 2: I Will Generate

Based on your input, I will:

1. **Determine the correct directory:**
   - Development prompts → `prompts/development/{category}/`
   - Business prompts → `prompts/business/{category}/`
   - Specialized → `prompts/specialized/cc-slash-commands/` or other

2. **Find the next sequential number:**
   - Check existing files in the category
   - Assign next number (e.g., PLAN-009, MARKET-006)

3. **Create the filename:**
   - Format: `CATEGORY-###-description-MMDDYY.md`
   - Example: `FEAT-004-api-integration-100425.md`

4. **Generate the template with:**
   - Proper YAML frontmatter
   - Clear structure and sections
   - Usage examples if applicable
   - Placeholder text you can customize

5. **Save to correct location**

6. **Validate the template:**
   - Run `python tools/validate_filenames.py`
   - Run `python tools/validate_frontmatter.py`

---

## Step 3: Template Structure I'll Create

```yaml
---
name: your-template-name
description: Your one-sentence description
model: opus  # or your selected model
---

# Template Title

## Purpose
[Clear statement of what this template does]

## Context
[When to use this template]

## Instructions
[Step-by-step instructions or prompt content]

## Expected Output
[What the AI should produce]

## Examples
[Optional: usage examples]

## Notes
[Optional: additional context, limitations, tips]
```

---

## Step 4: Confirmation

After creating the template, I will:
1. Show you the file path
2. Display the first 50 lines for review
3. Confirm validation passed
4. Suggest next steps (customize, test, commit)

---

## Quick Start Examples

### Example 1: Business Email Template
**Input:**
- Purpose: Generate follow-up emails for sales prospects
- Category: `MARKET`
- Model: `sonnet`
- Description: Sales follow-up email generator with personalization

**Output:** Creates `prompts/business/marketing/MARKET-006-sales-followup-email-100425.md`

### Example 2: Debug Assistant
**Input:**
- Purpose: Help debug API integration issues
- Category: `DEBUG`
- Model: `opus`
- Description: API integration error diagnosis and resolution

**Output:** Creates `prompts/development/debugging/DEBUG-006-api-integration-errors-100425.md`

### Example 3: Slash Command
**Input:**
- Purpose: Automate code review process
- Category: `CC`
- Model: `opus`
- Description: Comprehensive code review with security checks

**Output:** Creates `prompts/specialized/cc-slash-commands/CC-003-code-review-automation-100425.md`

---

## Ready to Create?

**Tell me what you want to create, and I'll generate the template for you!**

Provide your answers to questions 1-5 above, or just describe what you need in plain language and I'll extract the details.
