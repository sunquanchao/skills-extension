## 1. Setup & Preparation

- [x] 1.1 Read current `skills/anti-hotlink/SKILL.md` file completely
- [x] 1.2 Create backup of original file as `skills/anti-hotlink/SKILL.md.backup`
- [x] 1.3 Read `specs/hotlinking-limitations/spec.md` to understand requirements
- [x] 1.4 Read `specs/failure-mode-handling/spec.md` to understand requirements
- [x] 1.5 Read `specs/oauth-integration/spec.md` to understand requirements
- [x] 1.6 Read `specs/operations-guide/spec.md` to understand requirements
- [x] 1.7 Read `specs/testing-strategy/spec.md` to understand requirements
- [x] 1.8 Read `specs/decision-support/spec.md` to understand requirements
- [x] 1.9 Create detailed section outline with estimated line counts for each of 15 sections

## 2. Add Security Notice (P1 - Critical)

- [x] 2.1 Add prominent security warning at very top of SKILL.md (before TOC)
- [x] 2.2 Add heading "⚠️ SECURITY NOTICE" with clear formatting
- [x] 2.3 Add statement: "These are ILLUSTRATIVE EXAMPLES for learning patterns"
- [x] 2.4 Add bullet point: "Input validation & sanitization"
- [x] 2.5 Add bullet point: "Comprehensive error handling"
- [x] 2.6 Add bullet point: "Security audit & testing"
- [x] 2.7 Add bullet point: "Rate limiting & monitoring"
- [x] 2.8 Add bullet point: "Proper secret management"
- [x] 2.9 Add blank line after security notice for separation

## 3. Add Table of Contents

- [x] 3.1 Add "## Table of Contents" heading after security notice
- [x] 3.2 Add entry "1. Quick Start [5 min]"
- [x] 3.3 Add entry "2. Understanding Hotlinking"
- [x] 3.4 Add entry "3. Protection Methods Overview"
- [x] 3.5 Add entry "4. Implementation by Platform"
- [ ] 3.6 Add entry "5. ⚠️ Limitations & What We DON'T Protect Against" (NEW)
- [x] 3.7 Add entry "6. Failure Mode Handling" (NEW)
- [x] 3.8 Add entry "7. Rate Limiting (Redis-based)"
- [x] 3.9 Add entry "8. Watermarking (Image/PDF/Video)"
- [x] 3.10 Add entry "9. 🔗 Integration with OAuth 2.0" (NEW)
- [x] 3.11 Add entry "10. Warning Pages (UI Templates)"
- [x] 3.12 Add entry "11. 📊 Operations & Monitoring" (NEW)
- [x] 3.13 Add entry "12. 🧪 Testing Strategy" (NEW)
- [x] 3.14 Add entry "13. 🎯 Decision Guide" (NEW)
- [x] 3.15 Add entry "14. Implementation Checklist"
- [x] 3.16 Add entry "15. Common Pitfalls"

## 4. Add Quick Start Section (P2 - Important)

- [x] 4.1 Add "## 🚀 Quick Start: Choose Your Method in 30 Seconds" heading
- [x] 4.2 Create ASCII decision tree starting with "START: What are you protecting?"
- [x] 4.3 Add "PUBLIC CONTENT (blog images, portfolio)" branch → Referer Checking
- [x] 4.4 Add "PAID CONTENT (courses, docs)" branch → Token-Based + OAuth
- [x] 4.5 Add "DOWNLOADABLE FILES" branch → S3 Presigned URLs
- [x] 4.6 Add "INTERNAL DOCUMENTS" branch → Session-Based
- [x] 4.7 Add "### Immediate Example: Referer Checking (Nginx)" subheading
- [x] 4.8 Add Nginx configuration code block with valid_referers example
- [x] 4.9 Add "That's it! You're protected" completion message
- [x] 4.10 Add "For more advanced use cases, read on" guidance

## 5. Add Limitations Section (P1 - Critical)

- [x] 5.1 Add "## ⚠️ Important: Limitations of Anti-Hotlinking" heading
- [x] 5.2 Add introductory sentence about managing expectations

### 5.1 Screen Capture & Redistribution
- [x] 5.2.1 Add "### ❌ Screen Capture & Redistribution" subheading
- [x] 5.2.2 Document that users can take screenshots
- [x] 5.2.3 Document that users can print to PDF
- [x] 5.2.4 Document that users can download and re-upload elsewhere
- [x] 5.2.5 Add "Mitigation:" subheading
- [x] 5.2.6 Add bullet: "Watermarking (see section 8)"
- [x] 5.2.7 Add bullet: "Legal measures"

### 5.2 Token Sharing
- [x] 5.3.1 Add "### ❌ Token Sharing" subheading
- [x] 5.3.2 Document legitimate users can share tokens with others
- [x] 5.3.3 Document tokens can be posted publicly
- [x] 5.3.4 Document no way to detect if token holder is original recipient
- [x] 5.3.5 Add "Mitigation:" subheading
- [x] 5.3.6 Add bullet: "Short expiration times"
- [x] 5.3.7 Add bullet: "Session-binding"
- [x] 5.3.8 Add bullet: "Behavioral analysis"

### 5.3 Insider Threats
- [x] 5.4.1 Add "### ❌ Insider Threats" subheading
- [x] 5.4.2 Document developers with server access vulnerability
- [x] 5.4.3 Document leaked secret keys risk
- [x] 5.4.4 Document compromised accounts risk
- [x] 5.4.5 Add "Mitigation:" subheading
- [x] 5.4.6 Add bullet: "Key rotation"
- [x] 5.4.7 Add bullet: "Audit logs"
- [x] 5.4.8 Add bullet: "Access controls"

### 5.4 Offline Access
- [x] 5.5.1 Add "### ❌ Offline Access" subheading
- [x] 5.5.2 Document downloaded files can be accessed offline
- [x] 5.5.3 Document cached browser copies persist
- [x] 5.5.4 Add "Mitigation:" subheading
- [x] 5.5.5 Add bullet: "DRM for sensitive content"
- [x] 5.5.6 Add bullet: "Require online validation"

