# Anti-Hotlinking Protection Skill

A comprehensive skill for implementing anti-hotlinking (防盗链) protection for web resources.

## Overview

This skill helps you implement protection against unauthorized direct linking (hotlinking) to your web resources such as images, videos, documents, and other files. It provides implementation examples for various platforms and creates the warning UI matching the design shown in the reference image.

**⚠️ SECURITY NOTICE**: The code examples in this skill are illustrative examples for learning patterns. They are not production-ready code. Always add:
- Input validation & sanitization
- Comprehensive error handling
- Security audit & testing
- Rate limiting & monitoring
- Proper secret management

## 🚀 Getting Started

**New to this skill? Start here:**

1. **[QUICK_REFERENCE.md](QUICK_REFERENCE.md)** - Get started in 30 seconds with the decision tree
2. **[USER_GUIDE.md](USER_GUIDE.md)** - Comprehensive guide with examples and use cases
3. **[SKILL.md](SKILL.md)** - Full documentation (3,700+ lines) with complete implementations

**Quick example prompts:**
```bash
# Basic protection
"How do I prevent hotlinking with Nginx?"

# Token-based protection
"Implement token-based access control for Flask"

# Advanced protection
"Add OAuth + watermarking for premium video content"
```

## Features

### Core Protection Methods
- **Multiple Protection Methods**: Referer checking, token-based access, session-based validation
- **Cross-Platform Support**: Nginx, Apache, Node.js, Python/Flask, and more
- **Warning Page Generator**: Creates the "附件已做防盗链处理" warning UI
- **Security Best Practices**: Rate limiting, IP whitelisting, user-agent validation

### 🆕 Enhanced Capabilities

#### Decision Support
- **Quick Start Decision Tree**: Choose the right protection method in 30 seconds
- **Comprehensive Decision Guide**: Detailed comparison matrices for all scenarios
- **Method Comparison Tables**: Security, complexity, and use case analysis

#### Critical Security Information
- **⚠️ Limitations & What We DON'T Protect Against**: Clear expectations management
  - Screen capture & redistribution
  - Token sharing vulnerabilities
  - Insider threats
  - Offline access risks
  - Automated scraping limitations

- **🛡️ Failure Mode Handling**: Production-ready failure scenarios
  - Redis failures (fail-open vs fail-closed)
  - Clock skew mitigation
  - Secret key rotation procedures
  - CDN cache issues
  - Large file processing timeouts
  - Concurrent request race conditions

#### Advanced Integration
- **🔗 OAuth 2.0 Integration Patterns**: Multi-layer defense strategies
  - OAuth scopes for resource access
  - OAuth token + resource token combination
  - Auth0 integration examples
  - Okta integration examples
  - OAuth 2.0 token introspection
  - 4-layer defense architecture

#### Operations & Production
- **📊 Operations & Monitoring Guide**: Production deployment guidance
  - Prometheus metrics integration
  - Logging strategy with retention policies
  - Alerting rules (P1-P4 severity)
  - Key rotation procedures with zero downtime
  - Capacity planning for Redis and watermarking
  - CDN cost optimization

- **🧪 Comprehensive Testing Strategy**: Quality assurance framework
  - Unit tests with Pytest
  - Integration tests
  - Load tests with Locust
  - Security tests
  - Test coverage goals (>90%)
  - CI/CD pipeline examples

#### Enhanced Protection Methods
- **CDN-Level Protection**: CloudFront, Cloudflare Workers, S3 presigned URLs
- **Advanced Rate Limiting**: Fixed window and sliding window algorithms
- **Performance Benchmarks**: Hardware-specific timings for watermarking
  - Image watermarking: ~150-400ms on M1 Pro
  - PDF watermarking: ~50ms per page
  - Video watermarking: ~5-10s per minute of 1080p video

## Quick Start

Use our **30-second decision tree** to choose the right protection method:

