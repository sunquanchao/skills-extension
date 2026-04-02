---
name: anti-hotlink-rate-limiting
description: Triggers when user needs Redis-based rate limiting, mentions "rate limit", "API abuse", "throttle", "request limit", or wants to prevent excessive API requests
license: MIT
metadata:
  author: Quanchao Sun
  version: "2.0"
---

# Rate Limiting (Redis-based)

Rate limiting prevents abuse by restricting how many requests a user can make within a time window. Redis is ideal for distributed rate limiting due to its atomic operations and fast in-memory storage.

## When to Use

Use this skill when:
- User wants to prevent API abuse
- User mentions rate limiting, throttling, or request quotas
- User needs Redis-based rate limiting
- User asks about preventing excessive requests
- User mentions "rate limit", "throttle", "API abuse", or "request limit"

## SECURITY NOTICE

These are ILLUSTRATIVE EXAMPLES for learning patterns.
Before production use, add:

- Input validation & sanitization
- Rate limiting per endpoint
- Monitoring & alerting
- Regular security audits

## What to Do

### Fixed Window Rate Limiting

**Concept**: Counter resets at fixed time intervals (e.g., every minute). Simple but can allow bursts at window boundaries.

```python
import redis
import time
import logging

logger = logging.getLogger(__name__)

def fixed_window_rate_limit(user_id, limit=100, window_seconds=60):
    """
    Fixed window rate limiting using Redis.

    Args:
        user_id: Unique identifier for user/IP/token
        limit: Maximum requests allowed in window (default: 100)
        window_seconds: Time window in seconds (default: 60)

    Returns:
        dict: {'allowed': bool, 'remaining': int, 'reset_at': int}
    """
    try:
        # Create Redis key for this user in this window
        current_window = int(time.time() // window_seconds)
        key = f"rate_limit:fixed:{user_id}:{current_window}"

        # Increment counter atomically
        current_count = redis_client.incr(key)

        # Set expiration on first request
        if current_count == 1:
            redis_client.expire(key, window_seconds)

        # Calculate remaining and reset time
        remaining = max(0, limit - current_count)
        reset_at = (current_window + 1) * window_seconds

        return {
            'allowed': current_count <= limit,
            'remaining': remaining,
            'reset_at': reset_at
        }

    except redis.RedisError as e:
        logger.error(f"Redis error in rate limiting: {e}")
        # Fail-open: allow request if Redis fails
        return {'allowed': True, 'remaining': limit, 'reset_at': int(time.time()) + window_seconds}
    except Exception as e:
        logger.error(f"Unexpected error in rate limiting: {e}")
        # Fail-closed: deny on unexpected errors
        return {'allowed': False, 'remaining': 0, 'reset_at': int(time.time()) + window_seconds}

# Usage example
@app.route('/api/protected-resource')
@require_signed_token
def protected_resource():
    user_id = request.args.get('user')
    result = fixed_window_rate_limit(user_id, limit=100, window_seconds=60)

    if not result['allowed']:
        return jsonify({
            'error': 'Rate limit exceeded',
            'retry_after': result['reset_at'] - int(time.time())
        }), 429

    # Process request normally
    return jsonify({'data': 'response'})
```

**How it works**:
1. Each user gets a counter per time window
2. Counter increments atomically with each request
3. When window ends, counter automatically resets (Redis key expires)
4. Simple and efficient (2 Redis operations per request)

**Pros**:
- Simple implementation
- Low Redis operations count (2-3 per request)
- Easy to understand and debug

**Cons**:
- Allows bursts at window boundaries (double capacity)
- Not smooth: users can hit limit, then immediately get new allowance

**Best for**:
- APIs with consistent traffic patterns
- Simple rate limiting requirements
- Applications where boundary bursts are acceptable

### Sliding Window Rate Limiting

**Concept**: Tracks request timestamps for smooth, accurate rate limiting. More complex but prevents boundary bursts.

