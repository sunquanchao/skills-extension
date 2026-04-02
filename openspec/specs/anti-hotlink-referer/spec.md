# anti-hotlink-referer Specification

## Purpose
TBD - created by archiving change split-anti-hotlink-skill. Update Purpose after archive.
## Requirements
### Requirement: Nginx referer checking
The skill SHALL provide complete Nginx configuration for referer-based hotlink protection.

#### Scenario: Basic Nginx protection
- **WHEN** user needs Nginx referer checking for images
- **THEN** skill provides valid nginx location block with valid_referers directive

### Requirement: Apache referer checking
The skill SHALL provide complete Apache .htaccess configuration for referer-based protection.

#### Scenario: Basic Apache protection
- **WHEN** user needs Apache referer checking
- **THEN** skill provides valid RewriteRule configuration

### Requirement: CDN-level referer rules
The skill SHALL provide guidance for implementing referer checking at CDN level (CloudFlare, CloudFront).

#### Scenario: CloudFlare protection
- **WHEN** user asks about CloudFlare hotlink protection
- **THEN** skill provides CloudFlare Page Rule configuration

