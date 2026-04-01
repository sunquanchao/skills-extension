## ADDED Requirements

### Requirement: OAuth 2.0 integration patterns
The skill SHALL provide patterns for integrating anti-hotlink protection with OAuth 2.0 authentication systems, demonstrating defense-in-depth architecture.

#### Scenario: User reviews OAuth integration section
- **WHEN** user needs to combine OAuth with anti-hotlinking
- **THEN** skill SHALL provide "Integration with OAuth 2.0" section
- **AND** section SHALL include at least 4 integration patterns
- **AND** each pattern SHALL include complete code example

---

### Requirement: OAuth scopes for resource access control
The skill SHALL document using OAuth scopes to control which resources a token can access.

#### Scenario: OAuth scope pattern documented
- **WHEN** user reads OAuth integration section
- **THEN** documentation SHALL show OAuth scope-based access control
- **AND** SHALL provide Python/Flask decorator code example
- **AND** SHALL demonstrate scope checking before resource access

---

### Requirement: OAuth token combined with resource token
The skill SHALL document the pattern of combining OAuth authentication token with time-limited resource token for multi-layer protection.

#### Scenario: Dual-token pattern documented
- **WHEN** user reads OAuth integration section
- **THEN** documentation SHALL explain OAuth + resource token combination
- **AND** SHALL show code generating resource-specific token with user ID
- **AND** SHALL demonstrate including OAuth user_id in resource token

---

### Requirement: Auth0 integration example
The skill SHALL provide a complete integration example with Auth0 OAuth provider.

#### Scenario: Auth0 integration code provided
- **WHEN** user reads OAuth integration section
- **THEN** documentation SHALL include Auth0 integration pattern
- **AND** SHALL show Authlib Flask client configuration
- **AND** SHALL demonstrate protected route with Auth0 authentication

---

### Requirement: Okta integration example
The skill SHALL provide a complete integration example with Okta OAuth provider.

#### Scenario: Okta integration code provided
- **WHEN** user reads OAuth integration section
- **THEN** documentation SHALL include Okta integration pattern
- **AND** SHALL show Okta client initialization
- **AND** SHALL demonstrate user info retrieval and resource token generation

---

### Requirement: OAuth 2.0 token introspection pattern
The skill SHALL document the pattern of validating OAuth tokens with authorization server before issuing resource tokens.

#### Scenario: Token introspection documented
- **WHEN** user reads OAuth integration section
- **THEN** documentation SHALL explain token introspection flow
- **AND** SHALL provide code showing introspection request to auth server
- **AND** SHALL demonstrate checking token 'active' status and scopes

---

### Requirement: Defense-in-depth architecture diagram
The skill SHALL include a visual representation showing OAuth, resource token, transport security, and authorization as multiple protection layers.

#### Scenario: Defense-in-depth diagram included
- **WHEN** user reads OAuth integration section
- **THEN** documentation SHALL include ASCII diagram showing 4 layers:
  - Layer 1: OAuth Authentication
  - Layer 2: Resource Token (Anti-Hotlink)
  - Layer 3: Transport Security (HTTPS)
  - Layer 4: Application Authorization
- **AND** each layer SHALL be briefly explained

---

### Requirement: OAuth security best practices
The skill SHALL document security best practices when combining OAuth with anti-hotlink protection.

#### Scenario: Best practices documented
- **WHEN** user reads OAuth integration section
- **THEN** documentation SHALL list best practices:
  - Keep OAuth tokens short-lived (5-15 minutes)
  - Keep resource tokens even shorter (1-5 minutes)
  - Use different secrets for OAuth signing and resource tokens
  - Log all token validations for audit trail
  - Implement token revocation for compromised accounts

---

### Requirement: OAuth integration code is illustrative
All OAuth integration code SHALL be illustrative examples with try-catch blocks, not production-ready implementations.

#### Scenario: OAuth code style consistent
- **WHEN** user reviews OAuth code examples
- **THEN** code SHALL include try-catch error handling
- **AND** code SHALL demonstrate OAuth integration patterns
- **AND** code SHALL NOT include full production error handling
