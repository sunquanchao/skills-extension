## ADDED Requirements

### Requirement: Decision support tools for method selection
The skill SHALL provide decision trees, comparison matrices, and scenario-based guidance to help users choose appropriate protection methods.

#### Scenario: User reviews decision guide section
- **WHEN** user needs to choose hotlink protection method
- **THEN** skill SHALL provide "Decision Guide" section
- **AND** section SHALL include decision tree, comparison matrix, and combination examples

---

### Requirement: Quick decision tree for common scenarios
The skill SHALL include a decision tree mapping content type and use case to protection method.

#### Scenario: Decision tree provided
- **WHEN** user reads decision guide section
- **THEN** documentation SHALL include ASCII decision tree:
  - START: What are you protecting?
  - PUBLIC CONTENT → Referer Checking (Nginx/Apache)
  - PAID CONTENT → Token-Based + OAuth
  - DOWNLOADABLE FILES → S3 Presigned URLs or Token + Watermark
  - INTERNAL DOCUMENTS → Session-Based
- **AND** each branch SHALL include traffic level or user authentication sub-branches

---

### Requirement: Comparison matrix for scenarios
The skill SHALL provide a comparison matrix showing recommended method, reasoning, and complexity for common scenarios.

#### Scenario: Comparison matrix provided
- **WHEN** user reads decision guide section
- **THEN** documentation SHALL include matrix with columns:
  - Scenario (blog images, course videos, software downloads, internal docs, etc.)
  - Recommended Method
  - Why (reasoning)
  - Complexity (Low/Medium/High)

---

### Requirement: Defense-in-depth combination examples
The skill SHALL document when and how to combine multiple protection methods for comprehensive security.

#### Scenario: Combination guidance provided
- **WHEN** user reads decision guide section
- **THEN** documentation SHALL show example: Premium Video Course
  - Layer 1: OAuth Authentication
  - Layer 2: Token-Based Access (5 min expiration)
  - Layer 3: Rate Limiting (3 req/min)
  - Layer 4: Watermarking (user ID burned in)
  - Layer 5: Session Validation
- **AND** SHALL explain result: 5 layers enforcing different aspects

---

### Requirement: Protection method comparison table
The skill SHALL provide a table comparing all protection methods across security, complexity, and best-use criteria.

#### Scenario: Method comparison table provided
- **WHEN** user reads decision guide section
- **THEN** documentation SHALL include table comparing:
  - Method (Referer Check, Token-Based, Session-Based, CDN Signed URLs)
  - Security level (Low/High)
  - Complexity (Simple/Medium/High)
  - Best For (use cases)
  - Not For (anti-patterns)

---

### Requirement: Quick start guidance for immediate implementation
The skill SHALL provide a "Quick Start" section that gets users running with basic referer checking in 5 minutes.

#### Scenario: Quick start provided
- **WHEN** user needs immediate protection
- **THEN** skill SHALL provide "Quick Start" section
- **AND** section SHALL include:
  - Decision tree for method selection
  - Immediate working example (Nginx referer check)
  - Copy-paste configuration
  - "That's it! You're protected" completion message
  - "For more advanced use cases, read on" guidance

---

### Requirement: Visual decision aids
The skill SHALL use visual aids (ASCII diagrams, tables, trees) to make decision-making intuitive.

#### Scenario: Visual aids included
- **WHEN** user reviews decision guide section
- **THEN** documentation SHALL include:
  - ASCII decision tree with branching paths
  - Comparison table with clear columns
  - Defense-in-depth diagram with layered boxes
  - All visual aids SHALL use monospaced formatting for clarity
