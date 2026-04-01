## Context

The anti-hotlink skill currently provides a 345-line implementation guide with code examples for basic hotlinking protection. The existing structure includes: protection methods overview, web server configurations (Nginx/Apache), application-level code (Node.js/Python), HTML warning page, basic rate limiting, watermarking examples, and implementation checklist.

**Current State:**
- Single monolithic SKILL.md file (~345 lines)
- Code examples lack error handling
- No guidance on operational concerns (monitoring, logging, alerting)
- No testing strategy or examples
- No integration patterns with existing auth systems (OAuth, JWT)
- Missing explicit limitations documentation (what it doesn't protect against)
- No failure mode handling guidance
- No decision support for choosing protection methods

**Constraints:**
- Must remain a single monolithic skill file (user preference for "comprehensive reference guide")
- Code examples should be illustrative (not production-ready, but with try-catch blocks)
- Focus on P1 (critical) and P2 (important) gaps identified during exploration
- Must be maintainable and not become overwhelmingly verbose
- Include performance benchmarks for resource-intensive operations (watermarking)

**Stakeholders:**
- Claude Code users who need anti-hotlinking protection
- Developers implementing hotlink protection in production
- DevOps engineers operating protected systems
- Security architects reviewing protection strategies

## Goals / Non-Goals

**Goals:**
1. Transform the skill into a comprehensive production reference guide (~1,200 lines)
2. Add explicit documentation of limitations to manage user expectations
3. Provide failure mode handling guidance (what happens when things break)
4. Include OAuth 2.0 integration patterns for defense-in-depth
5. Add operations and monitoring guidance (metrics, logging, alerting, key rotation)
6. Provide complete testing strategy with pytest examples
7. Add decision support tools (trees, matrices) for method selection
8. Enhance all code examples with try-catch error handling
9. Add performance benchmarks for all watermarking operations
10. Expand CDN coverage with equal depth for all three platforms

**Non-Goals:**
- Creating separate skill files (keep monolithic)
- Providing production-ready code (examples remain illustrative)
- Implementing automated testing infrastructure (provide examples only)
- Adding new protection methods beyond CDN, token, referer, session
- Creating interactive tools (remain documentation/reference)
- Implementing actual monitoring/alerting systems (provide guidance only)

## Decisions

### Decision 1: Monolithic vs. Split Skill Structure

**Choice:** Keep single monolithic SKILL.md file (~1,200 lines)

**Rationale:**
- User explicitly chose "keep these functions in one skill"
- Easier to maintain and reference as complete guide
- Cross-references between sections simpler
- Single source of truth for anti-hotlinking

**Alternatives Considered:**
- Split into platform-specific skills (Nginx, Node.js, CDN) → Rejected due to user preference
- Split into functional skills (implementation, operations, testing) → Rejected due to fragmentation risk

---

### Decision 2: Illustrative Examples vs. Production-Ready Code

**Choice:** Provide illustrative examples with try-catch blocks (Level 2 error handling)

**Rationale:**
- User explicitly chose "examples" over production-ready code
- Balance between clarity and robustness
- Show error handling patterns without overwhelming verbosity
- Add prominent security warnings that these are examples

**Examples Style:**
```javascript
function generateToken(path, key, expires) {
    try {
        if (!path || typeof path !== 'string') {
            throw new Error('path must be a non-empty string');
        }
        // Core logic
        return signedUrl;
    } catch (error) {
        console.error('Token generation failed:', error);
        throw error;  // Re-throw for caller
    }
}
```

**Alternatives Considered:**
- Full production code (with logging, monitoring, retry logic) → Rejected due to verbosity
- Minimal examples (no error handling) → Rejected due to security concerns

---

### Decision 3: Security Warning Placement

**Choice:** Add prominent security notice at top of skill file

**Rationale:**
- Users might copy-paste examples directly
- Clear communication of limitations is critical
- Prevents false sense of security

**Warning Content:**
```markdown
⚠️ SECURITY NOTICE
These are ILLUSTRATIVE EXAMPLES for learning patterns.
Before production use, add:
- Input validation & sanitization
- Comprehensive error handling
- Security audit & testing
- Rate limiting & monitoring
- Proper secret management
```

---

### Decision 4: CDN Coverage Depth

**Choice:** Equal depth coverage for all three CDN platforms

**Platforms Covered:**
1. AWS CloudFront Signed URLs (~40 lines)
2. Cloudflare Workers Anti-Hotlink (~40 lines)
3. S3 Presigned URLs (~30 lines)

**Rationale:**
- User explicitly requested "show all three equally"
- Decision matrix helps users choose
- Each platform has different strengths and use cases

**Alternatives Considered:**
- Lead with CloudFront only → Rejected (user wanted equal coverage)
- Cover only most popular → Rejected (user requested all three)

---

### Decision 5: Watermarking Implementation Depth

**Choice:** Full implementation with all three formats (image, PDF, video)

**Rationale:**
- User explicitly requested "full implementation with image processing libraries"
- Comprehensive coverage makes skill valuable reference
- Performance benchmarks help users make informed decisions

**Implementations:**
- Image (sharp.js): Single text, tiled, logo overlay
- PDF (pdf-lib): Text watermark with font embedding
- Video (ffmpeg): Text/logo overlay with system requirements

**Performance Benchmarks Included:**
- Image: ~150-400ms on M1 Pro (5MB JPEG)
- PDF: ~50ms single page, ~3-5s for 100 pages
- Video: ~5-10s for 1min 1080p

**Alternatives Considered:**
- Image-only watermarking → Rejected (user wanted comprehensive)
- Conceptual patterns only → Rejected (user wanted full implementations)

---

### Decision 6: Rate Limiting Approach

**Choice:** Show both fixed-window and sliding-window with comparison

**Rationale:**
- User explicitly requested "show both sliding/fixed windows"
- Trade-offs between accuracy and complexity important
- Multi-dimensional limits (IP + token + global) add depth

**Comparison Provided:**
- Fixed window: 2-3 Redis operations, lower accuracy
- Sliding window: 4-5 Redis operations, higher accuracy
- Usage guidance for each approach

**Alternatives Considered:**
- Sliding window only → Rejected (user wanted both)
- Fixed window only → Rejected (less accurate)

---

### Decision 7: OAuth Integration Focus

**Choice:** Focus on OAuth 2.0 with Auth0 and Okta examples

**Rationale:**
- User explicitly requested "Integration oauth"
- OAuth 2.0 is industry standard
- Auth0 and Okta are popular providers
- Defense-in-depth architecture demonstration

**Patterns Included:**
1. OAuth scopes for resource access control
2. OAuth token + anti-hotlink token combination
3. Auth0 integration example
4. Okta integration example
5. OAuth 2.0 token introspection

**Alternatives Considered:**
- JWT-only integration → Rejected (user requested OAuth)
- Session-only integration → Too narrow
- Multiple providers (10+) → Too verbose, chose top 2

---

### Decision 8: Testing Framework Choice

**Choice:** Use pytest for Python examples

**Rationale:**
- User explicitly requested "include test code with pytest"
- Python has clear, readable test syntax
- Pytest ecosystem mature with good plugins
- Parallels Flask example in skill

**Testing Types Covered:**
- Unit tests (token generation/validation)
- Integration tests (full request flow)
- Load tests (Locust framework)
- Security tests (forgery prevention, timing attacks)
- CI/CD pipeline example (GitHub Actions)

**Alternatives Considered:**
- Jest (Node.js) → Rejected (user requested pytest)
- Multiple frameworks → Too verbose

---

### Decision 9: Documentation Structure

**Choice:** Add table of contents and use hierarchical sections

**Structure:**
```markdown
## Table of Contents
1. Quick Start [NEW]
2. Understanding Hotlinking
3. Protection Methods Overview
4. Implementation by Platform
5. ⚠️ Limitations [NEW]
6. Failure Mode Handling [NEW]
7. Rate Limiting
8. Watermarking
9. 🔗 Integration with OAuth 2.0 [NEW]
10. Warning Pages
11. 📊 Operations & Monitoring [NEW]
12. 🧪 Testing Strategy [NEW]
13. 🎯 Decision Guide [NEW]
14. Implementation Checklist
15. Common Pitfalls
```

**Rationale:**
- Clear navigation for 1,200-line document
- Visual indicators (⚠️ 🔗 📊 🧪 🎯) highlight new sections
- Logical flow from quick start → understanding → implementation → operations

---

### Decision 10: Performance Benchmark Format

**Choice:** Inline performance notes after each code example

**Format:**
```javascript
// ⏱️ Performance Notes
// - 5MB JPEG: ~150ms on M1 Pro
// - Scaling: O(n) where n = image dimensions
// - Memory: ~2x image size during processing
//
// Recommendations:
// - For high-volume: Pre-watermark during upload
// - For dynamic: Cache watermarked versions with short TTL
```

**Rationale:**
- Users need realistic expectations
- Helps choose between pre-processing vs. on-demand
- Hardware specified for context (M1 Pro)

**Alternatives Considered:**
- Separate benchmarks document → Rejected (harder to maintain)
- No hardware specification → Rejected (lack of context)

## Risks / Trade-offs

### Risk 1: Document Length (1,200 lines)

**Risk:** Skill file becomes difficult to navigate and maintain

**Mitigation:**
- Add comprehensive table of contents at top
- Use clear section headers with visual indicators
- Maintain hierarchical structure
- Consider adding "Quick Navigation" links

---

### Risk 2: Example Code Copied to Production

**Risk:** Users copy illustrative examples directly to production without proper hardening

**Mitigation:**
- Prominent security notice at top of file
- Clear statement that examples are illustrative
- List what's missing (validation, logging, monitoring, security audit)
- Use "⚠️" markers for security-critical sections

---

### Risk 3: Information Overload

**Risk:** Too much content overwhelms users who just need basic implementation

**Mitigation:**
- Quick Start section gets users running in 5 minutes
- Decision trees help narrow to relevant sections
- Clear hierarchy: Quick Start → Deep Dive → Operations
- "Start Here" guidance for different user types

---

### Risk 4: Performance Benchmarks Hardware-Specific

**Risk:** Benchmarks based on M1 Pro may not generalize to other hardware

**Mitigation:**
- Specify hardware clearly in all benchmarks
- Use relative comparisons where possible (O(n) notation)
- Provide scaling information, not absolute times
- Note that performance varies by hardware, load, network

---

### Risk 5: OAuth Integration Scope Creep

**Risk:** Too many OAuth providers or patterns make section unwieldy

**Mitigation:**
- Focus on OAuth 2.0 standard patterns
- Show only top 2 providers (Auth0, Okta)
- Keep examples illustrative, not comprehensive
- Reference provider documentation for details

---

### Risk 6: Testing Examples Not Actually Executed

**Risk:** Test code examples provided but never validated

**Mitigation:**
- Clearly label as "examples for reference"
- Provide pytest command to run if users want to validate
- Include CI/CD pipeline example for automated testing
- Note that examples assume test environment setup

---

### Risk 7: Maintenance Burden

**Risk:** 1,200-line document becomes stale as technologies evolve

**Mitigation:**
- Focus on patterns and principles, not specific versions
- Use version-agnostic examples where possible
- Document "last reviewed" dates for time-sensitive sections
- Modular structure allows updating sections independently

---

### Trade-off 1: Comprehensive vs. Concise

**Trade-off:** More comprehensive (1,200 lines) vs. More concise (345 lines)

**Decision:** Comprehensive

**Reason:** User explicitly chose "reference guide (comprehensive)" and wants P1 + P2 coverage

**Impact:** Longer document but single source of truth for all anti-hotlinking concerns

---

### Trade-off 2: Generic vs. Opinionated

**Trade-off:** Generic guidance (works for all) vs. Opinionated recommendations (what we think is best)

**Decision:** Balanced

**Approach:** Provide options for decision points (referer vs. token vs. CDN) with clear guidance on when to use each, but ultimately let users decide based on their context

---

### Trade-off 3: Code Example Verbosity

**Trade-off:** More verbose (with try-catch, validation) vs. Less verbose (just core logic)

**Decision:** Medium verbosity (Level 2 error handling)

**Approach:** Include try-catch and basic validation, but skip production concerns like detailed logging, retry logic, circuit breakers

## Migration Plan

This is a documentation enhancement, not a code change. No migration needed for existing systems.

**For Users of Current Skill:**
1. Existing implementations continue to work
2. New sections provide additional guidance (no breaking changes)
3. Enhanced examples with error handling are drop-in improvements
4. Can adopt new sections incrementally (operations, testing, OAuth)

**Rollback Strategy:**
- Documentation change only—no runtime impact
- If new sections cause confusion, can be clarified in follow-up
- Original 345-line content remains (just enhanced)

## Open Questions

1. **Video watermarking ffmpeg dependency:** Should we provide installation instructions for all platforms (macOS, Linux, Windows) or just reference ffmpeg documentation?
   - **Decision:** Include system requirements section with installation commands for all three platforms

2. **Performance benchmark hardware:** Should we provide benchmarks on multiple hardware configurations (e.g., Intel, AMD, ARM) or just M1 Pro?
   - **Decision:** M1 Pro only with clear labeling—adding multiple hardware configs would significantly increase document length

3. **Testing environment setup:** Should pytest examples include full test environment setup (requirements.txt, conftest.py, fixtures) or just test functions?
   - **Decision:** Include test environment setup to make examples runnable and complete

4. **Redis version compatibility:** Should Redis examples specify version requirements (e.g., Redis 6.0+ for atomic operations) or assume latest?
   - **Decision:** Specify minimum version requirements where operations depend on specific features

5. **Locale/charset in warning pages:** Should warning page HTML include charset declarations and language attributes for accessibility?
   - **Decision:** Yes, include proper HTML5 boilerplate with lang and charset attributes
