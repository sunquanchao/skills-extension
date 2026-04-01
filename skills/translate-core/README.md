# translate-core

Core translation engine for markdown files with multi-language support and markdown structure preservation.

## Overview

`translate-core` provides the core translation functionality, translating markdown files between configured language pairs while preserving formatting, links, code blocks, and YAML frontmatter.

## Features

- **Multi-language support**: Configure any language pair
- **Structure preservation**: Headers, lists, tables, code blocks
- **Frontmatter handling**: Preserves YAML frontmatter unchanged
- **Link preservation**: Keeps URLs intact while translating link text
- **Dual-version output**: Auto-generated and manual versions
- **Language auto-detection**: Detects source language from content
- **Batch processing**: Translate multiple files efficiently
- **Error handling**: Continues on individual file failures

## Usage

`translate-core` is typically invoked by `translate-watch` when file changes are detected, but can also be used directly.

### Direct Invocation

When used directly, translate-core accepts file paths and translates according to configuration:

```
# Translate specific file
translate-core docs/README.md

# Translate multiple files
translate-core docs/*.md

# Translate with specific language mapping
translate-core docs/README.md --mapping zh-ja
```

### Automatic Language Detection

When source language is not specified, translate-core:
1. Analyzes file content for character patterns
2. Matches against configured language mappings
3. Uses first matching enabled mapping
4. Translates accordingly

### Dual-Version Output

When `dualVersion: true` in configuration:

**First translation:**
- Creates `en/Filename_english.md` (auto-generated)
- Creates `en-manual/Filename_english.md` (manual template)

**Subsequent translations:**
- Updates `en/Filename_english.md`
- Preserves `en-manual/Filename_english.md` if manually edited

## Markdown Preservation

### Headers

```markdown
Input:  ## 中文标题
Output: ## Chinese Title
```

### Lists

```markdown
Input:  - 第一项\n- 第二项
Output: - First item\n- Second item
```

### Code Blocks (NOT translated)

```markdown
Input:  ```python\nprint('中文')\n```
Output: ```python\nprint('中文')\n```
```

### Links

```markdown
Input:  [中文链接](https://example.com)
Output: [Chinese Link](https://example.com)
```

### YAML Frontmatter (NOT translated)

```markdown
---
title: "保留"
date: "2026-03-28"
---

# Content translated here
```

## Configuration

`translate-core` reads configuration from `.translate/config.json` or `~/.translate/config.json`.

Required configuration:

```json
{
  "languageMappings": [
    {
      "source": "zh",
      "target": "en",
      "targetDir": "en",
      "suffix": "_english",
      "enabled": true
    }
  ],
  "dualVersion": true
}
```

## Error Handling

### Per-File Errors

Translation failures are reported with file paths and reasons:

```
Error translating docs/Guide.md:
  Translation API timeout (30s)

[3/5] files translated successfully
Failed: docs/Guide.md
```

### Batch Processing

When translating multiple files:
- Continues processing after individual failures
- Reports summary at end
- Lists all failed files with reasons

```
Translating 5 files...

[1/5] docs/README.md → en/README_english.md ✓
[2/5] docs/Guide.md → en/Guide_english.md ✓
[3/5] docs/API.md ✗ (translation failed)
[4/5] docs/FAQ.md → en/FAQ_english.md ✓
[5/5] docs/CHANGELOG.md → en/CHANGELOG_english.md ✓

Complete: 4/5 files translated
```

## Language Support

### Supported Language Pairs

Any language pair can be configured:

**Chinese → English (default):**
```json
{"source": "zh", "target": "en", "targetDir": "en", "suffix": "_english"}
```

**Chinese → Japanese:**
```json
{"source": "zh", "target": "ja", "targetDir": "ja", "suffix": "_japanese"}
```

**English → Chinese:**
```json
{"source": "en", "target": "zh", "targetDir": "zh", "suffix": "_chinese"}
```

### Auto-Detection

Source language is detected from character content:
- **Chinese**: CJK Unified Ideographs (U+4E00–U+9FFF)
- **Japanese**: Hiragana + Katakana + Kanji
- **Korean**: Hangul syllables (U+AC00–U+D7AF)
- **Latin**: ASCII + extended Latin

## File Naming

Output file naming follows configured patterns:

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

## Integration

### With translate-watch

`translate-core` is automatically invoked by `translate-watch` when file changes are detected:

1. `translate-watch` detects file change
2. Queues file with debounce timer
3. Invokes `translate-core` to translate
4. Reports success/failure back to watcher

### API Interface

Programmatic usage:

```javascript
const result = await translateCore.translate({
  filePath: "/path/to/file.md",
  sourceLang: "zh",
  targetLang: "en",
  mapping: config.languageMappings[0]
})

// Returns:
// {
//   success: true,
//   autoPath: "en/Filename_english.md",
//   manualPath: "en-manual/Filename_english.md"
// }
```

## Performance

- **Sequential processing**: Respects API rate limits
- **Atomic writes**: Only saves complete translations
- **Memory efficient**: Processes one file at a time
- **Incremental**: Only translates changed files

## See Also

- [translate-config](../translate-config/) - Configuration management
- [translate-watch](../translate-watch/) - File watcher daemon
- [translate-md](../translate-md/) - Original batch translation skill

## Migration from translate-md

If you're using the original `translate-md` skill:

1. Your existing workflow continues to work
2. To migrate: `translate-config init`
3. Move existing translations to `en/` directory
4. Start automatic watcher: `translate-watch start`

Both skills can coexist - use whichever fits your workflow.
