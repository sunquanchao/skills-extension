# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Disclaimer

**This is an independent, unofficial extension and is NOT an official Anthropic product.** This repository is maintained by Quanchao Sun and is not endorsed by or affiliated with Anthropic. It extends the work from [github.com/anthropics/skills](https://github.com/anthropics/skills) with additional skills and the experimental OpenSpec workflow system.

## Repository Overview

This is the **Skills Extension** repository - an independent collection of Claude skills and an experimental OpenSpec workflow system. The repository contains:

- **[skills/](skills/)** - Example skills that demonstrate the Claude skills system
- **[openspec/](openspec/)** - Experimental spec-driven workflow for managing changes with artifacts (proposal, design, tasks, specs)
- **[.claude/skills/](.claude/skills/)** - Built-in OpenSpec workflow skills (explore, propose, apply, archive)
- **[.claude/commands/opsx/](.claude/commands/opsx/)** - OPSX slash commands for the OpenSpec workflow
- **[template/](template/)** - Skill template for creating new skills
- **[spec/](spec/)** - Agent Skills specification reference

## OpenSpec Workflow System

OpenSpec is an experimental spec-driven development workflow. Changes are tracked in `openspec/changes/<change-name>/` with artifacts generated according to a schema-defined structure.

### The Four Workflow Modes

1. **Explore** (`/opsx:explore` or `openspec-explore` skill)
   - Thinking mode for exploring ideas, investigating problems, clarifying requirements
   - Never writes implementation code - only reads, investigates, and may create OpenSpec artifacts
   - Uses ASCII diagrams, questions architecture, explores codebase
   - May offer to capture insights in artifacts (proposal, design, specs)

2. **Propose** (`/opsx:propose` or `openspec-propose` skill)
   - Creates a new change with all artifacts in one step
   - Runs: `openspec new change "<name>"` to create the change directory
   - Gets artifact build order from `openspec status --change "<name>" --json`
   - Creates artifacts sequentially following dependency order
   - Each artifact created using `openspec instructions <artifact-id> --change "<name>" --json`

3. **Apply** (`/opsx:apply` or `openspec-apply-change` skill)
   - Implements tasks from a change
   - Gets apply instructions from `openspec instructions apply --change "<name>" --json`
   - Reads context files (proposal, design, specs, tasks - varies by schema)
   - Implements tasks sequentially, marking them complete with `- [x]`

4. **Archive** (`/opsx:archive` or `openspec-archive-change` skill)
   - Archives completed changes to `openspec/changes/archive/`

### OpenSpec CLI Commands

```bash
# List all changes
openspec list --json

# Create a new change
openspec new change "<name>"

# Check change status
openspec status --change "<name>" --json

# Get instructions for an artifact
openspec instructions <artifact-id> --change "<name>" --json

# Get apply instructions
openspec instructions apply --change "<name>" --json

# Archive a completed change
openspec archive "<name>"
```

### Change Directory Structure

```
openspec/changes/<change-name>/
├── .openspec.yaml          # Change metadata
├── proposal.md             # What & why
├── design.md               # How (technical design)
├── tasks.md                # Implementation steps (checkboxes)
├── test-plan.md            # Testing strategy (if required)
└── specs/                  # Capability specifications (if required)
    └── <capability>/
        └── spec.md
```

## Skills Structure

Each skill is a folder containing a `SKILL.md` file with YAML frontmatter:

```yaml
---
name: skill-name
description: When Claude should use this skill
license: MIT  # optional
metadata:      # optional
  author: name
  version: "1.0"
---

# Skill content below
```

### Skill Locations

- **[skills/](skills/)** - Example skills for various domains
- **[.claude/skills/](.claude/skills/)** - Built-in OpenSpec workflow skills
- **[template/SKILL.md](template/SKILL.md)** - Template for creating new skills

### Installing the Official Anthropic Skills Repository as a Plugin

**Note:** The commands below are for the official Anthropic skills repository, not this independent extension.

```bash
# Add the official Anthropic marketplace
/plugin marketplace add anthropics/skills

# Install skill sets from the official repository
/plugin install document-skills@anthropic-agent-skills
/plugin install example-skills@anthropic-agent-skills
```

## Key Architectural Patterns

### Schema-Driven Workflow

The `openspec/config.yaml` defines the schema (currently `spec-driven`). The schema determines:
- Which artifacts are required
- Artifact dependencies
- What's required before implementation can start (`apply.requires`)

### Artifact Dependency Resolution

When creating or implementing changes:
1. Always check `openspec status --change "<name>" --json` for current state
2. Parse `applyRequires` array to know what's needed before implementation
3. Parse `artifacts` array for dependency relationships
4. Create/implement in dependency order

### Context and Rules

When running `openspec instructions <artifact-id> --change "<name>" --json`:
- `context` and `rules` are constraints for YOU, not content for the artifact file
- Never copy `<context>`, `<rules>`, or `<project_context>` blocks into output files
- Use `template` as the structure for your output

## Common Workflows

### Starting a New Feature

1. Optionally run `/opsx:explore` to think through the approach
2. Run `/opsx:propose <change-name>` to create the change with all artifacts
3. Review generated artifacts (proposal, design, tasks)
4. Run `/opsx:apply <change-name>` to implement the tasks
5. Run `/opsx:archive <change-name>` when complete

### Investigating a Problem

1. Run `/opsx:explore` to think through the problem space
2. May create artifacts to capture decisions
3. When ready, either create a proposal or directly implement

### Resuming Work on a Change

1. Check status: `openspec list --json`
2. Run `/opsx:apply <change-name>` to continue implementation
3. Or run `/opsx:explore <change-name>` to think through issues mid-implementation

## Spec-Driven Schema Details

The `spec-driven` schema requires these artifacts before implementation:
- `proposal.md` - What changes and why
- `design.md` - Technical approach
- `tasks.md` - Step-by-step implementation with checkboxes
- `specs/` - Capability specifications (domain-specific requirements)

## Guardrails

### Explore Mode
- NEVER write implementation code
- MAY create OpenSpec artifacts (that's capturing thinking, not implementing)
- Use diagrams, questions, codebase investigation
- Offer to capture insights, don't auto-capture

### Propose Mode
- Create ALL artifacts needed for implementation (`apply.requires`)
- Read dependency artifacts before creating new ones
- Don't copy `context`/`rules` into output files
- Use `template` as structure

### Apply Mode
- Read context files before starting (from `openspec instructions apply --json`)
- Mark tasks complete immediately after finishing each: `- [ ]` → `- [x]`
- Keep changes minimal and scoped to each task
- Pause on errors, blockers, or unclear requirements
- Suggest artifact updates if implementation reveals design issues

## File References

- **Agent Skills specification**: See [spec/agent-skills-spec.md](spec/agent-skills-spec.md) (now at https://agentskills.io/specification)
- **OpenSpec config**: [openspec/config.yaml](openspec/config.yaml)
- **Skills template**: [template/SKILL.md](template/SKILL.md)
- **Example change**: [openspec/changes/enhance-git-status-triggers/](openspec/changes/enhance-git-status-triggers/)