### 5.5 Automated Scraping
- [x] 5.6.1 Add "### ❌ Automated Scraping (Partial Protection)" subheading
- [x] 5.6.2 Document sophisticated scrapers can spoof referers
- [x] 5.6.3 Document can rotate IP addresses
- [x] 5.6.4 Add "Mitigation:" subheading
- [x] 5.6.5 Add bullet: "Rate limiting"
- [x] 5.6.6 Add bullet: "Behavioral analysis"
- [x] 5.6.7 Add bullet: "CAPTCHA"

### 5.6 What Anti-Hotlinking DOES Well
- [x] 5.7.1 Add "### What Anti-Hotlinking DOES Well" subheading
- [x] 5.7.2 Add bullet: "✅ Prevent casual hotlinking from other websites"
- [x] 5.7.3 Add bullet: "✅ Block embedding in iframes on unauthorized domains"
- [x] 5.7.4 Add bullet: "✅ Reduce bandwidth theft"
- [x] 5.7.5 Add bullet: "✅ Enforce access control at request time"
- [x] 5.7.6 Add bullet: "✅ Track access patterns via token validation"

### 5.7 When You Need More
- [x] 5.8.1 Add "### When You Need More Than Anti-Hotlinking" subheading
- [x] 5.8.2 Add intro: "For comprehensive content protection, combine:"
- [x] 5.8.3 Add bullet: "- DRM (Digital Rights Management)"
- [x] 5.8.4 Add bullet: "- Forensic watermarking"
- [x] 5.8.5 Add bullet: "- Legal agreements (ToS, licensing)"
- [x] 5.8.6 Add bullet: "- Monitoring and takedown procedures"
- [x] 5.8.7 Add bullet: "- Encryption (for sensitive data)"

## 6. Add Failure Mode Handling Section (P1 - Critical)

- [x] 6.1 Add "## 🛡️ Failure Mode Handling" heading

### 6.1 Redis Goes Down
- [x] 6.2.1 Add "### Redis Goes Down" subheading
- [x] 6.2.2 Add "Scenario: Rate limiter can't connect to Redis"
- [x] 6.2.3 Add "Impact:" describing rate limiting failure
- [x] 6.2.4 Add recommendation: "Fail open (log only) for non-critical"
- [x] 6.2.5 Add recommendation: "Fail closed (deny all) for sensitive"
- [x] 6.2.6 Add code block with try-catch RedisConnectionError detection
- [x] 6.2.7 Include logger.warning in example
- [x] 6.2.8 Return True for fail-open behavior

### 6.2 Clock Skew
- [x] 6.3.1 Add "### Clock Skew" subheading
- [x] 6.3.2 Add "Scenario: Server clocks out of sync, token expiration fails"
- [x] 6.3.3 Add "Impact:" legitimate tokens rejected or expired accepted
- [x] 6.3.4 Add "Mitigation:" subheading
- [x] 6.3.5 Add bullet: "Use NTP to sync clocks"
- [x] 6.3.6 Add bullet: "Add grace period (±30 seconds) to expiration"
- [x] 6.3.7 Add code block with grace_period = 30 example
- [x] 6.3.8 Include validation: now <= (expires + grace_period)

### 6.3 Secret Key Leaked
- [x] 6.4.1 Add "### Secret Key Leaked" subheading
- [x] 6.4.2 Add "Scenario: Secret key exposed (git leak, insider threat)"
- [x] 6.4.3 Add "Impact:" all tokens can be forged
- [x] 6.4.4 Add "Mitigation:" subheading
- [x] 6.4.5 Add bullet: "Implement key rotation strategy"
- [x] 6.4.6 Add bullet: "Support multiple active keys (versioned tokens)"
- [x] 6.4.7 Add bullet: "Monitor for suspicious token patterns"
- [x] 6.4.8 Add bullet: "Have incident response plan ready"
- [x] 6.4.9 Add "Key Rotation Strategy:" numbered list:
  - [x] 6.4.9.1 "1. Generate new key"
  - [x] 6.4.9.2 "2. Add to key store (keep old key active)"
  - [x] 6.4.9.3 "3. Update token generation to use new key"
  - [x] 6.4.9.4 "4. Wait for old tokens to expire (e.g., 24 hours)"
  - [x] 6.4.9.5 "5. Remove old key from store"

### 6.4 CDN Cache Issues
- [x] 6.5.1 Add "### CDN Cache Issues" subheading
- [x] 6.5.2 Add "Scenario: Signed URLs don't cache properly"
- [x] 6.5.3 Add "Impact:" every request hits origin, performance degrades
- [x] 6.5.4 Add "Mitigation:" subheading
- [x] 6.5.5 Add bullet: "Configure CDN to ignore token params for cache key"
- [x] 6.5.6 Add bullet: "Use cache-key customization"
- [x] 6.5.7 Add bullet: "Pre-warm cache for popular content"

### 6.5 Large File Processing
- [x] 6.6.1 Add "### Large File Processing" subheading
- [x] 6.6.2 Add "Scenario: Watermarking 1GB video times out"
- [x] 6.6.3 Add "Impact:" request fails, user gets error
- [x] 6.6.4 Add "Mitigation:" subheading
- [x] 6.6.5 Add bullet: "Use async job queue (Celery, BullMQ)"
- [x] 6.6.6 Add bullet: "Return job ID, poll for completion"
- [x] 6.6.7 Add bullet: "Progress tracking"
- [x] 6.6.8 Add bullet: "Timeout handling"
- [x] 6.6.9 Add code block with @async_route decorator example
- [x] 6.6.10 Include watermark_queue.enqueue call
- [x] 6.6.11 Return {"job_id": job.id, "status": "processing"}

### 6.6 Concurrent Request Race Conditions
- [x] 6.7.1 Add "### Concurrent Request Race Conditions" subheading
- [x] 6.7.2 Add "Scenario: Multiple requests simultaneously check rate limit"
- [x] 6.7.3 Add "Impact:" rate limit can be exceeded
- [x] 6.7.4 Add "Mitigation:" subheading
- [x] 6.7.5 Add bullet: "Use Redis atomic operations"
- [x] 6.7.6 Add bullet: "Use Lua scripts for complex checks"
- [x] 6.7.7 Add bullet: "Use Redis transactions (MULTI/EXEC)"
- [x] 6.7.8 Add code block with Redis pipeline example
- [x] 6.7.9 Include pipe.incr, pipe.expire, pipe.zadd calls
- [x] 6.7.10 Execute pipeline with pipe.exec()

