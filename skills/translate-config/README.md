# translate-config

Configuration management for the auto-translation system.

## Overview

`translate-config` manages translation configuration including language mappings, output directories, and system settings. It supports both project-local and global configuration files.

## Installation

This skill is part of the auto-translation system. Ensure it's installed in your Claude Code skills directory.

## Quick Start

Initialize configuration for your project:

```
translate-config init
```

This creates `.translate/config.json` with default settings for Chinese → English translation.

## Commands

### `translate-config init`

Initialize configuration in the current directory.

**Example:**
```
$ translate-config init
Initialized translation configuration in .translate/config.json
Default mapping: zh → en (en/)
Edit the file to customize settings
```

### `translate-config add <source>-<target> [options]`

Add a new language mapping.

**Options:**
- `--target-dir <dir>`: Output directory (default: target language code)
- `--suffix <suffix>`: Filename suffix (default: "_english")

**Examples:**
```bash
# Add Chinese to Japanese
translate-config add zh-ja --target-dir ja --suffix _japanese

# Add English to Chinese
translate-config add en-zh --target-dir zh --suffix _chinese
```

### `translate-config list`

List all configured language mappings.

**Example:**
```
$ translate-config list

SOURCE  TARGET  DIRECTORY  SUFFIX      ENABLED
zh      en      en/        _english    ✓
zh      ja      ja/        _japanese   ✓
en      zh      zh/        _chinese    ✗

Total: 3 mappings (2 enabled)
```

### `translate-config remove <source>-<target>`

Remove a language mapping.

**Example:**
```bash
$ translate-config remove zh-ja
Removed language mapping: zh → ja
```

## Configuration File

Configuration is stored in `.translate/config.json`:

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
  "dualVersion": true,
  "watchPaths": ["."],
  "filePattern": "*.md",
  "debounceMs": 2000
}
```

### Configuration Fields

**languageMappings**: Array of language pair configurations
- `source`: Source language code (e.g., "zh", "en")
- `target`: Target language code (e.g., "en", "ja")
- `targetDir`: Output directory for translations
- `suffix`: Filename suffix for translated files
- `enabled`: Whether this mapping is active

**dualVersion**: Create both auto-generated and manual translation versions

**watchPaths**: Directories to monitor for file changes

**filePattern**: Glob pattern for files to translate (default: "*.md")

**debounceMs**: Milliseconds to wait after file change before translating

## Configuration Priority

1. `.translate/config.json` in current directory
2. Parent directory configurations (up to project root)
3. `~/.translate/config.json` (global fallback)
4. Built-in defaults

## Examples

### Default Chinese to English

```bash
translate-config init
# Creates .translate/config.json with zh → en mapping
```

### Multiple Language Pairs

```bash
translate-config add zh-ja --target-dir ja
translate-config add zh-ko --target-dir ko
translate-config add zh-fr --target-dir fr

translate-config list
# Shows all configured mappings
```

### Project-Specific Configuration

```bash
cd /path/to/project
translate-config init
# Edit .translate/config.json for project needs
```

## See Also

- [translate-core](../translate-core/) - Core translation engine
- [translate-watch](../translate-watch/) - File watcher daemon
- [translate-md](../translate-md/) - Original batch translation skill
