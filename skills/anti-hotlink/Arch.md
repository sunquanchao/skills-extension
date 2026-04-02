# Anti-Hotlink Skill Introduction

## Overview

The **anti-hotlink** skill is a comprehensive solution for implementing anti-hotlinking (防盗链) protection to prevent unauthorized direct linking to web resources like images, videos, documents, and files.

## Architecture

The skill provides a **multi-layer defense architecture** with four core protection methods:

```
┌─────────────────────────────────────────────────────────────┐
│                    Anti-Hotlink Architecture                 │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Layer 1: Referer Check (Simple)                            │
│  └─ Validates HTTP Referer header                           │
│                                                              │
│  Layer 2: Token-Based Access (Recommended)                  │
│  └─ Signed URLs with expiration timestamps                  │
│                                                              │
│  Layer 3: Session/Cookie-Based (Authenticated)              │
│  └─ User authentication + session validation                │
│                                                              │
│  Layer 4: OAuth 2.0 Integration (Enterprise)                │
│  └─ OAuth scopes + resource tokens + introspection          │
│                                                              │
│  Optional Enhancements:                                      │
│  ├─ Rate Limiting (Redis-based)                             │
│  ├─ Watermarking (Image/PDF/Video)                          │
│  └─ CDN Protection (CloudFront, Cloudflare, S3)             │
└─────────────────────────────────────────────────────────────┘
```

## Decision Process (30-Second Flow)

```
START: What are you protecting?
│
├─→ PUBLIC CONTENT (blog images, portfolio)
│   └─→ METHOD: Referer Checking (Nginx/Apache)
│       └─ 5 min implementation
│
├─→ PAID CONTENT (courses, premium docs)
│   └─→ METHOD: Token-Based + OAuth
│       └─ Signed URLs with user auth
│
├─→ DOWNLOADABLE FILES (software, archives)
│   └─→ METHOD: S3 Presigned URLs
│       └─ Time-limited access tokens
│
└─→ INTERNAL DOCUMENTS (company docs)
    └─→ METHOD: Session-Based + IP Whitelist
        └─ Requires active session
```

## Key Features

| Feature | Description |
|---------|-------------|
| **Cross-Platform** | Nginx, Apache, Node.js, Python/Flask, PHP, Go |
| **CDN Support** | AWS CloudFront, Cloudflare Workers, S3 |
| **OAuth Integration** | Auth0, Okta integration patterns |
| **Rate Limiting** | Redis-based fixed/sliding window |
| **Watermarking** | Image, PDF, Video with forensic tracing |
| **Monitoring** | Prometheus metrics, alerting rules |
| **Testing** | Pytest, Locust load tests, CI/CD examples |

## Files Structure

- [SKILL.md](SKILL.md) - Full documentation (~3,700 lines)
- [QUICK_REFERENCE.md](QUICK_REFERENCE.md) - 30-second decision tree
- [USER_GUIDE.md](USER_GUIDE.md) - Comprehensive usage guide
- [hotlink-warning.html](hotlink-warning.html) - Warning page UI template

## Limitations (What It Doesn't Protect)

- ❌ Screen capture & redistribution → Use watermarking
- ❌ Token sharing by users → Use short expiration + rate limiting
- ❌ Insider threats → Use audit logs + access controls
- ❌ Offline access after download → Requires DRM
- ❌ Sophisticated scraping → Use rate limiting + CAPTCHA