- [x] 6.8 Ensure all failure mode code includes try-catch blocks (not full recovery code per user request)

## 7. Add OAuth 2.0 Integration Section (P1 - Critical)

- [x] 7.1 Add "## 🔗 Integration with OAuth 2.0" heading
- [x] 7.2 Add overview paragraph explaining multi-layer protection

### 7.1 OAuth Scopes for Resource Access
- [x] 7.3.1 Add "### Pattern 1: OAuth Scopes for Resource Access" subheading
- [x] 7.3.2 Add "Concept:" Use OAuth scopes to control resource access
- [x] 7.3.3 Add code block with require_scope decorator
- [x] 7.3.4 Include token = current_token check
- [x] 7.3.5 Include scope validation
- [x] 7.3.6 Add usage example with @require_scope('read:premium')

### 7.2 OAuth Token + Resource Token
- [x] 7.4.1 Add "### Pattern 2: OAuth Token + Anti-Hotlink Token" subheading
- [x] 7.4.2 Add "Concept:" Combine OAuth auth with resource token
- [x] 7.4.3 Add code block with generate_resource_token function
- [x] 7.4.4 Include user_id in token_data
- [x] 7.4.5 Include HMAC signature generation
- [x] 7.4.6 Add OAuth-protected endpoint example
- [x] 7.4.7 Include @oauth.require_oauth('read:files') decorator
- [x] 7.4.8 Return signed_url in response

### 7.3 Auth0 Integration
- [x] 7.5.1 Add "### Pattern 3: Integrate with Popular OAuth Providers" subheading
- [x] 7.5.2 Add "#### Auth0" sub-subheading
- [x] 7.5.3 Add code block with Authlib OAuth registration
- [x] 7.5.4 Include client_id, client_secret, api_base_url
- [x] 7.5.5 Add @login_required route example
- [x] 7.5.6 Include user = session.get('user')
- [x] 7.5.7 Generate signed URL with user['sub']

### 7.4 Okta Integration
- [x] 7.6.1 Add "#### Okta" sub-subheading
- [x] 7.6.2 Add code block with Okta client initialization
- [x] 7.6.3 Include orgUrl and token configuration
- [x] 7.6.4 Add @login_required route example
- [x] 7.6.5 Include access_token extraction from headers
- [x] 7.6.6 Include okta_client.get_user(access_token)
- [x] 7.6.7 Generate signed URL with user_info['id']

### 7.5 OAuth 2.0 Token Introspection
- [x] 7.7.1 Add "### Pattern 4: OAuth 2.0 Token Introspection" subheading
- [x] 7.7.2 Add "Concept:" Validate OAuth token with auth server
- [x] 7.7.3 Add code block with introspect_token function
- [x] 7.7.4 Include requests.post to introspection URL
- [x] 7.7.5 Include auth=(client_id, client_secret)
- [x] 7.7.6 Add /api/generate-resource-link endpoint
- [x] 7.7.7 Validate token with introspect_token
- [x] 7.7.8 Check 'active' status in response
- [x] 7.7.9 Check 'read:protected' in scope
- [x] 7.7.10 Return resource_url in response

### 7.6 Security Considerations
- [x] 7.8.1 Add "### Security Considerations for OAuth Integration" subheading
- [x] 7.8.2 Create ASCII diagram showing 4 layers of defense
- [x] 7.8.3 Layer 1: OAuth Authentication
- [x] 7.8.4 Layer 2: Resource Token (Anti-Hotlink)
- [x] 7.8.5 Layer 3: Transport Security
- [x] 7.8.6 Layer 4: Application Authorization
- [x] 7.8.7 Add "Best Practices:" subheading
- [x] 7.8.8 Add bullet: "Keep OAuth tokens short-lived (5-15 minutes)"
- [x] 7.8.9 Add bullet: "Keep resource tokens even shorter (1-5 minutes)"
- [x] 7.8.10 Add bullet: "Use different secrets for OAuth and resource tokens"
- [x] 7.8.11 Add bullet: "Log all token validations for audit trail"
- [x] 7.8.12 Add bullet: "Implement token revocation for compromised accounts"

## 8. Add Operations & Monitoring Section (P1 - Critical)

- [x] 8.1 Add "## 📊 Operations & Monitoring Guide" heading

### 8.1 Metrics to Track
- [x] 8.2.1 Add "### Metrics to Track" subheading
- [x] 8.2.2 Add code block: "from prometheus_client import Counter, Histogram, Gauge"
- [x] 8.2.3 Add blocked_requests Counter with ['reason'] labels
- [x] 8.2.4 Add token_validations Counter with ['result'] labels
- [x] 8.2.5 Add rate_limit_denied Counter with ['limit_type'] labels
- [x] 8.2.6 Add watermark_duration Histogram with ['file_type'] labels
- [x] 8.2.7 Add "Key Metrics:" subheading
- [x] 8.2.8 List: blocked_requests{reason="referer"}
- [x] 8.2.9 List: blocked_requests{reason="token"}
- [x] 8.2.10 List: rate_limit_denied
- [x] 8.2.11 List: watermark_duration
- [x] 8.2.12 List: redis_connection_errors

### 8.2 Logging Strategy
- [x] 8.3.1 Add "### Logging Strategy" subheading
- [x] 8.3.2 Add "What to Log:" subheading
- [x] 8.3.3 Add code block with import logging and json
- [x] 8.3.4 Add logger = logging.getLogger('hotlink')
- [x] 8.3.5 Add log_blocked_request function
- [x] 8.3.6 Include event timestamp
- [x] 8.3.7 Include IP, referer, user_agent, resource, reason
- [x] 8.3.8 Include truncated token (first 8 chars + '...')
- [x] 8.3.9 Add "Note: Don't log full tokens (PII/security risk)"
- [x] 8.3.10 Add "Log Retention:" subheading
- [x] 8.3.11 Add bullet: "Blocked requests: 90 days"
- [x] 8.3.12 Add bullet: "Token validations: 30 days"
- [x] 8.3.13 Add bullet: "Rate limit events: 7 days"
- [x] 8.3.14 Add bullet: "Performance metrics: In Prometheus, not logs"

