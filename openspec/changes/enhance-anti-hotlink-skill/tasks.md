## 1. Setup & Preparation

- [ ] 1.1 Read current `skills/anti-hotlink/SKILL.md` file completely
- [ ] 1.2 Create backup of original file as `skills/anti-hotlink/SKILL.md.backup`
- [ ] 1.3 Read `specs/hotlinking-limitations/spec.md` to understand requirements
- [ ] 1.4 Read `specs/failure-mode-handling/spec.md` to understand requirements
- [ ] 1.5 Read `specs/oauth-integration/spec.md` to understand requirements
- [ ] 1.6 Read `specs/operations-guide/spec.md` to understand requirements
- [ ] 1.7 Read `specs/testing-strategy/spec.md` to understand requirements
- [ ] 1.8 Read `specs/decision-support/spec.md` to understand requirements
- [ ] 1.9 Create detailed section outline with estimated line counts for each of 15 sections

## 2. Add Security Notice (P1 - Critical)

- [ ] 2.1 Add prominent security warning at very top of SKILL.md (before TOC)
- [ ] 2.2 Add heading "⚠️ SECURITY NOTICE" with clear formatting
- [ ] 2.3 Add statement: "These are ILLUSTRATIVE EXAMPLES for learning patterns"
- [ ] 2.4 Add bullet point: "Input validation & sanitization"
- [ ] 2.5 Add bullet point: "Comprehensive error handling"
- [ ] 2.6 Add bullet point: "Security audit & testing"
- [ ] 2.7 Add bullet point: "Rate limiting & monitoring"
- [ ] 2.8 Add bullet point: "Proper secret management"
- [ ] 2.9 Add blank line after security notice for separation

## 3. Add Table of Contents

- [ ] 3.1 Add "## Table of Contents" heading after security notice
- [ ] 3.2 Add entry "1. Quick Start [5 min]"
- [ ] 3.3 Add entry "2. Understanding Hotlinking"
- [ ] 3.4 Add entry "3. Protection Methods Overview"
- [ ] 3.5 Add entry "4. Implementation by Platform"
- [ ] 3.6 Add entry "5. ⚠️ Limitations & What We DON'T Protect Against" (NEW)
- [ ] 3.7 Add entry "6. Failure Mode Handling" (NEW)
- [ ] 3.8 Add entry "7. Rate Limiting (Redis-based)"
- [ ] 3.9 Add entry "8. Watermarking (Image/PDF/Video)"
- [ ] 3.10 Add entry "9. 🔗 Integration with OAuth 2.0" (NEW)
- [ ] 3.11 Add entry "10. Warning Pages (UI Templates)"
- [ ] 3.12 Add entry "11. 📊 Operations & Monitoring" (NEW)
- [ ] 3.13 Add entry "12. 🧪 Testing Strategy" (NEW)
- [ ] 3.14 Add entry "13. 🎯 Decision Guide" (NEW)
- [ ] 3.15 Add entry "14. Implementation Checklist"
- [ ] 3.16 Add entry "15. Common Pitfalls"

## 4. Add Quick Start Section (P2 - Important)

- [ ] 4.1 Add "## 🚀 Quick Start: Choose Your Method in 30 Seconds" heading
- [ ] 4.2 Create ASCII decision tree starting with "START: What are you protecting?"
- [ ] 4.3 Add "PUBLIC CONTENT (blog images, portfolio)" branch → Referer Checking
- [ ] 4.4 Add "PAID CONTENT (courses, docs)" branch → Token-Based + OAuth
- [ ] 4.5 Add "DOWNLOADABLE FILES" branch → S3 Presigned URLs
- [ ] 4.6 Add "INTERNAL DOCUMENTS" branch → Session-Based
- [ ] 4.7 Add "### Immediate Example: Referer Checking (Nginx)" subheading
- [ ] 4.8 Add Nginx configuration code block with valid_referers example
- [ ] 4.9 Add "That's it! You're protected" completion message
- [ ] 4.10 Add "For more advanced use cases, read on" guidance

## 5. Add Limitations Section (P1 - Critical)

- [ ] 5.1 Add "## ⚠️ Important: Limitations of Anti-Hotlinking" heading
- [ ] 5.2 Add introductory sentence about managing expectations

### 5.1 Screen Capture & Redistribution
- [ ] 5.2.1 Add "### ❌ Screen Capture & Redistribution" subheading
- [ ] 5.2.2 Document that users can take screenshots
- [ ] 5.2.3 Document that users can print to PDF
- [ ] 5.2.4 Document that users can download and re-upload elsewhere
- [ ] 5.2.5 Add "Mitigation:" subheading
- [ ] 5.2.6 Add bullet: "Watermarking (see section 8)"
- [ ] 5.2.7 Add bullet: "Legal measures"

### 5.2 Token Sharing
- [ ] 5.3.1 Add "### ❌ Token Sharing" subheading
- [ ] 5.3.2 Document legitimate users can share tokens with others
- [ ] 5.3.3 Document tokens can be posted publicly
- [ ] 5.3.4 Document no way to detect if token holder is original recipient
- [ ] 5.3.5 Add "Mitigation:" subheading
- [ ] 5.3.6 Add bullet: "Short expiration times"
- [ ] 5.3.7 Add bullet: "Session-binding"
- [ ] 5.3.8 Add bullet: "Behavioral analysis"

### 5.3 Insider Threats
- [ ] 5.4.1 Add "### ❌ Insider Threats" subheading
- [ ] 5.4.2 Document developers with server access vulnerability
- [ ] 5.4.3 Document leaked secret keys risk
- [ ] 5.4.4 Document compromised accounts risk
- [ ] 5.4.5 Add "Mitigation:" subheading
- [ ] 5.4.6 Add bullet: "Key rotation"
- [ ] 5.4.7 Add bullet: "Audit logs"
- [ ] 5.4.8 Add bullet: "Access controls"

### 5.4 Offline Access
- [ ] 5.5.1 Add "### ❌ Offline Access" subheading
- [ ] 5.5.2 Document downloaded files can be accessed offline
- [ ] 5.5.3 Document cached browser copies persist
- [ ] 5.5.4 Add "Mitigation:" subheading
- [ ] 5.5.5 Add bullet: "DRM for sensitive content"
- [ ] 5.5.6 Add bullet: "Require online validation"

