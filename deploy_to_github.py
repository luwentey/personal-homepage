import subprocess
import sys
import time

def deploy_to_github():
    """部署项目到GitHub"""
    print("=== 部署个人主页到GitHub ===\n")
    
    try:
        # 1. 添加所有更改
        print("1. 添加文件到暂存区...")
        subprocess.run(['git', 'add', '.'], check=True)
        print("   ✅ 文件已添加")
        
        # 2. 提交更改
        print("\n2. 提交更改...")
        commit_message = input("请输入提交信息 (默认: 'Update personal homepage'): ") or "Update personal homepage"
        subprocess.run(['git', 'commit', '-m', commit_message], check=True)
        print("   ✅ 提交完成")
        
        # 3. 推送到GitHub
        print("\n3. 推送到GitHub...")
        print("   正在推送中，请稍候...")
        
        # 尝试推送
        result = subprocess.run(['git', 'push', 'origin', 'master'], 
                              capture_output=True, text=True)
        
        if result.returncode == 0:
            print("   ✅ 推送成功!")
            print("\n🎉 部署完成!")
            print("您的个人主页现在可以在GitHub上访问了")
            print("访问地址: https://luwentey.github.io/personal-homepage/")
        else:
            print("   ❌ 推送失败")
            print(f"   错误信息: {result.stderr}")
            
            # 提供故障排除建议
            print("\n🔧 故障排除建议:")
            print("1. 检查网络连接")
            print("2. 确认仓库名称正确: luwentey/personal-homepage")
            print("3. 检查是否有推送权限")
            print("4. 尝试使用HTTPS认证:")
            print("   git remote set-url origin https://github.com/luwentey/personal-homepage.git")
            
    except subprocess.CalledProcessError as e:
        print(f"❌ 操作失败: {e}")
    except Exception as e:
        print(f"❌ 发生错误: {e}")

def setup_github_pages():
    """设置GitHub Pages"""
    print("\n=== GitHub Pages设置指南 ===")
    print("要启用GitHub Pages，请按以下步骤操作:")
    print("\n1. 访问您的仓库:")
    print("   https://github.com/luwentey/personal-homepage")
    print("\n2. 点击 'Settings' 标签")
    print("\n3. 在左侧菜单中找到 'Pages'")
    print("\n4. 在 'Source' 部分:")
    print("   - 选择 'Deploy from a branch'")
    print("   - 分支选择 'master'")
    print("   - 文件夹选择 '/(root)'")
    print("\n5. 点击 'Save'")
    print("\n6. 等待几分钟，您的网站就会在以下地址可用:")
    print("   https://luwentey.github.io/personal-homepage/")

if __name__ == "__main__":
    deploy_to_github()
    setup_github_pages()