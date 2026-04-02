## Context

The current `anti-hotlink` skill is a monolithic 3712-line file covering everything from basic referer checking to advanced OAuth integration. The skill works functionally but its size creates usability and maintenance issues.

**Current Structure:**
```
skills/anti-hotlink/
├── SKILL.md (3712 lines - TOO LARGE)
├── SKILL.md.backup
├── prompts.md
├── USER_GUIDE.md
├── USER_GUIDE.zh.md
├── QUICK_REFERENCE.md
└── README.md
```

## Goals / Non-Goals

**Goals:**
- Split into 7 focused skills with clear single responsibilities
- Core skill acts as router with decision tree
- Each skill self-contained with duplicated context where needed
- Reduce token usage by ~80% for focused queries
- Maintain all existing functionality and trigger phrases

**Non-Goals:**
- Adding new anti-hotlink features (pure refactoring)
- Changing the API or code examples
- Modifying existing supporting files (USER_GUIDE.md, etc.)
- Creating shared utility skills

## Decisions

### 1. Skill Naming Convention
**Decision**: Use `anti-hotlink-<suffix>` pattern for all sub-skills.

**Rationale**:
- Groups all skills together alphabetically
- Clear namespace prevents collisions
- Easy to discover via skill listings

### 2. Core Skill as Router
**Decision**: `anti-hotlink-core` contains only decision logic and links to specialized skills.

**Rationale**:
- Keeps core skill small (~400 lines)
- Delegates implementation details to specialized skills
- Uses "When to Use" section to route users to correct skill

### 3. Content Duplication vs References
**Decision**: Duplicate essential context in each skill rather than cross-referencing.

**Rationale**:
- Each skill should be self-contained
- Avoids loading multiple skills for simple tasks
- Better token efficiency for focused use cases

### 4. Deprecation Strategy
**Decision**: Rename original SKILL.md to SKILL.md.deprecated (not delete).

**Rationale**:
- Preserves original for reference
- Allows rollback if needed
- Clear signal that it should not be used

### 5. Skill Directory Structure
**Decision**: Each sub-skill gets its own directory under `skills/`.

```
skills/
├── anti-hotlink/              # Original (deprecated)
├── anti-hotlink-core/         # Entry point
├── anti-hotlink-referer/      # Referer checking
├── anti-hotlink-tokens/       # Token-based access
├── anti-hotlink-rate-limiting/ # Rate limiting
├── anti-hotlink-watermarking/ # Watermarking
├── anti-hotlink-oauth/        # OAuth integration
└── anti-hotlink-operations/   # Ops & monitoring
```

**Rationale**:
- Follows existing pattern (each skill = one directory)
- Simple to find and navigate
- Independent installation possible

## Risks / Trade-offs

| Risk | Mitigation |
|------|------------|
| Users may not discover sub-skills | Core skill lists all available sub-skills prominently |
| Trigger phrases may not route correctly | Core skill includes all original triggers, routes based on context |
| Inconsistent patterns between sub-skills | Use consistent SKILL.md template across all sub-skills |
| Orphaned original skill files | Keep supporting files in original directory, reference from core |
| Breaking change for existing users | Core skill handles backward compatibility with all original triggers |

## Migration Plan

1. Create all 7 new skill directories with SKILL.md files
2. Test each skill independently
3. Rename original SKILL.md → SKILL.md.deprecated
4. Update any documentation referencing the old skill structure
5. No code changes required - this is documentation-only
