# Example Prompts for Anti-Hotlinking Skill

## Basic Implementation Requests

- "Add anti-hotlinking protection to my images"
- "Implement防盗链 for my PDF files"
- "Prevent other websites from linking to my resources"
- "Add referer checking to my nginx server"
- "Create token-based access control for my downloads"
- "Which protection method should I use for my use case?"

## Warning Page Requests

- "Create a warning page for blocked hotlink requests"
- "Show '附件已做防盗链处理' message when access is denied"
- "Design an anti-hotlink warning UI"
- "Create a page that says '请在原文件中访问该附件'"

## Code Generation Requests

- "Generate nginx hotlink protection configuration"
- "Write Apache .htaccess rules for blocking hotlinking"
- "Implement signed URL generation in Node.js"
- "Create token validation middleware for Express"
- "Write Python Flask code for resource protection"
- "Add error handling to my token validation code"

## Advanced Features

- "Add rate limiting to protected resources"
- "Implement user-specific watermarks on images"
- "Create expiring download links with tokens"
- "Add IP whitelisting for file access"
- "Monitor and log hotlinking attempts"

## OAuth 2.0 Integration

- "Integrate anti-hotlink protection with OAuth 2.0"
- "Combine Auth0 authentication with token-based protection"
- "Add OAuth scopes to control resource access"
- "Implement token introspection for validation"
- "Create multi-layer defense with OAuth + resource tokens"

## Operations & Monitoring

- "Add Prometheus metrics for anti-hotlink protection"
- "Set up alerting for high block rates"
- "Implement key rotation without downtime"
- "Create logging strategy for blocked requests"
- "Calculate capacity planning for Redis rate limiting"

## Testing & Debugging

- "Test if my hotlink protection is working"
- "Why are my images showing 403 errors?"
- "Debug token validation failing"
- "Check if my nginx referer rules are correct"
- "Test signed URL generation and validation"
- "Create unit tests for token generation"
- "Set up load testing with Locust"
- "Add integration tests for protection flows"

## Framework-Specific Requests

- "Add hotlink protection to my Next.js app"
- "Implement防盗链 in Django"
- "Create signed URLs for S3 resources"
- "Add token authentication to API endpoints"
- "Protect uploads in PHP application"

## CDN-Level Protection

- "Set up CloudFront signed URLs"
- "Implement Cloudflare Workers anti-hotlink protection"
- "Create S3 presigned URLs for file access"
- "Configure CDN cache for signed URLs"

## Failure Mode Handling

- "Handle Redis connection failures in rate limiter"
- "Mitigate clock skew in token expiration"
- "Implement fail-open vs fail-closed strategy"
- "Handle large file watermarking timeouts"
- "Add retry logic for transient failures"

## Decision Support

- "Which protection method for my blog images?"
- "Should I use referer checking or token-based?"
- "Compare protection methods for my use case"
- "When should I combine multiple protection methods?"
- "What are the limitations of anti-hotlinking?"
