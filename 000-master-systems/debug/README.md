# Debug & Fix Systems
**Category**: Master Debug Protocols
**Files**: 1 AI execution prompt

---

## 📚 **Documentation Model**

This directory contains AI execution prompts for systematic debugging and troubleshooting.

---

## 🔍 **Available Debug Protocols**

### **AI Execution Prompts** (Claude runs these)

#### **🐛 DEBUG-001**: Universal Debug-Fix Protocol
- **Type**: AI Execution Prompt
- **Purpose**: Comprehensive auditable debugging for failed fix attempts
- **What Claude Does**:
  1. Acknowledges failure and starts fresh
  2. Takes environment snapshot
  3. Creates Taskwarrior project with 7 tasks
  4. Reproduces error with exact steps
  5. Isolates failing layer
  6. Formulates hypothesis
  7. Implements fix behind branch/flag
  8. Executes positive and negative tests
  9. Generates complete evidence pack
  10. Creates after-action report
- **Use When**: Previous fix attempts failed, need systematic debugging with audit trail

**Key Features:**
- 8 comprehensive phases (ACK through Failure Policy)
- Mandatory execution gates requiring "Proceed"
- Real Taskwarrior IDs (no placeholders)
- UTC timestamps on all logs
- All artifacts saved to `claudes-docs/`
- File naming: `<UTC-ISO8601>_<project-slug>_<short-slug>.<ext>`
- Complete evidence pack with AAR

---

## 🚀 **Quick Start Guide**

### **Run Complete Debug Protocol**
Tell Claude:
> "Use DEBUG-001 to debug this issue"

Then fill in:
1. Problem description (expected vs actual behavior)
2. Your code/prompt to debug
3. Copy entire prompt to Claude

Claude will execute the full 8-phase protocol with gates and evidence collection.

---

## 🔄 **Debug Workflow**

### **When to Use DEBUG-001**
- ✅ Previous fix attempt failed
- ✅ Need systematic root-cause analysis
- ✅ Require complete audit trail
- ✅ Working on critical production issues
- ✅ Need comprehensive evidence for post-mortems

### **Complete Debugging Process**
1. **Acknowledge**: Start fresh, previous solution was wrong
2. **Snapshot**: Capture complete environment state
3. **Tasks**: Create 7 Taskwarrior tasks with dependencies
4. **Reproduce**: Exact steps with UTC timestamps
5. **Isolate**: Narrow to failing layer with proof
6. **Hypothesis**: Formulate falsifiable root cause
7. **Fix**: Implement behind branch/flag with rollback
8. **Verify**: Positive and negative tests
9. **Evidence**: Complete pack with AAR

### **Execution Gates**
- **Gate A**: After reproduction/isolation - wait for "Proceed"
- **Gate B**: After fix plan - wait for "Proceed"

### **Deliverables**
- Complete reproduction steps
- Root cause analysis
- Tested fix (positive + negative)
- Evidence pack in `claudes-docs/`:
  - After-action report
  - Test logs
  - Taskwarrior reports
  - Patch/diff files

---

## 🎯 **Key Principles**

### **Systematic Approach**
- No shortcuts - follow all 8 phases
- Real Taskwarrior IDs required
- UTC timestamps mandatory
- Evidence saved continuously

### **Audit Trail**
- All commands logged
- All outputs captured
- All decisions documented
- Complete evidence pack

### **Safety First**
- Feature flags for rollout
- Rollback procedures documented
- Positive AND negative tests
- Stop after 2 verification failures

---

**Updated**: 2025-10-05
**Category**: Debug & Fix Systems
**Model**: AI execution prompt with mandatory gates