```python
def sliding_window_rate_limit(user_id, limit=100, window_seconds=60):
    """
    Sliding window rate limiting using Redis sorted sets.

    Args:
        user_id: Unique identifier for user/IP/token
        limit: Maximum requests allowed in window (default: 100)
        window_seconds: Time window in seconds (default: 60)

    Returns:
        dict: {'allowed': bool, 'remaining': int, 'reset_at': int}
    """
    try:
        key = f"rate_limit:sliding:{user_id}"
        now = time.time()
        window_start = now - window_seconds

        # Use Redis pipeline for atomic operations
        pipe = redis_client.pipeline()

        # Remove old timestamps outside the window
        pipe.zremrangebyscore(key, 0, window_start)

        # Count current requests in window
        pipe.zcard(key)

        # Add current request timestamp
        pipe.zadd(key, {str(now): now})

        # Set expiration to window size + buffer
        pipe.expire(key, window_seconds + 1)

        # Execute all commands atomically
        results = pipe.execute()
        current_count = results[1]

        # Calculate remaining and reset time
        remaining = max(0, limit - current_count)
        reset_at = int(now) + window_seconds

        return {
            'allowed': current_count < limit,
            'remaining': remaining,
            'reset_at': reset_at
        }

    except redis.RedisError as e:
        logger.error(f"Redis error in sliding window rate limiting: {e}")
        # Fail-open: allow request if Redis fails
        return {'allowed': True, 'remaining': limit, 'reset_at': int(time.time()) + window_seconds}
    except Exception as e:
        logger.error(f"Unexpected error in sliding window rate limiting: {e}")
        # Fail-closed: deny on unexpected errors
        return {'allowed': False, 'remaining': 0, 'reset_at': int(time.time()) + window_seconds}

# Usage example
@app.route('/api/protected-resource')
@require_signed_token
def protected_resource():
    user_id = request.args.get('user')
    result = sliding_window_rate_limit(user_id, limit=100, window_seconds=60)

    if not result['allowed']:
        return jsonify({
            'error': 'Rate limit exceeded',
            'retry_after': result['reset_at'] - int(time.time())
        }), 429

    # Process request normally
    return jsonify({'data': 'response'})
```

**How it works**:
1. Each request timestamp stored in Redis sorted set
2. Old timestamps (outside window) removed before counting
3. Current request added to set
4. Smooth rate limiting: capacity doesn't reset abruptly

**Pros**:
- Smooth rate limiting (no boundary bursts)
- More accurate request tracking
- Better user experience (predictable limits)

**Cons**:
- Higher Redis operations count (4-5 per request)
- Higher memory usage (stores all request timestamps)
- More complex implementation

**Best for**:
- APIs requiring precise rate limiting
- High-value endpoints (paid APIs, premium features)
- Applications where burst prevention is critical

### Comparison: Which to Use?

| Feature | Fixed Window | Sliding Window |
|---------|-------------|----------------|
| **Burst Handling** | Allows bursts at boundaries | Smooth, no bursts |
| **Redis Operations** | 2-3 per request | 4-5 per request |
| **Memory Usage** | ~100 bytes per user | ~200 bytes per user |
| **Accuracy** | Lower (bursts possible) | Higher (smooth limiting) |
| **Complexity** | Simple | Moderate |
| **Best For** | Simple APIs, high traffic | Precise limiting, premium APIs |

**Recommendation**: Start with fixed window for simplicity. Upgrade to sliding window if boundary bursts become a problem.

### Multi-Dimensional Rate Limits

**Concept**: Apply multiple rate limit types (per-IP, per-token, global) for comprehensive protection.

```python
def check_multi_dimensional_limits(ip, token, user_id, limits):
    """
    Check multiple rate limit dimensions.

    Args:
        ip: Client IP address
        token: Access token (if applicable)
        user_id: User ID (if applicable)
        limits: Dict of limit configurations

    Returns:
        dict: {'allowed': bool, 'violations': list, 'retry_after': int}
    """
    try:
        violations = []
        retry_after = 0

        # Define limit dimensions (priority: token > user > IP > global)
        dimensions = []

        # Token-based limit (highest priority)
        if token:
            dimensions.append({
                'key': f'token:{token[:8]}',  # Use first 8 chars for privacy
                'limit': limits.get('token_per_minute', 50),
                'window': 60
            })

        # User-based limit
        if user_id:
            dimensions.append({
                'key': f'user:{user_id}',
                'limit': limits.get('user_per_minute', 100),
                'window': 60
            })

        # IP-based limit
        if ip:
            dimensions.append({
                'key': f'ip:{ip}',
                'limit': limits.get('ip_per_minute', 200),
                'window': 60
            })

        # Global limit (all requests)
        dimensions.append({
            'key': 'global',
            'limit': limits.get('global_per_minute', 10000),
            'window': 60
        })

        # Check each dimension
        for dimension in dimensions:
            result = sliding_window_rate_limit(
                dimension['key'],
                dimension['limit'],
                dimension['window']
            )

            if not result['allowed']:
                violations.append(dimension['key'])
                retry_after = max(retry_after, result['reset_at'] - int(time.time()))

        return {
            'allowed': len(violations) == 0,
            'violations': violations,
            'retry_after': retry_after
        }

    except Exception as e:
        logger.error(f"Error in multi-dimensional rate limiting: {e}")
        # Fail-closed: deny on unexpected errors
        return {'allowed': False, 'violations': ['system_error'], 'retry_after': 60}
```

