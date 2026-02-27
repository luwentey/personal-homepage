# 简化部署脚本
Write-Host "=== 部署个人主页 ===" -ForegroundColor Green

# 设置Git路径
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
$gitPath = "C:\Program Files\Git\bin"
if (Test-Path "$gitPath\git.exe") {
    $env:Path += ";$gitPath"
}

# 检查Git
try {
    git --version > $null
    Write-Host "✅ Git可用" -ForegroundColor Green
} catch {
    Write-Host "❌ Git不可用" -ForegroundColor Red
    exit 1
}

# 添加和提交
Write-Host "添加文件..." -ForegroundColor Yellow
git add .

Write-Host "提交更改..." -ForegroundColor Yellow
git commit -m "Update personal homepage"

# 推送
Write-Host "推送至GitHub..." -ForegroundColor Yellow
$result = git push -u origin master

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ 部署成功!" -ForegroundColor Green
    Write-Host "访问: https://github.com/luwentey/personal-homepage"
} else {
    Write-Host "❌ 部署失败" -ForegroundColor Red
}