### 5.5 Automated Scraping
- [ ] 5.6.1 Add "### ❌ Automated Scraping (Partial Protection)" subheading
- [ ] 5.6.2 Document sophisticated scrapers can spoof referers
- [ ] 5.6.3 Document can rotate IP addresses
- [ ] 5.6.4 Add "Mitigation:" subheading
- [ ] 5.6.5 Add bullet: "Rate limiting"
- [ ] 5.6.6 Add bullet: "Behavioral analysis"
- [ ] 5.6.7 Add bullet: "CAPTCHA"

### 5.6 What Anti-Hotlinking DOES Well
- [ ] 5.7.1 Add "### What Anti-Hotlinking DOES Well" subheading
- [ ] 5.7.2 Add bullet: "✅ Prevent casual hotlinking from other websites"
- [ ] 5.7.3 Add bullet: "✅ Block embedding in iframes on unauthorized domains"
- [ ] 5.7.4 Add bullet: "✅ Reduce bandwidth theft"
- [ ] 5.7.5 Add bullet: "✅ Enforce access control at request time"
- [ ] 5.7.6 Add bullet: "✅ Track access patterns via token validation"

### 5.7 When You Need More
- [ ] 5.8.1 Add "### When You Need More Than Anti-Hotlinking" subheading
- [ ] 5.8.2 Add intro: "For comprehensive content protection, combine:"
- [ ] 5.8.3 Add bullet: "- DRM (Digital Rights Management)"
- [ ] 5.8.4 Add bullet: "- Forensic watermarking"
- [ ] 5.8.5 Add bullet: "- Legal agreements (ToS, licensing)"
- [ ] 5.8.6 Add bullet: "- Monitoring and takedown procedures"
- [ ] 5.8.7 Add bullet: "- Encryption (for sensitive data)"

## 6. Add Failure Mode Handling Section (P1 - Critical)

- [ ] 6.1 Add "## 🛡️ Failure Mode Handling" heading

### 6.1 Redis Goes Down
- [ ] 6.2.1 Add "### Redis Goes Down" subheading
- [ ] 6.2.2 Add "Scenario: Rate limiter can't connect to Redis"
- [ ] 6.2.3 Add "Impact:" describing rate limiting failure
- [ ] 6.2.4 Add recommendation: "Fail open (log only) for non-critical"
- [ ] 6.2.5 Add recommendation: "Fail closed (deny all) for sensitive"
- [ ] 6.2.6 Add code block with try-catch RedisConnectionError detection
- [ ] 6.2.7 Include logger.warning in example
- [ ] 6.2.8 Return True for fail-open behavior

### 6.2 Clock Skew
- [ ] 6.3.1 Add "### Clock Skew" subheading
- [ ] 6.3.2 Add "Scenario: Server clocks out of sync, token expiration fails"
- [ ] 6.3.3 Add "Impact:" legitimate tokens rejected or expired accepted
- [ ] 6.3.4 Add "Mitigation:" subheading
- [ ] 6.3.5 Add bullet: "Use NTP to sync clocks"
- [ ] 6.3.6 Add bullet: "Add grace period (±30 seconds) to expiration"
- [ ] 6.3.7 Add code block with grace_period = 30 example
- [ ] 6.3.8 Include validation: now <= (expires + grace_period)

### 6.3 Secret Key Leaked
- [ ] 6.4.1 Add "### Secret Key Leaked" subheading
- [ ] 6.4.2 Add "Scenario: Secret key exposed (git leak, insider threat)"
- [ ] 6.4.3 Add "Impact:" all tokens can be forged
- [ ] 6.4.4 Add "Mitigation:" subheading
- [ ] 6.4.5 Add bullet: "Implement key rotation strategy"
- [ ] 6.4.6 Add bullet: "Support multiple active keys (versioned tokens)"
- [ ] 6.4.7 Add bullet: "Monitor for suspicious token patterns"
- [ ] 6.4.8 Add bullet: "Have incident response plan ready"
- [ ] 6.4.9 Add "Key Rotation Strategy:" numbered list:
  - [ ] 6.4.9.1 "1. Generate new key"
  - [ ] 6.4.9.2 "2. Add to key store (keep old key active)"
  - [ ] 6.4.9.3 "3. Update token generation to use new key"
  - [ ] 6.4.9.4 "4. Wait for old tokens to expire (e.g., 24 hours)"
  - [ ] 6.4.9.5 "5. Remove old key from store"

### 6.4 CDN Cache Issues
- [ ] 6.5.1 Add "### CDN Cache Issues" subheading
- [ ] 6.5.2 Add "Scenario: Signed URLs don't cache properly"
- [ ] 6.5.3 Add "Impact:" every request hits origin, performance degrades
- [ ] 6.5.4 Add "Mitigation:" subheading
- [ ] 6.5.5 Add bullet: "Configure CDN to ignore token params for cache key"
- [ ] 6.5.6 Add bullet: "Use cache-key customization"
- [ ] 6.5.7 Add bullet: "Pre-warm cache for popular content"

### 6.5 Large File Processing
- [ ] 6.6.1 Add "### Large File Processing" subheading
- [ ] 6.6.2 Add "Scenario: Watermarking 1GB video times out"
- [ ] 6.6.3 Add "Impact:" request fails, user gets error
- [ ] 6.6.4 Add "Mitigation:" subheading
- [ ] 6.6.5 Add bullet: "Use async job queue (Celery, BullMQ)"
- [ ] 6.6.6 Add bullet: "Return job ID, poll for completion"
- [ ] 6.6.7 Add bullet: "Progress tracking"
- [ ] 6.6.8 Add bullet: "Timeout handling"
- [ ] 6.6.9 Add code block with @async_route decorator example
- [ ] 6.6.10 Include watermark_queue.enqueue call
- [ ] 6.6.11 Return {"job_id": job.id, "status": "processing"}

