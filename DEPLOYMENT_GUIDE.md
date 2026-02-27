# 个人主页部署到GitHub指南

## 当前状态
✅ Git已安装并配置完成
✅ GitHub认证已设置
✅ 本地仓库已初始化并有初始提交
❌ 网络连接到GitHub存在问题

## 部署步骤

### 方法一：使用命令行（推荐）

1. **确保Git在PATH中**：
   ```bash
   # 在PowerShell中运行
   $env:Path += ";C:\Program Files\Git\bin"
   ```

2. **添加并提交更改**：
   ```bash
   git add .
   git commit -m "Initial commit: Personal homepage"
   ```

3. **推送到GitHub**：
   ```bash
   git push -u origin master
   ```

### 方法二：使用GitHub Desktop（最简单）

1. 下载并安装 [GitHub Desktop](https://desktop.github.com/)
2. 登录您的GitHub账户
3. 选择 "Add Local Repository"
4. 选择当前项目文件夹
5. 点击 "Publish repository"
6. 选择Public，填写仓库名：`personal-homepage`
7. 点击 "Publish Repository"

### 方法三：手动上传

1. 访问 [GitHub新建仓库](https://github.com/new)
2. 创建名为 `personal-homepage` 的仓库
3. 不要初始化README
4. 复制仓库URL
5. 在本地运行：
   ```bash
   git remote add origin YOUR_REPOSITORY_URL
   git push -u origin master
   ```

## GitHub Pages设置

部署完成后，按以下步骤启用GitHub Pages：

1. 访问您的仓库：`https://github.com/luwentey/personal-homepage`
2. 点击 "Settings" 标签
3. 在左侧菜单中找到 "Pages"
4. 在 "Source" 部分：
   - 选择 "Deploy from a branch"
   - 分支选择 "master"
   - 文件夹选择 "/(root)"
5. 点击 "Save"
6. 等待几分钟，您的网站将在以下地址可用：
   `https://luwentey.github.io/personal-homepage/`

## 故障排除

### 网络连接问题
如果遇到网络连接问题：
- 检查防火墙设置
- 尝试使用VPN
- 更换网络环境
- 使用SSH方式连接

### 权限问题
如果推送被拒绝：
- 确认仓库URL正确
- 检查GitHub账户权限
- 确认Personal Access Token有效

### Git命令找不到
如果Git命令无法识别：
- 重新安装Git
- 手动添加Git到系统PATH
- 使用GitHub Desktop替代

## 项目结构
```
D:\Program\PythonProject5\
├── index.html          # 主页文件
├── css/
│   └── style.css       # 样式文件
├── images/             # 图片文件夹
├── js/                 # JavaScript文件夹
└── .git/               # Git仓库文件
```

## 后续维护

更新网站内容后，使用以下命令部署：
```bash
git add .
git commit -m "Update website content"
git push origin master
```

GitHub Pages会自动部署最新的更改。

---
**注意**：首次部署可能需要几分钟时间才能在GitHub Pages上生效。