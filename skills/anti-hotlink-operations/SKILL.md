---
name: anti-hotlink-operations
description: Triggers for operations (monitoring, testing, failure handling, common pitfalls, best practices)
license: MIT
metadata:
  author: Quanchao Sun
  version: "2.0"
---

# Anti-Hotlinking Operations & Monitoring

Production-ready guidance for operating, monitoring, testing, and troubleshooting anti-hotlinking systems.

## When to Use

Use this skill when:
- User asks about monitoring anti-hotlinking systems in production
- User needs testing strategies for anti-hotlinking implementations
- User wants to understand limitations and common pitfalls
- User is troubleshooting failure modes or operational issues
- User wants defense-in-depth recommendations

## What to Do

### 1. Monitor Key Metrics

Track these essential metrics for system health and attack detection:

```python
from prometheus_client import Counter, Histogram, Gauge
import time
import logging

# Counters track total events
blocked_requests = Counter(
    'anti_hotlink_blocked_requests_total',
    'Total blocked requests by reason',
    ['reason']  # Labels: invalid_token, expired, rate_limit, invalid_referer
)

token_validations = Counter(
    'anti_hotlink_token_validations_total',
    'Total token validation attempts',
    ['result']  # Labels: success, failure
)

rate_limit_denied = Counter(
    'anti_hotlink_rate_limit_denied_total',
    'Total requests denied due to rate limiting',
    ['user_id']
)

# Histograms track distributions
validation_duration = Histogram(
    'anti_hotlink_validation_duration_seconds',
    'Token validation duration',
    buckets=[0.001, 0.005, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1.0]
)

watermark_duration = Histogram(
    'anti_hotlink_watermark_duration_seconds',
    'Watermark processing duration',
    buckets=[0.1, 0.5, 1.0, 2.5, 5.0, 10.0, 30.0, 60.0]
)

# Gauges track current values
redis_health = Gauge(
    'anti_hotlink_redis_health',
    'Redis connection health (1=healthy, 0=unhealthy)'
)
```

**Key Metrics to Monitor:**
- **blocked_requests**: Spike indicates attack or misconfiguration
- **token_validations**: High failure rate suggests secret key leak or abuse
- **rate_limit_denied**: Trend reveals abusive users or bots
- **watermark_duration**: Increasing duration indicates performance issues
- **redis_errors**: Non-zero means Redis is failing

### 2. Implement Logging Strategy

Log blocked requests with essential context (never log full tokens):

```python
import logging
from datetime import datetime

logger = logging.getLogger('anti_hotlink')

def log_blocked_request(request, reason, token_preview=None):
    """
    Log blocked request with essential context.
    Note: Don't log full tokens (PII/security risk).
    """
    try:
        log_data = {
            'timestamp': datetime.utcnow().isoformat(),
            'ip': request.remote_addr,
            'referer': request.headers.get('Referer', 'none'),
            'user_agent': request.headers.get('User-Agent', 'none')[:100],
            'resource': request.path,
            'reason': reason,
            'token_preview': token_preview[:8] if token_preview else 'none'
        }
        logger.warning(f"Blocked request: {log_data}")
    except Exception as e:
        logger.error(f"Failed to log blocked request: {e}")
```

**Log Retention:**
- Security events (blocked requests): 90 days minimum
- Token validation logs: 30 days
- Operational logs (Redis health, performance): 7 days
- Watermark processing logs: 30 days

### 3. Set Up Alerting

Configure alerts for critical thresholds:

```yaml
# Prometheus AlertManager rules
groups:
  - name: anti_hotlink_alerts
    interval: 30s
    rules:
      - alert: HighBlockRate
        expr: rate(anti_hotlink_blocked_requests_total[5m]) > 100
        for: 5m
        labels:
          severity: P2
          team: security
        annotations:
          summary: "High rate of blocked requests"
          description: "Blocking {{ $value }} req/sec for 5 minutes"

      - alert: RedisDown
        expr: anti_hotlink_redis_health == 0
        for: 1m
        labels:
          severity: P1
          team: infra
        annotations:
          summary: "Redis connection failed"
          description: "Rate limiting is not working"

      - alert: SlowWatermarking
        expr: histogram_quantile(0.95, rate(anti_hotlink_watermark_duration_seconds_bucket[10m])) > 30
        for: 10m
        labels:
          severity: P3
          team: performance
        annotations:
          summary: "Watermarking is slow"
          description: "95th percentile latency is {{ $value }}s"
```

**Severity Levels:**
- **P1 Critical**: System down, data loss, security breach
- **P2 High**: Major functionality broken
- **P3 Medium**: Performance degraded
- **P4 Low**: Minor issues

### 4. Handle Failure Modes

#### Redis Goes Down