### 6.6 Concurrent Request Race Conditions
- [ ] 6.7.1 Add "### Concurrent Request Race Conditions" subheading
- [ ] 6.7.2 Add "Scenario: Multiple requests simultaneously check rate limit"
- [ ] 6.7.3 Add "Impact:" rate limit can be exceeded
- [ ] 6.7.4 Add "Mitigation:" subheading
- [ ] 6.7.5 Add bullet: "Use Redis atomic operations"
- [ ] 6.7.6 Add bullet: "Use Lua scripts for complex checks"
- [ ] 6.7.7 Add bullet: "Use Redis transactions (MULTI/EXEC)"
- [ ] 6.7.8 Add code block with Redis pipeline example
- [ ] 6.7.9 Include pipe.incr, pipe.expire, pipe.zadd calls
- [ ] 6.7.10 Execute pipeline with pipe.exec()

- [ ] 6.8 Ensure all failure mode code includes try-catch blocks (not full recovery code per user request)

## 7. Add OAuth 2.0 Integration Section (P1 - Critical)

- [ ] 7.1 Add "## 🔗 Integration with OAuth 2.0" heading
- [ ] 7.2 Add overview paragraph explaining multi-layer protection

### 7.1 OAuth Scopes for Resource Access
- [ ] 7.3.1 Add "### Pattern 1: OAuth Scopes for Resource Access" subheading
- [ ] 7.3.2 Add "Concept:" Use OAuth scopes to control resource access
- [ ] 7.3.3 Add code block with require_scope decorator
- [ ] 7.3.4 Include token = current_token check
- [ ] 7.3.5 Include scope validation
- [ ] 7.3.6 Add usage example with @require_scope('read:premium')

### 7.2 OAuth Token + Resource Token
- [ ] 7.4.1 Add "### Pattern 2: OAuth Token + Anti-Hotlink Token" subheading
- [ ] 7.4.2 Add "Concept:" Combine OAuth auth with resource token
- [ ] 7.4.3 Add code block with generate_resource_token function
- [ ] 7.4.4 Include user_id in token_data
- [ ] 7.4.5 Include HMAC signature generation
- [ ] 7.4.6 Add OAuth-protected endpoint example
- [ ] 7.4.7 Include @oauth.require_oauth('read:files') decorator
- [ ] 7.4.8 Return signed_url in response

### 7.3 Auth0 Integration
- [ ] 7.5.1 Add "### Pattern 3: Integrate with Popular OAuth Providers" subheading
- [ ] 7.5.2 Add "#### Auth0" sub-subheading
- [ ] 7.5.3 Add code block with Authlib OAuth registration
- [ ] 7.5.4 Include client_id, client_secret, api_base_url
- [ ] 7.5.5 Add @login_required route example
- [ ] 7.5.6 Include user = session.get('user')
- [ ] 7.5.7 Generate signed URL with user['sub']

### 7.4 Okta Integration
- [ ] 7.6.1 Add "#### Okta" sub-subheading
- [ ] 7.6.2 Add code block with Okta client initialization
- [ ] 7.6.3 Include orgUrl and token configuration
- [ ] 7.6.4 Add @login_required route example
- [ ] 7.6.5 Include access_token extraction from headers
- [ ] 7.6.6 Include okta_client.get_user(access_token)
- [ ] 7.6.7 Generate signed URL with user_info['id']

### 7.5 OAuth 2.0 Token Introspection
- [ ] 7.7.1 Add "### Pattern 4: OAuth 2.0 Token Introspection" subheading
- [ ] 7.7.2 Add "Concept:" Validate OAuth token with auth server
- [ ] 7.7.3 Add code block with introspect_token function
- [ ] 7.7.4 Include requests.post to introspection URL
- [ ] 7.7.5 Include auth=(client_id, client_secret)
- [ ] 7.7.6 Add /api/generate-resource-link endpoint
- [ ] 7.7.7 Validate token with introspect_token
- [ ] 7.7.8 Check 'active' status in response
- [ ] 7.7.9 Check 'read:protected' in scope
- [ ] 7.7.10 Return resource_url in response

### 7.6 Security Considerations
- [ ] 7.8.1 Add "### Security Considerations for OAuth Integration" subheading
- [ ] 7.8.2 Create ASCII diagram showing 4 layers of defense
- [ ] 7.8.3 Layer 1: OAuth Authentication
- [ ] 7.8.4 Layer 2: Resource Token (Anti-Hotlink)
- [ ] 7.8.5 Layer 3: Transport Security
- [ ] 7.8.6 Layer 4: Application Authorization
- [ ] 7.8.7 Add "Best Practices:" subheading
- [ ] 7.8.8 Add bullet: "Keep OAuth tokens short-lived (5-15 minutes)"
- [ ] 7.8.9 Add bullet: "Keep resource tokens even shorter (1-5 minutes)"
- [ ] 7.8.10 Add bullet: "Use different secrets for OAuth and resource tokens"
- [ ] 7.8.11 Add bullet: "Log all token validations for audit trail"
- [ ] 7.8.12 Add bullet: "Implement token revocation for compromised accounts"

## 8. Add Operations & Monitoring Section (P1 - Critical)

- [ ] 8.1 Add "## 📊 Operations & Monitoring Guide" heading

### 8.1 Metrics to Track
- [ ] 8.2.1 Add "### Metrics to Track" subheading
- [ ] 8.2.2 Add code block: "from prometheus_client import Counter, Histogram, Gauge"
- [ ] 8.2.3 Add blocked_requests Counter with ['reason'] labels
- [ ] 8.2.4 Add token_validations Counter with ['result'] labels
- [ ] 8.2.5 Add rate_limit_denied Counter with ['limit_type'] labels
- [ ] 8.2.6 Add watermark_duration Histogram with ['file_type'] labels
- [ ] 8.2.7 Add "Key Metrics:" subheading
- [ ] 8.2.8 List: blocked_requests{reason="referer"}
- [ ] 8.2.9 List: blocked_requests{reason="token"}
- [ ] 8.2.10 List: rate_limit_denied
- [ ] 8.2.11 List: watermark_duration
- [ ] 8.2.12 List: redis_connection_errors

