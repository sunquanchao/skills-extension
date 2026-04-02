## Context

The git-status-display skill is a simple utility skill that displays current git branch and working directory information. It is currently installed at `C:\Users\86158\.claude\skills\git-status-display\skill.md` and triggers on natural language phrases like "where am i", "current branch", "git status", etc.

Current trigger phrases work well but require typing 8-20 characters per invocation, which is inefficient for power users who frequently check their git context throughout the day.

**Constraints:**
- Must maintain 100% backward compatibility with existing trigger phrases
- Skill uses Claude Code's skill triggering mechanism based on description matching
- Changes only affect the skill.md file (no code changes required)
- Output format must remain: `Branch: <branch-name> | Dir: <directory-path>`

**Stakeholders:**
- Power users who frequently check git context
- New users who rely on discoverable natural language triggers

## Goals / Non-Goals

**Goals:**
- Reduce typing effort from 8-20 characters to 2-3 characters for common git context checks
- Add three acronym triggers: "wai" (where am i), "cb" (current branch), "gs" (git status)
- Maintain full backward compatibility with all existing triggers
- Keep skill.md documentation clear and discoverable for all users

**Non-Goals:**
- Changing skill behavior or output format
- Creating a separate "power user" mode or section
- Adding additional shortcuts beyond the three acronyms
- Modifying the skill's bash commands or error handling
- Changing skill installation or deployment process

## Decisions

### Decision 1: Acronym Selection

**Chosen approach:** "wai", "cb", "gs"

**Rationale:**
- These three acronyms cover the most common use cases:
  - "wai" (where am i) - general context, most frequent use
  - "cb" (current branch) - branch-specific queries
  - "gs" (git status) - aligns with familiar `git status` command pattern
- All are 2-3 characters, minimizing typing effort
- Mnemonically clear and easy to remember
- No conflicts with common programming terms or commands

**Alternatives considered:**
- Single letters ("w", "b", "s") - rejected as potentially ambiguous and harder to remember
- Minimal fragments ("wh", "br", "st") - rejected as less intuitive than full acronyms
- Symbols ("!", "?", ">>") - rejected as non-discoverable and unclear meaning
- Single shortcut only ("wai") - rejected as insufficient for different use contexts

### Decision 2: Integration Approach

**Chosen approach:** Integrate acronyms directly into the main trigger list with inline explanations

**Rationale:**
- Single source of truth for all triggers
- Easier to maintain than separate sections
- More discoverable for new users who see all options together
- Prevents divergence between "standard" and "shortcut" documentation

**Alternatives considered:**
- Separate "Power User Shortcuts" section - rejected as creates second-class category
- Footnotes or appendix - rejected as reduces discoverability
- Separate skill file - rejected as overkill for simple trigger additions

### Decision 3: Placement in skill.md

**Chosen approach:** Add acronyms at the beginning of each relevant trigger category

**Example structure:**
```markdown
**ALWAYS use this skill when user says:**
- "wai" (where am i), "where am i", "where am I", "where am I working"
- "cb" (current branch), "what branch", "current branch", "git branch"
- "gs" (git status), "what's my git status", "show git info", "show status"
```

**Rationale:**
- Prominently displays shortcuts for power users
- Shows acronym → full phrase mapping for new users
- Maintains clear organization by semantic category
- Easy to scan for both power users and newcomers

**Alternatives considered:**
- Alphabetical ordering - rejected as groups related concepts poorly
- Frequency ordering - rejected as subjective and changes over time
- Separate acronym section - rejected per Decision 2

## Risks / Trade-offs

### Risk 1: Acronym discoverability for new users
**Risk:** New users may not discover acronyms if they skim documentation
**Mitigation:** Place acronyms at the START of each trigger list with clear parenthetical mappings (e.g., "wai (where am i)")

### Risk 2: Acronym ambiguity with other contexts
**Risk:** "gs" or "cb" might appear in non-git contexts (e.g., "gs" as "graphics system")
**Mitigation:** Claude Code's skill triggering uses semantic context matching, not just keyword matching. The skill description already provides strong git context. Testing in real usage will validate this.

### Risk 3: Over-reliance on acronyms reducing accessibility
**Risk:** Power users may share acronym-only commands with new users, causing confusion
**Mitigation:** Clear documentation in skill.md shows both acronyms and full phrases. Natural language triggers remain fully functional.

## Migration Plan

**Deployment:**
1. Edit `C:\Users\86158\.claude\skills\git-status-display\skill.md`
2. Add acronyms to the description field and trigger lists
3. Test each acronym in a Claude Code session
4. No restart required (skill changes take effect immediately)

**Rollback strategy:**
- Simple file edit revert if issues arise
- No database changes, dependencies, or infrastructure to modify
- Zero-downtime change (skill either works or doesn't, no partial states)

**Validation:**
- Test "wai", "cb", "gs" each trigger the skill
- Test existing phrases still work ("where am i", etc.)
- Test output format is identical across all triggers
- Test case insensitivity ("WAI", "wai", "Wai" all work)

## Open Questions

None. This is a straightforward documentation change with clear requirements and implementation path.