```
START: What are you protecting?

├─ PUBLIC CONTENT (blog images, portfolio)
│  └─ Low/Medium traffic → Referer Checking
│  └─ High traffic → CDN + Referer
│
├─ PAID CONTENT (courses, premium docs)
│  ├─ Yes → Token-Based + OAuth
│  └─ No → Token-Based (short expiration)
│
├─ DOWNLOADABLE FILES
│  ├─ Small (<100MB) → S3 Presigned URLs
│  └─ Large (>100MB) → Token + Watermark
│
└─ INTERNAL DOCUMENTS
   └─ Session-Based
```

### Immediate Example: Referer Checking (Nginx)

Add to your nginx config:

```nginx
location ~* \.(jpg|jpeg|png|gif|pdf|doc|docx)$ {
    valid_referers none blocked yourdomain.com *.yourdomain.com;
    if ($invalid_referer) {
        return 403;
    }
}
```

That's it! You're protected. For more advanced use cases, read on.

### Token-Based Access (Node.js/Express)

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
```

## Files Included

- **[SKILL.md](SKILL.md)** - Comprehensive skill documentation (~3,700 lines)
  - 15 major sections with detailed implementation guides
  - Quick start decision tree
  - Platform-specific code examples (Nginx, Apache, Node.js, Python, etc.)
  - OAuth 2.0 integration patterns
  - Operations & monitoring guide
  - Testing strategy with CI/CD examples
  - Failure mode handling
  - Performance benchmarks

- **[hotlink-warning.html](hotlink-warning.html)** - Reference warning page UI
  - Modern, responsive design
  - Chinese text: "附件已做防盗链处理"
  - Standalone HTML file (no dependencies)

- **[prompts.md](prompts.md)** - Example prompts for using the skill
  - Basic implementation requests
  - Advanced feature requests
  - Framework-specific examples
  - Testing & debugging prompts

- **[USER_GUIDE.md](USER_GUIDE.md)** - Comprehensive user guide
  - How to use the skill effectively
  - Common use cases and example prompts
  - Quick start examples for all protection levels
  - Tips for best results

- **[QUICK_REFERENCE.md](QUICK_REFERENCE.md)** - Quick reference card
  - 30-second decision tree
  - Method comparison table
  - Essential code snippets
  - Production checklist

## Warning Page

The skill includes a ready-to-use warning page that displays:

> 附件已做防盗链处理
> 请在原文件中访问该附件

With a modern, responsive design matching the reference image.

## Usage Examples

### Basic Implementation

Generate Nginx configuration:
```
"Add nginx hotlink protection for my images"
```

Create token-based protection:
```
"Implement token-based access control for my PDF downloads"
```

Generate warning page:
```
"Create a防盗链 warning page with Chinese text"
```

### Advanced Features

Add rate limiting:
```
"Add Redis-based rate limiting to my protected resources"
```

Implement OAuth 2.0 integration:
```
"Combine OAuth authentication with token-based resource protection"
```

Add watermarking:
```
"Watermark images with user IDs to prevent redistribution"
```

Set up monitoring:
```
"Add Prometheus metrics and alerting for anti-hotlink protection"
```

### Operations & Testing

Test protection:
```
"Test if my hotlink protection is working"
```

Debug issues:
```
"Debug why token validation is failing"
```

Set up CI/CD:
```
"Create integration tests for anti-hotlink protection"
```

## Protection Methods Comparison

| Method | Security | Complexity | Best For | Not For |
|--------|----------|-----------|----------|---------|
| Referer Check | Low | Simple | Public content | APIs, sensitive data |
| Token-Based | High | Medium | Paid content, time-limited | Simple sites |
| Session-Based | High | High | Logged-in users | Public access |
| CDN Signed URLs | High | Medium | High traffic, global | Small sites |

### Advanced Protection Methods

| Method | Use Case | Example Platforms |
|--------|----------|-------------------|
| OAuth 2.0 + Token | User-specific, traceable | Auth0, Okta |
| Watermarking | Prevent redistribution | Images, PDFs, Videos |
| Rate Limiting | Prevent abuse | Redis-based |
| CDN Protection | Global scale | CloudFront, Cloudflare, S3 |

## Security Considerations

1. **Referer headers can be spoofed** - Use for basic protection only
2. **Tokens should expire** - Set appropriate expiration times (1-5 min for sensitive)
3. **Use HTTPS** - Prevent token interception
4. **Monitor abuse** - Log and analyze blocked attempts
5. **Rate limiting** - Add to prevent brute force attacks
6. **Key rotation** - Implement secret key rotation procedures
7. **Defense in depth** - Combine multiple methods for critical assets

### What Anti-Hotlinking DOES Well

✅ Prevent casual hotlinking from other websites
✅ Block embedding in iframes on unauthorized domains
✅ Reduce bandwidth theft
✅ Enforce access control at request time
✅ Track access patterns via token validation

### What Anti-Hotlinking DOESN'T Prevent

❌ Screen capture & redistribution (mitigation: watermarking)
❌ Token sharing by legitimate users (mitigation: short expiration)
❌ Insider threats with server access (mitigation: audit logs)
❌ Offline access after download (mitigation: DRM)
❌ Sophisticated scraping with spoofed headers (mitigation: rate limiting + CAPTCHA)

## Testing Your Protection

```bash
# Test without referer (should be blocked)
curl -I http://yourdomain.com/protected/image.jpg

