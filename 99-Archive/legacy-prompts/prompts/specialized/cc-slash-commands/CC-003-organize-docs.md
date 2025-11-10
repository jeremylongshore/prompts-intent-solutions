---
name: organize-claudes-docs
description: Find and organize all Claude-created documentation into claudes-docs folder with proper structure
model: sonnet
---

# Organize Claude Documentation

Automatically find and organize all Claude-created documentation files into the `claudes-docs` folder.

## Phase 1: Check Current Directory and Create Structure

**Commands to run:**
```bash
# Show current directory
pwd

# Create claudes-docs if it doesn't exist
DOCS_DIR="$PWD/claudes-docs"
mkdir -p "$DOCS_DIR"
echo "DOCS_DIR=$DOCS_DIR"

# Create subdirectories for organization
mkdir -p "$DOCS_DIR/reports"
mkdir -p "$DOCS_DIR/audits"
mkdir -p "$DOCS_DIR/analysis"
mkdir -p "$DOCS_DIR/plans"
mkdir -p "$DOCS_DIR/tasks"
mkdir -p "$DOCS_DIR/logs"
mkdir -p "$DOCS_DIR/misc"

echo "✅ Directory structure created"
```

## Phase 2: Find All Recently Created Documentation

**Search for files created in current session:**
```bash
# Find markdown files created/modified in last 24 hours
find "$PWD" -maxdepth 2 -name "*.md" -type f -mtime -1 ! -path "*/claudes-docs/*" ! -path "*/.git/*" ! -path "*/node_modules/*"

# Find text files created/modified in last 24 hours
find "$PWD" -maxdepth 2 -name "*.txt" -type f -mtime -1 ! -path "*/claudes-docs/*" ! -path "*/.git/*" ! -path "*/node_modules/*"

# Find JSON export files
find "$PWD" -maxdepth 2 -name "*export*.json" -type f -mtime -1 ! -path "*/claudes-docs/*" ! -path "*/.git/*"

# Find log files
find "$PWD" -maxdepth 2 -name "*.log" -type f -mtime -1 ! -path "*/claudes-docs/*" ! -path "*/.git/*"
```

## Phase 3: Categorize and Move Files

Based on filename patterns, organize files into subdirectories:

**File patterns and destinations:**
- `*aar*.md`, `*after-action*.md` → `claudes-docs/reports/`
- `*audit*.md`, `*review*.md` → `claudes-docs/audits/`
- `*analysis*.md`, `*diagnostic*.md` → `claudes-docs/analysis/`
- `*plan*.md`, `*prd*.md`, `*ard*.md` → `claudes-docs/plans/`
- `*task*.txt`, `*task*.json` → `claudes-docs/tasks/`
- `*.log` → `claudes-docs/logs/`
- Everything else → `claudes-docs/misc/`

**Commands to execute for each file found:**
```bash
# Example: Move AAR files
for file in $(find "$PWD" -maxdepth 2 -name "*aar*.md" -type f -mtime -1 ! -path "*/claudes-docs/*"); do
  echo "Moving: $file → $DOCS_DIR/reports/$(basename "$file")"
  mv "$file" "$DOCS_DIR/reports/"
done

# Example: Move audit files
for file in $(find "$PWD" -maxdepth 2 -name "*audit*.md" -type f -mtime -1 ! -path "*/claudes-docs/*"); do
  echo "Moving: $file → $DOCS_DIR/audits/$(basename "$file")"
  mv "$file" "$DOCS_DIR/audits/"
done

# Similar for other patterns...
```

## Phase 4: Generate Inventory Report

**Create an inventory of all organized files:**
```bash
# Generate inventory
cat > "$DOCS_DIR/INVENTORY.md" << 'EOF'
# Claude Documentation Inventory

**Generated:** $(date -u +"%Y-%m-%dT%H:%M:%SZ")
**Location:** $DOCS_DIR

## Directory Structure

EOF

# Add directory listings
for dir in reports audits analysis plans tasks logs misc; do
  if [ -d "$DOCS_DIR/$dir" ] && [ "$(ls -A "$DOCS_DIR/$dir")" ]; then
    echo -e "\n### $dir/\n" >> "$DOCS_DIR/INVENTORY.md"
    ls -1 "$DOCS_DIR/$dir" | while read f; do
      echo "- $f" >> "$DOCS_DIR/INVENTORY.md"
    done
  fi
done

echo "✅ Inventory generated: $DOCS_DIR/INVENTORY.md"
cat "$DOCS_DIR/INVENTORY.md"
```

