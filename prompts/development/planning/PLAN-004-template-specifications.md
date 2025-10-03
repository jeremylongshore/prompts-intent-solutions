---
name: prompt-template-specifications
description: 5 specialized prompt templates based on audit analysis and core template patterns
model: opus
complexity: intermediate
date: 2025-09-28
---

# 📝 5 Specialized Prompt Templates

**Date:** September 28, 2025
**Based On:** Comprehensive prompt audit and core template analysis
**Purpose:** Create standardized, reusable prompt templates for systematic development

---

## 🎯 Template Design Philosophy

Based on audit findings, these templates follow:
- **Length Optimization:** 100-200 lines maximum
- **Structure Consistency:** Standardized sections and formatting
- **Example Integration:** Concrete examples required
- **Success Criteria:** Clear completion metrics
- **Error Handling:** Fallback instructions included
- **Modularity:** Composable and chainable design

## 📋 Template 1: Basic Task Template

### Purpose
Single-purpose prompts for straightforward, focused tasks requiring clear objectives and direct execution.

### Template Structure:
```markdown
---
name: [descriptive-task-name]
description: [one-line purpose statement]
model: [preferred-model]
complexity: basic
estimated_time: [5-30 minutes]
category: task
---

# 🎯 [Task Name]

**Objective:** [Clear, specific goal in 1-2 sentences]

**Context:** [Essential background - 2-3 sentences max]

---

## 🔧 Prerequisites
- [ ] [Required tool/access/knowledge]
- [ ] [Required file/directory/resource]
- [ ] [Required permission/setup]

## 📋 Instructions

### Step 1: [Action Verb] [Object]
[Clear instruction with example]
```
Example: Check current git status
Command: `git status`
Expected: Clean working directory or list of changes
```

### Step 2: [Next Action]
[Clear instruction with example]

### Step 3: [Final Action]
[Clear instruction with example]

## 📊 Expected Output
**Format:** [Specific format description]
**Contents:** [What should be included]

**Example:**
```
[Concrete example of expected output]
```

## ✅ Success Criteria
- [ ] [Specific measurable outcome]
- [ ] [Verification method]
- [ ] [Quality check]

## ⚠️ Error Handling
**If [common error]:** [Specific solution]
**If [another error]:** [Specific solution]
**If task fails completely:** [Rollback instructions]

---
*Template Version: 1.0 | Last Updated: {{DATE}}*
```

## 📋 Template 2: Complex Workflow Template

### Purpose
Multi-step processes with decision points, conditional logic, and phase-based execution.

### Template Structure:
```markdown
---
name: [workflow-name]
description: [comprehensive workflow purpose]
model: [preferred-model]
complexity: advanced
estimated_time: [30-120 minutes]
category: workflow
prerequisites: [list required basic templates]
---

# 🔄 [Workflow Name]

**Objective:** [Clear end-state description]

**Scope:** [What's included and excluded]

**Context:** [Why this workflow exists and when to use it]

---

## 📋 Phase Overview
1. **[Phase 1 Name]** - [Brief description]
2. **[Phase 2 Name]** - [Brief description]
3. **[Phase 3 Name]** - [Brief description]
4. **[Phase 4 Name]** - [Brief description]

## 🎯 Phase 1: [Name]

### Objectives
- [ ] [Specific objective]
- [ ] [Specific objective]

### Process
1. **[Action]**
   - Command: `[specific command]`
   - Expected: [expected result]
   - If error: [fallback action]

2. **[Decision Point]**
   - If [condition A]: → Go to Phase 2
   - If [condition B]: → Skip to Phase 3
   - If [condition C]: → Error handling procedure

### Deliverables
- [ ] [Specific deliverable with format]
- [ ] [Verification artifact]

### Validation
**Check:** [How to verify phase completion]
**Criteria:** [Pass/fail criteria]

---

## 🎯 Phase 2: [Name]
[Repeat structure]

---

## 🎯 Phase 3: [Name]
[Repeat structure]

---

## 🎯 Phase 4: [Name]
[Repeat structure]

---

## 📊 Final Deliverables
**Primary Output:** [Main deliverable]
**Supporting Artifacts:** [Additional outputs]
**Documentation:** [Required documentation]

## ✅ Workflow Success Criteria
- [ ] All phases completed successfully
- [ ] All deliverables meet quality standards
- [ ] All validation checks passed
- [ ] Documentation updated

## ⚠️ Error Recovery
**Phase 1 Failure:** [Recovery procedure]
**Phase 2 Failure:** [Recovery procedure]
**Phase 3 Failure:** [Recovery procedure]
**Phase 4 Failure:** [Recovery procedure]
**Complete Workflow Failure:** [Complete rollback]

## 🔄 Next Steps
**If workflow succeeds:** [What happens next]
**Related workflows:** [Link to connected processes]

---
*Template Version: 1.0 | Last Updated: {{DATE}}*
```