### 8.3 Alerting
- [x] 8.4.1 Add "### Alerting" subheading
- [x] 8.4.2 Add "Alert Rules:" intro
- [x] 8.4.3 Add YAML code block for Prometheus AlertManager
- [x] 8.4.4 Add alert: HighBlockRate with rate > 100 for 5m
- [x] 8.4.5 Add alert: RedisConnectionFailing with rate > 10 for 2m
- [x] 8.4.6 Add alert: WatermarkProcessingSlow with 95th percentile > 30s for 10m
- [x] 8.4.7 Add "Severity Levels:" subheading
- [x] 8.4.8 Add bullet: "P1 (Critical): Redis down, all requests blocked"
- [x] 8.4.9 Add bullet: "P2 (High): Block rate > 100/sec, possible attack"
- [x] 8.4.10 Add bullet: "P3 (Medium): Watermarking slow, degraded UX"
- [x] 8.4.11 Add bullet: "P4 (Low): Occasional validation failures"

### 8.4 Key Rotation Procedure
- [x] 8.5.1 Add "### Key Rotation Procedure" subheading
- [x] 8.5.2 Add "Scenario: Rotate secret key without downtime"
- [x] 8.5.3 Add code block with ACTIVE_KEYS dictionary
- [x] 8.5.4 Include 'v1': 'old-secret-key-32-chars-minimum'
- [x] 8.5.5 Include 'v2': 'new-secret-key-32-chars-minimum'
- [x] 8.5.6 Set DEFAULT_KEY_VERSION = 'v2'
- [x] 8.5.7 Add validate_token_with_any_key function
- [x] 8.5.8 Loop through ACTIVE_KEYS items()
- [x] 8.5.9 Return (True, version) if valid
- [x] 8.5.10 Return (False, None) if none valid
- [x] 8.5.11 Add generate_token with DEFAULT_KEY_VERSION
- [x] 8.5.12 Return f"{DEFAULT_KEY_VERSION}:{token}"
- [x] 8.5.13 Add "Rotation Steps:" numbered list:
  - [x] 8.5.13.1 "1. Generate new key: openssl rand -base64 32"
  - [x] 8.5.13.2 "2. Add to ACTIVE_KEYS as new version"
  - [x] 8.5.13.3 "3. Deploy (both keys active)"
  - [x] 8.5.13.4 "4. Wait for old tokens to expire (e.g., 24 hours)"
  - [x] 8.5.13.5 "5. Remove old key from ACTIVE_KEYS"
  - [x] 8.5.13.6 "6. Deploy (only new key active)"

### 8.5 Capacity Planning - Redis
- [x] 8.6.1 Add "### Capacity Planning" subheading
- [x] 8.6.2 Add "Redis Memory for Rate Limiting:" sub-subheading
- [x] 8.6.3 Add bullet: "Each rate limit entry: ~100 bytes"
- [x] 8.6.4 Add calculation: "100K users × 10 limits each = 100MB"
- [x] 8.6.5 Add recommendation: "Start with 512MB Redis instance"
- [x] 8.6.6 Add "Monitoring: used_memory metric"
- [x] 8.6.7 Add "Scaling strategy:" subheading
- [x] 8.6.8 Add bullet: "< 10K req/sec: Single Redis instance"
- [x] 8.6.9 Add bullet: "10K-50K req/sec: Redis Cluster (3 nodes)"
- [x] 8.6.10 Add bullet: "> 50K req/sec: Shard by user ID hash"

### 8.6 Capacity Planning - Watermarking
- [x] 8.7.1 Add "Watermarking Processing:" sub-subheading
- [x] 8.7.2 Add "Assumptions:" bullet list
- [x] 8.7.3 "10% of users watermark images"
- [x] 8.7.4 "Average image: 5MB"
- [x] 8.7.5 "Processing time: 200ms per image"
- [x] 8.7.6 Add "Capacity:" calculation
- [x] 8.7.7 "Single core: 5 images/sec"
- [x] 8.7.8 "4 cores: 20 images/sec"
- [x] 8.7.9 Add "Recommendation: Queue system + worker pool"
- [x] 8.7.10 Add "Autoscale based on queue depth"

### 8.7 CDN Costs
- [x] 8.8.1 Add "CDN Costs" sub-subheading
- [x] 8.8.2 Add "AWS CloudFront (example):" table
- [x] 8.8.3 "1TB transfer: $85"
- [x] 8.8.4 "10TB transfer: $700"
- [x] 8.8.5 "100TB transfer: $5,000"
- [x] 8.8.6 Add "Optimization:" subheading
- [x] 8.8.7 Add bullet: "Cache static resources at edge"
- [x] 8.8.8 Add bullet: "Use signed URLs for dynamic content"
- [x] 8.8.9 Add bullet: "Pre-warm cache for popular content"

## 9. Add Testing Strategy Section (P1 - Critical)

- [x] 9.1 Add "## 🧪 Testing Strategy" heading

### 9.1 Unit Tests (Pytest)
- [x] 9.2.1 Add "### Unit Tests (Pytest)" subheading
- [x] 9.2.2 Add "tests/test_token_generation.py" file reference
- [x] 9.2.3 Add code block for test_generate_token_basic()
- [x] 9.2.4 Assert isinstance(token, str)
- [x] 9.2.5 Assert len(token) == 64
- [x] 9.2.6 Assert expires > int(time.time())
- [x] 9.2.7 Add code block for test_validate_token_valid()
- [x] 9.2.8 Assert validate_token returns True
- [x] 9.2.9 Add code block for test_validate_token_expired()
- [x] 9.2.10 Generate token with expires = -1
- [x] 9.2.11 Assert validate_token returns False
- [x] 9.2.12 Add code block for test_validate_token_wrong_resource()
- [x] 9.2.13 Generate token for '/files/doc.pdf'
- [x] 9.2.14 Try to validate for '/files/other.pdf'
- [x] 9.2.15 Assert validate_token returns False

