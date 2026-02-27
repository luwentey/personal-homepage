# GitHub环境配置向导

Write-Host "=== GitHub MCP环境配置向导 ===" -ForegroundColor Green
Write-Host ""

# 步骤1: 检查Git安装
Write-Host "步骤1: 检查Git安装状态..." -ForegroundColor Yellow
try {
    $gitVersion = git --version
    Write-Host "✅ Git已安装: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Git未安装" -ForegroundColor Red
    Write-Host "请访问 https://git-scm.com/downloads 下载安装Git" -ForegroundColor Yellow
    Write-Host "安装完成后请重新运行此脚本"
    exit 1
}

Write-Host ""
Write-Host "步骤2: 配置Git用户信息" -ForegroundColor Yellow

# 获取用户输入
$username = Read-Host "请输入您的Git用户名"
$email = Read-Host "请输入您的Git邮箱"

# 配置Git
git config --global user.name "$username"
git config --global user.email "$email"

Write-Host "✅ Git配置完成!" -ForegroundColor Green
Write-Host "用户名: $username"
Write-Host "邮箱: $email"

Write-Host ""
Write-Host "步骤3: 设置GitHub Personal Access Token" -ForegroundColor Yellow
Write-Host "请按以下步骤操作:" -ForegroundColor Cyan
Write-Host "1. 访问 https://github.com/settings/tokens" -ForegroundColor White
Write-Host "2. 点击 'Generate new token (classic)'" -ForegroundColor White
Write-Host "3. 设置token名称和过期时间" -ForegroundColor White
Write-Host "4. 选择权限: repo, user, gist, workflow等" -ForegroundColor White
Write-Host "5. 复制生成的token" -ForegroundColor White

$token = Read-Host "请输入您的GitHub Personal Access Token (不会显示)"

# 设置环境变量
$env:GITHUB_TOKEN = $token
[System.Environment]::SetEnvironmentVariable("GITHUB_TOKEN", $token, "User")

Write-Host "✅ GitHub Token已设置!" -ForegroundColor Green

Write-Host ""
Write-Host "步骤4: 验证配置" -ForegroundColor Yellow
python test_github_mcp.py

Write-Host ""
Write-Host "🎉 配置完成! 现在可以使用GitHub MCP工具了。" -ForegroundColor Green