## 📋 Template 3: Research Template

### Purpose
Information gathering, analysis, and synthesis tasks requiring comprehensive investigation.

### Template Structure:
```markdown
---
name: [research-topic]
description: [specific research question or objective]
model: [preferred-model]
complexity: intermediate
estimated_time: [45-90 minutes]
category: research
output_format: [report/analysis/summary]
---

# 🔍 [Research Topic]

**Research Question:** [Specific, focused question]

**Scope:** [What will and won't be researched]

**Target Audience:** [Who will use this research]

---

## 🎯 Research Objectives
1. **Primary:** [Main research goal]
2. **Secondary:** [Supporting research goals]
3. **Success Metrics:** [How to measure research quality]

## 📚 Information Sources

### Primary Sources (Required)
- [ ] [Specific source type with access method]
- [ ] [Specific source type with access method]
- [ ] [Specific source type with access method]

### Secondary Sources (Optional)
- [ ] [Additional source type]
- [ ] [Additional source type]

### Search Strategy
**Keywords:** [Primary search terms]
**Filters:** [Date ranges, source types, etc.]
**Exclusions:** [What to avoid]

## 🔍 Research Process

### Phase 1: Information Gathering (30 minutes)
1. **[Search primary sources]**
   - Query: `[specific search terms]`
   - Collect: [What to extract]
   - Document: [How to record findings]

2. **[Validate information]**
   - Cross-reference: [Verification method]
   - Quality check: [Information reliability criteria]

### Phase 2: Analysis & Synthesis (45 minutes)
1. **[Organize findings]**
   - Categories: [How to group information]
   - Patterns: [What to look for]
   - Gaps: [Missing information identification]

2. **[Draw conclusions]**
   - Evidence: [Supporting data requirements]
   - Confidence levels: [High/Medium/Low criteria]
   - Assumptions: [Document all assumptions]

### Phase 3: Documentation (15 minutes)
1. **[Create deliverable]**
   - Format: [Specific output format]
   - Structure: [Required sections]
   - Citations: [How to reference sources]

## 📊 Research Output Format

### Executive Summary
**Key Findings:** [3-5 bullet points]
**Confidence Level:** [High/Medium/Low with justification]
**Recommendations:** [Action items based on research]

### Detailed Analysis
**Finding 1:** [Detailed finding with evidence]
**Finding 2:** [Detailed finding with evidence]
**Finding 3:** [Detailed finding with evidence]

### Supporting Data
**Sources:** [List all sources with links]
**Data Tables:** [Structured data presentation]
**Evidence Quality:** [Assessment of source reliability]

## ✅ Research Quality Criteria
- [ ] All primary sources consulted
- [ ] Information cross-validated from multiple sources
- [ ] Gaps and limitations clearly documented
- [ ] Conclusions supported by evidence
- [ ] Citations properly formatted

## ⚠️ Research Limitations
**Time Constraints:** [How time limits affected scope]
**Source Availability:** [What sources were inaccessible]
**Scope Restrictions:** [What was excluded and why]

## 🔄 Follow-up Actions
**Additional Research Needed:** [Identified gaps for future investigation]
**Related Research Questions:** [Connected topics to explore]
**Implementation Steps:** [If research leads to action items]

---
*Template Version: 1.0 | Last Updated: {{DATE}}*
```

