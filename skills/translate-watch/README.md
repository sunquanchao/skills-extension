# translate-watch

File watcher daemon for automatic markdown translation.

## Overview

`translate-watch` monitors directories for markdown file changes and automatically triggers translations. It provides real-time sync between source files and translated versions.

## Features

- **Real-time monitoring**: Detects file changes within 1 second
- **Debouncing**: Waits 2 seconds after last change before translating
- **Background daemon**: Runs independently of Claude Code session
- **Queue management**: Handles rapid changes efficiently
- **Auto-exclusion**: Prevents infinite loops by ignoring output directories
- **Graceful shutdown**: Completes in-progress translations before stopping
- **Status reporting**: Shows watched files, pending translations, uptime

## Installation

Part of the auto-translation system. Requires `translate-core` and `translate-config`.

## Quick Start

```bash
# 1. Initialize configuration
translate-config init

# 2. Start the watcher
translate-watch start

# 3. Edit files - they translate automatically!

# 4. Check status
translate-watch status

# 5. Stop when done
translate-watch stop
```

## Commands

### `translate-watch start`

Start the file watcher daemon.

**Example:**
```bash
$ translate-watch start
Starting translation watcher...
Watching: /Users/user/docs (23 .md files)
Language mapping: zh → en
Output: en/ (auto), en-manual/ (manual)
Debounce: 2 seconds

Watcher started (PID: 12345)
Press Ctrl+C or run 'translate-watch stop' to stop
```

**Large project warning:**
```bash
$ translate-watch start
Warning: 1,234 files will be monitored
This may impact performance. Consider:
- Limiting watchPaths to specific directories
- Using more specific filePattern

Continue anyway? [y/N]
```

### `translate-watch stop`

Stop the watcher daemon gracefully.

**Example:**
```bash
$ translate-watch stop
Stopping translation watcher...
Waiting for in-progress translations to complete...
[2/2] Translations complete

Watcher stopped
```

### `translate-watch status`

Check watcher status and statistics.

**Example (running):**
```bash
$ translate-watch status
Translation watcher status:
  State: Running
  PID: 12345
  Uptime: 2h 34m
  Watching: /Users/user/docs (23 files)
  Language: zh → en

  Since start:
    Translations completed: 47
    Current queue: 0 pending
    Last translation: 2m ago (docs/API.md)
```

**Example (stopped):**
```bash
$ translate-watch status
Translation watcher status: Stopped
Start with: translate-watch start
```

## How It Works

### File Monitoring

1. **Scan**: Configure `watchPaths` in `.translate/config.json`
2. **Watch**: Monitor for file creation and modification
3. **Filter**: Only process files matching `filePattern` (default: `*.md`)
4. **Exclude**: Ignore output directories (`en/`, `en-manual/`, etc.)

### Debouncing

Prevents redundant translations during rapid edits:

```
User edits file rapidly:
t=0s: Edit → queue file, start 2s timer
t=1s: Edit → reset timer (now t=3s)
t=2s: Edit → reset timer (now t=4s)
t=5s: No edits for 2s → translate file
```

### Translation Pipeline

1. File change detected
2. Add to queue with timestamp
3. Wait 2 seconds (reset on new changes)
4. Invoke `translate-core` to translate
5. Report success/failure
6. Process next item in queue

## Configuration

`translate-watch` reads from `.translate/config.json`:

```json
{
  "watchPaths": ["."],
  "filePattern": "*.md",
  "debounceMs": 2000,
  "languageMappings": [...]
}
```

### watchPaths

Directories to monitor. Can be multiple paths:

```json
"watchPaths": ["docs", "guides", "README.md"]
```

### filePattern

Glob pattern for files to watch:

```json
"filePattern": "*.md"           // All markdown files
"filePattern": "docs/**/*.md"   // Only in docs/ directory
"filePattern": "*_zh.md"        // Only Chinese files
```

### debounceMs

Milliseconds to wait after last change:

```json
"debounceMs": 2000  // 2 seconds (default)
"debounceMs": 5000  // 5 seconds (for slower workflows)
```

