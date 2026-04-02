---
name: anti-hotlink-referer
description: Triggers for referer-based protection (Nginx, Apache, CDN, "referer checking", "hotlink protection"). Use when user wants simple protection for public content, mentions Nginx or Apache configuration, or asks about referer checking.
metadata:
  author: Quanchao Sun
  version: "2.0"
---

## SECURITY NOTICE

These are ILLUSTRATIVE EXAMPLES for learning patterns.
Before production use, add:

- Input validation & sanitization
- Comprehensive error handling
- Security audit & testing
- Rate limiting & monitoring
- Proper secret management

## When to Use

Use this skill when:

- User wants simple protection for public content (images, PDFs, documents)
- User mentions Nginx, Apache, or CDN configuration for hotlink protection
- User asks about "referer checking" or "referer-based protection"
- User wants a lightweight solution that doesn't require server-side code changes
- User needs quick implementation for casual content protection

**For stronger security**, refer to `anti-hotlink-core` for token-based and session-based methods.

## What to Do

### 1. Understand Referer-Based Protection

Referer checking validates the HTTP `Referer` header to ensure requests originate from authorized domains. This is:

- **Simple to implement** - No server-side code required
- **Easy to bypass** - Referer headers can be spoofed
- **Good for casual protection** - Deters most casual hotlinking
- **NOT suitable for paid content** - Use token-based methods instead

### 2. Implement Nginx Configuration

Add this to your Nginx server block:

```nginx
# Error Handling: Nginx will return 403 if invalid_referer
# Monitor error.log for blocked requests
location ~* \.(jpg|jpeg|png|gif|pdf|doc|docx)$ {
    valid_referers none blocked yourdomain.com *.yourdomain.com;
    if ($invalid_referer) {
        return 403;
        # OR redirect to warning page
        # rewrite ^/hotlink-warning.html last;
    }
}
```

**Configuration Notes:**
- `none` - Allows requests with no Referer header (direct access)
- `blocked` - Allows requests where Referer was removed by firewall/proxy
- Add all authorized domains to the `valid_referers` list
- Test with `nginx -t` before reloading

### 3. Implement Apache .htaccess Configuration

Add this to your `.htaccess` file in the protected directory:

```apache
# Error Handling: Apache returns 403 Forbidden
# Check error.log for blocked requests
RewriteEngine on
RewriteCond %{HTTP_REFERER} !^$
RewriteCond %{HTTP_REFERER} !^https?://(www\.)?yourdomain\.com [NC]
RewriteRule \.(jpg|jpeg|png|gif|pdf|doc|docx)$ - [F,NC,L]
```

**Configuration Notes:**
- `!^$` - Allows empty Referer header (direct access)
- `[NC]` - Case-insensitive matching
- `[F]` - Returns 403 Forbidden
- `[L]` - Last rule (stop processing)

### 4. CDN-Level Protection

#### CloudFlare Hotlink Protection

1. Log into CloudFlare dashboard
2. Go to **Speed > Optimization**
3. Enable **Hotlink Protection**
4. Add authorized domains to the allowlist

**Note:** CloudFlare's hotlink protection uses Referer checking at the edge.

#### AWS CloudFront

CloudFront doesn't have built-in Referer checking. Options:

1. **Use CloudFront Functions** to check Referer headers at the edge
2. **Use Origin Access Control (OAC)** with signed URLs for stronger protection
3. **Configure your origin** (Nginx/Apache) to check Referer headers

For paid or sensitive content, use **CloudFront Signed URLs** (see `anti-hotlink-core` skill).

## Important Notes

1. **Referer Can Be Spoofed**: Technical users can easily bypass Referer checking by:
   - Setting a fake Referer header
   - Using browser extensions
   - Accessing via command-line tools

2. **Good For Casual Protection**: Referer checking effectively deters:
   - Most website hotlinking
   - Casual image/file theft
   - Automated scraping tools

3. **Not For Paid Content**: For premium content, paid courses, or sensitive files:
   - Use token-based access (see `anti-hotlink-core`)
   - Implement session-based authentication
   - Consider DRM for video/audio content

4. **Empty Referer Considerations**:
   - Allowing empty Referer permits direct URL access
   - Blocking empty Referer breaks bookmarks and some privacy tools
   - Choose based on your security requirements

5. **Link to Method Selection**: For choosing the right protection method, refer to `anti-hotlink-core` skill which provides a comprehensive comparison of all protection strategies.

## Related Skills

- **anti-hotlink-core** - Core concepts and method selection guidance
- **anti-hotlink-token** - Token-based protection for secure access
- **anti-hotlink-session** - Session/cookie-based protection for authenticated users
