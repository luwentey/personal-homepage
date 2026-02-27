# Deployment script for personal website
Write-Host "=== Deploying Personal Homepage ===" -ForegroundColor Green

# Setup Git path
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
$gitPath = "C:\Program Files\Git\bin"
if (Test-Path "$gitPath\git.exe") {
    $env:Path += ";$gitPath"
}

# Check Git availability
try {
    git --version > $null
    Write-Host "[OK] Git is available" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Git not available" -ForegroundColor Red
    exit 1
}

# Add and commit files
Write-Host "Adding files..." -ForegroundColor Yellow
git add .

Write-Host "Committing changes..." -ForegroundColor Yellow
git commit -m "Update personal homepage"

# Push to GitHub
Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
$result = git push -u origin master

if ($LASTEXITCODE -eq 0) {
    Write-Host "[SUCCESS] Deployment completed!" -ForegroundColor Green
    Write-Host "Visit: https://github.com/luwentey/personal-homepage"
    Write-Host "Next step: Enable GitHub Pages in repository settings"
} else {
    Write-Host "[FAILED] Deployment failed" -ForegroundColor Red
    Write-Host "Please check network connection and repository settings"
}