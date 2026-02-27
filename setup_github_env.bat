@echo off
echo === GitHub环境配置脚本 ===

REM 设置GitHub Token（请替换为你的实际token）
set GITHUB_TOKEN=your_personal_access_token_here

REM 验证环境变量
echo GITHUB_TOKEN已设置为: %GITHUB_TOKEN%

REM 检查Git安装
git --version
if %errorlevel% neq 0 (
    echo 错误: Git未安装或不在PATH中
    echo 请从 https://git-scm.com/downloads 下载安装Git
    pause
    exit /b 1
)

REM 配置Git用户信息
echo 请输入您的Git用户名:
set /p GIT_USERNAME=
git config --global user.name "%GIT_USERNAME%"

echo 请输入您的Git邮箱:
set /p GIT_EMAIL=
git config --global user.email "%GIT_EMAIL%"

echo 配置完成！现在可以测试GitHub MCP工具了。
pause