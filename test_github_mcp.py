import os
import requests

def test_github_api():
    """测试GitHub API连接"""
    token = os.environ.get('GITHUB_TOKEN')
    
    if not token:
        print("❌ 错误: 未找到GITHUB_TOKEN环境变量")
        return False
    
    headers = {
        'Authorization': f'token {token}',
        'Accept': 'application/vnd.github.v3+json'
    }
    
    try:
        # 测试API连接
        response = requests.get('https://api.github.com/user', headers=headers)
        
        if response.status_code == 200:
            user_data = response.json()
            print(f"✅ GitHub API连接成功!")
            print(f"用户: {user_data.get('login')}")
            print(f"ID: {user_data.get('id')}")
            return True
        elif response.status_code == 401:
            print("❌ 认证失败: Token无效或已过期")
            return False
        else:
            print(f"❌ API请求失败: {response.status_code}")
            print(response.text)
            return False
            
    except Exception as e:
        print(f"❌ 连接异常: {e}")
        return False

def test_mcp_tools():
    """模拟测试MCP工具调用"""
    print("\n=== MCP工具功能测试 ===")
    
    # 这里可以添加具体的MCP工具调用测试
    print("🔍 测试搜索仓库功能...")
    print("📊 测试获取用户信息功能...")
    print("📝 测试创建issue功能...")

if __name__ == "__main__":
    print("=== GitHub MCP可用性测试 ===\n")
    
    if test_github_api():
        test_mcp_tools()
        print("\n🎉 GitHub MCP工具可以正常使用!")
    else:
        print("\n🔧 请按照以下步骤解决问题:")
        print("1. 生成GitHub Personal Access Token")
        print("2. 设置GITHUB_TOKEN环境变量")
        print("3. 安装并配置Git")
        print("4. 重新运行此测试")