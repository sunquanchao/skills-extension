# Auto-Translation System - Quick Start Guide

## Overview

The auto-translation system provides real-time, automatic translation of markdown files as you edit them. It consists of three skills working together:

1. **translate-config** - Configuration management
2. **translate-core** - Translation engine
3. **translate-watch** - File watcher daemon

## Installation

Ensure all three skills are installed in your Claude Code skills directory:
- `translate-config/SKILL.md`
- `translate-core/SKILL.md`
- `translate-watch/SKILL.md`

## Basic Workflow

### 1. Initialize Configuration

```bash
translate-config init
```

This creates `.translate/config.json` with default settings:
- Language mapping: Chinese (zh) → English (en)
- Output directory: `en/` (auto-generated), `en-manual/` (manual)
- File pattern: `*.md`
- Debounce: 2 seconds

### 2. (Optional) Customize Configuration

Edit `.translate/config.json`:

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

### 3. Start the Watcher

```bash
translate-watch start
```

The watcher now monitors your markdown files for changes.

### 4. Edit Files Normally

As you edit `.md` files, translations happen automatically:
- Changes are detected within 1 second
- Translation triggers 2 seconds after last edit
- Output files are created in `en/` and `en-manual/`

### 5. Check Status

```bash
translate-watch status
```

Shows:
- Whether watcher is running
- Number of files being watched
- Translations completed
- Current queue status

### 6. Stop When Done

```bash
translate-watch stop
```

Gracefully stops the watcher, completing in-progress translations.

## Examples

### Translate Chinese Documentation

```bash
# Initialize
translate-config init

# Start watching
translate-watch start

# Edit docs/API.md (Chinese)
# Watcher automatically creates:
#   - en/API_english.md (auto-generated)
#   - en-manual/API_english.md (manual template)

# Check status
translate-watch status

# Stop when done
translate-watch stop
```

### Multiple Language Pairs

```bash
# Initialize
translate-config init

# Add Japanese
translate-config add zh-ja --target-dir ja --suffix _japanese

# Add Korean
translate-config add zh-ko --target-dir ko --suffix _korean

# List mappings
translate-config list

# Start watcher
translate-watch start

# Editing docs/README.md now creates:
#   - en/README_english.md
#   - ja/README_japanese.md
#   - ko/README_korean.md
```

### Project-Specific Configuration

```bash
cd /path/to/project

# Initialize project-specific config
translate-config init

# Edit .translate/config.json for project needs
# For example, only watch docs/ directory:
#   "watchPaths": ["docs"]

# Start watcher
translate-watch start
```

## Directory Structure

After initialization:

```
project/
├── .translate/
│   ├── config.json          # Configuration
│   ├── watcher.pid          # Watcher process ID
│   ├── queue.json           # Translation queue
│   ├── watcher.log          # Watcher logs
│   └── translations.log     # Translation logs
├── docs/
│   ├── API.md               # Source (Chinese)
│   └── Guide.md             # Source (Chinese)
├── en/
│   ├── API_english.md       # Auto-generated translation
│   └── Guide_english.md     # Auto-generated translation
└── en-manual/
    ├── API_english.md       # Manual translation (protected)
    └── Guide_english.md     # Manual translation (protected)
```

## Dual-Version Workflow

### First Translation

Both directories get identical content:
- `en/File_english.md` - Auto-generated
- `en-manual/File_english.md` - Manual template

### Subsequent Translations

- `en/File_english.md` - Updated automatically
- `en-manual/File_english.md` - Preserved if manually edited

### Manual Curation

1. Edit `en-manual/File_english.md` to refine translation
2. Auto-translations never overwrite your manual edits
3. `en/File_english.md` stays current with source changes

## Configuration Options

### Language Mappings

Add, list, or remove language pairs:

```bash
# Add mapping
translate-config add zh-ja --target-dir ja

# List all mappings
translate-config list

# Remove mapping
translate-config remove zh-ja
```

### Watch Paths

Configure which directories to monitor:

```json
"watchPaths": ["docs", "guides"]
```

### File Pattern

Control which files trigger translation:

```json
"filePattern": "*.md"              // All markdown
"filePattern": "docs/**/*.md"      // Only in docs/
"filePattern": "*_zh.md"           // Only Chinese files
```

### Debounce Interval

Adjust delay before translation:

```json
"debounceMs": 2000  // 2 seconds (default)
"debounceMs": 5000  // 5 seconds (slower)
"debounceMs": 1000  // 1 second (faster)
```

### Dual-Version Output

Enable/disable manual versions:

```json
"dualVersion": true   // Create both en/ and en-manual/
"dualVersion": false  // Only create en/
```

## Troubleshooting

### Watcher Won't Start

**Check if already running:**
```bash
translate-watch status
```

**Remove stale PID file:**
```bash
rm .translate/watcher.pid
translate-watch start
```

### Files Not Translating

**Check configuration:**
```bash
translate-config list
```

**Verify watcher is running:**
```bash
translate-watch status
```

**Check files match pattern:**
```bash
ls *.md
```

### Performance Issues

**Reduce watched scope:**
```json
"watchPaths": ["docs/**/*.md"]
"filePattern": "*.md"
```

**Increase debounce:**
```json
"debounceMs": 5000
```

## Migration from translate-md

If you're using the original `translate-md` skill:

1. **Both skills coexist** - No breaking changes
2. **Migrate gradually:**
   ```bash
   # Initialize new system
   translate-config init

   # Move existing translations to en/
   mv existing_translations/* en/

   # Start automatic watcher
   translate-watch start
   ```

3. **Fallback:** Original `translate-md` still works for manual batches

## Best Practices

### For Documentation Projects

- Use version control for both source and translations
- Commit `.translate/config.json` to share settings
- Add `en/` and `en-manual/` to `.gitignore` (generated content)
- Review `en-manual/` translations periodically

### For Multi-Language Teams

- Configure all needed language pairs upfront
- Use descriptive suffixes for each language
- Assign language-specific reviewers to manual versions
- Sync configuration across team via version control

### For Large Projects

- Limit `watchPaths` to specific directories
- Use more specific `filePattern`
- Monitor watcher status periodically
- Consider multiple watcher instances for different subdirectories

## Advanced Usage

### Global Configuration

Set default configuration for all projects:

```bash
# Edit global config
~/.translate/config.json

# Projects without local config inherit these defaults
```

### Background Operation

Watcher runs independently:
- Continue after closing Claude Code
- Survives terminal sessions
- Only stops with `translate-watch stop`

### Status Monitoring

Check watcher activity:
```bash
translate-watch status
# Shows uptime, translations completed, pending queue
```

## Support

For issues or questions:
- Check skill README files for detailed documentation
- Review `.translate/watcher.log` for watcher errors
- Review `.translate/translations.log` for translation errors
- Use `translate-config list` to verify configuration

## See Also

- [translate-config README](translate-config/README.md)
- [translate-core README](translate-core/README.md)
- [translate-watch README](translate-watch/README.md)
- [translate-md](translate-md/SKILL.md) - Original batch translation skill
