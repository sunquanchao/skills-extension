## Why

The current `anti-hotlink` skill is too large (3712 lines) to be effective as a single skill. It causes:
- **Token bloat**: Loading the entire skill consumes excessive context tokens
- **Poor discoverability**: Users can't find specific implementations quickly
- **Maintenance burden**: Updates require editing a massive file
- **All-or-nothing loading**: Users get everything even if they only need referer checking

Splitting into focused sub-skills improves usability, maintainability, and token efficiency.

## What Changes

**BREAKING**: The monolithic `anti-hotlink` skill will be replaced with a modular system.

- Create `anti-hotlink-core` as the entry point/router skill (~400 lines)
- Extract `anti-hotlink-referer` for Nginx/Apache referer checking (~300 lines)
- Extract `anti-hotlink-tokens` for HMAC/CloudFront signed URLs (~500 lines)
- Extract `anti-hotlink-rate-limiting` for Redis-based rate limiting (~400 lines)
- Extract `anti-hotlink-watermarking` for image/PDF/video watermarking (~500 lines)
- Extract `anti-hotlink-oauth` for OAuth 2.0 integration patterns (~400 lines)
- Extract `anti-hotlink-operations` for failure handling, monitoring, testing (~400 lines)
- Deprecate the original `anti-hotlink/SKILL.md` (keep as backup)

## Capabilities

### New Capabilities

- `anti-hotlink-core`: Entry point skill with decision tree, method selection guide, and links to specialized skills
- `anti-hotlink-referer`: Referer-based protection for Nginx, Apache, and CDN configurations
- `anti-hotlink-tokens`: Token-based access with HMAC signed URLs and CloudFront integration
- `anti-hotlink-rate-limiting`: Redis-based fixed and sliding window rate limiting
- `anti-hotlink-watermarking`: Image, PDF, and video watermarking with tiled patterns
- `anti-hotlink-oauth`: OAuth 2.0 integration patterns for resource protection
- `anti-hotlink-operations`: Failure mode handling, monitoring, testing strategies, and common pitfalls

### Modified Capabilities

None - this is a new capability decomposition.

## Impact

- **Files affected**:
  - `skills/anti-hotlink/SKILL.md` → deprecated (renamed to SKILL.md.deprecated)
  - New: `skills/anti-hotlink-core/SKILL.md`
  - New: `skills/anti-hotlink-referer/SKILL.md`
  - New: `skills/anti-hotlink-tokens/SKILL.md`
  - New: `skills/anti-hotlink-rate-limiting/SKILL.md`
  - New: `skills/anti-hotlink-watermarking/SKILL.md`
  - New: `skills/anti-hotlink-oauth/SKILL.md`
  - New: `skills/anti-hotlink-operations/SKILL.md`

- **User experience**:
  - Users type "anti-hotlink" → core skill routes to appropriate method
  - Users can directly invoke specialized skills (e.g., "rate limiting for API")
  - Token usage reduced by ~80% for focused queries

- **Backward compatibility**:
  - Core skill handles all original trigger phrases
  - Original skill preserved as `.deprecated` for reference