### 8.2 Logging Strategy
- [ ] 8.3.1 Add "### Logging Strategy" subheading
- [ ] 8.3.2 Add "What to Log:" subheading
- [ ] 8.3.3 Add code block with import logging and json
- [ ] 8.3.4 Add logger = logging.getLogger('hotlink')
- [ ] 8.3.5 Add log_blocked_request function
- [ ] 8.3.6 Include event timestamp
- [ ] 8.3.7 Include IP, referer, user_agent, resource, reason
- [ ] 8.3.8 Include truncated token (first 8 chars + '...')
- [ ] 8.3.9 Add "Note: Don't log full tokens (PII/security risk)"
- [ ] 8.3.10 Add "Log Retention:" subheading
- [ ] 8.3.11 Add bullet: "Blocked requests: 90 days"
- [ ] 8.3.12 Add bullet: "Token validations: 30 days"
- [ ] 8.3.13 Add bullet: "Rate limit events: 7 days"
- [ ] 8.3.14 Add bullet: "Performance metrics: In Prometheus, not logs"

### 8.3 Alerting
- [ ] 8.4.1 Add "### Alerting" subheading
- [ ] 8.4.2 Add "Alert Rules:" intro
- [ ] 8.4.3 Add YAML code block for Prometheus AlertManager
- [ ] 8.4.4 Add alert: HighBlockRate with rate > 100 for 5m
- [ ] 8.4.5 Add alert: RedisConnectionFailing with rate > 10 for 2m
- [ ] 8.4.6 Add alert: WatermarkProcessingSlow with 95th percentile > 30s for 10m
- [ ] 8.4.7 Add "Severity Levels:" subheading
- [ ] 8.4.8 Add bullet: "P1 (Critical): Redis down, all requests blocked"
- [ ] 8.4.9 Add bullet: "P2 (High): Block rate > 100/sec, possible attack"
- [ ] 8.4.10 Add bullet: "P3 (Medium): Watermarking slow, degraded UX"
- [ ] 8.4.11 Add bullet: "P4 (Low): Occasional validation failures"

### 8.4 Key Rotation Procedure
- [ ] 8.5.1 Add "### Key Rotation Procedure" subheading
- [ ] 8.5.2 Add "Scenario: Rotate secret key without downtime"
- [ ] 8.5.3 Add code block with ACTIVE_KEYS dictionary
- [ ] 8.5.4 Include 'v1': 'old-secret-key-32-chars-minimum'
- [ ] 8.5.5 Include 'v2': 'new-secret-key-32-chars-minimum'
- [ ] 8.5.6 Set DEFAULT_KEY_VERSION = 'v2'
- [ ] 8.5.7 Add validate_token_with_any_key function
- [ ] 8.5.8 Loop through ACTIVE_KEYS items()
- [ ] 8.5.9 Return (True, version) if valid
- [ ] 8.5.10 Return (False, None) if none valid
- [ ] 8.5.11 Add generate_token with DEFAULT_KEY_VERSION
- [ ] 8.5.12 Return f"{DEFAULT_KEY_VERSION}:{token}"
- [ ] 8.5.13 Add "Rotation Steps:" numbered list:
  - [ ] 8.5.13.1 "1. Generate new key: openssl rand -base64 32"
  - [ ] 8.5.13.2 "2. Add to ACTIVE_KEYS as new version"
  - [ ] 8.5.13.3 "3. Deploy (both keys active)"
  - [ ] 8.5.13.4 "4. Wait for old tokens to expire (e.g., 24 hours)"
  - [ ] 8.5.13.5 "5. Remove old key from ACTIVE_KEYS"
  - [ ] 8.5.13.6 "6. Deploy (only new key active)"

### 8.5 Capacity Planning - Redis
- [ ] 8.6.1 Add "### Capacity Planning" subheading
- [ ] 8.6.2 Add "Redis Memory for Rate Limiting:" sub-subheading
- [ ] 8.6.3 Add bullet: "Each rate limit entry: ~100 bytes"
- [ ] 8.6.4 Add calculation: "100K users × 10 limits each = 100MB"
- [ ] 8.6.5 Add recommendation: "Start with 512MB Redis instance"
- [ ] 8.6.6 Add "Monitoring: used_memory metric"
- [ ] 8.6.7 Add "Scaling strategy:" subheading
- [ ] 8.6.8 Add bullet: "< 10K req/sec: Single Redis instance"
- [ ] 8.6.9 Add bullet: "10K-50K req/sec: Redis Cluster (3 nodes)"
- [ ] 8.6.10 Add bullet: "> 50K req/sec: Shard by user ID hash"

### 8.6 Capacity Planning - Watermarking
- [ ] 8.7.1 Add "Watermarking Processing:" sub-subheading
- [ ] 8.7.2 Add "Assumptions:" bullet list
- [ ] 8.7.3 "10% of users watermark images"
- [ ] 8.7.4 "Average image: 5MB"
- [ ] 8.7.5 "Processing time: 200ms per image"
- [ ] 8.7.6 Add "Capacity:" calculation
- [ ] 8.7.7 "Single core: 5 images/sec"
- [ ] 8.7.8 "4 cores: 20 images/sec"
- [ ] 8.7.9 Add "Recommendation: Queue system + worker pool"
- [ ] 8.7.10 Add "Autoscale based on queue depth"

### 8.7 CDN Costs
- [ ] 8.8.1 Add "CDN Costs" sub-subheading
- [ ] 8.8.2 Add "AWS CloudFront (example):" table
- [ ] 8.8.3 "1TB transfer: $85"
- [ ] 8.8.4 "10TB transfer: $700"
- [ ] 8.8.5 "100TB transfer: $5,000"
- [ ] 8.8.6 Add "Optimization:" subheading
- [ ] 8.8.7 Add bullet: "Cache static resources at edge"
- [ ] 8.8.8 Add bullet: "Use signed URLs for dynamic content"
- [ ] 8.8.9 Add bullet: "Pre-warm cache for popular content"

## 9. Add Testing Strategy Section (P1 - Critical)

- [ ] 9.1 Add "## 🧪 Testing Strategy" heading

### 9.1 Unit Tests (Pytest)
- [ ] 9.2.1 Add "### Unit Tests (Pytest)" subheading
- [ ] 9.2.2 Add "tests/test_token_generation.py" file reference
- [ ] 9.2.3 Add code block for test_generate_token_basic()
- [ ] 9.2.4 Assert isinstance(token, str)
- [ ] 9.2.5 Assert len(token) == 64
- [ ] 9.2.6 Assert expires > int(time.time())
- [ ] 9.2.7 Add code block for test_validate_token_valid()
- [ ] 9.2.8 Assert validate_token returns True
- [ ] 9.2.9 Add code block for test_validate_token_expired()
- [ ] 9.2.10 Generate token with expires = -1
- [ ] 9.2.11 Assert validate_token returns False
- [ ] 9.2.12 Add code block for test_validate_token_wrong_resource()
- [ ] 9.2.13 Generate token for '/files/doc.pdf'
- [ ] 9.2.14 Try to validate for '/files/other.pdf'
- [ ] 9.2.15 Assert validate_token returns False

