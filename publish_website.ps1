# 个人主页发布脚本
Write-Host "=== 发布个人主页到GitHub ===" -ForegroundColor Green
Write-Host ""

# 重新设置PATH以包含Git
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
$gitPaths = @(
    "C:\Program Files\Git\bin",
    "C:\Program Files (x86)\Git\bin",
    "$env:ProgramFiles\Git\bin",
    "${env:ProgramFiles(x86)}\Git\bin"
)

foreach ($path in $gitPaths) {
    if (Test-Path "$path\git.exe") {
        $env:Path += ";$path"
        Write-Host "✅ 找到Git: $path" -ForegroundColor Green
        break
    }
}

# 测试Git
try {
    $gitVersion = & git --version
    Write-Host "Git版本: $gitVersion" -ForegroundColor Cyan
} catch {
    Write-Host "❌ 未找到Git命令" -ForegroundColor Red
    Write-Host "请确保Git已正确安装" -ForegroundColor Yellow
    exit 1
}

# 添加文件
Write-Host "`n1. 添加文件到暂存区..." -ForegroundColor Yellow
try {
    & git add .
    Write-Host "✅ 文件已添加" -ForegroundColor Green
} catch {
    Write-Host "❌ 添加文件失败: $_" -ForegroundColor Red
    exit 1
}

# 提交更改
Write-Host "`n2. 提交更改..." -ForegroundColor Yellow
$commitMessage = Read-Host "请输入提交信息 (默认: 'Update personal homepage')"
if ([string]::IsNullOrWhiteSpace($commitMessage)) {
    $commitMessage = "Update personal homepage"
}

try {
    & git commit -m $commitMessage
    Write-Host "✅ 提交完成" -ForegroundColor Green
} catch {
    Write-Host "ℹ️  没有需要提交的更改或提交失败: $_" -ForegroundColor Yellow
}

# 推送到GitHub
Write-Host "`n3. 推送到GitHub..." -ForegroundColor Yellow
Write-Host "正在推送，请稍候..." -ForegroundColor Cyan

try {
    $result = & git push -u origin master 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ 推送成功!" -ForegroundColor Green
        Write-Host "`n🎉 部署完成!" -ForegroundColor Green
        Write-Host "您的个人主页已成功推送到GitHub" -ForegroundColor Cyan
        Write-Host "仓库地址: https://github.com/luwentey/personal-homepage" -ForegroundColor White
        Write-Host ""
        Write-Host "下一步: 设置GitHub Pages" -ForegroundColor Yellow
        Write-Host "1. 访问仓库设置页面" -ForegroundColor White
        Write-Host "2. 找到Pages选项" -ForegroundColor White
        Write-Host "3. 选择master分支作为源" -ForegroundColor White
        Write-Host "4. 保存设置" -ForegroundColor White
        Write-Host ""
        Write-Host "完成后访问: https://luwentey.github.io/personal-homepage/" -ForegroundColor Green
    } else {
        Write-Host "❌ 推送失败" -ForegroundColor Red
        Write-Host "错误信息: $result" -ForegroundColor Yellow
        Write-Host "`n🔧 故障排除建议:" -ForegroundColor Yellow
        Write-Host "1. 检查网络连接" -ForegroundColor White
        Write-Host "2. 确认仓库存在且名称正确" -ForegroundColor White
        Write-Host "3. 检查推送权限" -ForegroundColor White
        Write-Host "4. 尝试使用GitHub Desktop" -ForegroundColor White
    }
} catch {
    Write-Host "❌ 推送过程中发生错误: $_" -ForegroundColor Red
}

Write-Host "`n按任意键退出..." -ForegroundColor Gray
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") > $null