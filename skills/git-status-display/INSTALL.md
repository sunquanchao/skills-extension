# Installation Guide for git-status-display Skill

## Method 1: Add to Claude Code Settings (Recommended)

### Step 1: Open Claude Code Settings

1. Open Claude Code
2. Click on the gear icon (Settings) or press `Ctrl+,` (Windows/Linux) or `Cmd+,` (macOS)
3. Look for "Skills" or "Extensions" section

### Step 2: Add the Skill Path

Add the skill path to your skills configuration:

```json
{
  "skills": [
    "e:/ws_python/Python-AI/skills/git-status-display"
  ]
}
```

Or if using YAML format:

```yaml
skills:
  - e:/ws_python/Python-AI/skills/git-status-display
```

### Step 3: Restart Claude Code

Close and reopen Claude Code for the changes to take effect.

## Method 2: Copy to Claude Skills Directory

### Find your Claude skills directory

**Windows:**
```
C:\Users\YourUsername\.claude\skills\
```

**macOS/Linux:**
```
~/.claude/skills/
```

### Copy the skill

```bash
# Windows (Git Bash)
cp -r e:/ws_python/Python-AI/skills/git-status-display ~/.claude/skills/

# macOS/Linux
cp -r ~/ws_python/Python-AI/skills/git-status-display ~/.claude/skills/
```

Or use File Explorer to copy the `git-status-display` folder to your `.claude/skills/` directory.

## Method 3: Package as .skill File (Coming Soon)

I can package this as a `.skill` file for easy installation. Would you like me to do that?

## Verify Installation

After installing, test it by asking Claude Code:

1. Open a new Claude Code session
2. Type: "What branch am I on?"
3. You should see: `Branch: <your-branch> | Dir: <your-directory>`

## Troubleshooting

### Skill not triggering?

1. Check the skill path is correct
2. Verify SKILL.md exists in the skill directory
3. Restart Claude Code
4. Check Claude Code logs for any errors

### Path not working on Windows?

- Use forward slashes: `e:/ws_python/Python-AI/skills/git-status-display`
- Or escape backslashes: `e:\\ws_python\\Python-AI\\skills\\git-status-display`

### Want to test first?

Try these prompts:
- "What branch am I on?"
- "Show me the current directory and git info"
- "I want to commit my changes"

All should show the status display in the format: `Branch: <branch> | Dir: <path>`