### 9.2 Integration Tests
- [ ] 9.3.1 Add "### Integration Tests" subheading
- [ ] 9.3.2 Add "tests/test_integration.py" file reference
- [ ] 9.3.3 Add @fixture for client()
- [ ] 9.3.4 Add test_protected_resource_without_token()
- [ ] 9.3.5 Assert response.status_code == 403
- [ ] 9.3.6 Assert b'附件已做防盗链处理' in response.data
- [ ] 9.3.7 Add test_protected_resource_with_valid_token()
- [ ] 9.3.8 Generate valid token
- [ ] 9.3.9 Assert response.status_code == 200
- [ ] 9.3.10 Add test_rate_limiting()
- [ ] 9.3.11 Loop 100 times with valid requests
- [ ] 9.3.12 101st request should return 429

### 9.3 Load Tests (Locust)
- [ ] 9.4.1 Add "### Load Tests (Locust)" subheading
- [ ] 9.4.2 Add "tests/load_test.py" file reference
- [ ] 9.4.3 Add code block with HotlinkUser(HttpUser) class
- [ ] 9.4.4 Set wait_time = between(1, 3)
- [ ] 9.4.5 Add on_start method generating token
- [ ] 9.4.6 Add @task(3) valid_request()
- [ ] 9.4.7 Add @task(1) invalid_request()
- [ ] 9.4.8 Add comment: "# Run: locust -f tests/load_test.py --host=http://localhost:5000"

### 9.4 Security Tests
- [ ] 9.5.1 Add "### Security Tests" subheading
- [ ] 9.5.2 Add "tests/test_security.py" file reference
- [ ] 9.5.3 Add test_cannot_forge_token()
- [ ] 9.5.4 Try fake_token = "a" * 64
- [ ] 9.5.5 Assert not validate_token(fake_token, ...)
- [ ] 9.5.6 Add test_timing_attack_resistance()
- [ ] 9.5.7 Import time module
- [ ] 9.5.8 Measure duration for valid token
- [ ] 9.5.9 Measure duration for invalid token
- [ ] 9.5.10 Assert abs(duration_valid - duration_invalid) < 0.01

### 9.5 Test Coverage
- [ ] 9.6.1 Add "### Test Coverage Goals" subheading
- [ ] 9.6.2 Add code block: "pytest --cov=hotlink --cov-report=html"
- [ ] 9.6.3 Add "Target metrics:" subheading
- [ ] 9.6.4 Add bullet: "Line coverage: > 90%"
- [ ] 9.6.5 Add bullet: "Branch coverage: > 85%"
- [ ] 9.6.6 Add bullet: "All security-critical paths: 100%"

### 9.6 Continuous Testing
- [ ] 9.7.1 Add "### Continuous Testing" subheading
- [ ] 9.7.2 Add YAML code block for ".github/workflows/test.yml"
- [ ] 9.7.3 Add name: "Test Suite"
- [ ] 9.7.4 Add on: [push, pull_request]
- [ ] 9.7.5 Add ubuntu-latest runner
- [ ] 9.7.6 Add redis service with alpine image
- [ ] 9.7.7 Add steps: checkout, setup-python, install
- [ ] 9.7.8 Add pytest tests/unit/ command
- [ ] 9.7.9 Add pytest tests/integration/ command
- [ ] 9.7.10 Add pytest tests/security/ command
- [ ] 9.7.11 Add pytest --cov=hotlink --cov-fail-under=90

## 10. Add Decision Guide Section (P2 - Important)

- [ ] 10.1 Add "## 🎯 Decision Guide: Which Method for You?" heading

### 10.1 Quick Decision Tree
- [ ] 10.2.1 Add "### Quick Decision Tree" subheading
- [ ] 10.2.2 Create ASCII tree starting with "START: What are you protecting?"
- [ ] 10.2.3 Add "PUBLIC CONTENT (blog images, portfolio)" branch
- [ ] 10.2.4 Add traffic level sub-branches
- [ ] 10.2.5 Low/Medium → Referer Checking
- [ ] 10.2.6 High → CDN + Referer
- [ ] 10.2.7 Add "PAID CONTENT (courses, premium docs)" branch
- [ ] 10.2.8 Add User auth? sub-branches
- [ ] 10.2.9 Yes → Token-Based + OAuth
- [ ] 10.2.10 No → Token-Based with short expiration
- [ ] 10.2.11 Add "DOWNLOADABLE FILES" branch
- [ ] 10.2.12 Add File size? sub-branches
- [ ] 10.2.13 Small (<100MB) → S3 Presigned URLs
- [ ] 10.2.14 Large (>100MB) → Token + Watermark
- [ ] 10.2.15 Add "INTERNAL DOCUMENTS" branch
- [ ] 10.2.16 → Session-Based

### 10.2 Comparison Matrix
- [ ] 10.3.1 Add "### Comparison Matrix" subheading
- [ ] 10.3.2 Create markdown table with columns: Scenario, Recommended Method, Why, Complexity
- [ ] 10.3.3 Add row: Blog images → Referer + CDN → Simple, fast → Low
- [ ] 10.3.4 Add row: Course videos → Token + OAuth + Watermark → User-specific, traceable → High
- [ ] 10.3.5 Add row: Software downloads → S3 Presigned URL → Scalable, no server → Medium
- [ ] 10.3.6 Add row: Internal docs → Session-Based → Only logged-in users → Medium
- [ ] 10.3.7 Add row: Public API → API Keys + Rate Limit → Track usage → High
- [ ] 10.3.8 Add row: Photo portfolio → Referer + Watermark → Prevent theft → Medium
- [ ] 10.3.9 Add row: Live streams → Token + Short Expiration → Prevent link sharing → Medium

