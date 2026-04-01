## Why

The current anti-hotlink skill is a 345-line implementation guide that provides code examples for basic hotlinking protection (referer checking, token-based access, CDN integration). However, it is incomplete as a production reference: it lacks critical guidance on limitations, failure modes, integration with existing authentication systems, operational concerns, and testing strategies. Users implementing this in production will encounter security blind spots, operational gaps, and lack clarity on which protection method to choose for their use case. This enhancement transforms the skill from a basic implementation guide into a comprehensive, production-ready reference that addresses both implementation and operational concerns.

## What Changes

This change comprehensively enhances the anti-hotlink skill from ~345 lines to ~1,200 lines by adding:

- **Quick Start Decision Tree**: Get users running in 5 minutes with clear method selection guidance
- **Limitations Section**: Explicitly document what anti-hotlinking does NOT protect against (screen capture, token sharing, insider threats, offline access)
- **Failure Mode Handling**: Document what happens when Redis fails, clocks skew, secrets leak, CDN cache issues occur, or large file processing times out
- **OAuth 2.0 Integration**: Add patterns for integrating anti-hotlink protection with OAuth 2.0, Auth0, and Okta, including defense-in-depth architecture
- **Operations & Monitoring Guide**: Add comprehensive guidance on metrics, logging, alerting, key rotation procedures, and capacity planning
- **Testing Strategy**: Include pytest-based unit tests, integration tests, load tests (Locust), and security tests with CI/CD examples
- **Decision Guide**: Add comparison matrices and decision trees to help users choose the right protection method for their scenario

Additionally, enhance existing sections:
- Add try-catch error handling to all code examples
- Add performance benchmarks for image, PDF, and video watermarking
- Add both fixed-window and sliding-window rate limiting with comparison
- Add multi-dimensional rate limiting (IP + token + global)
- Expand CDN coverage to include AWS CloudFront, Cloudflare Workers, and S3 Presigned URLs with equal depth

## Capabilities

### New Capabilities

Each of these will have a corresponding spec file created:

- `hotlinking-limitations`: Explicit documentation of what anti-hotlinking protects against and what it doesn't, including mitigation strategies for unsupported scenarios
- `failure-mode-handling`: Documentation and detection code for common failure scenarios (Redis failure, clock skew, secret key leaks, CDN cache issues, large file processing timeouts, concurrent request race conditions)
- `oauth-integration`: Patterns and code examples for integrating anti-hotlink protection with OAuth 2.0, including Auth0 and Okta providers, defense-in-depth architecture
- `operations-guide`: Comprehensive operational guidance including metrics (Prometheus), logging strategy, alerting rules, key rotation procedures, and capacity planning for Redis and watermarking
- `testing-strategy`: Complete testing approach with pytest unit tests, integration tests, Locust load tests, and security tests, including CI/CD pipeline configuration
- `decision-support`: Decision trees, comparison matrices, and scenario-based guidance to help users choose appropriate protection methods

### Modified Capabilities

None. The core anti-hotlinking functionality (generating tokens, validating access, preventing hotlinks) remains unchanged. This enhancement adds documentation, operational guidance, and integration patterns without changing the fundamental behavior specified in any existing specs.

## Impact

**Files Modified:**
- `skills/anti-hotlink/SKILL.md` - Main skill file, expanding from ~345 lines to ~1,200 lines
- `skills/anti-hotlink/hotlink-warning.html` - No changes to existing file
- `skills/anti-hotlink/prompts.md` - No changes to existing file
- `skills/anti-hotlink/README.md` - May need minor updates to reflect new sections

**New Capabilities (Specs):**
- 6 new spec directories will be created under `openspec/changes/enhance-anti-hotlink-skill/specs/`:
  - `specs/hotlinking-limitations/spec.md`
  - `specs/failure-mode-handling/spec.md`
  - `specs/oauth-integration/spec.md`
  - `specs/operations-guide/spec.md`
  - `specs/testing-strategy/spec.md`
  - `specs/decision-support/spec.md`

**Dependencies:**
- No new runtime dependencies required
- Documentation enhancements only
- Code examples assume existing tools: Redis, sharp.js, pdf-lib, ffmpeg, pytest, locust

**Testing Impact:**
- New pytest-based test examples will be provided
- No changes to existing test infrastructure (this is documentation/skill enhancement)

**Documentation Impact:**
- Transforms the skill from a basic implementation guide into a comprehensive production reference
- Adds ~855 lines of new content across 8 new sections
- Improves code quality with error handling in all examples
- Adds performance benchmarks for all watermarking operations
