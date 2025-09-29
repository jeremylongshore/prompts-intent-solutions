---
name: mcp-repo-diagnostic-extreme
description: Forensic-level analysis and repair plan for broken MCP repositories
model: opus
date: 2025-09-28
---

# EXTREME MCP REPO DIAGNOSTIC & REPAIR MISSION

You are conducting a forensic-level analysis of my MCP (Model Context Protocol) repository. Your mission: figure out what the fuck is happening, why it's broken, and give me a surgical plan to unfuck it.

## PHASE 1: RECONNAISSANCE (What exists)

Analyze EVERYTHING in the repo and tell me:

### File Structure Audit
- List every file and directory with purpose assessment (needed/redundant/missing/wrong-location)
- Identify orphaned files, dead code, and zombie dependencies
- Flag any files that shouldn't be committed (secrets, .env, node_modules, build artifacts)
- Check for MCP-specific structure: `/src/`, server implementations, client configs, schemas
- Verify package.json scripts actually point to real files

### MCP Protocol Compliance Check
- Is there a valid MCP server implementation? (stdio/SSE/WebSocket?)
- Are transport layers properly configured?
- Do tool definitions follow MCP schema spec?
- Are prompts, resources, and tools properly exported?
- Is the server discoverable via `npx` or direct execution?
- Check if `mcp.json` exists and is valid

### Dependency Hellscape Analysis
- List every dependency and whether it's actually imported anywhere
- Identify version conflicts, security vulns, deprecated packages
- Check if MCP SDK versions (@modelcontextprotocol/sdk) are consistent
- Find circular dependencies or import loops
- Assess if TypeScript/JavaScript mixing is causing issues

### Configuration Archaeology
- Find all config files (tsconfig, eslint, prettier, jest, etc.)
- Determine which configs are actually being used vs dead
- Check for conflicting configurations
- Verify build configs actually produce runnable output
- Ensure MCP server config matches client expectations

## PHASE 2: RUNTIME ANALYSIS (What breaks)

### Build & Execution Testing
- Try to build the project - capture EVERY error/warning
- Attempt to run the MCP server via all documented methods
- Test with stdio: `node server.js` or `npx -y .`
- Check if TypeScript compilation works
- Verify the server responds to MCP initialization handshake
- Test each tool/resource/prompt for runtime errors

### MCP Client Integration Testing
- Can Claude Desktop connect to it?
- Does the server appear in available MCP servers?
- Do tools actually execute when called?
- Are responses properly formatted JSON-RPC?
- Check request/response cycle for hangs or timeouts

### Error Pattern Detection
- Collect all error messages from:
  - Build logs
  - Runtime stderr
  - MCP client connection attempts
  - Tool execution failures
- Identify root causes vs cascading symptoms

## PHASE 3: DOCUMENTATION REALITY CHECK

### README vs Reality
- Does the README match what actually exists?
- Are installation instructions accurate?
- Do example commands actually work?
- Is the "Quick Start" actually quick (or possible)?

### MCP-Specific Docs
- Is there documentation on:
  - Available tools and their parameters?
  - Required environment variables?
  - How to add to Claude config?
  - Debugging/logging setup?

## PHASE 4: DEEP ISSUES DISCOVERY

### Code Quality Disasters
- Identify functions longer than 50 lines
- Find deeply nested callbacks/promises without error handling
- Locate copy-pasted code blocks
- Check for console.log() debug statements in production
- Find TODO/FIXME/HACK comments
- Identify unreachable code paths

### MCP Anti-Patterns
- Tools doing too much in single operation
- Missing input validation on tool parameters
- Synchronous operations blocking the event loop
- Memory leaks from unclosed resources
- Missing error boundaries for tool execution

### Security Nightmares
- Exposed API keys or secrets
- Unvalidated tool inputs that could cause injection
- File system access without sandboxing
- Network requests without timeouts
- Missing rate limiting on resource-intensive tools

## PHASE 5: GENERATE THE BATTLE PLAN

Based on everything above, output:

### IMMEDIATE FIXES (Do now or server won't run)
Format each as:
```
🔴 CRITICAL: [Issue]
   FILE: [exact file path]
   PROBLEM: [specific error]
   FIX: [exact code or command to run]
   PR_TITLE: "fix: [conventional commit message]"
```