### 10.3 When to Combine Methods
- [ ] 10.4.1 Add "### When to Combine Methods" subheading
- [ ] 10.4.2 Add "Defense in Depth:" intro
- [ ] 10.4.3 Create ASCII box for "Example: Premium Video Course"
- [ ] 10.4.4 Layer 1: OAuth Authentication
- [ ] 10.4.5 Layer 2: Token-Based Access (5 min expiration)
- [ ] 10.4.6 Layer 3: Rate Limiting (3 requests per minute)
- [ ] 10.4.7 Layer 4: Watermarking (user ID burned into video)
- [ ] 10.4.8 Layer 5: Session Validation (must have active session)
- [ ] 10.4.9 Add result: "5 layers of protection, each enforcing different aspect"

### 10.4 Method Comparison Table
- [ ] 10.5.1 Add "### Protection Method Comparison" subheading
- [ ] 10.5.2 Create markdown table with columns: Method, Security, Complexity, Best For, Not For
- [ ] 10.5.3 Add row: Referer Check | Low | Simple | Public content | APIs, sensitive data
- [ ] 10.5.4 Add row: Token-Based | High | Medium | Paid content, time-limited | Simple sites
- [ ] 10.5.5 Add row: Session-Based | High | High | Logged-in users | Public access
- [ ] 10.5.6 Add row: CDN Signed URLs | High | Medium | High traffic, global | Small sites

## 11. Enhance Protection Methods Overview

- [ ] 11.1 Locate existing "## What to Do" section in file
- [ ] 11.2 Add comparison table after existing text
- [ ] 11.3 Create table with columns: Method, Security, Complexity, Best For, Not For
- [ ] 11.4 Fill in Referer Checking row
- [ ] 11.5 Fill in Token-Based Access row
- [ ] 11.6 Fill in Cookie/Session Based row
- [ ] 11.7 Ensure consistent formatting with rest of document

## 12. Enhance Implementation Examples with Error Handling

### 12.1 Nginx Configuration
- [ ] 12.1.1 Locate Nginx configuration code block
- [ ] 12.1.2 Add comment above: "# Error Handling: Nginx will return 403 if invalid_referer"
- [ ] 12.1.3 Add comment: "# Monitor error.log for blocked requests"

### 12.2 Apache Configuration
- [ ] 12.2.1 Locate Apache .htaccess code block
- [ ] 12.2.2 Add comment: "# Error Handling: Apache returns 403 Forbidden"
- [ ] 12.2.3 Add comment: "# Check error.log for blocked requests"

### 12.3 Node.js/Express Token Generation
- [ ] 12.3.1 Locate generateSignedUrl function
- [ ] 12.3.2 Wrap function body in try-catch block
- [ ] 12.3.3 Add validation: if (!path || !key) throw Error
- [ ] 12.3.4 Add catch block with console.error
- [ ] 12.3.5 Re-throw error in catch block

### 12.4 Node.js/Express Token Validation
- [ ] 12.4.1 Locate validateSignedUrl function
- [ ] 12.4.2 Wrap function body in try-catch block
- [ ] 12.4.3 Add validation for inputs
- [ ] 12.4.4 Add catch block with error logging
- [ ] 12.4.5 Return false in catch block

### 12.5 Node.js/Express Middleware
- [ ] 12.5.1 Locate app.use middleware
- [ ] 12.5.2 Wrap in try-catch for token validation
- [ ] 12.5.3 Add error handling for invalid tokens
- [ ] 12.5.4 Add error logging for debugging

### 12.6 Python/Flask Token Generation
- [ ] 12.6.1 Locate generate_signed_url function
- [ ] 12.6.2 Wrap function body in try-except block
- [ ] 12.6.3 Add validation for inputs
- [ ] 12.6.4 Add except block with logging
- [ ] 12.6.5 Re-raise exception

### 12.7 Python/Flask Token Validation
- [ ] 12.7.1 Locate validate_signed_url function
- [ ] 12.7.2 Wrap function body in try-except block
- [ ] 12.7.3 Add except block returning False
- [ ] 12.7.4 Add logging for debugging

### 12.8 Python/Flask Decorator
- [ ] 12.8.1 Locate require_signed_token decorator
- [ ] 12.8.2 Wrap decorated function in try-except
- [ ] 12.8.3 Add error handling for missing/expired tokens
- [ ] 12.8.4 Return appropriate HTTP status codes

## 13. Add CDN Coverage with Equal Depth

### 13.1 Setup
- [ ] 13.1.1 Add "### CDN-Level Protection" heading after existing content
- [ ] 13.1.2 Add "### Decision Matrix: Which CDN for You?" subheading
- [ ] 13.1.3 Create table with Scenario, Best Choice, Why columns

### 13.2 AWS CloudFront
- [ ] 13.2.1 Add "#### AWS CloudFront Signed URLs" subheading
- [ ] 13.2.2 Add "Pattern:" Key-pair based signing, edge validation
- [ ] 13.2.3 Add code block with CloudFrontSigner import
- [ ] 13.2.4 Add signer initialization with keyPairId and privateKey
- [ ] 13.2.5 Add signUrl function with expiresIn parameter
- [ ] 13.2.6 Calculate expires timestamp
- [ ] 13.2.7 Return signer.getSignedUrl(url, {expires})
- [ ] 13.2.8 Add "When to use:" bullet list
- [ ] 13.2.9 Content already on CloudFront
- [ ] 13.2.10 Need global edge caching
- [ ] 13.2.11 High traffic (millions of requests)
- [ ] 13.2.12 Want to offload signing to edge
- [ ] 13.2.13 Add "Not ideal when:" bullet list
- [ ] 13.2.14 Not using AWS
- [ ] 13.2.15 Need per-request validation
- [ ] 13.2.16 Want user-specific metadata in tokens

### 13.3 Cloudflare Workers
- [ ] 13.3.1 Add "#### Cloudflare Workers Anti-Hotlink" subheading
- [ ] 13.3.2 Add "Pattern:" JavaScript at edge, referer checking
- [ ] 13.3.3 Add code block with export default { fetch }
- [ ] 13.3.4 Extract URL from request
- [ ] 13.3.5 Check if pathname starts with '/protected/'
- [ ] 13.3.6 Check referer header with isValidReferer()
- [ ] 13.3.7 Return warning page with 403 if invalid
- [ ] 13.3.8 Return fetch(request) if valid
- [ ] 13.3.9 Add "When to use:" bullet list
- [ ] 13.3.10 Already using Cloudflare
- [ ] 13.3.11 Need custom validation logic
- [ ] 13.3.12 Want to modify responses at edge
- [ ] 13.3.13 Simple setup (no key management)
- [ ] 13.3.14 Add "Not ideal when:" bullet list
- [ ] 13.3.15 Need token-based access
- [ ] 13.3.16 Complex validation rules
- [ ] 13.3.17 Not on Cloudflare

