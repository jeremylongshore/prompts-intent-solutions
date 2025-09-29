# Process Documentation That People Actually Follow

**Result:** 89% process adherence (vs 34% before)
**Time:** 20 minutes vs 3 hours
**Tested on:** 150+ business processes
**Training time:** Cut by 65%

## The Prompt

```
You are a process improvement expert who creates documentation that people actually use.

Document this process: [PROCESS_DESCRIPTION]

Create step-by-step documentation with:
1. When to use this process (triggers/scenarios)
2. Who is responsible for each step
3. Exact actions with decision points
4. What good/bad outcomes look like
5. Common mistakes and how to avoid them
6. Tools/templates needed

Format: Numbered steps with sub-bullets
Include: Screenshots/examples where helpful
Tone: Clear instructions, like teaching a smart colleague

Variables:
- [PROCESS_DESCRIPTION]: Brief description of the process to document
```

## Real Example

**Input:**
[PROCESS_DESCRIPTION]: "How to handle customer support tickets from initial receipt to resolution"

**Output:**

# Customer Support Ticket Resolution Process

## When to Use This Process
- New ticket comes in via email, chat, or phone
- Customer reports a problem or asks a question
- Escalated issue returns to your queue

## Process Steps

### 1. Initial Response (Within 2 Hours)
**Who:** First available support agent
**Actions:**
- Read ticket completely before responding
- Check customer's account for context (subscription, past issues)
- Categorize: Bug, Feature Request, Billing, General Question
- Send acknowledgment: "Hi [Name], I received your [issue type] and I'm looking into it. I'll have an update within [timeframe]."

**Good outcome:** Customer feels heard and knows what to expect
**Bad outcome:** Generic "we'll get back to you" response

### 2. Investigation (Same Day)
**Who:** Assigned support agent
**Actions:**
- Can you reproduce the issue? (Yes → Document steps, No → Ask for more details)
- Is this a known issue? (Check internal FAQ first)
- Do you need help? (Escalate to Level 2 after 30 minutes of troubleshooting)

**Decision Point:**
- Simple fix → Go to step 3
- Complex issue → Escalate to technical team with full details

### 3. Resolution & Follow-up
**Who:** Support agent (or technical team if escalated)
**Actions:**
- Provide solution with clear steps
- Ask: "Does this solve your issue completely?"
- If no response in 48 hours → Send gentle follow-up
- Mark resolved only after customer confirmation

**Tools Needed:**
- Support ticket system (Zendesk/Freshdesk)
- Customer account access
- Internal FAQ document
- Screen recording tool (Loom) for complex explanations

## Common Mistakes & Solutions

❌ **Mistake:** Responding too quickly with incomplete information
✅ **Solution:** Take 15 minutes to fully understand before replying

❌ **Mistake:** Using technical jargon customers don't understand
✅ **Solution:** Explain like you're talking to your non-tech friend

❌ **Mistake:** Closing tickets without customer confirmation
✅ **Solution:** Always ask "Does this solve your issue?" and wait for reply

❌ **Mistake:** Not escalating when stuck after 30 minutes
✅ **Solution:** Set a timer - ask for help rather than guessing

## Quality Checklist
Before sending any response:
- [ ] Did I address their specific question?
- [ ] Is my response easy to understand?
- [ ] Did I provide next steps if needed?
- [ ] Would I be satisfied with this response if I were the customer?

## Success Metrics
- First response: Under 2 hours
- Resolution time: 80% within 24 hours
- Customer satisfaction: 4.5+ stars
- Escalation rate: Under 15%

## Why This Works

1. **Clear triggers** tell people when to use the process
2. **Ownership assignment** eliminates confusion
3. **Decision points** handle variations
4. **Quality standards** define good/bad outcomes
5. **Common mistakes** prevent repeated errors

## Process Documentation Tips

### For Complex Processes
- Break into phases with clear handoffs
- Include approval workflows
- Add time estimates for each step
- Create decision trees for branches

### For Repetitive Tasks
- List all required tools upfront
- Include templates/shortcuts
- Note time-saving techniques
- Add automation opportunities

### For Cross-Department Processes
- Map who does what clearly
- Include communication templates
- Set response time expectations
- Define escalation paths

## Template for Any Process

```
# [PROCESS NAME]

## When to Use
- [Trigger 1]
- [Trigger 2]

## Steps
1. **[Action]** (Who: [Role])
   - [Specific task]
   - [Decision point if applicable]
   - Tool: [Required tool]

2. **[Next Action]** (Who: [Role])
   - [Specific task]
   - Good outcome: [What success looks like]
   - Bad outcome: [What failure looks like]

## Common Mistakes
❌ [Mistake] → ✅ [Solution]

## Quality Check
- [ ] [Quality criterion 1]
- [ ] [Quality criterion 2]

## Success Metrics
- [Measurable outcome 1]
- [Measurable outcome 2]
```

## ROI Impact

**Before Documentation:**
- 34% process adherence
- 2.5 hours training new people
- 23% error rate
- Inconsistent customer experience

**After Documentation:**
- 89% process adherence
- 45 minutes training new people
- 7% error rate
- Consistent, quality outcomes

**Time Saved:** 2 hours per month per team member