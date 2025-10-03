# TaskWarrior DiagnosticPro Quick Start Guide
## Get Running in 5 Minutes

**Created:** 2025-09-29
**Status:** ✅ Production Ready
**For:** Immediate deployment and first-time users

---

## ⚡ 60-Second Setup

### Prerequisites
```bash
# Ubuntu/Debian
sudo apt-get install taskwarrior python3

# macOS
brew install task python3

# Verify
task --version && python3 --version
```

### One-Command Deployment
```bash
cd /home/jeremy/projects/prompts-intent-solutions/scripts && \
python3 validate_taskwarrior_setup.py && \
./taskwarrior_setup_commands.sh && \
echo "✅ Ready for testing!"
```

---

## 🚀 First Payment Test (5 Minutes)

### Step 1: Start Interactive Mode
```bash
python3 taskwarrior_helpers.py interactive
```

### Step 2: Choose Option 1 (Show Next Tasks)
```
Select option: 1
```

### Step 3: Start First Task
```
Select option: 3
Enter task ID: [FIRST_TASK_ID]
```

### Step 4: Begin Testing
**PREP Task**: Create diagnostic submission
- Go to https://diagnosticpro.io
- Fill out equipment details
- Add realistic problem description
- Note submission ID

### Step 5: Complete Task
```
Select option: 5
Enter task ID: [SAME_TASK_ID]
Enter completion note: Submission created: [SUBMISSION_ID]
```

---

## 🎯 Common Commands

### Essential Commands
```bash
# Show what to do next
python3 taskwarrior_helpers.py next

# Start a specific task
python3 taskwarrior_helpers.py start --task-id 123

# Complete a task with notes
python3 taskwarrior_helpers.py complete --task-id 123 --annotation "All tests passed"

# See what you're working on
python3 taskwarrior_helpers.py active
```

### Quick Status Check
```bash
# See all project tasks
task project:DiagnosticPro

# See only ready tasks
task project:DiagnosticPro ready

# Time report
python3 taskwarrior_helpers.py report --days 7
```

---

## 💳 Payment Testing Workflow

### The 7-Step Process

1. **PREP: Create Submission** (30 min)
   - Real equipment details
   - Valid email address
   - Detailed problem description

2. **PREP: Setup Payment** (15 min)
   - Use test card: 4242424242424242
   - Any future expiry date
   - Any 3-digit CVC

3. **EXECUTE: Process Payment** (10 min)
   - Click "Pay $29.99"
   - Complete Stripe checkout
   - Return to success page

4. **VERIFY: Check Webhook** (15 min)
   - Stripe dashboard shows "succeeded"
   - Firebase order document created
   - Timestamp within 30 seconds

5. **VERIFY: Check AI Processing** (20 min)
   - Cloud Functions logs show execution
   - Vertex AI analysis completes
   - Processing time < 60 seconds

6. **VERIFY: Check Delivery** (15 min)
   - PDF generated successfully
   - Email delivered to customer
   - All content correct

7. **REPORT: Document Results** (20 min)
   - Record any issues found
   - Note performance metrics
   - Log recommendations

---

## 🔧 Quick Fixes

### TaskWarrior Not Found
```bash
sudo apt-get install taskwarrior  # Ubuntu
brew install task                 # macOS
```

### Permission Denied
```bash
chmod +x *.py *.sh
```

### No Tasks Showing
```bash
# Reset and recreate
python3 taskwarrior_diagnosticpro_setup.py
```

### Can't Start Task
```bash
# Check dependencies
task <ID> information

# Manual start if needed
task <ID> start
```

---

## 📊 Success Indicators

### You Know It's Working When:
- ✅ Tasks show in sequence (ready → active → completed)
- ✅ Time tracking shows actual work duration
- ✅ Annotations capture your progress notes
- ✅ Reports generate without errors
- ✅ Payment flow completes end-to-end

### Expected Timeline:
- **Setup**: 5 minutes
- **First complete test**: 2-3 hours
- **Subsequent tests**: 1-2 hours
- **Daily usage**: < 30 minutes overhead

---

## 🆘 When You Need Help

### Immediate Help
```bash
# System health check
python3 validate_taskwarrior_setup.py

# View quick reference
cat taskwarrior_quick_reference.md

# Reset everything
task project:DiagnosticPro delete
python3 taskwarrior_diagnosticpro_setup.py
```

### Getting Unstuck
1. **Check the task list**: `task project:DiagnosticPro`
2. **Look for errors**: Read terminal output carefully
3. **Try the demo**: `./demo_diagnosticpro_workflow.sh`
4. **Start fresh**: Delete and recreate tasks

### Documentation Hierarchy
1. **Start Here**: This quick start guide
2. **Reference**: `taskwarrior_quick_reference.md`
3. **Complete Guide**: `TASKWARRIOR_DIAGNOSTICPRO_COMPLETE.md`
4. **Framework Details**: `README_TaskWarrior_Framework.md`

---

## 🎓 Next Steps

### After First Success:
1. **Run the demo**: `./demo_diagnosticpro_workflow.sh`
2. **Try interactive mode**: `python3 taskwarrior_helpers.py interactive`
3. **Read the complete guide**: `TASKWARRIOR_DIAGNOSTICPRO_COMPLETE.md`
4. **Set up monitoring**: Create daily health checks

### For Teams:
1. **Train everyone**: 1-hour onboarding session
2. **Establish procedures**: Daily testing routine
3. **Create monitoring**: Weekly performance reviews
4. **Document issues**: Build institutional knowledge

---

**Remember**: This system is designed to catch payment issues before customers see them. Use it systematically and trust the process!

---

**Created:** 2025-09-29
**Ready for Production:** ✅
**Team Training Time:** < 1 hour