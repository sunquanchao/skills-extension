# Upgrade Guide: From translate-md to Auto-Translation System

## Overview

This guide helps you migrate from the manual `translate-md` skill to the new auto-translation system while maintaining backward compatibility.

## What's New

### Before (translate-md)
- Manual batch translation
- Explicit triggering required
- Single output directory
- No real-time sync

### After (Auto-Translation System)
- Real-time automatic translation
- File watcher daemon
- Dual-version output (auto + manual)
- Multi-language support
- Configurable mappings

## Compatibility

**Good news:** Both systems can coexist!
- `translate-md` continues to work unchanged
- New system installs alongside old system
- No breaking changes to existing workflows
- Gradual migration path

## Migration Paths

### Option 1: Parallel Operation (Recommended)

Use both systems simultaneously:
- `translate-md` for manual batch operations
- Auto-translation system for real-time sync
- Choose per-situation

**Steps:**
1. Keep using `translate-md` as before
2. Install new auto-translation system
3. Use auto-translation for new projects
4. Use `translate-md` for one-off batches

### Option 2: Full Migration

Replace `translate-md` with auto-translation system:
- Uninstall or ignore `translate-md`
- Use auto-translation for everything
- Manual batches via `translate-core` direct invocation

**Steps:**
1. Complete migration below
2. Optionally uninstall `translate-md`
3. Use `translate-core` for manual batches

## Migration Steps

### Step 1: Backup Existing Translations

```bash
# Backup current translations
cp -r en/ en-backup/
cp -r *_english.md *_english-backup.md 2>/dev/null || true
```

### Step 2: Initialize New System

```bash
# Initialize configuration
translate-config init
```

This creates `.translate/config.json` with defaults matching `translate-md`:
- Language: zh → en
- Output: `en/` directory
- Suffix: `_english`

### Step 3: Migrate Existing Translations

**If you have single output directory (like `translate-md`):**

```bash
# Create en-manual/ directory for manual edits
mkdir -p en-manual

# Copy existing translations to both directories
cp en/*.md en-manual/

# Your existing translations are now:
# - en/ - will be auto-updated
# - en-manual/ - preserved as manual versions
```

**If you want to re-translate from source:**

```bash
# Remove old translations
rm -rf en/

# Start watcher - will re-translate everything
translate-watch start
```

### Step 4: Configure Watch Paths

Edit `.translate/config.json`:

```json
{
  "watchPaths": ["."],
  "filePattern": "*.md"
}
```

### Step 5: Test Migration

```bash
# Start watcher
translate-watch start

# Edit a test file
echo "# 测试" > test.md

# Check if translation appeared
ls en/test_english.md

# Stop watcher
translate-watch stop

# Clean up test files
rm test.md en/test_english.md
```

### Step 6: Adopt New Workflow

**Old workflow:**
```bash
# Edit files manually
vim docs/API.md

# Remember to translate
translate-md "Translate my Chinese markdown files"
```

**New workflow:**
```bash
# Start watcher once
translate-watch start

# Edit files - translation happens automatically
vim docs/API.md

# Check status anytime
translate-watch status
```

## Feature Mapping

### translate-md Commands → Auto-Translation System

| translate-md | Auto-Translation System |
|--------------|-------------------------|
| Invoke skill to translate | `translate-watch start` (automatic) |
| Scan for Chinese files | Configured `filePattern` |
| Confirm which files | Automatic (all matching files) |
| Check existing files | Automatic dual-version handling |
| Translate all | Automatic on file change |
| Report summary | `translate-watch status` |

### File Naming

**translate-md:**
```
Arch.md → en/Arch_english.md
```

**Auto-translation system (default):**
```
Arch.md → en/Arch_english.md
        → en-manual/Arch_english.md (first time)
```

**Same naming convention!** No file renaming needed.

### Directory Structure

**translate-md:**
```
project/
├── Arch.md (Chinese)
└── en/
    └── Arch_english.md
```

**Auto-translation system:**
```
project/
├── .translate/
│   └── config.json
├── Arch.md (Chinese)
├── en/
│   └── Arch_english.md (auto-generated)
└── en-manual/
    └── Arch_english.md (manual, protected)
```

## Behavior Changes

### What's Different

1. **Automatic vs Manual:**
   - Old: Manually trigger translation
   - New: Automatic on file save

2. **Dual Output:**
   - Old: Single `en/` directory
   - New: Both `en/` and `en-manual/`

3. **Configuration:**
   - Old: Hardcoded in skill
   - New: Configurable via JSON

4. **Multi-language:**
   - Old: Chinese → English only
   - New: Any language pair