### 13.4 S3 Presigned URLs
- [ ] 13.4.1 Add "#### S3 Presigned URLs" subheading
- [ ] 13.4.2 Add "Pattern:" AWS SDK generates signed URLs, S3 validates
- [ ] 13.4.3 Add code block with S3Client import
- [ ] 13.4.4 Add generatePresignedUrl function
- [ ] 13.4.5 Create GetObjectCommand with Bucket and Key
- [ ] 13.4.6 Return getSignedUrl(s3, command, {expiresIn})
- [ ] 13.4.7 Add "When to use:" bullet list
- [ ] 13.4.8 Files stored in S3
- [ ] 13.4.9 No CDN layer needed
- [ ] 13.4.10 Direct file access
- [ ] 13.4.11 Simple setup
- [ ] 13.4.12 Add "Not ideal when:" bullet list
- [ ] 13.4.13 Need edge caching
- [ ] 13.4.14 High traffic (S3 costs)
- [ ] 13.4.15 Want custom validation logic

## 14. Enhance Rate Limiting Section

### 14.1 Fixed Window
- [ ] 14.1.1 Locate existing rate limiting section
- [ ] 14.1.2 Add "### Fixed Window Rate Limiting" subheading
- [ ] 14.1.3 Add code block with fixedWindowRateLimit function
- [ ] 14.1.4 Wrap in try-catch block
- [ ] 14.1.5 Use redis.incr for counter
- [ ] 14.1.6 Set expiration with redis.expire on first request
- [ ] 14.1.7 Return count <= limit

### 14.2 Sliding Window
- [ ] 14.2.1 Add "### Sliding Window Rate Limiting" subheading
- [ ] 14.2.2 Add code block with slidingWindowRateLimit function
- [ ] 14.2.3 Wrap in try-catch block
- [ ] 14.2.4 Calculate windowStart = now - (windowSec * 1000)
- [ ] 14.2.5 Use redis.pipeline for atomic operations
- [ ] 14.2.6 Remove old entries with zremrangebyscore
- [ ] 14.2.7 Count current with zcard
- [ ] 14.2.8 Add current with zadd
- [ ] 14.2.9 Set expiration with expire
- [ ] 14.2.10 Execute pipeline
- [ ] 14.2.11 Return allowed, remaining, resetAt

### 14.3 Comparison
- [ ] 14.3.1 Add "### Comparison: Which to Use?" subheading
- [ ] 14.3.2 Create comparison table
- [ ] 14.3.3 Columns: Aspect, Fixed Window, Sliding Window
- [ ] 14.3.4 Row: Accuracy | Lower (bursts at boundaries) | Higher (smooth)
- [ ] 14.3.5 Row: Redis Operations | 2-3 per request | 4-5 per request
- [ ] 14.3.6 Row: Use Case | Simple rate limiting | Accurate rate limiting

### 14.4 Multi-Dimensional Limits
- [ ] 14.4.1 Add "### Multi-Dimensional Limits" subheading
- [ ] 14.4.2 Add code block with limits array
- [ ] 14.4.3 IP-based: {'key': f'ip:{ip}', 'limit': 100, 'window': 60}
- [ ] 14.4.4 Token-based: {'key': f'token:{token}', 'limit': 50, 'window': 60}
- [ ] 14.4.5 Global: {'key': 'global', 'limit': 10000, 'window': 60}
- [ ] 14.4.6 Show checking all limits with Promise.all

### 14.5 Redis Connection Management
- [ ] 14.5.1 Add "### Redis Connection Management" subheading
- [ ] 14.5.2 Add code block with redis.Redis initialization
- [ ] 14.5.3 Add from redis.retry import Retry
- [ ] 14.5.4 Add from redis.backoff import ExponentialBackoff
- [ ] 14.5.5 Configure retry with ExponentialBackoff, 3 retries
- [ ] 14.5.6 Set decode_responses=True
- [ ] 14.5.7 Add comment about connection pooling

## 15. Enhance Watermarking Section with Performance Benchmarks

### 15.1 Single Text Watermark
- [ ] 15.1.1 Locate watermarkImage function
- [ ] 15.1.2 Add "⏱️ Performance Notes:" comment block after function
- [ ] 15.1.3 Add bullet: "5MB JPEG: ~150ms on M1 Pro"
- [ ] 15.1.4 Add bullet: "Scaling: O(n) where n = image dimensions"
- [ ] 15.1.5 Add bullet: "Memory: ~2x image size during processing"
- [ ] 15.1.6 Add "Recommendations:" subheading
- [ ] 15.1.7 Add bullet: "For high-volume: Pre-watermark during upload"
- [ ] 15.1.8 Add bullet: "For dynamic: Cache with short TTL (60s)"
- [ ] 15.1.9 Add bullet: "For batch: Process in parallel, limit concurrency"

### 15.2 Tiled Watermark
- [ ] 15.2.1 Locate tiledWatermark function
- [ ] 15.2.2 Add "⏱️ Performance Notes:" comment block
- [ ] 15.2.3 Add bullet: "5MB JPEG: ~400ms on M1 Pro"
- [ ] 15.2.4 Add bullet: "Better for: Preventing crop-out attacks"

### 15.3 Logo Overlay
- [ ] 15.3.1 Locate logoWatermark function
- [ ] 15.3.2 Add "⏱️ Performance Notes:" comment block
- [ ] 15.3.3 Add bullet: "5MB JPEG: ~200ms on M1 Pro"