## 📋 Template 4: Troubleshooting Template

### Purpose
Problem diagnosis, root cause analysis, and systematic resolution processes.

### Template Structure:
```markdown
---
name: [troubleshooting-scenario]
description: [specific problem or system being diagnosed]
model: [preferred-model]
complexity: intermediate
estimated_time: [20-60 minutes]
category: troubleshooting
urgency: [low/medium/high/critical]
---

# 🔧 [Problem/System] Troubleshooting

**Problem Statement:** [Clear, specific description of the issue]

**Impact:** [Who/what is affected and how severely]

**Context:** [When problem started, what changed, relevant background]

---

## 🚨 Severity Assessment

### Impact Level
- **Users Affected:** [Number/percentage]
- **Systems Affected:** [List of impacted systems]
- **Business Impact:** [Revenue/operations/reputation effects]

### Urgency Classification
- [ ] **Critical:** System down, immediate action required
- [ ] **High:** Major functionality impaired, quick resolution needed
- [ ] **Medium:** Partial functionality lost, resolution within hours
- [ ] **Low:** Minor issue, can be resolved during maintenance window

## 🔍 Initial Investigation

### Symptom Collection
1. **Observable Behaviors**
   - What's happening: [Specific symptoms]
   - When it happens: [Timing/frequency]
   - Where it happens: [Location/environment]

2. **Error Messages**
   ```
   [Copy exact error messages here]
   ```

3. **Environmental Factors**
   - Recent changes: [Deployments/config changes/updates]
   - Load patterns: [Traffic/usage patterns]
   - Dependencies: [External service status]

### Quick Checks (5 minutes)
- [ ] Check system status dashboards
- [ ] Review recent deployment logs
- [ ] Verify external service availability
- [ ] Check resource utilization (CPU/Memory/Disk)

## 🔍 Systematic Diagnosis

### Phase 1: Reproduce Issue (10 minutes)
1. **Attempt Reproduction**
   - Steps: [Specific steps to reproduce]
   - Expected: [What should happen]
   - Actual: [What actually happens]
   - Consistency: [How often it occurs]

### Phase 2: Root Cause Analysis (20 minutes)
1. **Layer Analysis** (Work from outside in)
   - **Network Layer:** [Check connectivity, DNS, firewalls]
   - **Application Layer:** [Check application logs, configurations]
   - **Data Layer:** [Check database connections, queries]
   - **Infrastructure Layer:** [Check servers, containers, resources]

2. **Timeline Analysis**
   - When did it start: [Timestamp]
   - What changed around that time: [List all changes]
   - Pattern analysis: [Is it getting worse/better/stable]

### Phase 3: Hypothesis Testing (15 minutes)
1. **Primary Hypothesis:** [Most likely cause based on evidence]
   - **Test:** [How to validate this hypothesis]
   - **Expected Result:** [What you'd see if hypothesis is correct]
   - **Actual Result:** [What you actually observe]

2. **Secondary Hypothesis:** [Next most likely cause]
   - **Test:** [Validation method]
   - **Expected Result:** [Expected outcome]
   - **Actual Result:** [Observed outcome]

## 🛠️ Resolution Process

### Immediate Actions (Critical/High Priority)
1. **Stabilization** (if needed)
   - [ ] Implement temporary workaround
   - [ ] Scale resources if resource-related
   - [ ] Rollback recent changes if applicable

### Root Cause Resolution
1. **Fix Implementation**
   - Action: [Specific fix to implement]
   - Risk Assessment: [Potential negative impacts]
   - Rollback Plan: [How to undo if fix makes things worse]

2. **Verification Process**
   - [ ] Apply fix in test environment first (if possible)
   - [ ] Monitor key metrics after implementation
   - [ ] Verify fix resolves original symptoms
   - [ ] Confirm no new issues introduced

## 📊 Solution Documentation

### Root Cause Summary
**Primary Cause:** [What actually caused the problem]
**Contributing Factors:** [Secondary factors that made it worse]
**Resolution:** [What was done to fix it]

### Prevention Measures
- [ ] [Specific action to prevent recurrence]
- [ ] [Monitoring/alerting improvements]
- [ ] [Process/documentation improvements]

## ✅ Resolution Validation
- [ ] Original symptoms no longer present
- [ ] All affected systems functioning normally
- [ ] Key metrics returned to normal ranges
- [ ] Stakeholders notified of resolution
- [ ] Post-incident documentation completed

## ⚠️ Escalation Procedures
**If initial troubleshooting fails:** [Who to contact and when]
**If issue gets worse:** [Emergency procedures]
**If resolution attempts cause new problems:** [Rollback and escalation]

## 🔄 Post-Resolution Actions
- [ ] Update runbooks with new troubleshooting steps
- [ ] Schedule post-incident review (if major issue)
- [ ] Implement identified prevention measures
- [ ] Update monitoring/alerting based on lessons learned

---
*Template Version: 1.0 | Last Updated: {{DATE}}*
```

