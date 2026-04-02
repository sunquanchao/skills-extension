## 1. Setup

- [x] 1.1 Create directory structure for 7 new skills
- [x] 1.2 Rename original SKILL.md to SKILL.md.deprecated

## 2. Core Skill Implementation

- [x] 2.1 Create skills/anti-hotlink-core/SKILL.md with YAML frontmatter
- [x] 2.2 Add "When to Use" section with all original trigger phrases
- [x] 2.3 Add Quick Start decision tree (from original lines 38-88)
- [x] 2.4 Add "Specialized Skills" section with links to all 6 sub-skills
- [x] 2.5 Add "What to Do" section that routes to appropriate sub-skill
- [x] 2.6 Add "Important Notes" about limitations

## 3. Referer Skill Implementation

- [x] 3.1 Create skills/anti-hotlink-referer/SKILL.md with YAML frontmatter
- [x] 3.2 Add "When to Use" triggers for referer-based protection
- [x] 3.3 Extract Nginx configuration (original lines 233-244)
- [x] 3.4 Extract Apache configuration (original lines 247-254)
- [x] 3.5 Extract CDN-level protection guidance

## 4. Tokens Skill Implementation

- [x] 4.1 Create skills/anti-hotlink-tokens/SKILL.md with YAML frontmatter
- [x] 4.2 Add "When to Use" triggers for token-based protection
- [x] 4.3 Extract Node.js/Express signed URL implementation (original lines 257-315)
- [x] 4.4 Extract Python/Flask signed URL implementation (original lines 318-379)
- [x] 4.5 Extract CloudFront signed URLs implementation (original lines 381-500)

## 5. Rate Limiting Skill Implementation

- [x] 5.1 Create skills/anti-hotlink-rate-limiting/SKILL.md with YAML frontmatter
- [x] 5.2 Add "When to Use" triggers for rate limiting
- [x] 5.3 Extract fixed window rate limiting (original lines 1026-1120)
- [x] 5.4 Extract sliding window rate limiting (original lines 1122-1220)
- [x] 5.5 Extract comparison table and best practices

## 6. Watermarking Skill Implementation

- [x] 6.1 Create skills/anti-hotlink-watermarking/SKILL.md with YAML frontmatter
- [x] 6.2 Add "When to Use" triggers for watermarking
- [x] 6.3 Extract simple image watermarking (original lines 1509-1595)
- [x] 6.4 Extract tiled watermark pattern (original lines 1597-1688)
- [x] 6.5 Extract logo overlay watermarking (original lines 1691-1750)
- [x] 6.6 Extract PDF watermarking section
- [x] 6.7 Extract video watermarking guidance

## 7. OAuth Integration Skill Implementation

- [x] 7.1 Create skills/anti-hotlink-oauth/SKILL.md with YAML frontmatter
- [x] 7.2 Add "When to Use" triggers for OAuth integration
- [x] 7.3 Extract OAuth scopes pattern (original lines 2469-2546)
- [x] 7.4 Extract two-token pattern (original lines 2548-2660)

## 8. Operations Skill Implementation

- [x] 8.1 Create skills/anti-hotlink-operations/SKILL.md with YAML frontmatter
- [x] 8.2 Add "When to Use" triggers for operations
- [x] 8.3 Extract failure mode handling (original lines 2141-2464)
- [x] 8.4 Extract operations & monitoring guide (original lines 3026-3375)
- [x] 8.5 Extract testing strategy (original lines 3375-3653)
- [x] 8.6 Extract common pitfalls (original lines 2133-2141)

## 9. Verification

- [x] 9.1 Verify each skill file has valid YAML frontmatter
- [x] 9.2 Verify each skill has proper "When to Use" triggers
- [x] 9.3 Verify core skill links to all sub-skills
- [x] 9.4 Verify no content is lost from original skill
- [x] 9.5 Test skill triggering with various phrases
