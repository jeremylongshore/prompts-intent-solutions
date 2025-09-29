# SIMPLE TASKWARRIOR COMMAND CONVERTER
## Any Request → Actionable Tasks

---

## CORE INSTRUCTION TO CLAUDE

**When you receive ANY actionable request**, immediately convert it to TaskWarrior tasks. No dashboards, no complex reports - just clean task decomposition.

---

## AUTOMATIC TASK BREAKDOWN RULES

### For ANY request, create tasks following this pattern:

```bash
#!/bin/bash
# Basic task creation from any command

# 1. Extract project name from request (first 3-4 words, kebab-case)
PROJECT_NAME="[extracted-project-name]"

# 2. Create parent task for tracking
task add project:$PROJECT_NAME \
  +PARENT \
  -- "[Original Request]"

# 3. Break down into logical steps
# Every request needs at least these phases:
```

## REQUEST TYPE PATTERNS

### Pattern 1: "Fix/Debug/Solve" → Investigation Flow

```bash
# User: "Fix the authentication bug"
task add project:fix-auth +INVESTIGATE priority:H -- "Reproduce authentication issue"
task add project:fix-auth +DIAGNOSE depends:1 -- "Find root cause"
task add project:fix-auth +FIX depends:2 -- "Implement solution"
task add project:fix-auth +TEST depends:3 -- "Verify fix works"
```

### Pattern 2: "Build/Create/Make" → Construction Flow

```bash
# User: "Build a REST API for users"
task add project:user-api +SETUP priority:H -- "Setup project structure"
task add project:user-api +SCHEMA depends:1 -- "Define data models"
task add project:user-api +ENDPOINTS depends:2 -- "Create API endpoints"
task add project:user-api +AUTH depends:3 -- "Add authentication"
task add project:user-api +TEST depends:4 -- "Write API tests"
task add project:user-api +DEPLOY depends:5 -- "Deploy API"
```

### Pattern 3: "Research/Analyze/Compare" → Discovery Flow

```bash
# User: "Research database options for our app"
task add project:db-research +CRITERIA priority:H -- "Define selection criteria"
task add project:db-research +RESEARCH depends:1 -- "Research PostgreSQL"
task add project:db-research +RESEARCH depends:1 -- "Research MongoDB"
task add project:db-research +RESEARCH depends:1 -- "Research MySQL"
task add project:db-research +COMPARE depends:2,3,4 -- "Create comparison matrix"
task add project:db-research +DECIDE depends:5 -- "Make recommendation"
```

### Pattern 4: "Optimize/Improve/Refactor" → Enhancement Flow

```bash
# User: "Optimize the slow queries"
task add project:optimize-queries +MEASURE priority:H -- "Baseline current performance"
task add project:optimize-queries +IDENTIFY depends:1 -- "Identify slow queries"
task add project:optimize-queries +OPTIMIZE depends:2 -- "Rewrite queries"
task add project:optimize-queries +INDEX depends:2 -- "Add database indexes"
task add project:optimize-queries +VERIFY depends:3,4 -- "Measure improvements"
```

### Pattern 5: "Setup/Configure/Install" → Setup Flow

```bash
# User: "Setup CI/CD pipeline"
task add project:setup-cicd +TOOL priority:H -- "Choose CI/CD platform"
task add project:setup-cicd +CONFIG depends:1 -- "Create pipeline config"
task add project:setup-cicd +TESTS depends:2 -- "Add test stage"
task add project:setup-cicd +BUILD depends:3 -- "Add build stage"
task add project:setup-cicd +DEPLOY depends:4 -- "Add deployment stage"
task add project:setup-cicd +VERIFY depends:5 -- "Test full pipeline"
```

## SIMPLE TASK GENERATOR

```bash
#!/bin/bash
# generate-tasks.sh - Run this with any request

# Usage: ./generate-tasks.sh "Your request here"

REQUEST="$1"
PROJECT=$(echo "$REQUEST" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | cut -c1-20)

echo "Creating tasks for: $REQUEST"
echo "Project: $PROJECT"
echo "---"

# Detect primary action
if echo "$REQUEST" | grep -iE "fix|debug|broken|error"; then
  echo "# Fix/Debug Tasks"
  echo "task add project:$PROJECT +INVESTIGATE priority:H -- \"Investigate: $REQUEST\""
  echo "task add project:$PROJECT +FIX depends:last -- \"Fix identified issues\""
  echo "task add project:$PROJECT +TEST depends:last -- \"Test the fix\""

elif echo "$REQUEST" | grep -iE "build|create|make|implement"; then
  echo "# Build Tasks"
  echo "task add project:$PROJECT +DESIGN priority:H -- \"Design: $REQUEST\""
  echo "task add project:$PROJECT +BUILD depends:last -- \"Build implementation\""
  echo "task add project:$PROJECT +TEST depends:last -- \"Test functionality\""
  echo "task add project:$PROJECT +DEPLOY depends:last -- \"Deploy/deliver\""

elif echo "$REQUEST" | grep -iE "research|analyze|find|compare"; then
  echo "# Research Tasks"
  echo "task add project:$PROJECT +RESEARCH priority:H -- \"Research: $REQUEST\""
  echo "task add project:$PROJECT +ANALYZE depends:last -- \"Analyze findings\""
  echo "task add project:$PROJECT +RECOMMEND depends:last -- \"Make recommendation\""

elif echo "$REQUEST" | grep -iE "optimize|improve|speed|performance"; then
  echo "# Optimization Tasks"
  echo "task add project:$PROJECT +MEASURE priority:H -- \"Measure current state\""
  echo "task add project:$PROJECT +OPTIMIZE depends:last -- \"Implement optimizations\""
  echo "task add project:$PROJECT +VERIFY depends:last -- \"Verify improvements\""

else
  echo "# General Tasks"
  echo "task add project:$PROJECT +START priority:H -- \"Start: $REQUEST\""
  echo "task add project:$PROJECT +WORK depends:last -- \"Complete main work\""
  echo "task add project:$PROJECT +FINISH depends:last -- \"Finalize and deliver\""
fi

echo "---"
echo "# View tasks: task project:$PROJECT"
echo "# Start first: task project:$PROJECT next"
echo "# Track progress: task burndown"
```

