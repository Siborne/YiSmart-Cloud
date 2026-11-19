# Landing 页重设计：移除 Emoji 并统一使用 SVG Icon

## 背景 / 目标

- 现有 `docs/site/index.html` 为项目 Landing 页，多处直接使用 Emoji（Java、Spring Boot、Vue、MySQL、Redis、环境要求等）。
- 新要求：Landing 页禁止使用 Emoji，图标统一改用内联 SVG Icon。
- 同时重新梳理页面结构与视觉层级，保持原有交互能力（多语言、主题切换、粒子背景、卡片滚动动画、移动端菜单）不变。

## 变更文件清单

- `docs/site/index.html`

## 关键改动说明

- 删除旧 Landing 页，重写为新的 Landing 页结构。
- 将所有 Emoji 替换为内联 SVG 图标：
  - Hero 技术栈徽章（Java 11、Spring Boot、Vue 3、Vite、MySQL、Redis）
  - 技术架构卡片的头部图标与前端/后端技术项图标
  - 快速开始卡片的头部图标
  - 环境要求（JDK、Maven、Node.js、MySQL、Redis、Git）
- 保留全部 `data-i18n` 键、交互元素 ID（`navbar`、`currentLang`、`sunIcon`、`moonIcon`、`langToggle*`、`themeToggle*`、`mobileMenu*`、`particles`）以及 `.feature-card` / `.tech-card` 滚动动画类，确保 `js/main.js` 与 `js/particles.js` 正常工作。
- 修正 Hero 描述块中被 `setLanguage` 覆盖的换行结构，描述改为单段文本。

## 影响范围

- **前端**：仅影响静态 Landing 页 `docs/site/index.html`。
- **接口/数据库**：无影响。
- **兼容性**：多语言切换、明暗主题、移动端菜单、粒子背景与滚动动画功能保留。

## 验证方式

- 已执行：对 `docs/site/index.html` 运行 Emoji 正则扫描，确认不再包含 Emoji。
- 已执行：校验页面使用的全部 `data-i18n` 键均存在于 `docs/site/js/main.js`。
- 已执行：校验 `main.js` 依赖的交互元素 ID 与动画类均存在。
- 未执行：浏览器视觉预览（建议本地打开 `docs/site/index.html` 复核响应式与暗色模式表现）。