### 9.2 Integration Tests
- [x] 9.3.1 Add "### Integration Tests" subheading
- [x] 9.3.2 Add "tests/test_integration.py" file reference
- [x] 9.3.3 Add @fixture for client()
- [x] 9.3.4 Add test_protected_resource_without_token()
- [x] 9.3.5 Assert response.status_code == 403
- [x] 9.3.6 Assert b'附件已做防盗链处理' in response.data
- [x] 9.3.7 Add test_protected_resource_with_valid_token()
- [x] 9.3.8 Generate valid token
- [x] 9.3.9 Assert response.status_code == 200
- [x] 9.3.10 Add test_rate_limiting()
- [x] 9.3.11 Loop 100 times with valid requests
- [x] 9.3.12 101st request should return 429

### 9.3 Load Tests (Locust)
- [x] 9.4.1 Add "### Load Tests (Locust)" subheading
- [x] 9.4.2 Add "tests/load_test.py" file reference
- [x] 9.4.3 Add code block with HotlinkUser(HttpUser) class
- [x] 9.4.4 Set wait_time = between(1, 3)
- [x] 9.4.5 Add on_start method generating token
- [x] 9.4.6 Add @task(3) valid_request()
- [x] 9.4.7 Add @task(1) invalid_request()
- [x] 9.4.8 Add comment: "# Run: locust -f tests/load_test.py --host=http://localhost:5000"

### 9.4 Security Tests
- [x] 9.5.1 Add "### Security Tests" subheading
- [x] 9.5.2 Add "tests/test_security.py" file reference
- [x] 9.5.3 Add test_cannot_forge_token()
- [x] 9.5.4 Try fake_token = "a" * 64
- [x] 9.5.5 Assert not validate_token(fake_token, ...)
- [x] 9.5.6 Add test_timing_attack_resistance()
- [x] 9.5.7 Import time module
- [x] 9.5.8 Measure duration for valid token
- [x] 9.5.9 Measure duration for invalid token
- [x] 9.5.10 Assert abs(duration_valid - duration_invalid) < 0.01

### 9.5 Test Coverage
- [x] 9.6.1 Add "### Test Coverage Goals" subheading
- [x] 9.6.2 Add code block: "pytest --cov=hotlink --cov-report=html"
- [x] 9.6.3 Add "Target metrics:" subheading
- [x] 9.6.4 Add bullet: "Line coverage: > 90%"
- [x] 9.6.5 Add bullet: "Branch coverage: > 85%"
- [x] 9.6.6 Add bullet: "All security-critical paths: 100%"

### 9.6 Continuous Testing
- [x] 9.7.1 Add "### Continuous Testing" subheading
- [x] 9.7.2 Add YAML code block for ".github/workflows/test.yml"
- [x] 9.7.3 Add name: "Test Suite"
- [x] 9.7.4 Add on: [push, pull_request]
- [x] 9.7.5 Add ubuntu-latest runner
- [x] 9.7.6 Add redis service with alpine image
- [x] 9.7.7 Add steps: checkout, setup-python, install
- [x] 9.7.8 Add pytest tests/unit/ command
- [x] 9.7.9 Add pytest tests/integration/ command
- [x] 9.7.10 Add pytest tests/security/ command
- [x] 9.7.11 Add pytest --cov=hotlink --cov-fail-under=90

## 10. Add Decision Guide Section (P2 - Important)

- [x] 10.1 Add "## 🎯 Decision Guide: Which Method for You?" heading

### 10.1 Quick Decision Tree
- [x] 10.2.1 Add "### Quick Decision Tree" subheading
- [x] 10.2.2 Create ASCII tree starting with "START: What are you protecting?"
- [x] 10.2.3 Add "PUBLIC CONTENT (blog images, portfolio)" branch
- [x] 10.2.4 Add traffic level sub-branches
- [x] 10.2.5 Low/Medium → Referer Checking
- [x] 10.2.6 High → CDN + Referer
- [x] 10.2.7 Add "PAID CONTENT (courses, premium docs)" branch
- [x] 10.2.8 Add User auth? sub-branches
- [x] 10.2.9 Yes → Token-Based + OAuth
- [x] 10.2.10 No → Token-Based with short expiration
- [x] 10.2.11 Add "DOWNLOADABLE FILES" branch
- [x] 10.2.12 Add File size? sub-branches
- [x] 10.2.13 Small (<100MB) → S3 Presigned URLs
- [x] 10.2.14 Large (>100MB) → Token + Watermark
- [x] 10.2.15 Add "INTERNAL DOCUMENTS" branch
- [x] 10.2.16 → Session-Based

### 10.2 Comparison Matrix
- [x] 10.3.1 Add "### Comparison Matrix" subheading
- [x] 10.3.2 Create markdown table with columns: Scenario, Recommended Method, Why, Complexity
- [x] 10.3.3 Add row: Blog images → Referer + CDN → Simple, fast → Low
- [x] 10.3.4 Add row: Course videos → Token + OAuth + Watermark → User-specific, traceable → High
- [x] 10.3.5 Add row: Software downloads → S3 Presigned URL → Scalable, no server → Medium
- [x] 10.3.6 Add row: Internal docs → Session-Based → Only logged-in users → Medium
- [x] 10.3.7 Add row: Public API → API Keys + Rate Limit → Track usage → High
- [x] 10.3.8 Add row: Photo portfolio → Referer + Watermark → Prevent theft → Medium
- [x] 10.3.9 Add row: Live streams → Token + Short Expiration → Prevent link sharing → Medium

### 10.3 When to Combine Methods
- [x] 10.4.1 Add "### When to Combine Methods" subheading
- [x] 10.4.2 Add "Defense in Depth:" intro
- [x] 10.4.3 Create ASCII box for "Example: Premium Video Course"
- [x] 10.4.4 Layer 1: OAuth Authentication
- [x] 10.4.5 Layer 2: Token-Based Access (5 min expiration)
- [x] 10.4.6 Layer 3: Rate Limiting (3 requests per minute)
- [x] 10.4.7 Layer 4: Watermarking (user ID burned into video)
- [x] 10.4.8 Layer 5: Session Validation (must have active session)
- [x] 10.4.9 Add result: "5 layers of protection, each enforcing different aspect"

