---
name: anti-hotlink-core
description: Implement anti-hotlinking protection for web resources. Use when user wants to prevent unauthorized direct linking to images, files, or attachments; implement referer checking; create token-based access control; generate hotlink protection code; add防盗链 (anti-hotlink) functionality; protect API endpoints from unauthorized access; implement signed URL generation for resource access; show "请在原文件中访问该附件" (Please access in original file) warning pages; set up rate limiting for resource access; add watermarking for content protection; integrate OAuth 2.0 for authenticated resource access; configure CloudFront signed URLs; or implement bandwidth theft prevention.
metadata:
  author: Quanchao Sun
  version: "2.0"
---

# Anti-Hotlinking Core (Router)

This is the **entry point/router skill** for anti-hotlinking protection. It helps you identify the right specialized skill for your needs.

## When to Use

**Use this skill when the user wants to:**

- Prevent hotlinking of images, videos, documents, or other resources
- Implement referer-based access control
- Create token-based resource protection
- Generate "attachment has been anti-hotlinking processed" warning pages
- Add防盗链 (anti-hotlink) functionality to web applications
- Protect API endpoints from unauthorized access
- Implement signed URL generation for resource access
- Set up rate limiting for resource access
- Add watermarking for leak tracing
- Integrate OAuth 2.0 for authenticated resource access
- Configure CloudFront/S3 signed URLs
- Prevent bandwidth theft from direct linking

## Quick Start: Decision Tree

Use this decision tree to find the right specialized skill:

```
START: What are you protecting?
|
+--> PUBLIC CONTENT (blog images, portfolio, free resources)
|    +--> METHOD: Referer Checking
|         +--> Nginx/Apache config changes
|         +--> 5 minutes to implement
|         +--> USE: anti-hotlink-referer
|
+--> PAID CONTENT (courses, premium docs, subscriptions)
|    +--> METHOD: Token-Based Access
|         +--> Signed URLs with expiration
|         +--> HMAC/CloudFront signing
|         +--> USE: anti-hotlink-tokens
|
+--> API ABUSE / BANDWIDTH THEFT
|    +--> METHOD: Rate Limiting
|         +--> Redis-based rate limiting
|         +--> Per-IP and per-user limits
|         +--> USE: anti-hotlink-rate-limiting
|
+--> TRACE CONTENT LEAKS
|    +--> METHOD: Watermarking
|         +--> Image/PDF/video watermarks
|         +--> User-specific identification
|         +--> USE: anti-hotlink-watermarking
|
+--> OAUTH PROTECTED RESOURCES
|    +--> METHOD: OAuth Integration
|         +--> OAuth 2.0 authentication
|         +--> Access token validation
|         +--> USE: anti-hotlink-oauth
|
+--> OPS & MONITORING
     +--> METHOD: Operations & Testing
          +--> Failure mode handling
          +--> Monitoring and alerting
          +--> Testing strategies
          +--> USE: anti-hotlink-operations
```

## Specialized Skills

Once you've identified your use case, switch to the appropriate specialized skill:

### 1. [anti-hotlink-referer](../anti-hotlink-referer/SKILL.md)

**Purpose**: Nginx/Apache referer-based access control

**Use when**:
- Protecting public content (blog images, portfolio)
- Need simple, quick implementation (~5 minutes)
- Working with Nginx or Apache servers
- CDN-level referer filtering

**Provides**:
- Nginx valid_referers configuration
- Apache .htaccess rewrite rules
- CDN referer filtering (CloudFront, Cloudflare)
- Warning page integration

---

### 2. [anti-hotlink-tokens](../anti-hotlink-tokens/SKILL.md)

**Purpose**: Token-based access with signed URLs

**Use when**:
- Protecting paid/premium content
- Need time-limited access URLs
- Working with CloudFront, S3, or custom backends
- Require cryptographic security

**Provides**:
- HMAC-based signed URLs (Node.js, Python)
- CloudFront signed URLs (RSA-based)
- S3 presigned URLs
- Token validation middleware

---

### 3. [anti-hotlink-rate-limiting](../anti-hotlink-rate-limiting/SKILL.md)

**Purpose**: Redis-based rate limiting

**Use when**:
- Preventing API abuse
- Stopping bandwidth theft
- Need per-IP or per-user limits
- Combating automated scraping

**Provides**:
- Redis-based token bucket algorithm
- Per-IP and per-user rate limits
- Exponential backoff strategies
- Integration with Express, Flask, FastAPI

---

### 4. [anti-hotlink-watermarking](../anti-hotlink-watermarking/SKILL.md)

