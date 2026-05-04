# UTF-8 统一转换脚本

## 变更背景/目的
- 用户反馈部分页面编码不是 UTF-8，导致显示/运行风险。
- 新增可复用脚本统一将文本文件转为 UTF-8（无 BOM）。

## 变更文件清单
- `scripts/ensure_utf8.py`
- `docs/code_review/2026-05-04_2362_utf8_normalize_script.md`

## 关键改动说明
- 新增脚本 `scripts/ensure_utf8.py`：
  - 支持目录递归处理。
  - 先尝试 `utf-8`，失败后回退 `utf-8-sig / gb18030 / gbk / big5 / utf-16*`。
  - 统一写回 UTF-8（无 BOM）。
  - 仅处理常见文本后缀（`.vue/.js/.json/.md/.java/.sql/...`）。
- 已在 `YiSmartCloud-member-uniapp` 执行一次实转：
  - 转换成功 15 个文件（均从 `gb18030` 转为 UTF-8）
  - 跳过 118 个无需转换文件

## 影响范围
- 前端：`pages/subPages/**` 下 15 个页面编码统一为 UTF-8。
- 构建与运行：降低中文乱码、跨工具链编码不一致风险。

## 验证方式
- 已执行：
  - `python scripts/ensure_utf8.py YiSmartCloud-member-uniapp`
  - 输出显示 15 个文件成功转换。
- 未执行：
  - 全仓库范围统一转换（可按需再执行）。