**Priority Order**:
1. **Token-based**: Most specific (per-API-key or per-access-token)
2. **User-based**: Per-user account limit
3. **IP-based**: Per-IP address limit
4. **Global**: System-wide limit (all requests combined)

**Best Practices**:
- Token limits should be most restrictive (prevent token abuse)
- IP limits should be moderate (allow multiple users per NAT)
- User limits should balance between UX and protection
- Global limits protect the entire system from overload

## Important Notes

### Redis Connection Handling

Robust Redis connection handling is critical for production rate limiting:

```python
import redis
from redis.retry import Retry
from redis.backoff import ExponentialBackoff
from redis.exceptions import RedisConnectionError, RedisTimeoutError

# Initialize Redis with retry logic and connection pooling
redis_client = redis.Redis(
    host='localhost',
    port=6379,
    db=0,
    decode_responses=True,
    # Retry logic: 3 retries with exponential backoff
    retry=Retry(
        ExponentialBackoff(initial=0.1, max=1.0),
        3  # Max 3 retries
    ),
    # Connection pooling
    connection_pool=redis.ConnectionPool(
        host='localhost',
        port=6379,
        db=0,
        decode_responses=True,
        max_connections=50,  # Pool size
        socket_connect_timeout=5,  # 5 second timeout
        socket_timeout=5,
        retry_on_timeout=True
    ),
    # Health check
    health_check_interval=30  # Check connection every 30 seconds
)

def check_redis_health():
    """Check Redis connection health."""
    try:
        redis_client.ping()
        return True
    except (RedisConnectionError, RedisTimeoutError) as e:
        logger.error(f"Redis health check failed: {e}")
        return False
```

### Fail-Open vs Fail-Closed Strategies

When Redis is unavailable, choose your strategy carefully:

**Fail-Open** (allow requests if Redis fails):
- Better user experience
- Less secure
- Good for non-critical rate limiting

**Fail-Closed** (block requests if Redis fails):
- More secure
- Worse user experience
- Good for sensitive operations

```python
def rate_limit_with_fail_open(user_id, limit=100, window_seconds=60):
    """Rate limiting with fail-open strategy on Redis failure."""
    try:
        if not check_redis_health():
            logger.warning("Redis is unhealthy, using fail-open strategy")
            return {'allowed': True, 'remaining': limit, 'reset_at': int(time.time()) + window_seconds}

        return fixed_window_rate_limit(user_id, limit, window_seconds)

    except Exception as e:
        logger.error(f"Unexpected error in rate limiting: {e}")
        # Fail-open: allow request but log error
        return {'allowed': True, 'remaining': limit, 'reset_at': int(time.time()) + window_seconds}
```

**Production Recommendations**:
- **Fail-open** for non-critical rate limiting (better UX)
- **Fail-closed** for sensitive operations (better security)
- **Monitor** Redis connection errors (alert on high error rates)
- **Scale** to Redis Cluster for high traffic (>10K req/sec)
- **Replicate** to Redis read replicas for failover

**Scaling Strategy**:
- **< 10K req/sec**: Single Redis instance
- **10K-50K req/sec**: Redis Cluster (3 nodes: 1 master + 2 replicas)

### Related Skills

For method selection guidance and core anti-hotlink patterns, see the **anti-hotlink-core** skill which covers:
- When to use different protection methods
- Core signed URL/token generation
- Integration patterns