## Phase 5: Ensure Proper Document Formatting

**All documents must follow these naming conventions:**

### File Naming Format
```
<UTC-ISO8601>_<project-slug>_<short-slug>.<ext>
```

**Examples:**
- `2025-10-04T16-05-12Z_debug-session_api-fix_aar.md`
- `2025-10-04T14-30-00Z_bobs-brain_audit-report.md`
- `2025-10-04T12-00-00Z_diagnosticpro_task-export.json`

### Required Elements
1. **UTC timestamp** - ISO8601 format: `YYYY-MM-DDTHH-MM-SSZ`
2. **Project slug** - Kebab-case project identifier
3. **Short description** - Brief descriptor of content
4. **Extension** - `.md`, `.txt`, `.json`, `.log`

### Auto-Rename Non-Compliant Files

**Check and rename files that don't follow format:**
```bash
# Function to generate compliant filename
generate_filename() {
  local original="$1"
  local category="$2"

  # Extract project from current directory or git repo
  local project=$(basename "$(git rev-parse --show-toplevel 2>/dev/null || pwd)" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g')

  # Get current UTC timestamp
  local timestamp=$(date -u +"%Y-%m-%dT%H-%M-%SZ")

  # Extract extension
  local ext="${original##*.}"

  # Generate short slug from filename
  local slug=$(basename "$original" ".$ext" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-\|-$//g')

  # Build compliant name
  echo "${timestamp}_${project}_${slug}.${ext}"
}

# Rename files that don't match pattern
for file in "$DOCS_DIR"/**/*; do
  if [ -f "$file" ]; then
    basename_file=$(basename "$file")

    # Check if filename matches ISO8601 pattern
    if ! echo "$basename_file" | grep -qE '^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}-[0-9]{2}-[0-9]{2}Z_'; then
      # Get the subdirectory
      subdir=$(dirname "$file" | sed "s|$DOCS_DIR/||")

      # Generate new compliant name
      new_name=$(generate_filename "$basename_file" "$subdir")
      new_path="$(dirname "$file")/$new_name"

      echo "Renaming: $basename_file → $new_name"
      mv "$file" "$new_path"
    fi
  fi
done

echo "✅ All files renamed to comply with format"
```

## Phase 6: Summary Report

**Output format:**
```
=== CLAUDE DOCS ORGANIZATION SUMMARY ===

📁 Location: $DOCS_DIR

📊 Files organized:
  - Reports: X files
  - Audits: X files
  - Analysis: X files
  - Plans: X files
  - Tasks: X files
  - Logs: X files
  - Misc: X files

Total: X files moved to claudes-docs/

✅ All documentation organized and inventoried
📄 Full inventory: claudes-docs/INVENTORY.md
```

## Usage Instructions

**Run this command in any project directory to:**
1. Create `claudes-docs/` structure if missing
2. Find all recently created documentation
3. Categorize and organize files by type
4. Generate inventory report
5. Clean up working directory

**Customization options:**
- Change time window: `-mtime -1` (last 24h) → `-mtime -7` (last 7 days)
- Change depth: `-maxdepth 2` → `-maxdepth 3` (search deeper)
- Add exclusions: `! -path "*/exclude-dir/*"`

## Safety Features

- Never moves files already in `claudes-docs/`
- Skips `.git/`, `node_modules/`, and common ignore patterns
- Preserves original filenames
- Creates backup-friendly structure
- Generates audit trail in INVENTORY.md

## Example Output

```
Moving: 2025-10-04T16-05-12Z_debug-session_aar.md → claudes-docs/reports/
Moving: task-export.json → claudes-docs/tasks/
Moving: api-analysis.md → claudes-docs/analysis/

=== CLAUDE DOCS ORGANIZATION SUMMARY ===
📁 Location: /home/user/project/claudes-docs
📊 Files organized: 12 files
✅ All documentation organized
```

---

**Run whenever you need to clean up and organize Claude-created documentation!**
