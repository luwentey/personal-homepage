import os
import subprocess
import sys

def check_git():
    """检查Git是否安装"""
    try:
        result = subprocess.run(['git', '--version'], capture_output=True, text=True)
        print(f"✅ Git版本: {result.stdout.strip()}")
        return True
    except FileNotFoundError:
        print("❌ Git未安装")
        print("请访问 https://git-scm.com/downloads 下载安装Git")
        return False

def configure_git():
    """配置Git用户信息"""
    print("\n=== 配置Git用户信息 ===")
    username = input("请输入Git用户名: ")
    email = input("请输入Git邮箱: ")
    
    try:
        subprocess.run(['git', 'config', '--global', 'user.name', username])
        subprocess.run(['git', 'config', '--global', 'user.email', email])
        print("✅ Git配置完成")
        return True
    except Exception as e:
        print(f"❌ Git配置失败: {e}")
        return False

def set_github_token():
    """设置GitHub Token"""
    print("\n=== 设置GitHub Personal Access Token ===")
    print("请先在GitHub上生成Personal Access Token:")
    print("1. 访问 https://github.com/settings/tokens")
    print("2. 点击 'Generate new token (classic)'")
    print("3. 选择必要权限: repo, user, gist等")
    print("4. 复制生成的token\n")
    
    token = input("请输入您的GitHub Personal Access Token: ")
    
    if token:
        # 设置环境变量
        os.environ['GITHUB_TOKEN'] = token
        # 永久设置（Windows）
        try:
            subprocess.run(['setx', 'GITHUB_TOKEN', token], capture_output=True)
            print("✅ GitHub Token已设置")
            return True
        except Exception as e:
            print(f"⚠️  环境变量设置可能需要重启终端: {e}")
            return True
    else:
        print("❌ Token不能为空")
        return False

def test_connection():
    """测试GitHub连接"""
    print("\n=== 测试GitHub连接 ===")
    try:
        result = subprocess.run([sys.executable, 'test_github_mcp.py'], 
                              capture_output=True, text=True)
        print(result.stdout)
        if result.returncode == 0:
            print("✅ 连接测试成功!")
            return True
        else:
            print("❌ 连接测试失败")
            print(result.stderr)
            return False
    except Exception as e:
        print(f"❌ 测试执行失败: {e}")
        return False

def main():
    print("=== GitHub MCP一键配置工具 ===\n")
    
    # 检查Git
    if not check_git():
        return
    
    # 配置Git
    if not configure_git():
        return
    
    # 设置Token
    if not set_github_token():
        return
    
    # 测试连接
    print("\n" + "="*50)
    test_connection()
    
    print("\n🎉 配置完成!")
    print("现在可以使用GitHub MCP工具了")

if __name__ == "__main__":
    main()