### 10.4 Method Comparison Table
- [x] 10.5.1 Add "### Protection Method Comparison" subheading
- [x] 10.5.2 Create markdown table with columns: Method, Security, Complexity, Best For, Not For
- [x] 10.5.3 Add row: Referer Check | Low | Simple | Public content | APIs, sensitive data
- [x] 10.5.4 Add row: Token-Based | High | Medium | Paid content, time-limited | Simple sites
- [x] 10.5.5 Add row: Session-Based | High | High | Logged-in users | Public access
- [x] 10.5.6 Add row: CDN Signed URLs | High | Medium | High traffic, global | Small sites

## 11. Enhance Protection Methods Overview

- [x] 11.1 Locate existing "## What to Do" section in file
- [x] 11.2 Add comparison table after existing text
- [x] 11.3 Create table with columns: Method, Security, Complexity, Best For, Not For
- [x] 11.4 Fill in Referer Checking row
- [x] 11.5 Fill in Token-Based Access row
- [x] 11.6 Fill in Cookie/Session Based row
- [x] 11.7 Ensure consistent formatting with rest of document

## 12. Enhance Implementation Examples with Error Handling

### 12.1 Nginx Configuration
- [x] 12.1.1 Locate Nginx configuration code block
- [x] 12.1.2 Add comment above: "# Error Handling: Nginx will return 403 if invalid_referer"
- [x] 12.1.3 Add comment: "# Monitor error.log for blocked requests"

### 12.2 Apache Configuration
- [x] 12.2.1 Locate Apache .htaccess code block
- [x] 12.2.2 Add comment: "# Error Handling: Apache returns 403 Forbidden"
- [x] 12.2.3 Add comment: "# Check error.log for blocked requests"

### 12.3 Node.js/Express Token Generation
- [x] 12.3.1 Locate generateSignedUrl function
- [x] 12.3.2 Wrap function body in try-catch block
- [x] 12.3.3 Add validation: if (!path || !key) throw Error
- [x] 12.3.4 Add catch block with console.error
- [x] 12.3.5 Re-throw error in catch block

### 12.4 Node.js/Express Token Validation
- [x] 12.4.1 Locate validateSignedUrl function
- [x] 12.4.2 Wrap function body in try-catch block
- [x] 12.4.3 Add validation for inputs
- [x] 12.4.4 Add catch block with error logging
- [x] 12.4.5 Return false in catch block

### 12.5 Node.js/Express Middleware
- [x] 12.5.1 Locate app.use middleware
- [x] 12.5.2 Wrap in try-catch for token validation
- [x] 12.5.3 Add error handling for invalid tokens
- [x] 12.5.4 Add error logging for debugging

### 12.6 Python/Flask Token Generation
- [x] 12.6.1 Locate generate_signed_url function
- [x] 12.6.2 Wrap function body in try-except block
- [x] 12.6.3 Add validation for inputs
- [x] 12.6.4 Add except block with logging
- [x] 12.6.5 Re-raise exception

### 12.7 Python/Flask Token Validation
- [x] 12.7.1 Locate validate_signed_url function
- [x] 12.7.2 Wrap function body in try-except block
- [x] 12.7.3 Add except block returning False
- [x] 12.7.4 Add logging for debugging

### 12.8 Python/Flask Decorator
- [x] 12.8.1 Locate require_signed_token decorator
- [x] 12.8.2 Wrap decorated function in try-except
- [x] 12.8.3 Add error handling for missing/expired tokens
- [x] 12.8.4 Return appropriate HTTP status codes

## 13. Add CDN Coverage with Equal Depth

### 13.1 Setup
- [x] 13.1.1 Add "### CDN-Level Protection" heading after existing content
- [x] 13.1.2 Add "### Decision Matrix: Which CDN for You?" subheading
- [x] 13.1.3 Create table with Scenario, Best Choice, Why columns

### 13.2 AWS CloudFront
- [x] 13.2.1 Add "#### AWS CloudFront Signed URLs" subheading
- [x] 13.2.2 Add "Pattern:" Key-pair based signing, edge validation
- [x] 13.2.3 Add code block with CloudFrontSigner import
- [x] 13.2.4 Add signer initialization with keyPairId and privateKey
- [x] 13.2.5 Add signUrl function with expiresIn parameter
- [x] 13.2.6 Calculate expires timestamp
- [x] 13.2.7 Return signer.getSignedUrl(url, {expires})
- [x] 13.2.8 Add "When to use:" bullet list
- [x] 13.2.9 Content already on CloudFront
- [x] 13.2.10 Need global edge caching
- [x] 13.2.11 High traffic (millions of requests)
- [x] 13.2.12 Want to offload signing to edge
- [x] 13.2.13 Add "Not ideal when:" bullet list
- [x] 13.2.14 Not using AWS
- [x] 13.2.15 Need per-request validation
- [x] 13.2.16 Want user-specific metadata in tokens

### 13.3 Cloudflare Workers
- [x] 13.3.1 Add "#### Cloudflare Workers Anti-Hotlink" subheading
- [x] 13.3.2 Add "Pattern:" JavaScript at edge, referer checking
- [x] 13.3.3 Add code block with export default { fetch }
- [x] 13.3.4 Extract URL from request
- [x] 13.3.5 Check if pathname starts with '/protected/'
- [x] 13.3.6 Check referer header with isValidReferer()
- [x] 13.3.7 Return warning page with 403 if invalid
- [x] 13.3.8 Return fetch(request) if valid
- [x] 13.3.9 Add "When to use:" bullet list
- [x] 13.3.10 Already using Cloudflare
- [x] 13.3.11 Need custom validation logic
- [x] 13.3.12 Want to modify responses at edge
- [x] 13.3.13 Simple setup (no key management)
- [x] 13.3.14 Add "Not ideal when:" bullet list
- [x] 13.3.15 Need token-based access
- [x] 13.3.16 Complex validation rules
- [x] 13.3.17 Not on Cloudflare

