#!/usr/bin/env python3
"""
TaskWarrior automation scripts for prompt engineering toolkit.
"""

import subprocess
import sys
import json
from datetime import datetime

def run_task_command(command):
    """Run a TaskWarrior command and return the result."""
    try:
        result = subprocess.run(
            ['task'] + command.split(),
            capture_output=True,
            text=True,
            check=True
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(f"Error running task command: {e}")
        return None

def get_prompt_project_status():
    """Get status of prompt-related projects."""
    print("📋 PROMPT PROJECT STATUS")
    print("=" * 50)

    # Get prompts project tasks
    prompts_output = run_task_command("list project:prompts")
    if prompts_output:
        print("\n🎯 PROMPTS PROJECT:")
        print(prompts_output)

    # Get ai-prompts project tasks
    ai_prompts_output = run_task_command("list project:ai-prompts")
    if ai_prompts_output:
        print("\n🤖 AI-PROMPTS PROJECT:")
        print(ai_prompts_output)

def get_next_task():
    """Get the next pending task for prompt projects."""
    print("🔜 NEXT TASKS")
    print("=" * 30)

    next_prompts = run_task_command("list project:prompts status:pending limit:3")
    if next_prompts:
        print("\n📝 Next Prompts Tasks:")
        print(next_prompts)

    next_ai = run_task_command("list project:ai-prompts status:pending limit:3")
    if next_ai:
        print("\n🤖 Next AI-Prompts Tasks:")
        print(next_ai)

def add_template_task(category, description, due_date=None):
    """Add a new template-related task."""
    if due_date:
        command = f"add project:prompts +template +{category} {description} due:{due_date}"
    else:
        command = f"add project:prompts +template +{category} {description}"

    result = run_task_command(command)
    if result:
        print(f"✅ Added task: {description}")
        return True
    return False

def mark_task_done(task_id):
    """Mark a task as completed and show next tasks."""
    result = run_task_command(f"{task_id} done")
    if result:
        print(f"✅ Completed task {task_id}")
        print("\n🔄 Next tasks:")
        get_next_task()
        return True
    return False

def main():
    """Main automation script."""
    if len(sys.argv) < 2:
        print("Usage:")
        print("  task_automation.py status    - Show project status")
        print("  task_automation.py next      - Show next tasks")
        print("  task_automation.py done <id> - Mark task as done")
        print("  task_automation.py add <category> <description> [due_date]")
        sys.exit(1)

    command = sys.argv[1]

    if command == "status":
        get_prompt_project_status()
    elif command == "next":
        get_next_task()
    elif command == "done" and len(sys.argv) >= 3:
        task_id = sys.argv[2]
        mark_task_done(task_id)
    elif command == "add" and len(sys.argv) >= 4:
        category = sys.argv[2]
        description = sys.argv[3]
        due_date = sys.argv[4] if len(sys.argv) > 4 else None
        add_template_task(category, description, due_date)
    else:
        print("Invalid command or missing arguments")
        sys.exit(1)

if __name__ == "__main__":
    main()