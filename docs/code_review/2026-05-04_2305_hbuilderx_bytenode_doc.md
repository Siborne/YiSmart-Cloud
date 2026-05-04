# 变更记录：HBuilderX bytenode 编译错误说明与 engines

## 背景

在 HBuilderX 内运行 UniApp（Vite）工程时出现 `Invalid or incompatible cached data (cachedDataRejected)`，堆栈指向 HBuilderX 安装目录下 `plugins/uni_helpers` 的 bytenode 加载 `.jsc`，与当前 Node/V8 版本不兼容。

## 变更文件

- 新增：[`YiSmartCloud-member-uniapp/docs/HBuilderX编译说明.md`](../../YiSmartCloud-member-uniapp/docs/HBuilderX编译说明.md)
- 修改：[`YiSmartCloud-member-uniapp/README.md`](../../YiSmartCloud-member-uniapp/README.md)（增加 HBX 故障小节与文档链接）
- 修改：[`YiSmartCloud-member-uniapp/package.json`](../../YiSmartCloud-member-uniapp/package.json)（增加 `engines` 提示 Node 版本范围）

## 说明

未改 `vite.config.js` 与业务代码；问题根因在 HBX 插件链与 Node 版本组合，文档中给出 CLI 编译、切换 Node LTS、升级 HBX 等处理方式。

## 验证

- 文档与 JSON 校验通过；未改构建逻辑。
