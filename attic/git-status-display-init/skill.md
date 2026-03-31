---
name: git-status-display
description: Display current git branch and working directory. Use this skill whenever user says "where am i (wai)", "where am I", "what directory", "current directory", "pwd", "what branch", "current branch (cb)", "git branch", "what's my git status", "show git info", "show status (gs)", or asks about location/branch. ALWAYS use before ANY git operation (commit, push, pull, merge, branch, checkout). Also trigger when user wants to know their current location, project path, or repository context. This is a simple status display - use it whenever the user needs context about where they are or what branch they're on.
---

# Git Status Display

Quickly show the current git branch and working directory.

## When to Use

**ALWAYS use this skill when user says:**
- "wai" (where am i), "where am i", "where am I", "where am I working"
- "what directory", "current directory", "pwd", "what's the directory"
- "cb" (current branch), "what branch", "current branch", "git branch", "what branch am i on"
- "gs" (git status), "what's my git status", "show git info", "show status"
- "show me where I am", "display current location"

**ALWAYS use before ANY git operation:**
- User wants to commit, push, pull, merge, branch, checkout
- Any git-related action

## What to Do

Run these two commands:

```bash
# Get current git branch
git branch --show-current

# Get current working directory
pwd
```

## Output Format

Display the results in this single-line format:

```
Branch: <branch-name> | Dir: <directory-path>
```

**Examples:**
```
Branch: main | Dir: /Users/john/projects/myapp
Branch: V1.0.1-feature | Dir: e:\ws_python\Python-AI
Branch: feature/new-ui | Dir: /e/ws_python/Python-AI
```

That's it! Just run the two commands and display them in that format.

## Important Notes

- Use `git branch --show-current` (works on all platforms)
- Use `pwd` (works on all platforms - bash, Git Bash, macOS, Linux)
- Accept whatever path format `pwd` returns - both Unix and Windows paths are fine
- If not in a git repo, show: `Branch: (not in git repo) | Dir: <directory>`
- Keep it brief - one line is perfect