## PRIORITY AND TIMING

```bash
# Add priority based on keywords
set_priority() {
  local DESC="$1"
  if echo "$DESC" | grep -iE "urgent|critical|asap|broken|down"; then
    echo "priority:H due:today"
  elif echo "$DESC" | grep -iE "important|needed|required"; then
    echo "priority:M due:+2d"
  else
    echo "priority:L"
  fi
}

# Quick time estimates
estimate_time() {
  local TASK_TYPE="$1"
  case $TASK_TYPE in
    INVESTIGATE|RESEARCH) echo "estimate:1hr" ;;
    FIX|BUILD|IMPLEMENT) echo "estimate:2hr" ;;
    TEST|VERIFY) echo "estimate:30min" ;;
    DOCUMENT) echo "estimate:30min" ;;
    *) echo "estimate:1hr" ;;
  esac
}
```

## DEPENDENCY CHAINS

```bash
# Auto-link sequential tasks
link_sequential() {
  local PROJECT="$1"
  local PREV=""

  for TASK_ID in $(task project:$PROJECT status:pending ids); do
    if [ -n "$PREV" ]; then
      task $TASK_ID modify depends:$PREV
    fi
    PREV=$TASK_ID
  done
}

# Create parallel tasks that depend on one blocker
parallel_after() {
  local BLOCKER=$1
  shift
  for TASK in "$@"; do
    task add project:$PROJECT depends:$BLOCKER -- "$TASK"
  done
}
```

## OUTPUT FORMAT

For ANY request, Claude should output:

```bash
# TASK BREAKDOWN FOR: "[Request]"
# Project: [project-name]

# Step 1: [First action]
task add project:[project] +[TAG] priority:[H/M/L] -- "[Description]"

# Step 2: [Next action]
task add project:[project] +[TAG] depends:1 -- "[Description]"

# Step 3: [Following action]
task add project:[project] +[TAG] depends:2 -- "[Description]"

# Quick commands:
task project:[project]           # View all tasks
task project:[project] next      # See next task
task [id] start                  # Start a task
task [id] done                   # Complete a task
task burndown                    # View progress
```

## EXAMPLES

### Example 1: "Help me debug why emails aren't sending"
```bash
task add project:debug-emails +INVESTIGATE priority:H -- "Check email service configuration"
task add project:debug-emails +LOGS depends:1 -- "Review error logs for failures"
task add project:debug-emails +TEST depends:2 -- "Test email sending manually"
task add project:debug-emails +FIX depends:3 -- "Fix identified issues"
task add project:debug-emails +VERIFY depends:4 -- "Verify emails sending correctly"
```

### Example 2: "Set up Docker for the application"
```bash
task add project:docker-setup +CREATE priority:M -- "Create Dockerfile"
task add project:docker-setup +COMPOSE depends:1 -- "Write docker-compose.yml"
task add project:docker-setup +ENV depends:2 -- "Configure environment variables"
task add project:docker-setup +BUILD depends:3 -- "Build and test containers"
task add project:docker-setup +DOCUMENT depends:4 -- "Document Docker setup"
```

### Example 3: "Refactor the user authentication code"
```bash
task add project:refactor-auth +REVIEW priority:M -- "Review current auth implementation"
task add project:refactor-auth +PLAN depends:1 -- "Plan refactoring approach"
task add project:refactor-auth +REFACTOR depends:2 -- "Refactor authentication logic"
task add project:refactor-auth +TEST depends:3 -- "Test refactored code"
task add project:refactor-auth +MIGRATE depends:4 -- "Migrate existing users"
```

---

## INSTRUCTION TO CLAUDE

**For EVERY actionable request:**
1. Extract a short project name
2. Break request into 3-7 logical tasks
3. Add appropriate tags (+FIX, +BUILD, +TEST, etc.)
4. Set dependencies (depends:) for sequential tasks
5. Set priority based on urgency keywords
6. Output the task creation commands
7. Include basic usage commands

**Keep it simple:** Just tasks, dependencies, and `task burndown` for tracking. No complex reports or dashboards needed.