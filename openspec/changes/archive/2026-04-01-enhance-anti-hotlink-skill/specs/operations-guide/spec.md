## ADDED Requirements

### Requirement: Comprehensive operations and monitoring guidance
The skill SHALL provide operational guidance including metrics, logging, alerting, key rotation, and capacity planning for anti-hotlinking systems.

#### Scenario: User reviews operations section
- **WHEN** user deploys anti-hotlinking to production
- **THEN** skill SHALL provide "Operations & Monitoring Guide" section
- **AND** section SHALL cover metrics, logging, alerting, key rotation, capacity planning
- **AND** each topic SHALL include actionable code or configuration examples

---

### Requirement: Metrics collection with Prometheus
The skill SHALL provide Prometheus metrics collection examples for tracking blocked requests, token validations, rate limit denials, and watermarking performance.

#### Scenario: Prometheus metrics documented
- **WHEN** user reads operations guide section
- **THEN** documentation SHALL show Prometheus Counter/Histogram definitions
- **AND** SHALL include metrics for:
  - Blocked requests (by reason: referer, token, rate_limit)
  - Token validation results (valid, invalid, expired)
  - Rate limit denials (by limit type: ip, token, global)
  - Watermarking duration (by file type)
- **AND** SHALL explain what each metric tracks

---

### Requirement: Logging strategy and what to log
The skill SHALL document what to log (blocked requests, token usage patterns) and what NOT to log (full tokens for security).

#### Scenario: Logging strategy documented
- **WHEN** user reads operations guide section
- **THEN** documentation SHALL specify logging requirements:
  - Log blocked requests with IP, referer, resource, reason
  - Log first 8 chars of token only (not full token for PII/security)
  - Specify log retention periods (90 days for security, 30 days for validation)
  - Provide Python logging code example

---

### Requirement: Alerting rules for common issues
The skill SHALL provide Prometheus AlertManager rules for high block rates, Redis failures, and slow watermarking.

#### Scenario: Alerting rules documented
- **WHEN** user reads operations guide section
- **THEN** documentation SHALL include YAML alert rules:
  - High block rate (>100/sec for 5 minutes)
  - Redis connection failing (>10 errors/sec for 2 minutes)
  - Watermark processing slow (95th percentile >30s for 10 minutes)
- **AND** SHALL define severity levels (P1 Critical, P2 High, P3 Medium, P4 Low)

---

### Requirement: Key rotation procedure without downtime
The skill SHALL document a key rotation strategy that supports multiple active keys and allows zero-downtime rotation.

#### Scenario: Key rotation documented
- **WHEN** user reads operations guide section
- **THEN** documentation SHALL explain versioned token approach
- **AND** SHALL provide code showing:
  - Multiple active keys dictionary (v1, v2, etc.)
  - Token generation with version prefix
  - Token validation trying all active keys
  - Rotation steps with 24-hour wait period

---

### Requirement: Capacity planning for Redis
The skill SHALL provide Redis capacity planning calculations based on request volume and rate limiting configuration.

#### Scenario: Redis capacity planning documented
- **WHEN** user reads operations guide section
- **THEN** documentation SHALL calculate Redis memory requirements:
  - Each rate limit entry: ~100 bytes
  - 100K users × 10 limits = 100MB
  - Recommend starting instance size (512MB)
  - Scaling strategy (single → cluster → sharded)

---

### Requirement: Capacity planning for watermarking
The skill SHALL provide watermarking processing capacity calculations and autoscaling recommendations.

#### Scenario: Watermarking capacity documented
- **WHEN** user reads operations guide section
- **THEN** documentation SHALL calculate processing capacity:
  - Assumptions: 10% of users watermark, 5MB avg image, 200ms processing
  - Single core: 5 images/sec
  - 4 cores: 20 images/sec
  - Recommendation: Queue system + worker pool + autoscale

---

### Requirement: CDN cost considerations and optimization
The skill SHALL document CDN egress costs and provide optimization strategies.

#### Scenario: CDN costs documented
- **WHEN** user reads operations guide section
- **THEN** documentation SHALL list CloudFront cost examples:
  - 1TB transfer: ~$85
  - 10TB transfer: ~$700
  - 100TB transfer: ~$5,000
- **AND** SHALL provide optimization strategies:
  - Cache static resources at edge
  - Use signed URLs for dynamic content
  - Pre-warm cache for popular content

---

### Requirement: Operations code is illustrative
All operations code SHALL be illustrative examples showing patterns, not production-ready implementations.

#### Scenario: Operations code style consistent
- **WHEN** user reviews operations code examples
- **THEN** code SHALL demonstrate operational patterns
- **AND** code SHALL include try-catch error handling
- **AND** code SHALL be sufficiently complete to understand the pattern
