---
name: master-file-naming-conventions
description: Complete guide to file naming conventions - professional reference for directory excellence
model: opus
date: 2025-09-28
---

# Complete Guide to File Naming Conventions
## A Professional Reference for Directory Excellence

---

## What Are Naming Conventions?

Naming conventions are standardized rules for naming files, folders, variables, and other elements in your projects. They ensure consistency, readability, and compatibility across different systems and team members.

---

## The Major Naming Conventions

### 1. kebab-case (dash-case, hyphen-case)

**Format**: Words are lowercase, separated by hyphens
**Example**: `user-authentication-service.js`

**When to Use**:
- File names in most projects
- URLs and routes
- CSS class names
- HTML attributes
- Docker images
- Git branch names

**Advantages**:
- ✅ URL-safe without encoding
- ✅ Universally readable
- ✅ Works on all operating systems
- ✅ SEO-friendly for web

**Examples**:
```
api-documentation.md
user-profile-settings.html
deploy-production.sh
feature-user-login (git branch)
my-docker-image:latest
```

---

### 2. camelCase (lowerCamelCase)

**Format**: First word lowercase, subsequent words capitalized, no spaces
**Example**: `userAuthenticationService`

**When to Use**:
- JavaScript/TypeScript variables and functions
- JSON object keys
- Java methods
- Swift properties
- Feature names in documentation

**Advantages**:
- ✅ Industry standard for JavaScript
- ✅ Compact (no separators)
- ✅ Clear word boundaries
- ✅ Follows programming conventions

**Examples**:
```javascript
let userName = "John";
function calculateTotalPrice() {}
const apiResponseData = {};
```

```json
{
  "firstName": "Jane",
  "lastName": "Doe",
  "emailAddress": "jane@example.com"
}
```

---

### 3. PascalCase (UpperCamelCase)

**Format**: Every word capitalized, no spaces or separators
**Example**: `UserAuthenticationService`

**When to Use**:
- Class names in programming
- React/Vue/Angular components
- Type definitions in TypeScript
- C# everything
- Constructor functions

**Advantages**:
- ✅ Clearly indicates classes/components
- ✅ Distinguishes from variables
- ✅ Industry standard for OOP
- ✅ Immediately recognizable

**Examples**:
```javascript
class UserAccount {}
function PersonModel() {}
interface ApiResponse {}
```

```
React Components:
UserProfile.jsx
NavigationBar.tsx
ShoppingCart.vue
```

---

### 4. snake_case

**Format**: Words are lowercase, separated by underscores
**Example**: `user_authentication_service`

**When to Use**:
- Python files and variables
- Ruby files and methods
- Database table and column names
- C/C++ constants (sometimes)
- R programming
- Rust variables

**Advantages**:
- ✅ Python/Ruby standard
- ✅ Database compatible
- ✅ Clear word separation
- ✅ Works in all systems

**Examples**:
```python
user_name = "John"
def calculate_total_price():
    pass

# File names
data_processor.py
test_user_auth.py
```

```sql
CREATE TABLE user_accounts (
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    created_at TIMESTAMP
);
```

---

### 5. SCREAMING_SNAKE_CASE (CONSTANT_CASE)

**Format**: All uppercase letters, separated by underscores
**Example**: `MAX_USER_ATTEMPTS`

**When to Use**:
- Constants in any language
- Environment variables
- Configuration keys
- SQL keywords (sometimes)
- Macro definitions in C

**Advantages**:
- ✅ Immediately identifies constants
- ✅ Prevents accidental modification
- ✅ Universal convention
- ✅ High visibility

**Examples**:
```javascript
const MAX_LOGIN_ATTEMPTS = 3;
const API_BASE_URL = "https://api.example.com";
```

```bash
# .env file
DATABASE_URL=postgresql://localhost/mydb
API_KEY=sk_live_abc123
NODE_ENV=production
```

---

### 6. CAPS-WITH-DASHES

**Format**: All uppercase letters, separated by hyphens
**Example**: `USER-AUTHENTICATION-COMPLETE`

**When to Use**:
- Status indicators in reports
- Phase identifiers (AUDIT, CHORE, RELEASE)
- Important document sections
- Log level indicators
- Deployment stage names

**Advantages**:
- ✅ Maximum visibility
- ✅ Clear importance indicator
- ✅ Good for scanning documents
- ✅ Stands out in logs

**Examples**:
```
0001-AUDIT-102824-INITIAL-SCAN.md
0002-DEBUG-102824-FIX-DATABASE.md
STATUS-CRITICAL-ACTION-REQUIRED.txt
PHASE-COMPLETE-READY-FOR-REVIEW.md
```

---

## Comparison Table

| Convention | Example | Primary Use | Readability | URL-Safe | Case-Sensitive |
|------------|---------|-------------|-------------|----------|----------------|
| kebab-case | `my-file-name` | Files, URLs | High | Yes | No |
| camelCase | `myFileName` | Variables | Medium | Yes | Yes |
| PascalCase | `MyFileName` | Classes | Medium | Yes | Yes |
| snake_case | `my_file_name` | Python, DBs | High | No* | No |
| SCREAMING_SNAKE | `MY_FILE_NAME` | Constants | High | No* | No |
| CAPS-WITH-DASHES | `MY-FILE-NAME` | Statuses | Maximum | Yes | No |

*Underscores may need encoding in some URL contexts

---

## Platform-Specific Considerations

### Operating System Compatibility

| OS | Case-Sensitive | Special Chars | Max Path | Notes |
|----|---------------|---------------|----------|-------|
| Linux | Yes | Avoid: `/ \0` | 4096 | Most permissive |
| macOS | No* | Avoid: `/ :` | 1024 | Case-preserving |
| Windows | No | Avoid: `< > : " \| ? * /` | 260** | Most restrictive |

