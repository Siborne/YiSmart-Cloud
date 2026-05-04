# 变更记录：家属端 UniApp UTF-8 规范化脚本

## 变更背景 / 目的

满足仓库「源码统一 UTF-8」规则，并为 Windows 下可能出现的 ANSI/GBK 保存情况提供可重复执行的转换手段。

## 变更文件清单

- 新增：[`YiSmartCloud-member-uniapp/scripts/ensure-utf8.mjs`](../../YiSmartCloud-member-uniapp/scripts/ensure-utf8.mjs)
- 修改：[`YiSmartCloud-member-uniapp/package.json`](../../YiSmartCloud-member-uniapp/package.json)（增加 `ensure-utf8` 脚本）
- 修改：[`YiSmartCloud-member-uniapp/README.md`](../../YiSmartCloud-member-uniapp/README.md)（说明如何运行）
- 执行脚本后：若干 `YiSmartCloud-member-uniapp` 内文本文件被重写为 UTF-8（无 BOM）。脚本逻辑已修正为：**仅**在 WHATWG `utf-8` fatal 解码失败时再尝试 `gb18030`/`gbk`，避免把已是 UTF-8 的文件误转码。

## 关键改动说明

- `ensure-utf8.mjs`：递归扫描工程根下文本扩展名与 `.env*`、`.gitignore`，跳过 `node_modules`、`dist`、`unpackage`；**跳过脚本自身路径**，避免运行中读写同一文件；去除 UTF-8 BOM / UTF-16 BOM；**先**用 WHATWG `utf-8` fatal 解码判断，仅在失败时再尝试 `gb18030`/`gbk`；写回 `Buffer.from(text, 'utf8')`（无 BOM）。

## 影响范围

- 仅 `YiSmartCloud-member-uniapp` 目录内文本；不涉及后端与 PC 管理端。

## 验证方式

- 已执行：`node scripts/ensure-utf8.mjs`；修订逻辑后再次执行应显示 `rewritten: 0`（当前工作区已规范为 UTF-8）。
- 已执行：`npm run build:mp-weixin`（通过）。
