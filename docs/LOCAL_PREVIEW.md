# 本地预览指南 (Local Preview)

为了在本地查看 GitHub Pages 的实际效果，您需要启动一个静态文件服务器。以下是几种常用的方法：

## 方法 1：使用 npx serve (推荐)

`serve` 是一个非常简单快捷的静态文件服务器，无需全局安装。

```bash
# 在项目根目录执行
npx serve docs/site
```

启动后，终端会显示类似 `http://localhost:3000` 的地址，在浏览器打开即可预览。

## 方法 2：使用 Python 内置服务器

如果您安装了 Python，可以直接使用其内置的 HTTP 服务器。

```bash
# 进入静态文件目录
cd docs/site

# 启动服务器 (Python 3)
python -m http.server 8000

# 或者 (Python 2)
python -m SimpleHTTPServer 8000
```

启动后，访问 `http://localhost:8000`。

## 方法 3：使用 Node.js http-server

如果您喜欢更轻量级的工具，可以使用 `http-server`。

```bash
# 需要先全局安装 (只需一次)
npm install -g http-server

# 启动服务器
http-server docs/site -p 8080
```

启动后，访问 `http://localhost:8080`。

---

**提示**：推荐使用 **方法 1 (npx serve)**，因为它不需要全局安装任何包，且配置简单。
