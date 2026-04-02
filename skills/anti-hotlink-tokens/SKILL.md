---
name: anti-hotlink-tokens
description: Triggers for token-based protection (signed URLs, HMAC, CloudFront, "token-based access", "presigned URLs"). Use when user wants protection for paid/premium content, mentions signed URLs, presigned URLs, token-based access, or needs CloudFront/S3 protection.
metadata:
  author: Quanchao Sun
  version: "2.0"
---

# Token-Based Anti-Hotlinking Protection

This skill provides implementations for token-based access control to protect web resources from unauthorized hotlinking.

## When to Use

Use this skill when:

- User wants protection for **paid/premium content** (courses, downloads, media)
- User mentions **signed URLs**, **presigned URLs**, or **token-based access**
- User needs **CloudFront** or **S3** protection
- User wants **time-limited** access to resources
- User needs **cryptographic verification** of resource access

## What to Do

Implement token-based protection using one of the following methods based on the user's infrastructure.

---

## Node.js/Express: Signed URL Implementation

```javascript
const crypto = require('crypto');

function generateSignedUrl(resourcePath, secretKey, expiresIn = 3600) {
    try {
        if (!resourcePath || !secretKey) {
            throw new Error('resourcePath and secretKey are required');
        }
        const expires = Date.now() + expiresIn * 1000;
        const token = crypto
            .createHmac('sha256', secretKey)
            .update(`${resourcePath}:${expires}`)
            .digest('hex');
        return `${resourcePath}?token=${token}&expires=${expires}`;
    } catch (error) {
        console.error('Error generating signed URL:', error.message);
        throw error;
    }
}

function validateSignedUrl(resourcePath, token, expires, secretKey) {
    try {
        if (!resourcePath || !token || !expires || !secretKey) {
            console.error('Missing required parameters for validation');
            return false;
        }
        const now = Date.now();
        if (now > expires) return false;

        const expectedToken = crypto
            .createHmac('sha256', secretKey)
            .update(`${resourcePath}:${expires}`)
            .digest('hex');
        return token === expectedToken;
    } catch (error) {
        console.error('Error validating signed URL:', error.message);
        return false;
    }
}

// Middleware
app.use((req, res, next) => {
    try {
        if (req.query.token && req.query.expires) {
            if (validateSignedUrl(req.path, req.query.token, req.query.expires, process.env.SECRET_KEY)) {
                return next();
            }
        }
        // For protected resources without valid token
        if (req.path.startsWith('/protected/')) {
            return res.status(403).sendFile('hotlink-warning.html');
        }
        next();
    } catch (error) {
        console.error('Middleware error:', error.message);
        res.status(500).json({ error: 'Internal server error' });
    }
});
```

---

## Python/Flask: Signed URL Implementation

```python
import hmac
import hashlib
import time
import logging
from flask import request, abort, send_file
from functools import wraps

logger = logging.getLogger(__name__)

def generate_signed_url(resource_path, secret_key, expires_in=3600):
    try:
        if not resource_path or not secret_key:
            raise ValueError("resource_path and secret_key are required")
        expires = int(time.time()) + expires_in
        token = hmac.new(
            secret_key.encode(),
            f"{resource_path}:{expires}".encode(),
            hashlib.sha256
        ).hexdigest()
        return f"{resource_path}?token={token}&expires={expires}"
    except Exception as e:
        logger.error(f"Error generating signed URL: {e}")
        raise

def validate_signed_url(resource_path, token, expires, secret_key):
    try:
        if time.time() > expires:
            return False
        expected = hmac.new(
            secret_key.encode(),
            f"{resource_path}:{expires}".encode(),
            hashlib.sha256
        ).hexdigest()
        return hmac.compare_digest(token, expected)
    except Exception as e:
        logger.error(f"Error validating signed URL: {e}")
        return False

def require_signed_token(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        try:
            token = request.args.get('token')
            expires = request.args.get('expires')
            if not token or not expires:
                logger.warning("Missing token or expires parameter")
                return send_file('hotlink-warning.html'), 403
            if not validate_signed_url(request.path, token, int(expires), SECRET_KEY):
                logger.warning("Invalid or expired token")
                return send_file('hotlink-warning.html'), 403
            return f(*args, **kwargs)
        except Exception as e:
            logger.error(f"Error in require_signed_token decorator: {e}")
            return send_file('hotlink-warning.html'), 403
    return decorated_function

@app.route('/protected/<path:filepath>')
@require_signed_token
def protected_file(filepath):
    return send_file(filepath)
```

---

## CloudFront Signed URLs

CloudFront signed URLs provide edge-level validation for content distributed through AWS's global CDN network. URLs are signed with RSA key-pair authentication and validated at CloudFront edge locations.

### Python: CloudFront Signed URL