## Auto-Excluded Directories

These directories are automatically ignored to prevent infinite loops:

- `en/` - Auto-generated translations
- `en-manual/` - Manual translations
- `ja/`, `ko/`, etc. - Other language outputs
- `.translate/` - Configuration directory
- `node_modules/` - Dependencies
- `.git/` - Version control

## Process Management

### Background Operation

The watcher runs as a background daemon:
- Continues after closing Claude Code
- Detached from terminal
- Logs to `.translate/watcher.log`

### PID File

Process ID stored in `.translate/watcher.pid`:
- Prevents multiple instances
- Enables graceful shutdown
- Removed on clean exit

### Signal Handling

- **SIGTERM**: Graceful shutdown (complete queue)
- **SIGINT**: Immediate shutdown (abort queue)
- **SIGHUP**: Reload configuration

## Output and Logging

### Silent Operation

**Normal operation:**
- No console output for successful translations
- Errors reported immediately

**Logged to file:**
- `.translate/translations.log` with timestamps
- All translations (success and failure)

### Error Output

```
Error translating docs/Guide.md:
  Translation API timeout (30s)
```

### Verbose Mode (Optional)

Enable for detailed progress:

```
[1/3] Translating docs/README.md...
[2/3] Translating docs/Guide.md...
[3/3] Translating docs/API.md...
All translations complete
```

## Troubleshooting

### Watcher not starting

**Problem:** `translate-watch start` fails

**Solutions:**
1. Check if already running: `translate-watch status`
2. Remove stale PID file: `rm .translate/watcher.pid`
3. Verify configuration: `translate-config list`
4. Check directory exists and is accessible

### Files not being translated

**Problem:** Editing files doesn't trigger translation

**Solutions:**
1. Check watcher is running: `translate-watch status`
2. Verify files are in watched directories
3. Confirm files match `filePattern`
4. Check language mapping is enabled: `translate-config list`

### Infinite translation loop

**Problem:** Same file translates repeatedly, high CPU

**Cause:** Output directory not being excluded

**Solution:**
```bash
translate-watch stop
# Verify en/ and en-manual/ are in exclusion list
translate-watch start
```

### Performance issues

**Problem:** High CPU or memory usage

**Solutions:**
1. Reduce watched directories in `watchPaths`
2. Use more specific `filePattern`
3. Increase `debounceMs` to reduce triggers
4. Check file count (warns if > 1000 files)

## Performance Tips

### For Large Projects

```json
{
  "watchPaths": ["docs/**/*.md"],
  "filePattern": "*.md",
  "debounceMs": 5000
}
```

### For Specific Directories

```json
{
  "watchPaths": ["src/docs", "guides/api"],
  "filePattern": "*.md"
}
```

### For Rapid Development

```json
{
  "watchPaths": ["."],
  "filePattern": "*.md",
  "debounceMs": 1000
}
```

## Integration

### With translate-core

`translate-watch` automatically invokes `translate-core`:

1. Detects file change
2. Debounces rapid changes
3. Calls translate-core with file path
4. Handles success/failure
5. Updates queue

### With translate-config

Configuration changes require restart:

```bash
# Change configuration
translate-config add zh-ja

# Restart watcher to apply
translate-watch stop
translate-watch start
```

## Examples

### Watch specific directory

```bash
# Configure
translate-config init
# Edit .translate/config.json: "watchPaths": ["docs"]

# Start
translate-watch start
```

### Multiple language pairs

```bash
# Add mappings
translate-config add zh-ja
translate-config add zh-ko

# Start watcher
translate-watch start

# Files translate to both ja/ and ko/
```

### Manual workflow

```bash
# 1. Start watching
translate-watch start

# 2. Work normally - edit files

# 3. Check progress
translate-watch status

# 4. When done, stop
translate-watch stop
```

## See Also

- [translate-config](../translate-config/) - Configuration management
- [translate-core](../translate-core/) - Translation engine
- [translate-md](../translate-md/) - Manual batch translation
