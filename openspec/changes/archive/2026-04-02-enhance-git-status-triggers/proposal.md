## Why

The git-status-display skill currently requires typing full phrases like "where am i" or "current branch" to trigger, which is inefficient for power users who frequently need to check their git context. Adding acronym shortcuts will significantly reduce typing effort and improve workflow speed for frequent usage.

## What Changes

- Add three new acronym trigger phrases to the git-status-display skill:
  - **"wai"** → shorthand for "where am i" queries
  - **"cb"** → shorthand for "current branch" queries
  - **"gs"** → shorthand for "git status" context checks
- Integrate these shortcuts into the existing trigger phrase list in skill.md
- Maintain all existing trigger phrases for backward compatibility

## Capabilities

### New Capabilities
- `git-status-shortcuts`: Abbreviated trigger phrases for rapid git context display

### Modified Capabilities
None (existing skill behavior unchanged, only adding new triggers)

## Impact

- **Affected files**: `C:\Users\86158\.claude\skills\git-status-display\skill.md`
- **Dependencies**: None (skill configuration only)
- **Backward compatibility**: Fully maintained - all existing triggers remain functional
- **User experience**: Power users can trigger the skill with 2-3 keystrokes instead of typing full phrases
