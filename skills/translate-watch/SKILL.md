---
name: translate-watch
description: File watcher daemon for automatic markdown translation. Monitors directories for file changes and triggers translation. Use this skill when starting automatic translation monitoring, stopping the watcher, checking watcher status, or setting up real-time translation sync.
---

# File Watcher for Automatic Translation

This skill provides real-time file monitoring and automatic translation triggering for markdown files.

## What This Skill Does

- Monitors configured directories for markdown file changes
- Detects file creation and modification events
- Debounces rapid successive changes (2-second default)
- Invokes translate-core for actual translation
- Manages background daemon process (start, stop, status)
- Maintains queue of pending translations
- Reports progress and errors

## When to Use This Skill

Use this skill when:
- User says `translate-watch start`, `translate-watch stop`, or `translate-watch status`
- User wants automatic translation as they edit files
- User needs to start/stop real-time translation monitoring
- User asks to watch files for changes and auto-translate

## Configuration

The skill reads configuration from `.translate/config.json`:
```json
{
  "watchPaths": ["."],
  "filePattern": "*.md",
  "debounceMs": 2000,
  "languageMappings": [...]
}
```

**watchPaths**: Directories to monitor (default: current directory)
**filePattern**: Glob pattern for files to watch (default: `*.md`)
**debounceMs**: Milliseconds to wait after last change before translating (default: 2000)

## Process Lifecycle

### Starting the Watcher

**Command:** `translate-watch start`

**Actions:**
1. Check if watcher already running (PID file exists)
2. If running, report status and offer to restart
3. Count files to watch (warn if > 1000 files)
4. Create PID file: `.translate/watcher.pid`
5. Start file monitoring daemon
6. Confirm start to user

**Example output:**
```
Starting translation watcher...
Watching: /Users/user/docs (23 .md files)
Language mapping: zh → en
Output: en/ (auto), en-manual/ (manual)
Debounce: 2 seconds

Watcher started (PID: 12345)
Press Ctrl+C or run 'translate-watch stop' to stop
```

**Large project warning (>1000 files):**
```
Warning: 1,234 files will be monitored
This may impact performance. Consider:
- Limiting watchPaths to specific directories
- Using more specific filePattern

Continue anyway? [y/N]
```

### Stopping the Watcher

**Command:** `translate-watch stop`

**Actions:**
1. Check if watcher is running (read PID file)
2. Send graceful shutdown signal
3. Wait for in-progress translations to complete (max 30 seconds)
4. Force kill if doesn't stop gracefully
5. Remove PID file
6. Confirm stop to user

**Graceful shutdown behavior:**
- Stop accepting new file change events
- Complete all queued translations
- Save progress state
- Exit cleanly

**Example output:**
```
Stopping translation watcher...
Waiting for in-progress translations to complete...
[2/2] Translations complete

Watcher stopped
```

### Checking Status

**Command:** `translate-watch status`

**Actions:**
1. Check if watcher is running (PID file exists, process alive)
2. If running, report:
   - Process ID
   - Uptime (duration since start)
   - Files being watched
   - Translations pending/complete
   - Last translation time
3. If not running, report stopped state

**Example output (running):**
```
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

**Example output (stopped):**
```
Translation watcher status: Stopped
Start with: translate-watch start
```

## File Monitoring

### Detection Events

**File created:**
- When a new .md file is created in watched directory
- Add to translation queue
- Trigger debounce timer

**File modified:**
- When an existing .md file is saved
- Add to translation queue
- Reset debounce timer

**File deleted:**
- Ignore deletion events (no translation action)
- Don't remove translated files

**Non-markdown files:**
- Ignore completely (not watched)
- Don't trigger any actions

### Debouncing

**Purpose:** Prevent redundant translations during rapid edits

**Mechanism:**
1. File change detected → add to queue with timestamp
2. Start 2-second timer
3. If another change for same file within 2 seconds:
   - Reset timer
   - Update timestamp
4. After 2 seconds of no changes:
   - Translate file with final content
   - Remove from queue

**Example:**
```
User edits file rapidly:
t=0s: Edit → queue file, start 2s timer
t=1s: Edit → reset timer (now t=3s)
t=2s: Edit → reset timer (now t=4s)
t=3s: Edit → reset timer (now t=5s)
t=5s: No edits for 2s → translate file
```

### Excluded Directories

**Auto-excluded from watching:**
- `en/` - Auto-generated translations (would cause infinite loop)
- `en-manual/` - Manual translations
- `ja/` - Other language output directories
- `.translate/` - Configuration directory
- `node_modules/` - Dependencies
- `.git/` - Version control

**Rationale:** Prevents infinite translation loops and ignores generated files

## Translation Queue

### Queue Management

**Queue structure:**
```javascript
{
  "pending": [
    {
      "filePath": "/path/to/file.md",
      "lastChange": 1640995200000,
      "scheduled": 1640995202000
    }
  ],
  "processing": [],
  "complete": []
}
```

**Processing order:**
- FIFO (first in, first out)
- One file at a time (respect rate limits)
- Skip duplicates (same file, newer timestamp)

### Queue Persistence

**State file:** `.translate/queue.json`

Saved periodically to allow recovery after crash or restart:
- Pending translations
- Completed translations (for status reporting)
- Timestamps for debounce calculation

## Integration with translate-core

**Calling translation:**
```javascript
// When file is ready for translation
const result = await translateCore.translate({
  filePath: queuedItem.filePath,
  autoDetectLanguage: true,
  config: loadConfig()
})