**Purpose**: Content watermarking for leak tracing

**Use when**:
- Need to trace content leaks to specific users
- Protecting images, PDFs, or videos
- Want forensic identification capability
- Building deterrent against sharing

**Provides**:
- Image watermarking (visible and invisible)
- PDF watermarking
- Video watermarking
- User-specific watermark embedding

---

### 5. [anti-hotlink-oauth](../anti-hotlink-oauth/SKILL.md)

**Purpose**: OAuth 2.0 integration for resource protection

**Use when**:
- Resources require user authentication
- Integrating with OAuth providers (Google, GitHub, etc.)
- Need access token validation
- Building SaaS or membership sites

**Provides**:
- OAuth 2.0 flow implementation
- Access token validation
- Session-based resource access
- Integration with major OAuth providers

---

### 6. [anti-hotlink-operations](../anti-hotlink-operations/SKILL.md)

**Purpose**: Operations, monitoring, and testing

**Use when**:
- Setting up monitoring for protected resources
- Implementing failure mode handling
- Creating test suites for protection logic
- Configuring alerts and dashboards

**Provides**:
- Failure mode handling strategies
- Monitoring and alerting setup
- Testing strategies (unit, integration, load)
- Operational runbooks

## What to Do

1. **Identify the use case**: Use the decision tree above to categorize the user's needs

2. **Delegate to specialized skill**: Switch to the appropriate skill based on the decision tree:
   - Public content -> anti-hotlink-referer
   - Paid content -> anti-hotlink-tokens
   - API abuse -> anti-hotlink-rate-limiting
   - Leak tracing -> anti-hotlink-watermarking
   - OAuth resources -> anti-hotlink-oauth
   - Ops/monitoring -> anti-hotlink-operations

3. **Combine methods when needed**: For comprehensive protection, multiple skills can be used together:
   - Tokens + Rate Limiting for paid APIs
   - Referer + Watermarking for public images
   - OAuth + Tokens for authenticated downloads

4. **Cross-reference limitations**: See the Important Notes section below for what anti-hotlinking does NOT protect against

## Important Notes

### Limitations of Anti-Hotlinking

Anti-hotlinking is ONE layer of protection, not a complete solution. Understanding what it doesn't protect against is critical:

**What Anti-Hotlinking Does NOT Prevent:**

1. **Screen Capture & Redistribution**: Users can screenshot content, print to PDF, or re-upload files elsewhere
   - Mitigation: Use watermarking (anti-hotlink-watermarking) to trace leaks

2. **Token Sharing**: Legitimate users can share access tokens with others
   - Mitigation: Use short expiration, session-binding, rate limiting

3. **Insider Threats**: Developers with server access can bypass protections
   - Mitigation: Audit logs, access controls, secrets management

4. **Offline Access**: Downloaded files are accessible indefinitely
   - Mitigation: DRM for video/audio, streaming protocols, online validation

5. **Sophisticated Scraping**: Scrapers can spoof referers, rotate IPs, use headless browsers
   - Mitigation: Rate limiting, CAPTCHA, behavioral analysis

**What Anti-Hotlinking DOES Well:**

- Prevents casual hotlinking from blogs, forums, other websites
- Blocks iframe embedding
- Reduces bandwidth theft
- Enforces access control (users must visit your site)
- Tracks unauthorized access attempts

### Security Notice

All implementations in these skills are ILLUSTRATIVE EXAMPLES for learning patterns. Before production use, add:

- Input validation & sanitization
- Comprehensive error handling
- Security audit & testing
- Proper secret management
- Rate limiting & monitoring

## Common Combinations

| Use Case | Skills to Combine |
|----------|-------------------|
| Premium video courses | anti-hotlink-tokens + anti-hotlink-watermarking |
| Public image gallery | anti-hotlink-referer + anti-hotlink-rate-limiting |
| SaaS document downloads | anti-hotlink-oauth + anti-hotlink-tokens |
| API with file endpoints | anti-hotlink-rate-limiting + anti-hotlink-tokens |
| Internal document portal | anti-hotlink-oauth + anti-hotlink-watermarking |

## Need Help Deciding?

If you're unsure which method to use, ask the user these questions:

1. **Is the content public or does it require authentication?**
2. **What type of content are you protecting?** (images, videos, documents, API endpoints)
3. **What's your primary concern?** (bandwidth theft, unauthorized access, content leaks)
4. **What's your server environment?** (Nginx, Apache, Node.js, Python, CloudFront)

The answers will map directly to the decision tree above.