# Test with valid token (should succeed)
curl -I "http://yourdomain.com/file.pdf?token=abc&expires=123456"
```

## Documentation Structure

The skill documentation is organized into 15 comprehensive sections:

1. **🚀 Quick Start** (30-second decision tree)
2. **Understanding Hotlinking** (what and why)
3. **Protection Methods Overview** (comparison table)
4. **Implementation by Platform** (Nginx, Apache, Node.js, Python, etc.)
5. **⚠️ Limitations & What We DON'T Protect Against** (critical expectations)
6. **🛡️ Failure Mode Handling** (production-ready scenarios)
7. **Rate Limiting** (Redis-based, fixed/sliding window)
8. **Watermarking** (Image/PDF/Video with performance benchmarks)
9. **🔗 Integration with OAuth 2.0** (Auth0, Okta, token introspection)
10. **Warning Pages** (UI templates)
11. **📊 Operations & Monitoring** (Prometheus, logging, alerting, capacity planning)
12. **🧪 Testing Strategy** (Pytest, Locust, security tests, CI/CD)
13. **🎯 Decision Guide** (which method for your scenario)
14. **Implementation Checklist** (step-by-step verification)
15. **Common Pitfalls** (what to avoid)

## Platform Support

- **Web Servers**: Nginx, Apache
- **Languages**: Node.js, Python, PHP, Go
- **Frameworks**: Express, Flask, Django, FastAPI
- **CDNs**: AWS CloudFront, Cloudflare Workers
- **Storage**: AWS S3 (presigned URLs)
- **Authentication**: OAuth 2.0, Auth0, Okta
- **Infrastructure**: Redis, Prometheus

## Performance Benchmarks

All performance timings are measured on **M1 Pro** hardware:

- **Image watermarking**: 150-400ms (5MB JPEG)
- **PDF watermarking**: 50ms per page
- **Video watermarking**: 5-10s per minute of 1080p video
- **Token validation**: <1ms
- **Rate limiting check**: 2-5ms (Redis)

## Testing Coverage

The skill includes comprehensive testing examples:

- **Unit tests**: Token generation/validation, rate limiting logic
- **Integration tests**: End-to-end protection flows
- **Load tests**: Locust-based performance testing
- **Security tests**: Token forgery, timing attack resistance
- **Coverage goal**: >90% line coverage, >85% branch coverage

## License

Apache-2.0

## Author

Quanchao Sun

## See Also

- [Agent Skills Specification](https://agentskills.io/specification)
- [OWASP Hotlinking Protection](https://cheatsheetseries.owasp.org/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.html)