```python
import redis
from redis.exceptions import RedisConnectionError, RedisTimeoutError

def check_rate_limit(user_id, limit=100, window=60):
    try:
        key = f"rate_limit:{user_id}"
        current = redis_client.incr(key)
        if current == 1:
            redis_client.expire(key, window)
        return current <= limit
    except RedisConnectionError as e:
        logger.warning(f"Redis connection failed: {e}")
        return True  # Fail-open: allow request but log
    except RedisTimeoutError as e:
        logger.warning(f"Redis timeout: {e}")
        return True  # Fail-open
    except Exception as e:
        logger.error(f"Unexpected Redis error: {e}")
        return False  # Fail-closed: deny on unexpected errors
```

Choose fail-open (better UX, less secure) or fail-closed (more secure, worse UX) based on security requirements.

#### Clock Skew

```python
def validate_signed_url_with_grace(resource_path, token, expires, secret_key, grace_period=30):
    """
    Validate token with grace period to handle clock skew.
    """
    now = int(time.time())

    # Allow grace period for clock skew
    if now > (expires + grace_period):
        logger.warning(f"Token expired: now={now}, expires={expires}")
        return False

    # Check if token is from the future (clock skew)
    if now < (expires - 3600):
        logger.warning(f"Token timestamp in the future")
        return False

    expected = hmac.new(
        secret_key.encode(),
        f"{resource_path}:{expires}".encode(),
        hashlib.sha256
    ).hexdigest()
    return hmac.compare_digest(token, expected)
```

Use NTP for clock synchronization and implement grace periods.

#### Secret Key Leaked

Implement key rotation with versioned tokens:

```python
SECRET_KEYS = {
    'v1': 'old-secret-key-rotated',  # Still valid for grace period
    'v2': 'current-secret-key',      # Active key
    'v3': 'future-secret-key',       # Next key (pre-deployed)
}

def validate_token_with_version(token_with_version):
    """
    Validate token that includes key version.
    Token format: v2:abcdef1234...
    """
    try:
        version, token = token_with_version.split(':', 1)
        secret_key = SECRET_KEYS.get(version)
        if not secret_key:
            logger.warning(f"Unknown token version: {version}")
            return False
        return validate_token(token, secret_key)
    except ValueError:
        logger.error("Invalid token format")
        return False
```

**Key Rotation Steps (Zero Downtime):**
1. Generate new key
2. Add to ACTIVE_KEYS while keeping old keys
3. Deploy new version (update CURRENT_KEY_VERSION)
4. Wait for old tokens to expire (e.g., 24 hours)
5. Remove old keys from configuration

#### CDN Cache Issues

Customize cache keys to ignore token parameters:

```nginx
# Nginx: Customize cache key to ignore token parameter
proxy_cache_path /path/to/cache levels=1:2 keys_zone=my_cache:10m;

location /protected/ {
    proxy_cache_key "$scheme$request_method$host$uri";
    proxy_cache my_cache;
    proxy_pass http://backend;
}
```

#### Large File Processing

Use async job queues for large files:

```python
def async_route(f):
    """Decorator for async endpoints that returns job ID for long-running tasks."""
    @wraps(f)
    def decorated(*args, **kwargs):
        file_size = get_file_size(request)
        if file_size > 100 * 1024 * 1024:  # 100MB
            job_id = str(uuid.uuid4())
            watermark_queue.enqueue(
                'process_watermark',
                file_path=request.files['file'].filename,
                user_id=current_user.id,
                job_id=job_id,
                timeout=3600
            )
            return jsonify({
                'status': 'processing',
                'job_id': job_id,
                'message': 'File is being processed.'
            }), 202
        else:
            return f(*args, **kwargs)
    return decorated
```

#### Concurrent Request Race Conditions

Use atomic operations:

```python
def check_rate_limit_atomic(user_id, limit=100, window=60):
    """Atomic rate limit check using Redis pipeline."""
    key = f"rate_limit:{user_id}"
    pipe = redis_client.pipeline()
    try:
        pipe.incr(key)
        pipe.expire(key, window)
        pipe.get(key)
        results = pipe.execute()
        current_count = int(results[2])
        if current_count > limit:
            logger.warning(f"Rate limit exceeded for {user_id}")
            return False
        return True
    except redis.RedisError as e:
        logger.error(f"Redis error: {e}")
        return True  # Fail-open
```

### 5. Implement Testing Strategy

#### Unit Tests

```python
def test_validate_token_valid():
    """Test valid token validation."""
    resource = '/files/doc.pdf'
    secret = 'test-secret'
    expires = int(time.time()) + 3600

    token = hmac.new(
        secret.encode(),
        f"{resource}:{expires}".encode(),
        hashlib.sha256
    ).hexdigest()

    assert validate_signed_url(resource, token, expires, secret) is True

def test_validate_token_expired():
    """Test expired token rejection."""
    resource = '/files/doc.pdf'
    secret = 'test-secret'
    expires = int(time.time()) - 1  # Expired

    token = hmac.new(
        secret.encode(),
        f"{resource}:{expires}".encode(),
        hashlib.sha256
    ).hexdigest()

    assert validate_signed_url(resource, token, expires, secret) is False

def test_validate_token_wrong_resource():
    """Test token doesn't work for different resource."""
    secret = 'test-secret'
    expires = int(time.time()) + 3600

    token = hmac.new(
        secret.encode(),
        f"/files/doc.pdf:{expires}".encode(),
        hashlib.sha256
    ).hexdigest()

    assert validate_signed_url('/files/other.pdf', token, expires, secret) is False
```