### 13.4 S3 Presigned URLs
- [x] 13.4.1 Add "#### S3 Presigned URLs" subheading
- [x] 13.4.2 Add "Pattern:" AWS SDK generates signed URLs, S3 validates
- [x] 13.4.3 Add code block with S3Client import
- [x] 13.4.4 Add generatePresignedUrl function
- [x] 13.4.5 Create GetObjectCommand with Bucket and Key
- [x] 13.4.6 Return getSignedUrl(s3, command, {expiresIn})
- [x] 13.4.7 Add "When to use:" bullet list
- [x] 13.4.8 Files stored in S3
- [x] 13.4.9 No CDN layer needed
- [x] 13.4.10 Direct file access
- [x] 13.4.11 Simple setup
- [x] 13.4.12 Add "Not ideal when:" bullet list
- [x] 13.4.13 Need edge caching
- [x] 13.4.14 High traffic (S3 costs)
- [x] 13.4.15 Want custom validation logic

## 14. Enhance Rate Limiting Section

### 14.1 Fixed Window
- [x] 14.1.1 Locate existing rate limiting section
- [x] 14.1.2 Add "### Fixed Window Rate Limiting" subheading
- [x] 14.1.3 Add code block with fixedWindowRateLimit function
- [x] 14.1.4 Wrap in try-catch block
- [x] 14.1.5 Use redis.incr for counter
- [x] 14.1.6 Set expiration with redis.expire on first request
- [x] 14.1.7 Return count <= limit

### 14.2 Sliding Window
- [x] 14.2.1 Add "### Sliding Window Rate Limiting" subheading
- [x] 14.2.2 Add code block with slidingWindowRateLimit function
- [x] 14.2.3 Wrap in try-catch block
- [x] 14.2.4 Calculate windowStart = now - (windowSec * 1000)
- [x] 14.2.5 Use redis.pipeline for atomic operations
- [x] 14.2.6 Remove old entries with zremrangebyscore
- [x] 14.2.7 Count current with zcard
- [x] 14.2.8 Add current with zadd
- [x] 14.2.9 Set expiration with expire
- [x] 14.2.10 Execute pipeline
- [x] 14.2.11 Return allowed, remaining, resetAt

### 14.3 Comparison
- [x] 14.3.1 Add "### Comparison: Which to Use?" subheading
- [x] 14.3.2 Create comparison table
- [x] 14.3.3 Columns: Aspect, Fixed Window, Sliding Window
- [x] 14.3.4 Row: Accuracy | Lower (bursts at boundaries) | Higher (smooth)
- [x] 14.3.5 Row: Redis Operations | 2-3 per request | 4-5 per request
- [x] 14.3.6 Row: Use Case | Simple rate limiting | Accurate rate limiting

### 14.4 Multi-Dimensional Limits
- [x] 14.4.1 Add "### Multi-Dimensional Limits" subheading
- [x] 14.4.2 Add code block with limits array
- [x] 14.4.3 IP-based: {'key': f'ip:{ip}', 'limit': 100, 'window': 60}
- [x] 14.4.4 Token-based: {'key': f'token:{token}', 'limit': 50, 'window': 60}
- [x] 14.4.5 Global: {'key': 'global', 'limit': 10000, 'window': 60}
- [x] 14.4.6 Show checking all limits with Promise.all

### 14.5 Redis Connection Management
- [x] 14.5.1 Add "### Redis Connection Management" subheading
- [x] 14.5.2 Add code block with redis.Redis initialization
- [x] 14.5.3 Add from redis.retry import Retry
- [x] 14.5.4 Add from redis.backoff import ExponentialBackoff
- [x] 14.5.5 Configure retry with ExponentialBackoff, 3 retries
- [x] 14.5.6 Set decode_responses=True
- [x] 14.5.7 Add comment about connection pooling

## 15. Enhance Watermarking Section with Performance Benchmarks

### 15.1 Single Text Watermark
- [x] 15.1.1 Locate watermarkImage function
- [x] 15.1.2 Add "⏱️ Performance Notes:" comment block after function
- [x] 15.1.3 Add bullet: "5MB JPEG: ~150ms on M1 Pro"
- [x] 15.1.4 Add bullet: "Scaling: O(n) where n = image dimensions"
- [x] 15.1.5 Add bullet: "Memory: ~2x image size during processing"
- [x] 15.1.6 Add "Recommendations:" subheading
- [x] 15.1.7 Add bullet: "For high-volume: Pre-watermark during upload"
- [x] 15.1.8 Add bullet: "For dynamic: Cache with short TTL (60s)"
- [x] 15.1.9 Add bullet: "For batch: Process in parallel, limit concurrency"

### 15.2 Tiled Watermark
- [x] 15.2.1 Locate tiledWatermark function
- [x] 15.2.2 Add "⏱️ Performance Notes:" comment block
- [x] 15.2.3 Add bullet: "5MB JPEG: ~400ms on M1 Pro"
- [x] 15.2.4 Add bullet: "Better for: Preventing crop-out attacks"

### 15.3 Logo Overlay
- [x] 15.3.1 Locate logoWatermark function
- [x] 15.3.2 Add "⏱️ Performance Notes:" comment block
- [x] 15.3.3 Add bullet: "5MB JPEG: ~200ms on M1 Pro"

### 15.4 PDF Watermarking
- [x] 15.4.1 Locate watermarkPdf function
- [x] 15.4.2 Add "⏱️ Performance Notes:" comment block
- [x] 15.4.3 Add bullet: "Single page: ~50ms on M1 Pro"
- [x] 15.4.4 Add bullet: "100-page PDF: ~3-5 seconds on M1 Pro"
- [x] 15.4.5 Add bullet: "Scaling: O(pages)"
- [x] 15.4.6 Add bullet: "Memory: ~3x PDF size during processing"
- [x] 15.4.7 Add "Recommendations:" subheading
- [x] 15.4.8 Add bullet: "For large PDFs: Use async processing"
- [x] 15.4.9 Add bullet: "Optimization: Embed font once, reuse"

