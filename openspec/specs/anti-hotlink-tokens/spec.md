# anti-hotlink-tokens Specification

## Purpose
TBD - created by archiving change split-anti-hotlink-skill. Update Purpose after archive.
## Requirements
### Requirement: HMAC signed URL generation
The skill SHALL provide implementations for generating cryptographically signed URLs with expiration.

#### Scenario: Python signed URL
- **WHEN** user needs Python implementation of signed URLs
- **THEN** skill provides complete Flask/Python code with HMAC-SHA256 signing

#### Scenario: Node.js signed URL
- **WHEN** user needs Node.js implementation of signed URLs
- **THEN** skill provides complete Express/Node.js code with crypto module

### Requirement: CloudFront signed URLs
The skill SHALL provide implementation for AWS CloudFront signed URLs with RSA authentication.

#### Scenario: CloudFront signed URL generation
- **WHEN** user needs CloudFront signed URL for video/content distribution
- **THEN** skill provides complete Python/Node.js code using CloudFrontSigner

### Requirement: Token validation middleware
The skill SHALL provide middleware implementations for validating signed tokens.

#### Scenario: Express middleware
- **WHEN** user needs Express middleware for token validation
- **THEN** skill provides complete middleware function with error handling

