# Anti-Hotlinking Protection Skill

A comprehensive skill for implementing anti-hotlinking (防盗链) protection for web resources.

## Overview

This skill helps you implement protection against unauthorized direct linking (hotlinking) to your web resources such as images, videos, documents, and other files. It provides implementation examples for various platforms and creates the warning UI matching the design shown in the reference image.

## Features

- **Multiple Protection Methods**: Referer checking, token-based access, session-based validation
- **Cross-Platform Support**: Nginx, Apache, Node.js, Python/Flask, and more
- **Warning Page Generator**: Creates the "附件已做防盗链处理" warning UI
- **Security Best Practices**: Rate limiting, IP whitelisting, user-agent validation
- **Testing Tools**: Commands to verify protection is working

## Quick Start

### 1. For Nginx (Simple Referer-Based)

Add to your nginx config:

```nginx
location ~* \.(jpg|jpeg|png|gif|pdf|doc|docx)$ {
    valid_referers none blocked yourdomain.com *.yourdomain.com;
    if ($invalid_referer) {
        return 403;
    }
}
```

### 2. For Node.js/Express (Token-Based)

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

- **[SKILL.md](SKILL.md)** - Main skill documentation with implementation guides
- **[hotlink-warning.html](hotlink-warning.html)** - Reference warning page UI
- **[prompts.md](prompts.md)** - Example prompts for using the skill

## Warning Page

The skill includes a ready-to-use warning page that displays:

> 附件已做防盗链处理
> 请在原文件中访问该附件

With a modern, responsive design matching the reference image.

## Usage Examples

### Generate Nginx Configuration
```
"Add nginx hotlink protection for my images"
```

### Create Token-Based Protection
```
"Implement token-based access control for my PDF downloads"
```

### Generate Warning Page
```
"Create a防盗链 warning page with Chinese text"
```

## Protection Methods Comparison

| Method | Security | Complexity | Use Case |
|--------|----------|-----------|----------|
| Referer Checking | Low | Simple | Public websites, basic protection |
| Token-Based | High | Medium | Sensitive resources, time-limited access |
| Session-Based | High | Complex | User-specific resources, authenticated access |

## Security Considerations

1. **Referer headers can be spoofed** - Use for basic protection only
2. **Tokens should expire** - Set appropriate expiration times
3. **Use HTTPS** - Prevent token interception
4. **Monitor abuse** - Log and analyze blocked attempts
5. **Rate limiting** - Add to prevent brute force attacks

## Testing Your Protection

```bash
# Test without referer (should be blocked)
curl -I http://yourdomain.com/protected/image.jpg

# Test with valid token (should succeed)
curl -I "http://yourdomain.com/file.pdf?token=abc&expires=123456"
```

## License

Apache-2.0

## Author

Quanchao Sun

## See Also

- [Agent Skills Specification](https://agentskills.io/specification)
- [OWASP Hotlinking Protection](https://cheatsheetseries.owasp.org/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.html)
