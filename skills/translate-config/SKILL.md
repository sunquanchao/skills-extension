---
name: translate-config
description: Configuration management for the auto-translation system. Use this skill when initializing translation configuration, adding/removing language mappings, listing configured languages, or managing translation settings. Triggers on commands like 'translate-config init', 'translate-config add', 'translate-config list', or when user asks to set up translation configuration.
---

# Translation Configuration Management

This skill manages configuration for the auto-translation system, including language mappings, directory structures, and system settings.

## What This Skill Does

- Initializes project configuration with sensible defaults
- Manages language pair mappings (source → target)
- Configures output directory patterns and naming conventions
- Supports project-local and global configuration files
- Provides CLI interface for all configuration operations

## When to Use This Skill

Use this skill when:
- User says `translate-config init`, `translate-config add`, `translate-config list`, or `translate-config remove`
- User asks to set up translation configuration for a project
- User wants to add or modify language mappings
- User needs to view or change translation settings

## Configuration Structure

Configuration is stored in JSON format at two locations:
- **Project-local:** `.translate/config.json` (takes precedence)
- **Global fallback:** `~/.translate/config.json` (used when no project config)

```json
{
  "languageMappings": [
    {
      "source": "zh",
      "target": "en",
      "targetDir": "en",
      "suffix": "_english",s
      "enabled": true
    }
  ],
  "dualVersion": true,
  "watchPaths": ["."],
  "filePattern": "*.md",
  "debounceMs": 2000
}
```

## Configuration Fields

### languageMappings
Array of language pair configurations. Each mapping defines:
- **source**: Source language code (e.g., "zh", "en")
- **target**: Target language code (e.g., "en", "ja")
- **targetDir**: Output directory for translations (e.g., "en", "ja")
- **suffix**: Filename suffix for translated files (e.g., "_english")
- **enabled**: Whether this mapping is active

### dualVersion
Boolean. If `true`, creates both auto-generated (`en/`) and manual (`en-manual/`) versions. If `false`, only creates auto-generated versions.

### watchPaths
Array of directory paths to monitor for file changes. Defaults to `["."]` for current directory.

### filePattern
Glob pattern for files to translate. Defaults to `"*.md"` for markdown files.

### debounceMs
Milliseconds to wait after file change before translating. Defaults to `2000` (2 seconds). Prevents redundant translations during rapid edits.

## Commands

### init
Initializes configuration in the current directory.

**Usage:** `translate-config init`

**Action:**
1. Create `.translate/` directory if it doesn't exist
2. Create `.translate/config.json` with default settings
3. Confirm initialization to user

**Example output:**
```
Initialized translation configuration in .translate/config.json
Default mapping: zh → en (en/)
Edit the file to customize settings
```

### add
Adds a new language mapping to the configuration.

**Usage:** `translate-config add <source>-<target> [options]`

**Options:**
- `--target-dir <dir>`: Output directory (default: target language code)
- `--suffix <suffix>`: Filename suffix (default: "_english")

**Action:**
1. Parse source-target pair (e.g., "zh-ja" for Chinese to Japanese)
2. Load existing configuration (project-local or global)
3. Add new mapping to `languageMappings` array
4. Save configuration
5. Confirm addition to user

**Example:**
```bash
translate-config add zh-ja --target-dir ja --suffix _japanese
```

Output:
```
Added language mapping: zh → ja
Target directory: ja/
Filename suffix: _japanese
```

### list
Lists all configured language mappings.

**Usage:** `translate-config list`

**Action:**
1. Load configuration (project-local or global)
2. Display all mappings in table format
3. Show source, target, directory, suffix, and enabled status

**Example output:**
```
Configured language mappings:

SOURCE  TARGET  DIRECTORY  SUFFIX      ENABLED
zh      en      en/        _english    ✓
zh      ja      ja/        _japanese   ✓
en      zh      zh/        _chinese    ✗

Total: 3 mappings (2 enabled)
```

### remove
Removes a language mapping from the configuration.

**Usage:** `translate-config remove <source>-<target>`

**Action:**
1. Parse source-target pair
2. Load configuration
3. Find and remove matching mapping
4. Save configuration
5. Confirm removal to user

**Example:**
```bash
translate-config remove zh-ja
```

Output:
```
Removed language mapping: zh → ja
```

## Configuration Resolution Order

1. Check `.translate/config.json` in current directory
2. If not found, check parent directories (up to project root)
3. If no project config found, use `~/.translate/config.json`
4. If no global config, use built-in defaults

## Error Handling

### No configuration found
When no configuration exists and command requires it:
- Suggest running `translate-config init` first
- Offer to create default configuration

### Invalid language codes
When user provides invalid ISO language codes:
- Show error with valid examples (zh, en, ja, ko, etc.)
- Suggest correcting the command

### Configuration file errors
When config file has invalid JSON:
- Show parse error location
- Suggest fixing or reinitializing

## Integration with Other Skills

This skill provides configuration used by:
- **translate-core**: Reads language mappings and output patterns
- **translate-watch**: Reads watch paths and debounce settings

Configuration changes take effect on next translation or watcher restart.
