---
name: translate-core
description: Core translation engine for markdown files with multi-language support, markdown structure preservation, and dual-version output. Use this skill when translating markdown files, preserving formatting during translation, or need to translate content programmatically. Works standalone or invoked by translate-watch.
---

# Core Translation Engine

This skill provides the core translation functionality for markdown files, with support for multiple languages, markdown structure preservation, and dual-version output management.

## What This Skill Does

- Translates markdown files between configured language pairs
- Preserves markdown structure (headers, lists, code blocks, tables, links)
- Maintains YAML frontmatter unchanged
- Skips code block content during translation
- Supports dual-version output (auto-generated and manual versions)
- Detects source language automatically
- Handles batch translation of multiple files
- Provides clear error reporting with file paths and reasons

## When to Use This Skill

Use this skill when:
- User asks to translate markdown files
- translate-watch detects file changes and triggers translation
- User needs to translate specific files or batches
- User invokes translation commands directly

## Configuration

The skill reads configuration from:
1. `.translate/config.json` (project-local)
2. `~/.translate/config.json` (global fallback)
3. Built-in defaults if no config exists

Required configuration fields:
```json
{
  "languageMappings": [{
    "source": "zh",
    "target": "en",
    "targetDir": "en",
    "suffix": "_english",
    "enabled": true
  }],
  "dualVersion": true
}
```

## Translation Workflow

### Step 1: Identify Files to Translate

**For standalone invocation:**
- Accept file paths or glob patterns as input
- Filter by configured `filePattern` (default: `*.md`)

**For batch/watcher invocation:**
- Receive list of file paths from caller
- No filtering needed (caller handles this)

### Step 2: Detect Source Language

For each file:
1. Read file content
2. Analyze character distribution:
   - Chinese characters (CJK Unified Ideographs)
   - Other language indicators
3. Match against configured `languageMappings`
4. Use first matching enabled mapping

**Auto-detection logic:**
```javascript
// Primary language = max character count
if (chineseCharCount > totalChars * 0.3) return "zh"
if (japaneseCharCount > totalChars * 0.3) return "ja"
// ... other languages
```

### Step 3: Parse Markdown Structure

Before translation:
1. Extract YAML frontmatter (if present between `---` markers)
2. Separate into sections:
   - Frontmatter (preserve unchanged)
   - Code blocks (preserve unchanged)
   - Inline code (preserve unchanged)
   - Links (preserve URLs, translate text)
   - Regular text (translate)

**Parsing example:**
```markdown
---
title: "保留"
---

# 标题
```python
代码不翻译
```
Text to [翻译](url) here.
```

Parsed as:
- Frontmatter: `---\ntitle: "保留"\n---` → keep
- Header: `# 标题` → translate "标题"
- Code block: ` ```python\n代码不翻译\n``` ` → keep
- Link: `[翻译](url)` → translate "翻译", keep `url`
- Text: `Text to ` and ` here.` → translate

### Step 4: Perform Translation

For each translatable section:
1. Use Claude's translation API
2. Translate from source → target language
3. Maintain technical accuracy and context
4. Preserve formatting markers

**Translation API usage:**
```
Source: zh → Target: en
Input: "数据集管理"
Output: "Dataset Management"
```

### Step 5: Preserve Markdown Structure

After translation, reassemble with proper structure:

**Headers:**
```markdown
Input:  ## 中文标题
Output: ## Chinese Title
```

**Lists:**
```markdown
Input:  - 第一项\n- 第二项
Output: - First item\n- Second item
```

**Code blocks (NOT translated):**
```markdown
Input:  ```python\nprint('中文')\n```
Output: ```python\nprint('中文')\n```
```

**Inline code (NOT translated):**
```markdown
Input:  使用 `print()` 函数
Output: Use `print()` function
```

**Links:**
```markdown
Input:  [中文链接](https://example.com)
Output: [Chinese Link](https://example.com)
```

### Step 6: Handle Dual-Version Output

If `dualVersion: true` in configuration:

**First translation of a file:**
1. Create `en/Filename_english.md` (auto-generated)
2. Create `en-manual/Filename_english.md` (manual template)
3. Both contain identical translated content

**Subsequent translations:**
1. Check if `en-manual/Filename_english.md` exists
2. If exists and differs from auto version:
   - Only update `en/Filename_english.md`
   - Preserve `en-manual/Filename_english.md` unchanged
