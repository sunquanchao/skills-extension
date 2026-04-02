# git-status-shortcuts Specification

## Purpose
TBD - created by archiving change enhance-git-status-triggers. Update Purpose after archive.
## Requirements
### Requirement: Acronym trigger phrases
The git-status-display skill SHALL recognize and respond to abbreviated acronym trigger phrases in addition to existing full phrases.

#### Scenario: User types "wai" acronym
- **WHEN** user types "wai" in any context (where, command, casual mention)
- **THEN** git-status-display skill triggers and displays branch and directory information

#### Scenario: User types "cb" acronym
- **WHEN** user types "cb" in any context
- **THEN** git-status-display skill triggers and displays branch and directory information

#### Scenario: User types "gs" acronym
- **WHEN** user types "gs" in any context
- **THEN** git-status-display skill triggers and displays branch and directory information

### Requirement: Backward compatibility
The git-status-display skill SHALL continue to recognize all existing trigger phrases without any changes to behavior.

#### Scenario: Existing phrases still work
- **WHEN** user types "where am i" or any existing trigger phrase
- **THEN** git-status-display skill triggers as before
- **AND** output format remains unchanged

#### Scenario: Mixed usage
- **WHEN** user alternates between acronyms and full phrases
- **THEN** all triggers work correctly
- **AND** skill behavior is identical regardless of trigger used

### Requirement: Output consistency
The git-status-display skill SHALL produce identical output format regardless of which trigger phrase or acronym is used.

#### Scenario: Consistent output from any trigger
- **WHEN** skill is triggered via "wai", "cb", "gs", or any existing phrase
- **THEN** output format is: `Branch: <branch-name> | Dir: <directory-path>`
- **AND** no additional conversational text is added based on trigger type

### Requirement: Case insensitivity
The git-status-display skill SHALL recognize acronym triggers regardless of letter case.

#### Scenario: Uppercase acronyms
- **WHEN** user types "WAI", "CB", or "GS"
- **THEN** skill triggers correctly

#### Scenario: Mixed case acronyms
- **WHEN** user types "Wai", "Cb", or "Gs"
- **THEN** skill triggers correctly

### Requirement: Integration with existing triggers
Acronym triggers SHALL be integrated into the main trigger list in skill.md, not separated into a special section.

#### Scenario: Triggers in skill file
- **WHEN** skill.md is viewed
- **THEN** acronym triggers appear alongside existing trigger phrases
- **AND** all triggers are clearly documented in the "When to Use" section

#### Scenario: Discoverability
- **WHEN** user reads skill.md documentation
- **THEN** acronyms are clearly listed with their full phrase equivalents
- **AND** purpose of each acronym is explained

