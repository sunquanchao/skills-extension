---
name: anti-hotlink-oauth
description: Triggers for OAuth integration (OAuth, "scope-based access", "session binding", "authenticated resources")
license: MIT
metadata:
  author: Quanchao Sun
  version: "2.0"
---

# OAuth 2.0 Integration for Anti-Hotlinking

OAuth 2.0 provides a robust framework for protecting resources while maintaining user experience. By combining OAuth authentication with anti-hotlinking techniques, you create multi-layered protection that validates both user identity and resource access authorization.

## When to Use

Use this skill when:
- User wants OAuth-based resource protection
- User mentions OAuth scopes for access control
- User needs session-bound tokens
- User asks about integrating authentication with resource protection
- User needs to bind resource access to authenticated users

## What to Do

### Pattern 1: OAuth Scopes for Resource Access

**Concept**: Use OAuth scopes to control which resources a user can access. Combine scope validation with token-based resource protection.

```python
from functools import wraps
from flask import request, jsonify, abort
from authlib.integrations.flask_oauth2 import current_token

def require_scope(*scopes):
    """
    Decorator to require specific OAuth scopes for resource access.
    Scopes control WHAT resources a user can access.
    """
    def decorator(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            # Get OAuth token from request
            token = current_token
            if not token:
                return jsonify({'error': 'Unauthorized'}), 401

            # Check if token has required scopes
            token_scopes = token.get('scope', '').split()
            if not any(scope in token_scopes for scope in scopes):
                return jsonify({
                    'error': 'Insufficient scope',
                    'required': scopes,
                    'provided': token_scopes
                }), 403

            # Scopes validated - proceed to resource access
            return f(*args, **kwargs)
        return decorated_function
    return decorator

# Usage example: Protect premium content
@app.route('/api/premium/<path:filepath>')
@require_scope('read:premium')
def premium_resource(filepath):
    """
    Access to premium resources requires 'read:premium' scope.
    OAuth token validated first, then resource access granted.
    """
    # Generate signed URL for this specific user
    user_id = current_token.get('user_id')
    signed_url = generate_signed_url(
        resource_path=f'/premium/{filepath}',
        user_id=user_id,
        secret_key=SECRET_KEY,
        expires_in=300  # 5 minutes
    )

    return jsonify({
        'resource_url': signed_url,
        'expires_in': 300
    })

# Usage example: Protect free resources
@app.route('/api/free/<path:filepath>')
@require_scope('read:free', 'read:premium')  # Either scope works
def free_resource(filepath):
    """
    Free resources accessible with 'read:free' OR 'read:premium' scope.
    """
    user_id = current_token.get('user_id')
    signed_url = generate_signed_url(
        resource_path=f'/free/{filepath}',
        user_id=user_id,
        secret_key=SECRET_KEY,
        expires_in=600  # 10 minutes
    )

    return jsonify({
        'resource_url': signed_url,
        'expires_in': 600
    })
```

### Pattern 2: OAuth Token + Anti-Hotlink Token (Two-Token Pattern)

**Concept**: Combine OAuth authentication (user identity) with resource-specific signed tokens (access authorization). Two-token approach provides defense-in-depth.

```python
import hmac
import hashlib
import time
from flask import request, jsonify
from authlib.integrations.flask_oauth2 import require_oauth

oauth = require_oauth('profile')  # Require OAuth authentication

def generate_resource_token(resource_path, user_id, secret_key, expires_in=300):
    """
    Generate resource-specific access token.

    Args:
        resource_path: Path to resource (e.g., '/files/document.pdf')
        user_id: User ID from OAuth token
        secret_key: Server secret for HMAC signing
        expires_in: Token validity in seconds

    Returns:
        Dictionary with token, expires, and signed URL
    """
    expires = int(time.time()) + expires_in

    # Create token payload: resource_path + user_id + expires
    payload = f"{resource_path}:{user_id}:{expires}"
    token = hmac.new(
        secret_key.encode(),
        payload.encode(),
        hashlib.sha256
    ).hexdigest()

    # Build signed URL
    signed_url = f"{resource_path}?token={token}&user={user_id}&expires={expires}"

    return {
        'token': token,
        'expires': expires,
        'signed_url': signed_url
    }

# OAuth-protected endpoint: Generate resource access token
@app.route('/api/generate-resource-link', methods=['POST'])
@oauth  # Require valid OAuth token
def generate_resource_link():
    """
    Generate signed URL for resource access.
    User must be authenticated via OAuth first.
    """
    try:
        # Get user from OAuth token
        token = current_token
        user_id = token.get('user_id')

        # Get requested resource from request body
        data = request.get_json()
        resource_path = data.get('resource_path')

        if not resource_path:
            return jsonify({'error': 'resource_path required'}), 400

        # Validate user has access to this resource
        if not user_has_access(user_id, resource_path):
            return jsonify({'error': 'Resource access denied'}), 403

        # Generate resource-specific token
        resource_token = generate_resource_token(
            resource_path=resource_path,
            user_id=user_id,
            secret_key=SECRET_KEY,
            expires_in=300  # 5 minutes
        )

        return jsonify({
            'resource_url': resource_token['signed_url'],
            'expires_in': 300,
            'user_id': user_id
        })

    except Exception as e:
        return jsonify({'error': f'Internal error: {str(e)}'}), 500

# Resource endpoint: Validate both OAuth and resource token
@app.route('/files/<path:filepath>')
def protected_file(filepath):
    """
    Serve file after validating resource token.
    OAuth already validated at link generation.
    """
    try:
        token = request.args.get('token')
        user_id = request.args.get('user')
        expires = request.args.get('expires')

        # Validate resource token
        if not all([token, user_id, expires]):
            return jsonify({'error': 'Missing token parameters'}), 403

        # Rebuild payload and validate signature
        resource_path = f'/files/{filepath}'
        payload = f"{resource_path}:{user_id}:{expires}"
        expected = hmac.new(
            SECRET_KEY.encode(),
            payload.encode(),
            hashlib.sha256
        ).hexdigest()

        if not hmac.compare_digest(token, expected):
            return jsonify({'error': 'Invalid token'}), 403

        # Check expiration
        if time.time() > int(expires):
            return jsonify({'error': 'Token expired'}), 403

        # Token valid - serve file
        return send_file(filepath)

    except Exception as e:
        return jsonify({'error': f'Server error: {str(e)}'}), 500
```

