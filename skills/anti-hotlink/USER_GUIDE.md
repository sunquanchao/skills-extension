# Anti-Hotlink Skill - User Guide

## What This Skill Does

This skill helps you implement anti-hotlinking protection to prevent unauthorized websites from directly linking to your resources (images, videos, documents, etc.). It provides:

- **Quick implementation guides** for multiple protection methods
- **Production-ready patterns** for authentication, rate limiting, and monitoring
- **Decision support** to choose the right protection level for your use case
- **Complete examples** in Python, JavaScript, Nginx, and Apache

---

## How to Use This Skill

### Start with a Question

Simply describe what you want to protect:

> "How do I prevent hotlinking of my blog images?"
> "I need to protect premium video content from unauthorized access."
> "What's the best way to secure PDF downloads for paid users?"
> "Help me implement token-based protection for my API."

### Ask for Specific Implementations

Request code for your platform:

> "Show me Nginx configuration for referer checking."
> "Generate a Flask decorator for token-based access control."
> "Create a Node.js middleware for validating signed URLs."
> "How do I add watermarking to downloaded PDFs?"

### Get Decision Support

Not sure which method to use? Ask:

> "Which protection method should I use for [your scenario]?"
> "Compare token-based vs session-based protection."
> "What are the limitations of referer checking?"
> "How do I handle rate limiting failures?"

---

## Quick Start Examples

### 1. Basic Referer Checking (5 minutes)

**Prompt:** "How do I prevent hotlinking with Nginx?"

**Result:** Ready-to-use Nginx configuration:
```nginx
location ~* \.(jpg|jpeg|png|gif)$ {
    valid_referers none blocked yourdomain.com *.yourdomain.com;
    if ($invalid_referer) {
        return 403;
    }
}
```

### 2. Token-Based Protection (15 minutes)

**Prompt:** "Generate token-based protection for Flask with user-specific tokens."

**Result:** Complete Flask implementation with token generation, validation, and middleware.

### 3. Premium Content Protection (30 minutes)

**Prompt:** "I need to protect course videos with OAuth and watermarking."

**Result:** Full integration guide including:
- OAuth 2.0 authentication
- Token generation with user IDs
- FFmpeg watermarking workflow
- Rate limiting and monitoring

---

## Common Use Cases

### 📝 Blog/Portfolio Images
**Method:** Referer Checking + CDN
**Complexity:** Low
**Prompt:** "How do I protect my blog images from hotlinking?"

### 💎 Paid Content (Courses, Premium Docs)
**Method:** Token-Based + OAuth + Watermarking
**Complexity:** High
**Prompt:** "Help me implement protection for premium video courses."

### 📦 Downloadable Files (Software, PDFs)
**Method:** S3 Presigned URLs
**Complexity:** Medium
**Prompt:** "How do I secure file downloads with S3 presigned URLs?"

### 🔐 Internal Documents
**Method:** Session-Based
**Complexity:** Medium
**Prompt:** "How do I restrict document access to logged-in users?"

### 🌐 Public API
**Method:** API Keys + Rate Limiting
**Complexity:** High
**Prompt:** "Implement API key authentication and rate limiting."

---

## Decision Tree (30 Seconds)

Start here if you're not sure which method to use:

```
What are you protecting?
│
├─→ PUBLIC CONTENT (blog images, portfolio)
│   → Referer Checking (Nginx/Apache, 5 min)
│
├─→ PAID CONTENT (courses, premium docs)
│   → Token-Based + OAuth (15-30 min)
│
├─→ DOWNLOADABLE FILES (software, archives)
│   → S3 Presigned URLs (10 min)
│
└─→ INTERNAL DOCUMENTS (company docs)
    → Session-Based (20 min)
```

---

## Tips for Best Results

### 1. Be Specific About Your Stack
- ✅ "How do I implement token-based protection in Flask?"
- ✅ "Generate Nginx configuration for image hotlinking protection."
- ❌ "How do I prevent hotlinking?" (Too broad)

### 2. Describe Your Threat Model
- ✅ "I need to prevent users from sharing download links."
- ✅ "How do I stop other sites from embedding my images?"
- ✅ "I want to track who accesses each resource."

