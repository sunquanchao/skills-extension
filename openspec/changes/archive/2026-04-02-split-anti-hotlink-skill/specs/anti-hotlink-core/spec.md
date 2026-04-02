## ADDED Requirements

### Requirement: Core skill provides decision tree
The anti-hotlink-core skill SHALL provide a quick start decision tree to help users select the appropriate protection method.

#### Scenario: User needs simple image protection
- **WHEN** user asks about protecting public images or blog content
- **THEN** skill recommends referer checking and links to anti-hotlink-referer

#### Scenario: User needs paid content protection
- **WHEN** user asks about protecting premium or subscription content
- **THEN** skill recommends token-based access and links to anti-hotlink-tokens

### Requirement: Core skill links to specialized skills
The core skill SHALL contain links to all specialized anti-hotlink sub-skills with brief descriptions.

#### Scenario: User wants rate limiting
- **WHEN** user asks about API abuse prevention or rate limiting
- **THEN** skill links to anti-hotlink-rate-limiting

#### Scenario: User wants watermarking
- **WHEN** user asks about tracing leaks or watermarking content
- **THEN** skill links to anti-hotlink-watermarking

### Requirement: Core skill handles backward compatibility
The core skill SHALL respond to all original trigger phrases from the monolithic anti-hotlink skill.

#### Scenario: Original trigger phrase used
- **WHEN** user says "implement anti-hotlinking" or "add 防盗链 protection"
- **THEN** core skill activates and presents the decision tree
