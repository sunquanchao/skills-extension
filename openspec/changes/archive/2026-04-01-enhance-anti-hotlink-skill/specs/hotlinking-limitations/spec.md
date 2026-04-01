## ADDED Requirements

### Requirement: Explicit documentation of anti-hotlinking limitations
The anti-hotlink skill SHALL explicitly document what hotlinking protection does NOT defend against, including specific attack scenarios that remain possible even with hotlinking protection in place.

#### Scenario: User reads limitations section
- **WHEN** user reviews the anti-hotlink skill documentation
- **THEN** user SHALL see a dedicated "Limitations & What We DON'T Protect Against" section
- **AND** section SHALL list specific scenarios NOT protected against
- **AND** each limitation SHALL include mitigation strategies

---

### Requirement: Screen capture and redistribution limitations
The skill SHALL document that users can still capture content via screenshots, print to PDF, or download and re-upload.

#### Scenario: Documentation mentions screen capture risk
- **WHEN** user reads limitations section
- **THEN** documentation SHALL state that screen capture is not prevented
- **AND** SHALL list watermarking as a mitigation strategy
- **AND** SHALL note that legal measures may be necessary for complete protection

---

### Requirement: Token sharing limitations
The skill SHALL document that legitimate users can share tokens with others, and tokens can be posted publicly.

#### Scenario: Documentation explains token sharing risk
- **WHEN** user reads limitations section
- **THEN** documentation SHALL explain token sharing is not prevented
- **AND** SHALL recommend short expiration times as mitigation
- **AND** SHALL suggest session-binding or behavioral analysis as additional protection

---

### Requirement: Insider threat limitations
The skill SHALL document that developers with server access, leaked secret keys, and compromised accounts remain vulnerabilities.

#### Scenario: Documentation lists insider threat risks
- **WHEN** user reads limitations section
- **THEN** documentation SHALL list insider threats as not prevented
- **AND** SHALL recommend key rotation, audit logs, and access controls as mitigation

---

### Requirement: Offline access limitations
The skill SHALL document that downloaded files can be accessed offline, cached browser copies persist, and DRM may be needed for sensitive content.

#### Scenario: Documentation explains offline access risk
- **WHEN** user reads limitations section
- **THEN** documentation SHALL state that offline access is not prevented
- **AND** SHALL recommend DRM for highly sensitive content
- **AND** SHALL suggest online validation requirements

---

### Requirement: Automated scraping partial protection
The skill SHALL document that sophisticated scrapers can spoof referers, rotate IP addresses, and rate limiting provides only partial protection.

#### Scenario: Documentation describes scraping protection limits
- **WHEN** user reads limitations section
- **THEN** documentation SHALL explain that automated scraping is partially mitigated
- **AND** SHALL list rate limiting, behavioral analysis, and CAPTCHA as additional protections

---

### Requirement: Clear statement of what anti-hotlinking DOES well
The skill SHALL clearly state what hotlinking protection effectively prevents to provide balanced perspective.

#### Scenario: Documentation lists effective protections
- **WHEN** user reads limitations section
- **THEN** documentation SHALL explicitly list what hotlinking prevents:
  - Casual hotlinking from other websites
  - Embedding in iframes on unauthorized domains
  - Bandwidth theft
  - Enforcing access control at request time
  - Tracking access patterns via token validation

---

### Requirement: Guidance on when additional protection is needed
The skill SHALL recommend combining anti-hotlinking with other protection mechanisms for comprehensive content protection.

#### Scenario: Documentation suggests multi-layer protection
- **WHEN** user reads limitations section
- **THEN** documentation SHALL recommend combining protections:
  - DRM (Digital Rights Management)
  - Forensic watermarking
  - Legal agreements (ToS, licensing)
  - Monitoring and takedown procedures
  - Encryption for sensitive data
