# Anti-Hotlink Skill - Quick Reference

## 🎯 Choose Your Method in 30 Seconds

```
What are you protecting?
│
├─→ Blog images, portfolio → Referer Checking (5 min)
├─→ Paid courses, docs → Token-Based + OAuth (15 min)
├─→ File downloads → S3 Presigned URLs (10 min)
└─→ Internal docs → Session-Based (20 min)
```

---

## 💬 Example Prompts

### Basic Protection
- "How do I prevent hotlinking with Nginx?"
- "Generate Apache .htaccess for image protection."
- "Add token-based protection to my Flask app."

### Advanced Protection
- "Implement OAuth + token protection for premium content."
- "How do I watermark PDFs with user IDs?"
- "Set up rate limiting with Redis."

### Operational Guidance
- "What happens when Redis fails?"
- "How do I monitor blocked requests?"
- "Show me key rotation procedures."

---

## 📊 Method Comparison

| Method | Security | Complexity | Best For |
|--------|----------|------------|----------|
| Referer Check | ⭐ | Easy | Public content |
| Token-Based | ⭐⭐⭐ | Medium | Paid content |
| Session-Based | ⭐⭐⭐ | Medium | Logged-in users |
| CDN Signed URLs | ⭐⭐⭐ | Medium | High traffic |
| OAuth + Token + Watermark | ⭐⭐⭐⭐⭐ | Hard | Premium content |

---

## ⚠️ Key Limitations

Anti-hotlinking **DOES** prevent:
- ✅ Other sites embedding your content
- ✅ Unauthorized direct linking
- ✅ Bandwidth theft

Anti-hotlinking **DOES NOT** prevent:
- ❌ Screenshots and redistribution
- ❌ Users sharing tokens willingly
- ❌ Offline access to downloaded files

---

## 🚀 Quick Implementations

### Nginx Referer Checking
```nginx
location ~* \.(jpg|jpeg|png|gif)$ {
    valid_referers none blocked yourdomain.com *.yourdomain.com;
    if ($invalid_referer) {
        return 403;
    }
}
```

### Flask Token-Based Protection
```python
# Generate token
token, expires = generate_token('/files/doc.pdf', 3600)

# Validate token
if validate_token(token, '/files/doc.pdf', expires):
    return send_file('/files/doc.pdf')
```

---

## 📁 What's Included

- ✅ 15+ Python examples (Flask, Redis, AWS)
- ✅ 10+ JavaScript/Node.js examples
- ✅ Nginx & Apache configurations
- ✅ OAuth 2.0 integration (Auth0, Okta)
- ✅ Performance benchmarks
- ✅ Testing strategies (pytest, Locust)
- ✅ Operations & monitoring guides

---

## 💡 Pro Tips

1. **Start simple** - Use referer checking for public content
2. **Add layers** - Combine multiple methods for sensitive content
3. **Monitor everything** - Track blocked requests and validation failures
4. **Test thoroughly** - Use the provided pytest examples
5. **Plan for failures** - Implement fail-open strategies for Redis/CDN outages

---

## 🔧 Production Checklist

Before deploying to production:
- [ ] Add comprehensive input validation
- [ ] Implement full error handling
- [ ] Set up monitoring and alerting
- [ ] Configure log retention (90 days security, 30 days validation)
- [ ] Implement secret key rotation
- [ ] Conduct security audit
- [ ] Load test with Locust
- [ ] Set up CI/CD pipeline

---

**Need help? Just describe what you're protecting and ask!**
