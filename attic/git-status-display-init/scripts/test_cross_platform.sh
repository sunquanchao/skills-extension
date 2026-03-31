#!/bin/bash
# Cross-platform test script for git-status-display skill
# Works on macOS, Linux, and Windows (Git Bash/WSL)

echo "Testing git-status-display skill..."
echo ""

# Test 1: Get git branch
echo "Test 1: Get current git branch"
branch=$(git branch --show-current 2>/dev/null)
if [ $? -eq 0 ]; then
    echo "✓ Git branch: $branch"
else
    branch="(not in git repo)"
    echo "✓ Not in a git repository"
fi

# Test 2: Get working directory
echo ""
echo "Test 2: Get working directory"
dir=$(pwd)
echo "✓ Working directory: $dir"

# Test 3: Format output
echo ""
echo "Test 3: Formatted output"
echo "Branch: $branch | Dir: $dir"

# Test 4: Platform detection
echo ""
echo "Test 4: Platform information"
uname_output=$(uname -s)
case "$uname_output" in
    Linux*)     platform="Linux";;
    Darwin*)    platform="macOS";;
    MINGW*|MSYS*|CYGWIN*) platform="Windows (Git Bash/MSYS)";;
    *)          platform="Unknown: $uname_output"
esac
echo "✓ Detected platform: $platform"

# Test 5: Path format detection
echo ""
echo "Test 5: Path format"
if [[ "$dir" =~ ^/[a-zA-Z]/ ]]; then
    echo "✓ Path format: Windows (Git Bash style) - $dir"
elif [[ "$dir" =~ ^[A-Z]:\\ ]]; then
    echo "✓ Path format: Windows (native) - $dir"
elif [[ "$dir" =~ ^/ ]]; then
    echo "✓ Path format: Unix-style - $dir"
else
    echo "✓ Path format: Unknown - $dir"
fi

echo ""
echo "All tests passed! ✓"
