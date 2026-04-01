## ADDED Requirements

### Requirement: Failure mode documentation and detection
The skill SHALL document common failure scenarios that can occur in anti-hotlinking systems and provide detection code examples for each scenario.

#### Scenario: User reviews failure mode section
- **WHEN** user implements anti-hotlinking protection
- **THEN** skill SHALL provide "Failure Mode Handling" section
- **AND** section SHALL cover at least 6 failure scenarios
- **AND** each scenario SHALL include detection code example

---

### Requirement: Redis connection failure handling
The skill SHALL document what happens when Redis becomes unavailable for rate limiting and provide detection code.

#### Scenario: Redis failure documented
- **WHEN** user reads failure modes section
- **THEN** documentation SHALL describe Redis connection failure
- **AND** SHALL provide detection code using try-catch
- **AND** SHALL recommend fail-open strategy for non-critical resources
- **AND** SHALL recommend fail-closed strategy for sensitive resources

---

### Requirement: Clock skew handling
The skill SHALL document the impact of server clock skew on token expiration and provide mitigation code.

#### Scenario: Clock skew documented with mitigation
- **WHEN** user reads failure modes section
- **THEN** documentation SHALL explain clock skew causes token validation failures
- **AND** SHALL recommend NTP synchronization
- **AND** SHALL provide code showing grace period implementation (±30 seconds)

---

### Requirement: Secret key leak response
The skill SHALL document the impact of leaked secret keys and provide key rotation strategy.

#### Scenario: Key leak documented with rotation procedure
- **WHEN** user reads failure modes section
- **THEN** documentation SHALL explain that leaked secrets compromise all tokens
- **AND** SHALL provide key rotation strategy
- **AND** SHALL show code supporting multiple active keys (versioned tokens)
- **AND** SHALL outline rotation steps: generate → add to store → deploy → wait → remove old

---

### Requirement: CDN cache invalidation issues
The skill SHALL document that signed URLs may not cache properly in CDNs and provide configuration guidance.

#### Scenario: CDN caching documented
- **WHEN** user reads failure modes section
- **THEN** documentation SHALL explain signed URL caching challenges
- **AND** SHALL recommend cache-key customization
- **AND** SHALL suggest ignoring token params for cache key
- **AND** SHALL recommend pre-warming cache for popular content

---

### Requirement: Large file processing timeout handling
The skill SHALL document that watermarking large files (e.g., 1GB video) may timeout and provide async processing pattern.

#### Scenario: Large file timeout documented
- **WHEN** user reads failure modes section
- **THEN** documentation SHALL explain large file processing timeout risk
- **AND** SHALL provide async job queue pattern code example
- **AND** SHALL show job ID return and polling approach
- **AND** SHALL include progress tracking example

---

### Requirement: Concurrent request race condition prevention
The skill SHALL document race conditions in rate limiting and provide atomic operation code.

#### Scenario: Race conditions documented with prevention
- **WHEN** user reads failure modes section
- **THEN** documentation SHALL explain concurrent request race conditions
- **AND** SHALL provide Redis atomic operations code example
- **AND** SHALL show Redis pipeline for batch operations
- **AND** SHALL recommend Lua scripts for complex checks

---

### Requirement: Failure mode code is illustrative
All failure mode detection code SHALL be illustrative examples with try-catch blocks, not full production implementations.

#### Scenario: Failure mode code style consistent
- **WHEN** user reviews failure mode code examples
- **THEN** code SHALL include try-catch error handling
- **AND** code SHALL include basic validation
- **AND** code SHALL NOT include full recovery logic (per user request)
- **AND** documentation SHALL clearly state failures are "mentioned" with detection code