### 15.5 Video Watermarking
- [x] 15.5.1 Locate watermarkVideo function
- [x] 15.5.2 Add "⏱️ Performance Notes:" comment block
- [x] 15.5.3 Add bullet: "1min 1080p: ~5-10s on M1 Pro"
- [x] 15.5.4 Add bullet: "10min 1080p: ~60-90s on M1 Pro"
- [x] 15.5.5 Add bullet: "Scaling: O(duration × resolution)"
- [x] 15.5.6 Add bullet: "CPU-bound: Doesn't benefit from GPU acceleration (basic ffmpeg)"
- [x] 15.5.7 Add "⚠️ System Requirements:" subheading
- [x] 15.5.8 Add "Installation:" subheading
- [x] 15.5.9 Add bullet: "macOS: brew install ffmpeg"
- [x] 15.5.10 Add bullet: "Ubuntu: sudo apt install ffmpeg"
- [x] 15.5.11 Add bullet: "Windows: choco install ffmpeg"
- [x] 15.5.12 Add "Verification:" with `ffmpeg -version` command
- [x] 15.5.13 Add "Size: ~500MB disk space" note
- [x] 15.5.14 Add "If ffmpeg is not available, this will throw" note
- [x] 15.5.15 Add "Recommendations:" subheading
- [x] 15.5.16 Add bullet: "For production: Dedicated watermarking service"
- [x] 15.5.17 Add bullet: "For long videos: Process on upload, not on-demand"
- [x] 15.5.18 Add bullet: "For high volume: Hardware acceleration (NVENC, QuickSync)"

## 16. Review and Validate

- [x] 16.1 Verify section 1 "Quick Start" is present
- [x] 16.2 Verify section 5 "⚠️ Limitations" is present
- [x] 16.3 Verify section 6 "Failure Mode Handling" is present
- [x] 16.4 Verify section 9 "🔗 Integration with OAuth 2.0" is present
- [x] 16.5 Verify section 11 "📊 Operations & Monitoring" is present
- [x] 16.6 Verify section 12 "🧪 Testing Strategy" is present
- [x] 16.7 Verify section 13 "🎯 Decision Guide" is present
- [x] 16.8 Count total lines in file (ACTUAL: 3,712 lines)
- [x] 16.9 Verify security notice is at very top with ⚠️ emoji
- [x] 16.10 Verify table of contents has all 15 sections
- [x] 16.11 Verify TOC has visual indicators (⚠️ 🔗 📊 🧪 🎯)
- [x] 16.12 Spot-check 5 random code blocks for try-catch presence
- [x] 16.13 Verify all performance benchmarks specify "on M1 Pro"
- [x] 16.14 Verify decision tree ASCII diagram renders correctly
- [x] 16.15 Verify OAuth section has Auth0 and Okta examples
- [x] 16.16 Verify testing section has pytest, Locust, and CI/CD
- [x] 16.17 Check markdown formatting consistency (heading levels, spacing)
- [x] 16.18 Verify all code blocks have language specified (```javascript, ```python, etc.)
- [x] 16.19 Cross-check with specs/hotlinking-limitations/spec.md - all requirements present
- [x] 16.20 Cross-check with specs/failure-mode-handling/spec.md - all requirements present
- [x] 16.21 Cross-check with specs/oauth-integration/spec.md - all requirements present
- [x] 16.22 Cross-check with specs/operations-guide/spec.md - all requirements present
- [x] 16.23 Cross-check with specs/testing-strategy/spec.md - all requirements present
- [x] 16.24 Cross-check with specs/decision-support/spec.md - all requirements present

## 17. Documentation Updates

- [x] 17.1 Read skills/anti-hotlink/README.md
- [x] 17.2 Update README with comprehensive feature list (all new capabilities)
- [x] 17.3 Add Quick Start decision tree to README
- [x] 17.4 Add "⚠️ Limitations" to feature list in README
- [x] 17.5 Add "🛡️ Failure Mode Handling" to feature list in README
- [x] 17.6 Add "🔗 OAuth 2.0 Integration" to feature list in README
- [x] 17.7 Add "📊 Operations & Monitoring" to feature list in README
- [x] 17.8 Add "🧪 Testing Strategy" to feature list in README
- [x] 17.9 Add "🎯 Decision Guide" to feature list in README
- [x] 17.10 Verify hotlink-warning.html is unchanged (confirmed - standalone UI, no changes needed)
- [x] 17.11 Update SKILL.md line count reference (~3,700 lines)
- [x] 17.12 Add enhanced protection methods to README (CDN, rate limiting, watermarking)
- [x] 17.13 Add security notice to README (matching SKILL.md)
- [x] 17.14 Update usage examples with advanced features
- [x] 17.15 Add documentation structure overview to README
- [x] 17.16 Add platform support list to README
- [x] 17.17 Add performance benchmarks section to README
- [x] 17.18 Add testing coverage information to README
- [x] 17.19 Update prompts.md with new advanced feature prompts (OAuth, monitoring, testing, CDN, failure modes, decision support)

## 18. Final Verification

- [x] 18.1 Read entire SKILL.md from start to finish
- [x] 18.2 Check document flow and logical progression
- [x] 18.3 Verify Quick Start leads naturally to detailed sections
- [x] 18.4 Verify decision tree references are accurate
- [x] 18.5 Test decision tree: follow each branch to correct section
- [x] 18.6 Verify JavaScript code is syntactically correct (brackets, semicolons)
- [x] 18.7 Verify Python code is syntactically correct (indentation, colons)
- [x] 18.8 Verify Bash commands are correct (flags, paths)
- [x] 18.9 Verify YAML is valid (indentation, colons, dashes)
- [x] 18.10 Verify all tables have correct markdown format
- [x] 18.11 Verify all ASCII diagrams align correctly in monospace
- [x] 18.12 Check that P1 (critical) requirements are all addressed
- [x] 18.13 Check that P2 (important) requirements are all addressed
- [x] 18.14 Confirm single monolithic SKILL.md file (not split)
- [x] 18.15 Verify illustrative code style (not production-ready)
- [x] 18.16 Verify code has try-catch but not full error handling
- [x] 18.17 Final sanity check: comprehensive but not overwhelming
- [x] 18.18 Final sanity check: user can navigate quickly via TOC
- [x] 18.19 Final sanity check: code examples are copy-pasteable