if (result.success) {
  console.log(`✓ ${result.autoPath}`)
} else {
  console.error(`✗ ${queuedItem.filePath}: ${result.error}`)
}
```

**Queue processing:**
1. Take next pending item from queue
2. Invoke translate-core
3. Mark as complete or failed
4. Continue to next item
5. Report batch summary

## Output During Operation

### Silent Normal Operation

**Successful translations:**
- No console output (silent operation)
- Log to `.translate/translations.log`
- User only sees errors

**Error output:**
```
Error translating docs/Guide.md:
  Translation API timeout (30s)
```

### Status Updates (Optional)

If user enables verbose mode:
```
[1/3] Translating docs/README.md...
[2/3] Translating docs/Guide.md...
[3/3] Translating docs/API.md...
All translations complete
```

## Error Handling

### File System Errors

**Watch directory not found:**
```
Error: Watch directory not found: /path/to/docs
Please check watchPaths in .translate/config.json
```

**Permission denied:**
```
Error: Cannot watch /path/to/docs (permission denied)
Fix permissions or choose different directory
```

### Translation Errors

**API timeout:**
```
Error translating docs/Guide.md: API timeout
File queued for retry (will retry in 60s)
```

**Rate limit:**
```
Rate limit reached. Pausing for 30s...
[2/5] files remaining in queue
```

**Parse error:**
```
Error: Invalid markdown in docs/File.md
Skipping this file
```

### Recovery Actions

**On API failure:**
- Queue file for retry (exponential backoff)
- Continue with other files
- Report error to user

**On watcher crash:**
- Save queue state
- User can restart with `translate-watch start`
- Queued files will be processed

## Background Process

### PID File

**Location:** `.translate/watcher.pid`

**Content:**
```
12345
```

**Purpose:**
- Track if watcher is running
- Enable graceful shutdown
- Prevent multiple instances

**Cleanup:**
- Removed on graceful shutdown
- May need manual removal if crashed

### Daemon Behavior

**Run in background:**
- Detach from terminal
- Continue running after user closes session
- Log output to `.translate/watcher.log`

**Signal handling:**
- SIGTERM: Graceful shutdown (complete queue)
- SIGINT: Immediate shutdown (abort queue)
- SIGHUP: Reload configuration

## Troubleshooting

### Watcher not starting

**Check:**
- Is another watcher already running? (`translate-watch status`)
- Are watchPaths valid directories?
- Does .translate/config.json exist and is valid JSON?

**Solution:**
- Stop existing watcher: `translate-watch stop`
- Fix configuration: `translate-config init`
- Remove stale PID file: `rm .translate/watcher.pid`

### Files not being translated

**Check:**
- Are files in watched directories?
- Do files match filePattern?
- Is language mapping configured correctly?

**Solution:**
- Check status: `translate-watch status`
- Verify files match pattern: `ls *.md`
- List language mappings: `translate-config list`

### Infinite translation loop

**Symptoms:**
- Same file translates repeatedly
- CPU usage high
- Disk I/O constant

**Cause:** Output directory not excluded from watching

**Solution:**
- Stop watcher: `translate-watch stop`
- Verify en/ and en-manual/ are excluded
- Restart watcher: `translate-watch start`
- Check .translate/watcher.log for exclusions

## Performance Considerations

### Large Projects

**Recommendations:**
- Limit watchPaths to specific directories
- Use more specific filePattern (e.g., `docs/**/*.md`)
- Consider splitting into multiple watcher instances

**Monitoring:**
- Check file count in status output
- Monitor CPU/memory usage
- Adjust debounce interval if needed

### Rate Limiting

**To avoid API rate limits:**
- Process queue sequentially (not parallel)
- Add delay between translations (configurable)
- Implement exponential backoff on errors

**Configuration:**
```json
{
  "translationDelayMs": 1000,
  "maxRetries": 3
}
```