### 15.4 PDF Watermarking
- [ ] 15.4.1 Locate watermarkPdf function
- [ ] 15.4.2 Add "⏱️ Performance Notes:" comment block
- [ ] 15.4.3 Add bullet: "Single page: ~50ms on M1 Pro"
- [ ] 15.4.4 Add bullet: "100-page PDF: ~3-5 seconds on M1 Pro"
- [ ] 15.4.5 Add bullet: "Scaling: O(pages)"
- [ ] 15.4.6 Add bullet: "Memory: ~3x PDF size during processing"
- [ ] 15.4.7 Add "Recommendations:" subheading
- [ ] 15.4.8 Add bullet: "For large PDFs: Use async processing"
- [ ] 15.4.9 Add bullet: "Optimization: Embed font once, reuse"

### 15.5 Video Watermarking
- [ ] 15.5.1 Locate watermarkVideo function
- [ ] 15.5.2 Add "⏱️ Performance Notes:" comment block
- [ ] 15.5.3 Add bullet: "1min 1080p: ~5-10s on M1 Pro"
- [ ] 15.5.4 Add bullet: "10min 1080p: ~60-90s on M1 Pro"
- [ ] 15.5.5 Add bullet: "Scaling: O(duration × resolution)"
- [ ] 15.5.6 Add bullet: "CPU-bound: Doesn't benefit from GPU acceleration (basic ffmpeg)"
- [ ] 15.5.7 Add "⚠️ System Requirements:" subheading
- [ ] 15.5.8 Add "Installation:" subheading
- [ ] 15.5.9 Add bullet: "macOS: brew install ffmpeg"
- [ ] 15.5.10 Add bullet: "Ubuntu: sudo apt install ffmpeg"
- [ ] 15.5.11 Add bullet: "Windows: choco install ffmpeg"
- [ ] 15.5.12 Add "Verification:" with `ffmpeg -version` command
- [ ] 15.5.13 Add "Size: ~500MB disk space" note
- [ ] 15.5.14 Add "If ffmpeg is not available, this will throw" note
- [ ] 15.5.15 Add "Recommendations:" subheading
- [ ] 15.5.16 Add bullet: "For production: Dedicated watermarking service"
- [ ] 15.5.17 Add bullet: "For long videos: Process on upload, not on-demand"
- [ ] 15.5.18 Add bullet: "For high volume: Hardware acceleration (NVENC, QuickSync)"

## 16. Review and Validate

- [ ] 16.1 Verify section 1 "Quick Start" is present
- [ ] 16.2 Verify section 5 "⚠️ Limitations" is present
- [ ] 16.3 Verify section 6 "Failure Mode Handling" is present
- [ ] 16.4 Verify section 9 "🔗 Integration with OAuth 2.0" is present
- [ ] 16.5 Verify section 11 "📊 Operations & Monitoring" is present
- [ ] 16.6 Verify section 12 "🧪 Testing Strategy" is present
- [ ] 16.7 Verify section 13 "🎯 Decision Guide" is present
- [ ] 16.8 Count total lines in file (target ~1,200, allow ±10% variance)
- [ ] 16.9 Verify security notice is at very top with ⚠️ emoji
- [ ] 16.10 Verify table of contents has all 15 sections
- [ ] 16.11 Verify TOC has visual indicators (⚠️ 🔗 📊 🧪 🎯)
- [ ] 16.12 Spot-check 5 random code blocks for try-catch presence
- [ ] 16.13 Verify all performance benchmarks specify "on M1 Pro"
- [ ] 16.14 Verify decision tree ASCII diagram renders correctly
- [ ] 16.15 Verify OAuth section has Auth0 and Okta examples
- [ ] 16.16 Verify testing section has pytest, Locust, and CI/CD
- [ ] 16.17 Check markdown formatting consistency (heading levels, spacing)
- [ ] 16.18 Verify all code blocks have language specified (```javascript, ```python, etc.)
- [ ] 16.19 Cross-check with specs/hotlinking-limitations/spec.md - all requirements present
- [ ] 16.20 Cross-check with specs/failure-mode-handling/spec.md - all requirements present
- [ ] 16.21 Cross-check with specs/oauth-integration/spec.md - all requirements present
- [ ] 16.22 Cross-check with specs/operations-guide/spec.md - all requirements present
- [ ] 16.23 Cross-check with specs/testing-strategy/spec.md - all requirements present
- [ ] 16.24 Cross-check with specs/decision-support/spec.md - all requirements present

## 17. Documentation Updates

- [ ] 17.1 Read skills/anti-hotlink/README.md
- [ ] 17.2 Update line count from ~345 to ~1,200
- [ ] 17.3 Add list of new sections under "Features" section
- [ ] 17.4 Add "⚠️ Limitations" to feature list
- [ ] 17.5 Add "🛡️ Failure Mode Handling" to feature list
- [ ] 17.6 Add "🔗 OAuth 2.0 Integration" to feature list
- [ ] 17.7 Add "📊 Operations & Monitoring" to feature list
- [ ] 17.8 Add "🧪 Testing Strategy" to feature list
- [ ] 17.9 Add "🎯 Decision Guide" to feature list
- [ ] 17.10 Verify hotlink-warning.html is unchanged (per design decision)

## 18. Final Verification

- [ ] 18.1 Read entire SKILL.md from start to finish
- [ ] 18.2 Check document flow and logical progression
- [ ] 18.3 Verify Quick Start leads naturally to detailed sections
- [ ] 18.4 Verify decision tree references are accurate
- [ ] 18.5 Test decision tree: follow each branch to correct section
- [ ] 18.6 Verify JavaScript code is syntactically correct (brackets, semicolons)
- [ ] 18.7 Verify Python code is syntactically correct (indentation, colons)
- [ ] 18.8 Verify Bash commands are correct (flags, paths)
- [ ] 18.9 Verify YAML is valid (indentation, colons, dashes)
- [ ] 18.10 Verify all tables have correct markdown format
- [ ] 18.11 Verify all ASCII diagrams align correctly in monospace
- [ ] 18.12 Check that P1 (critical) requirements are all addressed
- [ ] 18.13 Check that P2 (important) requirements are all addressed
- [ ] 18.14 Confirm single monolithic SKILL.md file (not split)
- [ ] 18.15 Verify illustrative code style (not production-ready)
- [ ] 18.16 Verify code has try-catch but not full error handling
- [ ] 18.17 Final sanity check: comprehensive but not overwhelming
- [ ] 18.18 Final sanity check: user can navigate quickly via TOC
- [ ] 18.19 Final sanity check: code examples are copy-pasteable