### Token Binding with IP and User Agent

For additional security, bind tokens to user sessions:

```python
import hashlib

def generate_resource_token_bound(resource_path, user_id, secret_key, expires_in=300):
    """
    Generate token bound to user IP and user agent.
    Prevents token sharing across different devices.
    """
    expires = int(time.time()) + expires_in

    # Get client IP and user agent
    client_ip = request.remote_addr
    user_agent = request.headers.get('User-Agent', '')

    # Create fingerprint
    fingerprint = hashlib.sha256(f"{client_ip}:{user_agent}".encode()).hexdigest()[:16]

    # Include fingerprint in token payload
    payload = f"{resource_path}:{user_id}:{fingerprint}:{expires}"
    token = hmac.new(
        secret_key.encode(),
        payload.encode(),
        hashlib.sha256
    ).hexdigest()

    signed_url = f"{resource_path}?token={token}&user={user_id}&fp={fingerprint}&expires={expires}"

    return {
        'token': token,
        'fingerprint': fingerprint,
        'signed_url': signed_url
    }

def validate_bound_token(resource_path, token, user_id, fingerprint, expires, secret_key):
    """
    Validate token and check fingerprint matches.
    """
    # Rebuild payload and validate signature
    payload = f"{resource_path}:{user_id}:{fingerprint}:{expires}"
    expected = hmac.new(
        secret_key.encode(),
        payload.encode(),
        hashlib.sha256
    ).hexdigest()

    if not hmac.compare_digest(token, expected):
        return False

    # Check expiration
    if time.time() > int(expires):
        return False

    # Validate fingerprint
    client_ip = request.remote_addr
    user_agent = request.headers.get('User-Agent', '')
    current_fingerprint = hashlib.sha256(f"{client_ip}:{user_agent}".encode()).hexdigest()[:16]

    if fingerprint != current_fingerprint:
        return False

    return True
```

## SECURITY NOTICE

When integrating OAuth with anti-hotlinking, you create multiple layers of defense:

```
+-------------------------------------------------------------+
|                    FOUR LAYERS OF DEFENSE                    |
+-------------------------------------------------------------+
|                                                              |
|  LAYER 1: OAUTH AUTHENTICATION                              |
|  |-- Validate token with auth server                        |
|  |-- Check token expiration and revocation                  |
|  |-- Verify user identity (user_id, sub)                    |
|                                                              |
|  LAYER 2: RESOURCE TOKEN                                    |
|  |-- Generate signed URL with expiration                    |
|  |-- Include user_id in token payload                       |
|  |-- Validate HMAC signature on access                      |
|                                                              |
|  LAYER 3: HTTPS ENCRYPTION                                  |
|  |-- Encrypt tokens in transit                              |
|  |-- Prevent token interception                             |
|  |-- Secure communication channel                           |
|                                                              |
|  LAYER 4: APPLICATION AUTHORIZATION                         |
|  |-- Check user has permission for resource                 |
|  |-- Enforce rate limits                                    |
|  |-- Log access for audit trail                             |
|                                                              |
+-------------------------------------------------------------+
```

**Best Practices:**

1. **Token Lifetimes**
   - OAuth access tokens: 5-15 minutes (short-lived)
   - Resource tokens: 1-5 minutes (very short-lived)
   - Refresh tokens: 30 days (stored securely)

2. **Secret Separation**
   - Use different secrets for OAuth and resource tokens
   - Rotate secrets regularly (monthly/quarterly)
   - Never commit secrets to version control

3. **Token Binding**
   - Bind tokens to user sessions or IP addresses
   - Include browser fingerprint in token payload
   - Revoke tokens on suspicious activity

4. **Logging and Monitoring**
   - Log all token generation and validation
   - Alert on high failure rates
   - Monitor for token patterns (sharing, abuse)

5. **Revocation Strategy**
   - Maintain token blacklist in Redis
   - Implement immediate revocation on compromise
   - Clear blacklist after token expiration

6. **Error Handling**
   - Return generic error messages (don't leak info)
   - Log detailed errors server-side
   - Implement exponential backoff for failures

## Important Notes

- Two-token pattern provides defense-in-depth by separating authentication from resource access
- Session binding prevents token sharing across different devices/users
- OAuth scopes enable fine-grained access control for different resource types
- Always use HTTPS to protect tokens in transit
- For method selection guidance, see the **anti-hotlink-core** skill