## 📋 Template 5: Setup Template

### Purpose
System configuration, initialization, and environment preparation tasks.

### Template Structure:
```markdown
---
name: [system-setup-name]
description: [what system/environment is being configured]
model: [preferred-model]
complexity: [beginner/intermediate/advanced]
estimated_time: [15-90 minutes]
category: setup
environment: [local/dev/staging/production]
---

# ⚙️ [System/Environment] Setup

**Purpose:** [What this setup accomplishes]

**Target Environment:** [Local development/Server/Container/etc.]

**Prerequisites:** [Required knowledge, tools, access]

---

## 📋 Pre-Setup Checklist

### System Requirements
- [ ] **Operating System:** [Required OS and version]
- [ ] **Hardware:** [CPU/RAM/Disk requirements]
- [ ] **Network:** [Required connectivity/ports]
- [ ] **Permissions:** [Required access levels]

### Dependencies
- [ ] **Tools:** [Required software installations]
- [ ] **Accounts:** [Required service accounts/API keys]
- [ ] **Resources:** [Required external resources]

### Verification Commands
```bash
# Check tool versions
[command to verify dependencies]

# Check permissions
[command to verify access]

# Check connectivity
[command to verify network]
```

## 🔧 Installation Process

### Phase 1: Core Installation (15-30 minutes)

#### Step 1: [Primary Component Installation]
**Purpose:** [Why this step is necessary]

**Commands:**
```bash
# [Description of what these commands do]
[specific installation commands]
```

**Verification:**
```bash
# Verify installation
[verification command]
# Expected output: [what to expect]
```

**Troubleshooting:**
- **If error [X]:** [Specific solution]
- **If permission denied:** [Permission fix]

#### Step 2: [Configuration Setup]
**Purpose:** [Why this configuration is needed]

**File Locations:**
- Config file: `[path/to/config]`
- Log file: `[path/to/logs]`
- Data directory: `[path/to/data]`

**Configuration:**
```bash
# Create configuration
[commands to create config]
```

**Template Configuration:**
```yaml
# [config-file-name.yml]
[sample configuration with comments]
```

### Phase 2: Service Configuration (15-30 minutes)

#### Step 3: [Service Setup]
**Purpose:** [What service provides]

**Commands:**
```bash
# Service installation and configuration
[service setup commands]
```

#### Step 4: [Security Configuration]
**Purpose:** [Security considerations]

**Commands:**
```bash
# Security hardening
[security setup commands]
```

### Phase 3: Testing & Validation (10-15 minutes)

#### Step 5: [Functionality Testing]
**Tests to perform:**
- [ ] **Basic connectivity:** [Test method]
- [ ] **Authentication:** [Test method]
- [ ] **Core functionality:** [Test method]

**Test Commands:**
```bash
# Test 1: [Description]
[test command]
# Expected: [expected result]