### HIGH PRIORITY (Server runs but barely)
```
🟠 HIGH: [Issue]
   IMPACT: [what breaks]
   FILES: [affected files]
   SOLUTION: [step-by-step fix]
   TIME: [estimated minutes]
   PR_TITLE: "fix: [message]"
```

### MEDIUM PRIORITY (Quality/maintainability)
```
🟡 MEDIUM: [Issue]
   WHY: [why this matters]
   APPROACH: [how to fix]
   PR_TITLE: "refactor: [message]"
```

### NICE TO HAVE (Polish)
```
🟢 ENHANCEMENT: [what to add]
   BENEFIT: [why bother]
   PR_TITLE: "feat: [message]"
```

## PHASE 6: EXECUTABLE RESCUE SCRIPTS

Generate ready-to-run shell commands:

```bash
# Emergency CPR Script
#!/bin/bash
# Run this first to make the server barely functional

[commands to fix critical issues]
```

```bash
# Dependency Unfucker
#!/bin/bash
# Fixes the package hell

[npm/yarn commands to clean dependencies]
```

```bash
# MCP Validation Script
#!/bin/bash
# Verifies MCP server actually works

[commands to test MCP compliance]
```

## PHASE 7: NEW FILE CONTENTS

For each broken file, provide the COMPLETE fixed version:

```typescript
// FILE: src/server.ts
// FIXED VERSION - Copy this entire content

[complete working code]
```

## PHASE 8: MCP CONFIG TEMPLATES

Provide working configs:

### mcp.json
```json
[complete valid MCP manifest]
```

### Claude Desktop Config Addition
```json
[exact JSON to add to claude_desktop_config.json]
```

### Example .env
```
[all required environment variables with descriptions]
```

## PHASE 9: TEST HARNESS

Create a test script that validates everything works:

```typescript
// FILE: test-mcp-server.ts
// Run this to verify your MCP server is properly fixed

[complete test implementation]
```

## PHASE 10: FUTURE-PROOFING

### CI/CD Pipeline
```yaml
# .github/workflows/mcp-validate.yml
[GitHub action that prevents future breakage]
```

### Pre-commit Hooks
```json
// package.json additions
[husky + lint-staged config]
```

### Monitoring/Logging Setup
```typescript
// src/utils/logger.ts
[proper logging implementation for MCP debugging]
```

## OUTPUT SUMMARY DASHBOARD

```
🏥 MCP REPO HEALTH REPORT
━━━━━━━━━━━━━━━━━━━━━━━
Overall Status: [CRITICAL/UNSTABLE/DEGRADED/HEALTHY]
Can Connect to Claude: [YES/NO]
Tools Functional: [X/Y working]
Build Success: [YES/NO/PARTIAL]

Top 3 Issues Blocking Usage:
1. [Issue] - [30 sec fix]
2. [Issue] - [2 min fix]
3. [Issue] - [5 min fix]

Total Issues Found: [number]
Estimated Fix Time: [minutes]
Code Smell Score: [X/10]
MCP Compliance: [X%]

VERDICT: [One sentence diagnosis of main problem]
PRESCRIPTION: [One sentence solution path]
```

---

## USAGE INSTRUCTIONS

**When using this prompt:**

1. **Gather Information First:**
   ```bash
   # Run these commands and paste outputs into your prompt:
   ls -la                    # Directory structure
   cat package.json          # Dependencies and scripts
   npm run build 2>&1        # Build errors
   node server.js 2>&1       # Runtime errors
   ```

2. **Provide Context:**
   - What should the MCP server do?
   - What errors are you seeing?
   - When did it last work?
   - What changed recently?

3. **Execute the Analysis:**
   - Paste this entire prompt
   - Add your repo information
   - Let Claude systematically analyze everything

4. **Follow the Battle Plan:**
   - Start with CRITICAL fixes
   - Test after each fix
   - Use provided scripts
   - Validate with test harness

**Expected Outcome:**
A working MCP server that connects to Claude Desktop with all tools functional and properly documented.

**Time Investment:**
- Analysis: 10-15 minutes
- Critical fixes: 30-60 minutes
- Full restoration: 2-4 hours

---

NOW ANALYZE MY MCP REPO WITH THIS LEVEL OF DETAIL. Start with Phase 1 and work through systematically. Be brutal about what's broken. Give me actionable fixes, not philosophical discussions.

**Current directory structure:**
[ls -la output here]

**Package.json:**
[paste your package.json]

**Recent error messages:**
[paste any errors you're seeing]

**What should be happening:**
[explain what you expect the MCP server to do]