```python
import boto3
from botocore.signers import CloudFrontSigner
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import padding
from cryptography.hazmat.backends import default_backend
import datetime
import hashlib
import logging

logger = logging.getLogger(__name__)

def rsa_signer(message):
    """Sign CloudFront URL with RSA private key."""
    try:
        # Load private key from file or environment variable
        private_key_str = open('cloudfront_key.pem').read()
        private_key = serialization.load_pem_private_key(
            private_key_str.encode(),
            password=None,
            backend=default_backend()
        )

        # Sign the message
        return private_key.sign(message, padding.PKCS1v15(), hashlib.sha1)
    except Exception as e:
        logger.error(f"Error signing CloudFront URL: {e}")
        raise

def generate_cloudfront_url(resource_url, key_pair_id, expires_in=3600):
    """
    Generate CloudFront signed URL for resource access.

    Args:
        resource_url: Full CloudFront URL (e.g., https://d123.cloudfront.net/video.mp4)
        key_pair_id: CloudFront key pair ID (from AWS Console)
        expires_in: URL validity in seconds (default: 1 hour)

    Returns:
        Signed URL with authentication parameters
    """
    try:
        if not resource_url or not key_pair_id:
            raise ValueError("resource_url and key_pair_id are required")

        # Initialize CloudFront signer
        cloudfront_signer = CloudFrontSigner(key_pair_id, rsa_signer)

        # Calculate expiration timestamp
        expire_date = datetime.datetime.now() + datetime.timedelta(seconds=expires_in)

        # Generate signed URL
        signed_url = cloudfront_signer.generate_presigned_url(
            resource_url,
            date_less_than=expire_date
        )

        logger.info(f"Generated CloudFront signed URL for {resource_url}")
        return signed_url

    except Exception as e:
        logger.error(f"Error generating CloudFront signed URL: {e}")
        raise

# Usage example
signed_url = generate_cloudfront_url(
    resource_url='https://d123.cloudfront.net/videos/course.mp4',
    key_pair_id='APKAIEXAMPLEKEY',
    expires_in=1800  # 30 minutes
)
print(f"Signed URL: {signed_url}")
```

### Node.js: CloudFront Signed URL

```javascript
const { CloudFrontClient } = require('@aws-sdk/client-cloudfront');
const { getSignedUrl } = require('@aws-sdk/cloudfront-signer');
const fs = require('fs');

async function generateCloudFrontSignedUrl(resourceUrl, keyPairId, privateKeyPath, expiresIn = 3600) {
    try {
        if (!resourceUrl || !keyPairId || !privateKeyPath) {
            throw new Error('resourceUrl, keyPairId, and privateKeyPath are required');
        }

        // Load private key
        const privateKey = fs.readFileSync(privateKeyPath);

        // Calculate expiration
        const expireDate = new Date();
        expireDate.setSeconds(expireDate.getSeconds() + expiresIn);

        // Generate signed URL
        const signedUrl = getSignedUrl({
            url: resourceUrl,
            keyPairId: keyPairId,
            privateKey: privateKey,
            dateLessThan: expireDate
        });

        console.log(`Generated CloudFront signed URL for ${resourceUrl}`);
        return signedUrl;

    } catch (error) {
        console.error('Error generating CloudFront signed URL:', error.message);
        throw error;
    }
}

// Usage example
(async () => {
    const signedUrl = await generateCloudFrontSignedUrl(
        'https://d123.cloudfront.net/videos/course.mp4',
        'APKAIEXAMPLEKEY',
        './cloudfront_key.pem',
        1800  // 30 minutes
    );
    console.log('Signed URL:', signedUrl);
})();
```

### CloudFront Key Features

- **Edge validation**: URL signatures validated at 200+ global edge locations
- **RSA signing**: Cryptographically secure with 2048-bit RSA keys
- **Low latency**: No origin server request for validation
- **High traffic**: Scales to millions of requests without origin load

### When to Use CloudFront

- Content already hosted on CloudFront
- Global audience with high traffic volume
- Want to offload validation from origin server
- Need edge caching with access control

### CloudFront Security Notes

- Keep private key secure (use AWS Secrets Manager or Parameter Store)
- Rotate keys periodically (recommended: quarterly)
- Set appropriate expiration times (shorter = more secure)
- Monitor for unusual access patterns via CloudFront access logs

---

## SECURITY NOTICE

These are ILLUSTRATIVE EXAMPLES for learning patterns. Before production use, add:

- Input validation & sanitization
- Comprehensive error handling
- Security audit & testing
- Rate limiting & monitoring
- Proper secret management

---

## Important Notes

### Token Expiration Best Practices

- **Short-lived tokens**: Use 15-30 minutes for sensitive content
- **Medium-lived tokens**: Use 1-4 hours for general protected content
- **Long-lived tokens**: Use 24+ hours only for low-risk content
- **Never use infinite expiration**: Always set an expiration time

### Secret Key Management

- Store secret keys in environment variables (never in code)
- Use secure secret management (AWS Secrets Manager, HashiCorp Vault)
- Rotate keys periodically (recommended: every 90 days)
- Use different keys for different environments (dev, staging, prod)
- Never log or expose secret keys

### Related Skills

- For **method selection guidance**, see `anti-hotlink-core` skill
- For **referer-based protection**, see `anti-hotlink-referer` skill
- For **OAuth/JWT integration**, see `anti-hotlink-oauth` skill
- For **operational patterns**, see `anti-hotlink-operations` skill
