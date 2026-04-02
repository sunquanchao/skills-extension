# anti-hotlink-oauth Specification

## Purpose
TBD - created by archiving change split-anti-hotlink-skill. Update Purpose after archive.
## Requirements
### Requirement: OAuth scope-based resource access
The skill SHALL provide pattern for using OAuth scopes to control resource access.

#### Scenario: Premium content access
- **WHEN** user needs OAuth-based premium content protection
- **THEN** skill provides require_scope decorator implementation

### Requirement: Two-token pattern
The skill SHALL provide pattern for combining OAuth authentication with resource-specific tokens.

#### Scenario: OAuth + resource token
- **WHEN** user needs defense-in-depth protection
- **THEN** skill provides two-token implementation with OAuth validation and signed resource URLs

### Requirement: Session binding
The skill SHALL provide pattern for binding resource tokens to user sessions.

#### Scenario: Session-bound tokens
- **WHEN** user needs to prevent token sharing
- **THEN** skill provides session-binding implementation

