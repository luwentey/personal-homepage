@echo off
echo === 部署个人主页到GitHub ===
echo.

REM 刷新环境变量
echo 刷新环境变量...
set PATH=%PATH%;C:\Program Files\Git\bin;C:\Program Files (x86)\Git\bin

REM 检查Git
echo 检查Git安装...
git --version
if %errorlevel% neq 0 (
    echo 错误: Git未找到
    pause
    exit /b 1
)

REM 添加所有文件
echo.
echo 1. 添加文件到暂存区...
git add .

REM 提交更改
echo.
echo 2. 提交更改...
set /p commit_msg=请输入提交信息 (回车使用默认): 
if "%commit_msg%"=="" set commit_msg=Update personal homepage
git commit -m "%commit_msg%"

REM 推送到GitHub
echo.
echo 3. 推送到GitHub...
echo 正在推送，请稍候...
git push -u origin master

if %errorlevel% equ 0 (
    echo.
    echo 🎉 部署成功!
    echo 您的个人主页已推送到GitHub
    echo 仓库地址: https://github.com/luwentey/personal-homepage
    echo.
    echo 下一步: 设置GitHub Pages
    echo 1. 访问仓库设置页面
    echo 2. 找到Pages选项
    echo 3. 选择master分支作为源
    echo 4. 保存设置
    echo.
    echo 完成后访问: https://luwentey.github.io/personal-homepage/
) else (
    echo.
    echo ❌ 部署失败
    echo 请检查:
    echo 1. 网络连接
    echo 2. GitHub仓库是否存在
    echo 3. 是否有推送权限
)

pause