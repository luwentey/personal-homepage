import os
import requests
import subprocess

def verify_complete_setup():
    """完整的配置验证"""
    print("=== GitHub MCP环境最终验证 ===\n")
    
    # 1. 验证Git安装和配置
    print("1. Git配置检查:")
    try:
        # 检查Git版本
        git_version = subprocess.run(['git', '--version'], capture_output=True, text=True)
        print(f"   ✅ Git版本: {git_version.stdout.strip()}")
        
        # 检查用户配置
        username = subprocess.run(['git', 'config', '--global', '--get', 'user.name'], 
                                capture_output=True, text=True)
        email = subprocess.run(['git', 'config', '--global', '--get', 'user.email'], 
                             capture_output=True, text=True)
        print(f"   ✅ Git用户名: {username.stdout.strip()}")
        print(f"   ✅ Git邮箱: {email.stdout.strip()}")
    except Exception as e:
        print(f"   ❌ Git配置有问题: {e}")
        return False
    
    # 2. 验证GitHub Token
    print("\n2. GitHub认证检查:")
    token = os.environ.get('GITHUB_TOKEN')
    if not token:
        print("   ❌ 未找到GITHUB_TOKEN环境变量")
        return False
    
    print(f"   ✅ Token长度: {len(token)} 字符")
    
    # 3. 测试GitHub API
    print("\n3. GitHub API连接测试:")
    headers = {
        'Authorization': f'token {token}',
        'Accept': 'application/vnd.github.v3+json'
    }
    
    try:
        response = requests.get('https://api.github.com/user', headers=headers)
        if response.status_code == 200:
            user_data = response.json()
            print(f"   ✅ API连接成功!")
            print(f"   ✅ 用户名: {user_data.get('login')}")
            print(f"   ✅ 用户ID: {user_data.get('id')}")
            print(f"   ✅ 公共仓库数: {user_data.get('public_repos')}")
        else:
            print(f"   ❌ API连接失败: {response.status_code}")
            return False
    except Exception as e:
        print(f"   ❌ API测试异常: {e}")
        return False
    
    # 4. 项目状态检查
    print("\n4. 项目状态检查:")
    try:
        # 检查项目文件
        import os
        files = ['index.html', 'css/style.css']
        for file in files:
            if os.path.exists(file):
                print(f"   ✅ {file} 存在")
            else:
                print(f"   ⚠️  {file} 不存在")
    except Exception as e:
        print(f"   ❌ 项目检查异常: {e}")
    
    print("\n" + "="*50)
    print("🎉 恭喜！GitHub环境配置完全成功！")
    print("现在您可以:")
    print("• 使用GitHub API进行各种操作")
    print("• 部署项目到GitHub Pages")
    print("• 管理仓库和Issues")
    print("• 进行代码协作开发")
    
    return True

if __name__ == "__main__":
    verify_complete_setup()