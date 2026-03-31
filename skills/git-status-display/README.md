# Git Status Display Skill

A Claude Code skill that quickly displays the current git branch and working directory. **Works on macOS, Linux, and Windows.**

## What it does

Shows your current git branch and working directory in a brief, single-line format:

```text
Branch: <branch-name> | Dir: <working-directory-path>
```

### Examples by Platform

**macOS/Linux:**

```text
Branch: feature/user-auth | Dir: /Users/john/projects/myapp
```

**Windows (PowerShell/CMD):**

```text
Branch: main | Dir: e:\ws_python\Python-AI
```

**Windows (Git Bash):**

```text
Branch: V1.0.1-feature | Dir: /e/ws_python/Python-AI
```

## Cross-Platform Support

- ✓ **macOS** - Native Unix-style paths
- ✓ **Linux** - Native Unix-style paths
- ✓ **Windows** - Supports both native paths (`C:\path`) and Git Bash paths (`/c/path`)

The skill automatically detects your platform and accepts whichever path format your shell returns.

## When it triggers

- When you ask: "What branch am I on?", "current git branch", "show git status"
- When you ask: "Where am I?", "current directory", "working directory"
- Before git operations (commit, push, merge, branch operations)
- When requesting a status overview or project summary

## How to install

1. Copy this skill directory to your Claude skills folder, or
2. In Claude Code, reference the skill path directly:

```bash
e:/ws_python/Python-AI/skills/git-status-display
```

## Test it

### Quick Test

Try these prompts in Claude Code:

- "What branch am I on?"
- "Show me the current directory and git info"
- "I want to commit my changes" (should show status first)

### Platform-Specific Testing

Run the test scripts to verify cross-platform compatibility:

**Bash (macOS/Linux/Git Bash on Windows):**

```bash
bash skills/git-status-display/scripts/test_cross_platform.sh
```

**PowerShell (Windows):**

```powershell
powershell -File skills/git-status-display/scripts/test_cross_platform.ps1
```

## Skill structure

```text
git-status-display/
├── SKILL.md              # Main skill instructions (cross-platform)
├── README.md             # This file
├── scripts/
│   ├── test_cross_platform.sh    # Bash test script
│   └── test_cross_platform.ps1   # PowerShell test script
└── evals/
    └── evals.json        # Test cases with platform-specific scenarios
```

## Error Handling

- If not in a git repository, shows: `Branch: (not in git repo) | Dir: <path>`
- Never fails - always shows directory even if git commands don't work
- Accepts both Unix and Windows path formats

## Technical Details

- Uses `git branch --show-current` for branch detection (works on all platforms)
- Uses `pwd` for directory path (works on all platforms)
- Gracefully handles non-git directories
- No external dependencies beyond git