# Test 2: [Description]
[test command]
# Expected: [expected result]
```

## 📊 Configuration Details

### Environment Variables
```bash
# Required environment variables
export [VAR_NAME]="[value_description]"
export [VAR_NAME_2]="[value_description]"
```

### File Structure
```
[project-root]/
├── config/
│   ├── [config-file]
│   └── [other-config]
├── logs/
├── data/
└── scripts/
    ├── start.sh
    └── stop.sh
```

### Service Configuration
- **Service Name:** [service-name]
- **Port:** [port-number]
- **Protocol:** [HTTP/HTTPS/TCP/etc.]
- **Dependencies:** [list of dependent services]

## ✅ Setup Validation

### Functional Tests
- [ ] Service starts successfully
- [ ] All ports are accessible
- [ ] Authentication works correctly
- [ ] Core features function properly
- [ ] Logs are generated correctly

### Performance Tests
- [ ] Response times within acceptable range
- [ ] Resource usage within expected bounds
- [ ] Concurrent connection handling works

### Security Tests
- [ ] Unauthorized access blocked
- [ ] Secure communication protocols active
- [ ] Logs don't contain sensitive information

## 🔧 Maintenance Information

### Regular Maintenance Tasks
- **Daily:** [Daily maintenance items]
- **Weekly:** [Weekly maintenance items]
- **Monthly:** [Monthly maintenance items]

### Monitoring & Alerts
- **Key Metrics:** [What to monitor]
- **Alert Thresholds:** [When to alert]
- **Dashboard Location:** [Where to view status]

### Backup & Recovery
- **Backup Strategy:** [What and how often to backup]
- **Recovery Process:** [How to restore from backup]
- **Testing Schedule:** [How often to test recovery]

## ⚠️ Troubleshooting Common Issues

### Issue 1: [Common Problem]
**Symptoms:** [How to recognize this issue]
**Cause:** [Why it happens]
**Solution:** [How to fix it]

### Issue 2: [Another Common Problem]
**Symptoms:** [Recognition signs]
**Cause:** [Root cause]
**Solution:** [Resolution steps]

## 🔄 Next Steps

### Post-Setup Actions
- [ ] Schedule first backup
- [ ] Configure monitoring alerts
- [ ] Document any customizations made
- [ ] Add system to inventory/documentation

### Related Setups
- **If using [related system]:** [Link to related setup guide]
- **For [environment] deployment:** [Link to deployment guide]

### Team Onboarding
- [ ] Share access credentials securely
- [ ] Document custom configurations
- [ ] Schedule knowledge transfer session

---
*Template Version: 1.0 | Last Updated: {{DATE}}*
```

---

## 🎯 Template Usage Guidelines

### Selection Criteria:
- **Basic Task:** Single step, clear outcome, <30 minutes
- **Complex Workflow:** Multi-phase, decision points, >30 minutes
- **Research:** Information gathering, analysis required
- **Troubleshooting:** Problem exists, diagnosis needed
- **Setup:** New system/environment configuration

### Customization Tips:
1. Replace all `[bracketed placeholders]` with specific content
2. Adjust complexity and time estimates based on actual requirements
3. Add or remove sections based on specific needs
4. Include project-specific examples and commands
5. Update error handling based on common issues encountered

### Quality Standards:
- All examples must be functional and tested
- All commands must include expected outputs
- All error conditions must have specific solutions
- All templates must include validation steps

---

**Document Status:** ✅ Complete
**Next Phase:** GitHub Repository Structure Planning
**Task Warrior Integration:** Ready for task creation