### 3. Ask About Limitations
- ✅ "What are the limitations of referer checking?"
- ✅ "Can users share tokens with others?"
- ✅ "What happens if Redis goes down?"

### 4. Request Production Guidance
- ✅ "How do I monitor token validation failures?"
- ✅ "What metrics should I track for rate limiting?"
- ✅ "How do I rotate secret keys without downtime?"

---

## Advanced Features

### OAuth 2.0 Integration
**Ask:** "Show me how to integrate anti-hotlinking with Auth0."
**Result:** Complete OAuth + token pattern implementation.

### Failure Mode Handling
**Ask:** "What happens when Redis fails?"
**Result:** Detection code and fail-open/fail-closed strategies.

### Performance Benchmarks
**Ask:** "How long does PDF watermarking take?"
**Result:** Hardware-specific benchmarks (M1 Pro) with optimization tips.

### Testing Strategy
**Ask:** "How do I test token validation?"
**Result:** pytest unit tests, integration tests, and Locust load tests.

---

## What You'll Get

When you use this skill, expect:

✅ **Complete code examples** - Ready to run with minor modifications
✅ **Error handling** - Try-catch blocks for common failures
✅ **Security warnings** - Clear guidance on production requirements
✅ **Performance expectations** - Benchmarks and bottlenecks identified
✅ **Limitations explained** - Honest assessment of what's protected
✅ **Operational guidance** - Monitoring, alerting, and maintenance

---

## Example Conversations

### Beginner Level
```
You: "How do I stop other sites from using my images?"

Skill: "Use Nginx referer checking. Here's a 5-line configuration
that blocks requests from other domains..."
```

### Intermediate Level
```
You: "I need to protect PDF downloads for paid users."

Skill: "Use token-based protection with expiration. Here's a Flask
implementation that generates user-specific tokens valid for 1 hour..."
```

### Advanced Level
```
You: "I'm building a video course platform. Users authenticate with
Auth0, I need to prevent link sharing, and I want to watermark videos
with user IDs."

Skill: "Implement a defense-in-depth approach:
1. OAuth authentication (verify user has access)
2. Token-based video URLs (5-minute expiration)
3. Dynamic watermarking with FFmpeg
4. Rate limiting (3 videos per minute)
Here's the complete implementation..."
```

---

## Important Notes

### ⚠️ These Are Illustrative Examples
All code examples are for learning patterns. Before production use:
- Add comprehensive input validation
- Implement full error handling
- Conduct security audit
- Set up monitoring and alerting
- Use proper secret management

### 🔒 Understand the Limitations
Anti-hotlinking protects against:
- ✅ Casual hotlinking from other websites
- ✅ Unauthorized direct linking
- ✅ Bandwidth theft

It does NOT prevent:
- ❌ Screenshots and redistribution
- ❌ Token sharing (if users choose to share)
- ❌ Offline access to downloaded files
- ❌ Insider threats (developers, leaked keys)

For complete content protection, consider combining:
- DRM (Digital Rights Management)
- Forensic watermarking
- Legal agreements (ToS, licensing)
- Encryption for sensitive data

---

## Getting Help

### If You're Not Sure Where to Start
1. Use the Quick Start decision tree (first section in skill)
2. Ask: "Which protection method should I use for [your scenario]?"
3. Review the Limitations section to understand what's protected

### If Something Isn't Clear
Ask for clarification:
- "Can you explain how token validation works?"
- "What's the difference between fixed and sliding window rate limiting?"
- "How do OAuth and anti-hotlink tokens work together?"

### If You Need Production Guidance
Ask for operational details:
- "How do I set up monitoring for blocked requests?"
- "What should I log for security audits?"
- "How do I rotate secret keys without downtime?"

---

## Quick Reference

| Protection Method | Complexity | Best For | Time to Implement |
|-------------------|------------|----------|-------------------|
| Referer Checking | Low | Public content, blogs | 5 minutes |
| Token-Based | Medium | Paid content, APIs | 15 minutes |
| Session-Based | Medium | Logged-in users | 20 minutes |
| CDN Signed URLs | Medium | High traffic, global | 10 minutes |
| OAuth + Token + Watermark | High | Premium content | 30+ minutes |

---

**Ready to protect your content? Just describe what you're trying to protect!**