#### Integration Tests

```python
def test_protected_resource_without_token(client):
    """Test accessing protected resource without token."""
    response = client.get('/files/document.pdf')
    assert response.status_code == 403

def test_protected_resource_with_valid_token(client):
    """Test accessing protected resource with valid token."""
    resource = '/files/document.pdf'
    expires = int(time.time()) + 300
    token = hmac.new(
        app.config['SECRET_KEY'].encode(),
        f"{resource}:{expires}".encode(),
        hashlib.sha256
    ).hexdigest()

    response = client.get(f'{resource}?token={token}&expires={expires}')
    assert response.status_code == 200
```

#### Security Tests

```python
def test_cannot_forge_token():
    """Test attacker cannot forge valid token without secret."""
    fake_token = hashlib.sha256(b'attacker-guess').hexdigest()
    assert validate_signed_url(resource, fake_token, expires, 'real-secret') is False

def test_timing_attack_resistance():
    """Test token validation uses constant-time comparison."""
    # Times should be similar (within 2x) to prevent timing attacks
    assert invalid_time < valid_time * 2
```

**Coverage Goals:**
- Line coverage: >90%
- Branch coverage: >85%
- Security-critical functions: 100%

### 6. Avoid Common Pitfalls

| Pitfall | Impact | Solution |
|---------|--------|----------|
| Allowing empty referers | Some browsers/plugins strip referers | Decide policy; handle gracefully |
| Token leakage in logs | Security vulnerability | Never log full tokens |
| Clock sync issues | Token validation failures | Use NTP; implement grace periods |
| CDN caching | Signed URLs may not cache | Customize cache keys |
| Browser prefetching | Triggers hotlink protection | Handle prefetch requests gracefully |

### 7. Understand Limitations

**Anti-hotlinking is ONE layer of protection, not a complete solution.**

#### What Anti-Hotlinking Does NOT Protect Against

| Threat | Reality | Mitigation |
|--------|---------|------------|
| Screen Capture | Users can screenshot, print to PDF | Watermarking, legal measures |
| Token Sharing | Legitimate users can share tokens | Short expiration, session-binding, rate limiting |
| Insider Threats | Developers with access can bypass | Key rotation, audit logs, access controls |
| Offline Access | Downloaded files persist indefinitely | DRM, streaming protocols, online validation |
| Sophisticated Scraping | Spoofed headers, IP rotation | Rate limiting, behavioral analysis, CAPTCHA |

#### What Anti-Hotlinking DOES Well

- Prevents casual hotlinking (bloggers, forums embedding your resources)
- Blocks iframe embedding on unauthorized sites
- Reduces bandwidth theft
- Enforces access control (users must visit your site/app)
- Tracks patterns and unauthorized access attempts

### 8. Capacity Planning

**Redis Memory:**
- Per entry: ~100 bytes
- 100K users = 10MB
- 1M users = 100MB
- Starting allocation: 512MB

**Scaling Strategy:**
- < 10K users: Single Redis instance
- 10K-50K users: Redis cluster (master + replicas)
- > 50K users: Sharded Redis cluster

**Watermarking Capacity:**
- Single core: ~5 images/second
- Recommended: Queue system + worker pool + autoscaling

## Important Notes

### Defense-in-Depth Recommendations

For comprehensive content protection, combine multiple strategies:

1. **DRM (Digital Rights Management)**: For premium video/audio requiring persistent online validation
2. **Forensic watermarking**: User-identifiable watermarks that trace leaks to specific accounts
3. **Legal agreements**: Strong Terms of Service, copyright notices, contracts with legal enforceability
4. **Active monitoring**: Services that scan the web for your content
5. **Encryption**: Encrypt content at rest and in transit
6. **Rate limiting & anomaly detection**: Real-time monitoring for suspicious patterns
7. **Regular security audits**: Periodic penetration testing

### When You Need More Than Anti-Hotlinking

Anti-hotlinking is useful but not a silver bullet. Design your content protection strategy with defense-in-depth. The goal is to raise the bar high enough that:
- Casual abuse is prevented
- Serious abuse becomes detectable and traceable

### Related Skills

- **anti-hotlink-core**: Method selection and core concepts
- **anti-hotlink-tokens**: Token-based protection implementation
- **anti-hotlink-rate-limiting**: Rate limiting strategies
- **anti-hotlink-watermarking**: Watermark implementation
- **anti-hotlink-referer**: Referer-based protection
- **anti-hotlink-oauth**: OAuth 2.0 integration

For method selection guidance, refer to **anti-hotlink-core**.
