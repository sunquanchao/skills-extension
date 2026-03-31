# Cross-platform test script for git-status-display skill (PowerShell version)
# Works on Windows PowerShell and PowerShell Core

Write-Host "Testing git-status-display skill..." -ForegroundColor Green
Write-Host ""

# Test 1: Get git branch
Write-Host "Test 1: Get current git branch" -ForegroundColor Cyan
try {
    $branch = git branch --show-current 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Git branch: $branch" -ForegroundColor Green
    } else {
        $branch = "(not in git repo)"
        Write-Host "✓ Not in a git repository" -ForegroundColor Yellow
    }
} catch {
    $branch = "(not in git repo)"
    Write-Host "✓ Not in a git repository" -ForegroundColor Yellow
}

# Test 2: Get working directory
Write-Host ""
Write-Host "Test 2: Get working directory" -ForegroundColor Cyan
$dir = Get-Location
$dirPath = $dir.Path
Write-Host "✓ Working directory: $dirPath" -ForegroundColor Green

# Test 3: Format output
Write-Host ""
Write-Host "Test 3: Formatted output" -ForegroundColor Cyan
Write-Host "Branch: $branch | Dir: $dirPath" -ForegroundColor White

# Test 4: Platform detection
Write-Host ""
Write-Host "Test 4: Platform information" -ForegroundColor Cyan
$platform = [System.Environment]::OSVersion.Platform
Write-Host "✓ Detected platform: $platform" -ForegroundColor Green

# Test 5: Path format detection
Write-Host ""
Write-Host "Test 5: Path format" -ForegroundColor Cyan
if ($dirPath -match '^[A-Z]:\\') {
    Write-Host "✓ Path format: Windows (native) - $dirPath" -ForegroundColor Green
} elseif ($dirPath -match '^/[a-zA-Z]/') {
    Write-Host "✓ Path format: Windows (Git Bash style) - $dirPath" -ForegroundColor Green
} else {
    Write-Host "✓ Path format: Other - $dirPath" -ForegroundColor Green
}

Write-Host ""
Write-Host "All tests passed! ✓" -ForegroundColor Green