### What's the Same

1. **Translation quality:** Same translation engine
2. **Markdown preservation:** Same structure handling
3. **File naming:** Same `_english` suffix
4. **CLI invocation:** Both use Claude Code skills

## Migration Scenarios

### Scenario 1: Single Documentation Project

**Current:**
```
docs/
├── README.md (Chinese)
├── Guide.md (Chinese)
└── en/
    ├── README_english.md
    └── Guide_english.md
```

**Migration:**
```bash
cd docs

# Initialize
translate-config init

# Create manual version directory
mkdir -p en-manual

# Copy existing translations
cp en/*.md en-manual/

# Start auto-translation
translate-watch start

# Now edit README.md or Guide.md
# Translations update automatically in en/
# Manual versions preserved in en-manual/
```

### Scenario 2: Multi-Language Documentation

**Current:**
Using `translate-md` for Chinese → English

**Goal:**
Add Japanese and Korean translations

**Migration:**
```bash
# Initialize
translate-config init

# Add new language mappings
translate-config add zh-ja --target-dir ja --suffix _japanese
translate-config add zh-ko --target-dir ko --suffix _korean

# Verify mappings
translate-config list

# Start watcher
translate-watch start

# Now editing docs/API.md creates:
# - en/API_english.md
# - ja/API_japanese.md
# - ko/API_korean.md
```

### Scenario 3: Mixed Manual/Auto Workflow

**Use case:**
Some documents need manual curation, others can be automatic

**Migration:**
```bash
# Initialize with dual version
translate-config init

# Edit config: "dualVersion": true

# Migrate curated docs to en-manual/
cp en/Policy_english.md en-manual/
# Hand-edit en-manual/Policy_english.md as needed

# Leave other docs as auto-only
# They'll only exist in en/

# Start watcher
translate-watch start

# Results:
# - Policy_english.md: manual version protected in en-manual/
# - Other docs: auto-generated in en/ only
```

## Rollback Plan

If you need to rollback to `translate-md`:

```bash
# Stop watcher
translate-watch stop

# Remove new system config
rm -rf .translate/

# Restore from backup (if needed)
# cp -r en-backup/* en/

# Use original translate-md skill
translate-md "Translate my Chinese markdown files"
```

**All existing translations preserved!**

## Tips for Smooth Migration

### 1. Test on Small Project First

Try migration on a small project before migrating large documentation sets.

### 2. Use Parallel Operation Initially

Keep `translate-md` available while learning new system.

### 3. Commit to Version Control

Before migration:
```bash
git add .
git commit -m "Before migration to auto-translation system"
```

After migration:
```bash
git add .translate/config.json
git commit -m "Add auto-translation configuration"
```

### 4. Add to .gitignore

```bash
echo ".translate/" >> .gitignore
echo "en/" >> .gitignore
echo "en-manual/" >> .gitignore
echo "ja/" >> .gitignore
# ... other language directories
```

### 5. Document Configuration

Commit `.translate/config.json` to share settings with team.

### 6. Train Team

- Share quick start guide with team
- Document project-specific configuration
- Explain dual-version workflow

## Common Questions

### Q: Will my existing translations break?

**A:** No. Existing translations are compatible. Migration preserves them.

### Q: Can I still use translate-md?

**A:** Yes. Both systems coexist without conflicts.

### Q: Do I have to use dual-version?

**A:** No. Set `"dualVersion": false` in config for single output.

### Q: What happens to manually edited translations?

**A:** They're preserved in `en-manual/` and never overwritten.

### Q: Can I customize the file naming?

**A:** Yes. Configure `suffix` and `targetDir` per language mapping.

### Q: Does this work with version control?

**A:** Yes. Commit `.translate/config.json`, ignore generated directories.

### Q: What if I don't want automatic translation?

**A:** Don't start `translate-watch`. Use `translate-core` directly for manual batches.

### Q: Can I use this for non-Chinese languages?

**A:** Yes. Configure any language pair via `translate-config add`.

## Next Steps

1. **Backup** existing translations
2. **Initialize** new system: `translate-config init`
3. **Test** on small subset of files
4. **Migrate** remaining files
5. **Train** team on new workflow
6. **Commit** configuration to version control

## Support

For migration issues:
- Review this guide
- Check skill README files
- Examine `.translate/watcher.log` and `.translate/translations.log`
- Use `translate-config list` to verify configuration

## Conclusion

The auto-translation system provides significant productivity improvements while maintaining compatibility with existing workflows. Migrate at your own pace, and both systems will continue to work together seamlessly.