*macOS is case-insensitive by default but case-preserving
**Windows 10+ can enable long paths up to 32,767 characters

### Git Considerations

```bash
# Good branch names (kebab-case)
feature/user-authentication
bugfix/login-error-handling
release/v1.2.3

# Bad branch names (spaces, special chars)
Feature/User Authentication  # Space will break
bugfix\login-error           # Backslash issues
release@v1.2.3              # @ may cause issues
```

---

## Real-World Application Examples

### Web Development Project

```
my-web-app/                      # kebab-case for project
├── src/
│   ├── components/
│   │   ├── UserProfile.jsx      # PascalCase for components
│   │   └── NavigationBar.jsx
│   ├── utils/
│   │   ├── api-helper.js        # kebab-case for utilities
│   │   └── date-formatter.js
│   ├── constants/
│   │   └── config.js            # Contains SCREAMING_SNAKE constants
│   └── styles/
│       └── main-theme.css       # kebab-case for CSS
├── user-guide.md                # kebab-case for docs
└── .env                         # Contains SCREAMING_SNAKE vars
```

### Python Data Science Project

```
data_analysis_project/           # snake_case for Python
├── notebooks/
│   ├── 01_data_exploration.ipynb
│   └── 02_model_training.ipynb
├── src/
│   ├── data_processor.py       # snake_case files
│   ├── model_builder.py
│   └── CONSTANTS.py            # SCREAMING_SNAKE for constants
├── tests/
│   └── test_data_processor.py
└── README.md                    # Exception: standard files
```

### Enterprise Documentation Project

```
deployment-docs/                 # kebab-case folder
├── 0001-AUDIT-102824-INITIAL-SCAN.md    # Numbered + CAPS phases
├── 0002-DEBUG-102824-DATABASE-FIX.md
├── 00-user-authentication/     # kebab-case feature folder
│   ├── 00-prd-userAuth.md     # camelCase feature name
│   ├── 00-tasks-userAuth.md
│   └── 00-adr-userAuth.md
└── archive/
    └── cleanup-2024-10-15/     # kebab-case with date
```

---

## Common Mistakes and How to Avoid Them

### ❌ Mixing Conventions (Bad)
```
myProject/
├── user_profile.js       # Wrong: snake_case in JS
├── DateFormatter.py      # Wrong: PascalCase in Python
└── API-DOCS.md          # Inconsistent with others
```

### ✅ Consistent Conventions (Good)
```
my-project/
├── user-profile.js       # Correct: kebab-case
├── date-formatter.py     # Correct: snake_case
└── api-docs.md          # Correct: kebab-case
```

### ❌ Using Spaces (Bad)
```
My Documents/
├── Project Report Final.docx
└── Meeting Notes 10-15-24.txt
```

### ✅ No Spaces (Good)
```
my-documents/
├── project-report-final.docx
└── meeting-notes-2024-10-15.txt
```

### ❌ Special Characters (Bad)
```
reports/
├── Q3-Report@2024!.pdf
├── Sales_Data_#final.xlsx
└── Budget(revised).doc
```

### ✅ Safe Characters (Good)
```
reports/
├── q3-report-2024.pdf
├── sales-data-final.xlsx
└── budget-revised.doc
```

---

## Quick Decision Guide

```
IF creating a file/folder:
  IF web project → use kebab-case
  IF Python project → use snake_case
  IF documentation → use kebab-case
  IF script → use kebab-case

IF naming in code:
  IF variable/function:
    IF JavaScript → use camelCase
    IF Python → use snake_case
  IF class/component → use PascalCase
  IF constant → use SCREAMING_SNAKE_CASE

IF creating report/status:
  IF needs high visibility → use CAPS-WITH-DASHES
  IF regular document → use kebab-case
```

---

## Best Practices Summary

1. **Be Consistent**: Choose a convention and stick to it within each context
2. **Follow Language Standards**: Use Python conventions in Python, JS conventions in JavaScript
3. **Avoid Spaces**: Always replace with hyphens or underscores
4. **No Special Characters**: Stick to letters, numbers, hyphens, underscores
5. **Use Meaningful Names**: `user-auth-service` not `uas` or `thing1`
6. **Include Dates Properly**: `2024-10-28` or `20241028`, not `10-28-24`
7. **Keep It Reasonable**: Don't exceed 255 characters
8. **Consider the Platform**: Ensure compatibility with target systems
9. **Document Your Choices**: Include naming conventions in your README
10. **Automate Enforcement**: Use linters and pre-commit hooks

---

## Enforcement Tools

### ESLint (JavaScript)
```json
{
  "rules": {
    "camelcase": ["error", {"properties": "always"}],
    "filenames/match-regex": ["error", "^[a-z-]+$"]
  }
}
```

### Pylint (Python)
```ini
[BASIC]
# Naming style for variables and functions
variable-naming-style=snake_case
function-naming-style=snake_case
class-naming-style=PascalCase
const-naming-style=UPPER_CASE
```

### Pre-commit Hook (Git)
```yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    hooks:
      - id: check-case-conflict
      - id: check-filenames-kebab-case
```

---

## Conclusion

Naming conventions are not just about aesthetics—they're about:
- **Clarity**: Anyone can understand your structure
- **Compatibility**: Works across all systems
- **Professionalism**: Shows attention to detail
- **Efficiency**: Reduces confusion and errors
- **Scalability**: Maintains organization as projects grow

Choose the right convention for each context, be consistent, and document your choices. Your future self and team members will thank you!

---

**Remember**: The best naming convention is the one that's consistently applied throughout your project.

---
*Updated: September 28, 2025*