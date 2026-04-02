## ADDED Requirements

### Requirement: Fixed window rate limiting
The skill SHALL provide Redis-based fixed window rate limiting implementation.

#### Scenario: Basic rate limiting
- **WHEN** user needs simple rate limiting with Redis
- **THEN** skill provides complete fixed_window_rate_limit function with atomic Redis operations

### Requirement: Sliding window rate limiting
The skill SHALL provide Redis-based sliding window rate limiting implementation.

#### Scenario: Precise rate limiting
- **WHEN** user needs accurate rate limiting without boundary bursts
- **THEN** skill provides complete sliding_window_rate_limit function using Redis sorted sets

### Requirement: Rate limiting comparison
The skill SHALL provide clear comparison between fixed and sliding window approaches.

#### Scenario: Choosing rate limit method
- **WHEN** user asks which rate limiting method to use
- **THEN** skill provides comparison table with pros/cons and best use cases