3. If manual version doesn't exist:
   - Update `en/Filename_english.md`
   - Optionally create manual template

**Manual version detection:**
- Compare file modification times
- Compare file content (hash)
- If manual version is newer or different, consider it "manually curated"

### Step 7: Write Translated Files

**Output path construction:**
```javascript
// Suffix pattern (default)
const autoPath = `${targetDir}/${baseName}${suffix}.md`
const manualPath = `${targetDir}-manual/${baseName}${suffix}.md`

// Example: docs/README.md → en/README_english.md
```

**Atomic writes:**
1. Write to temporary file first
2. Only rename to final path on success
3. Prevents partial/corrupted files on errors

### Step 8: Error Handling

**Per-file errors:**
- Report file path and error reason
- Continue with remaining files in batch
- Don't create partial files for failed translations

**Error message format:**
```
Error translating docs/Guide.md:
  Translation API timeout (30s)

[3/5] files translated successfully
```

**Retry logic:**
- Network/API errors: Retry up to 3 times with exponential backoff
- Parse errors: Report immediately, don't retry
- Rate limit errors: Wait and retry after delay

## Batch Translation

For multiple files:
1. Process files sequentially (respect rate limits)
2. Show progress: `[2/5] Translating docs/API.md`
3. Report summary at end
4. Continue on individual file failures

**Batch progress output:**
```
Translating 5 files...

[1/5] docs/README.md → en/README_english.md ✓
[2/5] docs/Guide.md → en/Guide_english.md ✓
[3/5] docs/API.md ✗ (translation failed)
[4/5] docs/FAQ.md → en/FAQ_english.md ✓
[5/5] docs/CHANGELOG.md → en/CHANGELOG_english.md ✓

Complete: 4/5 files translated
Failed: docs/API.md (API timeout)
```

## Language Support

### Configurable Language Pairs

The skill supports any language pair configured in `languageMappings`:

**Chinese → English (default):**
```json
{
  "source": "zh",
  "target": "en",
  "targetDir": "en",
  "suffix": "_english"
}
```

**Chinese → Japanese:**
```json
{
  "source": "zh",
  "target": "ja",
  "targetDir": "ja",
  "suffix": "_japanese"
}
```

**English → Chinese:**
```json
{
  "source": "en",
  "target": "zh",
  "targetDir": "zh",
  "suffix": "_chinese"
}
```

### Language Auto-Detection

When source language is not specified:
1. Analyze file content for character patterns
2. Match against configured mappings
3. Use first matching enabled mapping
4. Report detected language if verbose mode

**Detection patterns:**
- Chinese: CJK Unified Ideographs (U+4E00–U+9FFF)
- Japanese: Hiragana (U+3040–U+309F) + Katakana (U+30A0–U+30FF) + Kanji
- Korean: Hangul syllables (U+AC00–U+D7AF)
- Latin scripts: ASCII + extended Latin

## File Naming Patterns

Supports multiple naming patterns via configuration:

**Suffix pattern (default):**
```
文件.md → en/文件_english.md
```

**Subdirectory pattern:**
```
文件.md → en/文件.md
```

**Locale code pattern:**
```
文件.md → en/文件_zh.md
```

**Custom suffix:**
```
文件.md → ja/文件_日本語.md
```

## Integration with translate-watch

When invoked by translate-watch:
1. Receive file path and language mapping
2. Translate according to configuration
3. Return success/failure status
4. Write to configured output directories

**Watcher API interface:**
```javascript
translateCore.translate({
  filePath: "/path/to/file.md",
  sourceLang: "zh",
  targetLang: "en",
  mapping: config.languageMappings[0]
})
// Returns: { success: true, autoPath: "...", manualPath: "..." }
```

## Important Notes

- **Quality**: Translate accurately while maintaining meaning and tone
- **Structure**: Never break markdown structure
- **Code blocks**: Keep unchanged - may contain Chinese comments
- **Links**: Preserve URLs and file paths exactly
- **Frontmatter**: Don't translate YAML - may contain English metadata
- **Atomicity**: Only write complete translations, never partial files

## Error Recovery

**On API failure:**
- Log error with timestamp
- Return error status to caller
- Don't create output files
- Allow retry on next invocation

**On file system errors:**
- Check directory exists (create if needed)
- Check write permissions
- Report specific error to user
- Continue with other files in batch

**On partial failures (batch):**
- Complete remaining files
- Report summary at end
- List all failed files with reasons
- Allow user to retry failed files
