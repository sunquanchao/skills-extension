---
name: anti-hotlink
description: Implement anti-hotlinking protection for web resources. Use when user wants to prevent unauthorized direct linking to images, files, or attachments; implement referer checking; create token-based access control; generate hotlink protection code; add防盗链 (anti-hotlink) functionality; or show "请在原文件中访问该附件" (Please access in original file) warning pages.
metadata:
  author: Quanchao Sun
  version: "1.0"
---

# Anti-Hotlinking Protection

Implement anti-hotlinking (防盗链) protection to prevent unauthorized direct linking to your web resources.

## When to Use

**Use this skill when user wants to:**
- Prevent hotlinking of images, videos, documents, or other resources
- Implement referer-based access control
- Create token-based resource protection
- Generate "attachment has been anti-hotlinking processed" warning pages
- Add防盗链 functionality to web applications
- Protect API endpoints from unauthorized access
- Implement signed URL generation for resource access

## What to Do

### 1. Understand the Protection Method

Choose the appropriate anti-hotlinking strategy:

**Referer Checking** (simple, for web resources):
- Checks HTTP Referer header
- Allows requests only from authorized domains
- Easy to bypass but simple to implement

**Token-Based Access** (recommended):
- Requires signed tokens/URLs with expiration
- Cryptographically secure
- Can include user-specific permissions

**Cookie/Session Based** (for logged-in users):
- Verifies user authentication
- Session-based authorization
- More complex but flexible

### 2. Implement Server-Side Protection

**For Nginx (Referer-based):**
```nginx
location ~* \.(jpg|jpeg|png|gif|pdf|doc|docx)$ {
    valid_referers none blocked yourdomain.com *.yourdomain.com;
    if ($invalid_referer) {
        return 403;
        # OR redirect to warning page
        # rewrite ^/hotlink-warning.html last;
    }
}
```

**For Apache (.htaccess):**
```apache
RewriteEngine on
RewriteCond %{HTTP_REFERER} !^$
RewriteCond %{HTTP_REFERER} !^https?://(www\.)?yourdomain\.com [NC]
RewriteRule \.(jpg|jpeg|png|gif|pdf|doc|docx)$ - [F,NC,L]
```

**For Node.js/Express (Token-based):**
```javascript
const crypto = require('crypto');

function generateSignedUrl(resourcePath, secretKey, expiresIn = 3600) {
    const expires = Date.now() + expiresIn * 1000;
    const token = crypto
        .createHmac('sha256', secretKey)
        .update(`${resourcePath}:${expires}`)
        .digest('hex');
    return `${resourcePath}?token=${token}&expires=${expires}`;
}

function validateSignedUrl(resourcePath, token, expires, secretKey) {
    const now = Date.now();
    if (now > expires) return false;
    
    const expectedToken = crypto
        .createHmac('sha256', secretKey)
        .update(`${resourcePath}:${expires}`)
        .digest('hex');
    return token === expectedToken;
}

// Middleware
app.use((req, res, next) => {
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
});
```

**For Python/Flask (Token-based):**
```python
import hmac
import hashlib
import time
from flask import request, abort, send_file
from functools import wraps

def generate_signed_url(resource_path, secret_key, expires_in=3600):
    expires = int(time.time()) + expires_in
    token = hmac.new(
        secret_key.encode(),
        f"{resource_path}:{expires}".encode(),
        hashlib.sha256
    ).hexdigest()
    return f"{resource_path}?token={token}&expires={expires}"

def validate_signed_url(resource_path, token, expires, secret_key):
    if time.time() > expires:
        return False
    expected = hmac.new(
        secret_key.encode(),
        f"{resource_path}:{expires}".encode(),
        hashlib.sha256
    ).hexdigest()
    return hmac.compare_digest(token, expected)

def require_signed_token(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        token = request.args.get('token')
        expires = request.args.get('expires')
        if not token or not expires:
            return send_file('hotlink-warning.html'), 403
        if not validate_signed_url(request.path, token, int(expires), SECRET_KEY):
            return send_file('hotlink-warning.html'), 403
        return f(*args, **kwargs)
    return decorated_function

@app.route('/protected/<path:filepath>')
@require_signed_token
def protected_file(filepath):
    return send_file(filepath)
```

