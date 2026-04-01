## ADDED Requirements

### Requirement: Comprehensive testing strategy with pytest
The skill SHALL provide a complete testing approach using pytest including unit tests, integration tests, load tests, and security tests.

#### Scenario: User reviews testing section
- **WHEN** user needs to validate anti-hotlinking implementation
- **THEN** skill SHALL provide "Testing Strategy" section
- **AND** section SHALL cover unit, integration, load, and security tests
- **AND** all test code SHALL use pytest framework
- **AND** section SHALL include CI/CD pipeline example

---

### Requirement: Unit tests for token generation and validation
The skill SHALL provide pytest unit tests covering token generation, validation, expiration, and resource binding.

#### Scenario: Unit test examples provided
- **WHEN** user reads testing strategy section
- **THEN** documentation SHALL include pytest test functions:
  - `test_generate_token_basic()`
  - `test_generate_token_with_custom_expires()`
  - `test_validate_token_valid()`
  - `test_validate_token_invalid()`
  - `test_validate_token_expired()`
  - `test_validate_token_wrong_resource()`
  - `test_generate_token_various_resources()` (parametrized)

---

### Requirement: Integration tests for full request flow
The skill SHALL provide pytest integration tests covering protected resource access with and without valid tokens.

#### Scenario: Integration test examples provided
- **WHEN** user reads testing strategy section
- **THEN** documentation SHALL include integration tests:
  - `test_protected_resource_without_token()` (expect 403)
  - `test_protected_resource_with_valid_token()` (expect 200)
  - `test_protected_resource_with_expired_token()` (expect 403)
  - `test_rate_limiting()` (100 requests OK, 101st rate limited)

---

### Requirement: Load tests with Locust
The skill SHALL provide Locust load test script simulating legitimate users and attackers.

#### Scenario: Load test example provided
- **WHEN** user reads testing strategy section
- **THEN** documentation SHALL include Locust test class:
  - `HotlinkUser` class with wait_time
  - `valid_request()` task (3x weight)
  - `invalid_request()` task (1x weight)
  - Token generation on start
- **AND** SHALL include command to run Locust

---

### Requirement: Security tests for attack prevention
The skill SHALL provide pytest security tests covering token forgery prevention, reuse prevention, and timing attack resistance.

#### Scenario: Security test examples provided
- **WHEN** user reads testing strategy section
- **THEN** documentation SHALL include security tests:
  - `test_cannot_forge_token()` (fake token rejected)
  - `test_token_reuse_prevention()` (can't reuse for different resource)
  - `test_timing_attack_resistance()` (constant-time comparison)
  - `test_validate_token_handles_invalid_input()` (edge cases)

---

### Requirement: Test coverage goals and commands
The skill SHALL document test coverage targets and provide commands to measure coverage.

#### Scenario: Coverage goals documented
- **WHEN** user reads testing strategy section
- **THEN** documentation SHALL specify coverage targets:
  - Line coverage: > 90%
  - Branch coverage: > 85%
  - Security-critical paths: 100%
- **AND** SHALL provide pytest-cov command examples

---

### Requirement: Continuous testing with CI/CD
The skill SHALL provide GitHub Actions workflow for automated testing on push and pull requests.

#### Scenario: CI/CD pipeline provided
- **WHEN** user reads testing strategy section
- **THEN** documentation SHALL include `.github/workflows/test.yml`:
  - Ubuntu latest runner
  - Redis service container
  - Python setup
  - Dependency installation
  - Unit, integration, and security test execution
  - Coverage check with --cov-fail-under=90

---

### Requirement: Test environment setup
The skill SHALL provide complete test environment setup including requirements.txt, test fixtures, and Redis configuration.

#### Scenario: Test setup documented
- **WHEN** user reads testing strategy section
- **THEN** documentation SHALL include:
  - pytest fixtures for test client and Redis client
  - Redis cleanup in fixtures
  - Test configuration (TESTING=True, separate Redis DB)
  - Dependencies list (pytest, pytest-cov, locust, redis)

---

### Requirement: Test code is runnable and complete
All test code examples SHALL be complete and runnable with appropriate setup.

#### Scenario: Tests are complete examples
- **WHEN** user reviews test code
- **THEN** tests SHALL include proper imports
- **AND** tests SHALL use pytest fixtures appropriately
- **AND** tests SHALL include assertions
- **AND** tests SHALL be documented with docstrings
