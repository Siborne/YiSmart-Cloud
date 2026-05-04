# 代码变更记录：毕业设计说明书初稿（本地）与 gitignore

## 变更背景/目的

应毕业设计需要，基于本仓库「颐智云 YiSmartCloud」实际模块与接口整理说明书初稿正文；初稿含个人信息占位，不宜纳入版本库，故将 `docs/graduation/` 目录加入根目录 `.gitignore`。

## 变更文件清单

- `.gitignore`：新增忽略 `docs/graduation/`。
- `docs/graduation/YiSmartCloud_毕业设计说明书初稿.md`：**已被上述规则忽略**，仅保留于本地工作区；若需备份请自行复制至网盘或使用未忽略路径。

## 关键改动说明

- 初稿结构含封面与诚信承诺书占位、中英文摘要、目录、第 1～7 章正文、结束语、致谢、参考文献及附录说明，内容结合 `YiSmartCloud-nursing-platform` 下 `/serve/**`、`/member/reservation` 等与前端、小程序目录的对应关系撰写。
- 初稿正文汉字量约 8500 字（以 UTF-8 解码后 Unicode 汉字正则统计，满足「八千字以上」量级要求）；文件已转换为 **UTF-8（无 BOM）** 存储，以符合仓库编码规则。

## 影响范围

- **Git**：`docs/graduation/` 下文件默认不被 `git add` 跟踪；团队其他成员克隆仓库后不会自带该初稿，需各自维护或另行分发。
- **接口/数据库/运行时**：无影响。

## 验证方式

- 已执行：人工核对 `.gitignore` 条目与初稿路径一致。
- 未执行：`git check-ignore -v docs/graduation/YiSmartCloud_毕业设计说明书初稿.md`（可选，用于本地确认忽略生效）。