### 3. Create Warning Page (if redirecting)

**HTML Warning Page (matches the UI from the image):**
```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>附件已做防盗链处理</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .container {
            background: white;
            border-radius: 16px;
            padding: 60px 40px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 400px;
            width: 90%;
        }
        
        .icon-container {
            width: 80px;
            height: 80px;
            margin: 0 auto 24px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }
        
        .icon-container svg {
            width: 48px;
            height: 48px;
            fill: white;
        }
        
        .scroll-icon {
            width: 60px;
            height: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 6px 6px 0 0;
            margin: 0 auto 30px;
            opacity: 0.6;
        }
        
        .text-container h1 {
            font-size: 20px;
            color: #333;
            margin-bottom: 12px;
            font-weight: 600;
        }
        
        .text-container p {
            font-size: 16px;
            color: #666;
            line-height: 1.6;
        }
        
        .action-button {
            margin-top: 32px;
            padding: 12px 32px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            text-decoration: none;
            display: inline-block;
        }
        
        .action-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon-container">
            <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path d="M12 2L3 7v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V7l-9-5zm-2 15l-4-4 1.41-1.41L10 14.17l6.59-6.59L18 9l-8 8z"/>
            </svg>
        </div>
        <div class="scroll-icon"></div>
        <div class="text-container">
            <h1>附件已做防盗链处理</h1>
            <p>请在原文件中访问该附件</p>
        </div>
        <a href="javascript:history.back()" class="action-button">返回上一页</a>
    </div>
</body>
</html>
```

### 4. Generate Signed URLs for Authorized Access

**Example: Generating authorized access links**
```javascript
// Server-side: Generate link for authorized user
const userSpecificUrl = generateSignedUrl(
    '/protected/document.pdf',
    process.env.SECRET_KEY,
    3600 // expires in 1 hour
);
console.log(userSpecificUrl);
// Output: /protected/document.pdf?token=abc123&expires=1234567890
```

### 5. Additional Security Measures

**Rate Limiting:**
- Implement rate limiting on protected endpoints
- Use Redis or in-memory store for tracking requests

**User-Agent Validation:**
- Check for valid user agents
- Block suspicious bots/crawlers

**IP Whitelisting:**
- Allow access only from specific IP ranges
- Useful for internal resources

**Watermarking:**
- Add user-specific watermarks to images
- Trace leaks back to source

## Implementation Checklist

- [ ] Choose protection method (referer/token/session)
- [ ] Implement server-side validation
- [ ] Create warning page for blocked requests
- [ ] Generate signed URLs for authorized access
- [ ] Test protection from external domains
- [ ] Test with valid tokens/referers
- [ ] Monitor for abuse/attempts
- [ ] Document token generation process
- [ ] Set appropriate expiration times
- [ ] Consider CDN integration (if using)

## Testing

**Test hotlinking is blocked:**
```bash
# Test without referer (should be blocked)
curl -I http://yourdomain.com/protected/image.jpg

# Test with invalid referer (should be blocked)
curl -e http://evil.com -I http://yourdomain.com/protected/image.jpg

# Test with valid referer (should succeed)
curl -e http://yourdomain.com -I http://yourdomain.com/protected/image.jpg

# Test with valid token (should succeed)
curl -I "http://yourdomain.com/protected/file.pdf?token=valid_token&expires=future_timestamp"
```

## Important Notes

- Referer checking can be bypassed but is simple to implement
- Token-based protection is more secure but requires URL generation
- Always use HTTPS to prevent token interception
- Set appropriate token expiration times (balance security vs. UX)
- Consider CDN implications (some CDNs have built-in hotlink protection)
- Monitor logs for abuse patterns
- For high-security requirements, use multiple protection layers

## Common Pitfalls

- **Allowing empty referers**: Some browsers/plugins strip referers - decide if you want to allow these
- **Token leakage in logs**: Ensure tokens don't appear in access logs
- **Clock sync issues**: Token expiration requires synchronized clocks for distributed systems
- **CDN caching**: Signed URLs may not cache well - use cache-key customization
- **Browser prefetching**: May trigger hotlink protection - handle gracefully
