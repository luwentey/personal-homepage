import os
import subprocess

def check_github_setup():
    """检查GitHub相关配置"""
    print("=== GitHub配置检查 ===\n")
    
    # 检查环境变量
    github_token = os.environ.get('GITHUB_TOKEN')
    print(f"GITHUB_TOKEN环境变量: {'已设置' if github_token else '未设置'}")
    
    # 检查Git是否安装
    try:
        result = subprocess.run(['git', '--version'], capture_output=True, text=True)
        print(f"Git版本: {result.stdout.strip()}")
    except FileNotFoundError:
        print("Git未安装或不在PATH中")
    
    # 检查Git配置
    try:
        result = subprocess.run(['git', 'config', '--global', '--get', 'user.name'], 
                              capture_output=True, text=True)
        username = result.stdout.strip()
        print(f"Git用户名: {username if username else '未设置'}")
        
        result = subprocess.run(['git', 'config', '--global', '--get', 'user.email'], 
                              capture_output=True, text=True)
        email = result.stdout.strip()
        print(f"Git邮箱: {email if email else '未设置'}")
    except Exception as e:
        print(f"Git配置检查失败: {e}")

if __name__ == "__main__":
    check_github_setup()