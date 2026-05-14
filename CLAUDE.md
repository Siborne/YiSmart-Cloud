# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

YiSmartCloud (颐智云) is a smart elderly-care management system built on **RuoYi-Vue 3.8.9**. It is a full-stack, separated-frontend-backend platform: a Java 11 / Spring Boot 2.5 multi-module backend, a Vue 3 / Vite management frontend, and a UniApp (Vue3) WeChat mini-program for family members.

Root package: `org.FlyingSparrow.YiSmartCloud`

## Commands

### Backend (YiSmartCloud-background)

```bash
# Full build (skip tests)
mvn clean install -DskipTests

# Run admin (boot module, default port 8080)
mvn -pl YiSmartCloud-admin spring-boot:run

# Run a single test class across modules
mvn test -pl YiSmartCloud-nursing-platform -Dtest=YourTest
```

### Frontend (YiSmartCloud-front)

```bash
npm install
npm run dev          # Dev server, port 80, proxies /dev-api → localhost:8080
npm run build:prod   # Production build
npm run build:stage  # Staging build
```

### Member mini-program (YiSmartCloud-member-uniapp)

```bash
npm install
npm run build:mp-weixin   # Output to dist/build/mp-weixin
# Then import dist/build/mp-weixin into WeChat DevTools
```

## Maven module map

| Module | Role |
|---|---|
| `YiSmartCloud-admin` | **Boot module** — Spring Boot entry point (`YiSmartCloudApplication`), aggregates config. No business logic here. |
| `YiSmartCloud-framework` | Security (Spring Security + JWT), Redis, global config, interceptors |
| `YiSmartCloud-system` | System management — users, roles, menus, dicts, params |
| `YiSmartCloud-common` | Shared utilities — `BaseController`, `AjaxResult`, `SecurityUtils`, AI client (`QianfanChatSupport`) |
| `YiSmartCloud-nursing-platform` | **Core elderly-care business module** — all `/serve/` controllers, services, domain/VO, MyBatis XML |
| `YiSmartCloud-quartz` | Scheduled tasks |
| `YiSmartCloud-generator` | Code generation (Velocity templates) |
| `YiSmartCloud-oss` | Object storage (Aliyun OSS) |

## Architecture patterns

### Backend request flow

```
Controller (@RestController, @PreAuthorize, @Log, @Api)
  → Service (business validation, @Transactional)
    → Mapper (BaseMapper for simple CRUD; custom XML for JOINs, trees, stats)
```

- Controllers return `AjaxResult` via `toAjax()`, `success()`, `getDataTable()` (with `startPage()` for pagination)
- Throw `ServiceException` for business errors; do not scatter validation into controllers
- Use `@RepeatSubmit` on write endpoints susceptible to double-submission
- All business code under `YiSmartCloud-nursing-platform` in the `serve` package, not in `YiSmartCloud-system` or `-admin`

### HTTP / API conventions

- Elderly-care API prefix: **`/serve/...`**
- Frontend API modules in `src/api/serve/`, pages in `src/views/serve/`
- Dev proxy: `/dev-api` → `http://localhost:8080` (strips `/dev-api` prefix)
- API docs: Knife4j (`/doc.html`) + Swagger 2 annotations (`io.swagger.annotations` — `@Api`, `@ApiOperation`). Do NOT use springdoc/OpenAPI 3 annotations.
- Auth: `Authorization: Bearer <jwt>` header

### Frontend patterns

- Vue 3 `script setup`, Element Plus, Pinia
- Page state: `queryParams`, `form`, `rules` in `reactive`, exposed via `toRefs`
- Standard CRUD function names: `getList`, `handleQuery`, `resetQuery`, `handleAdd`, `handleUpdate`, `handleDelete`, `handleExport`
- Permission: `v-hasPermi="['module:entity:action']"` on buttons; must match backend `@PreAuthorize("@ss.hasPermi('module:entity:action')")`
- API functions follow `listX/getX/addX/updateX/delX` naming
- Routes are primarily **dynamic** from backend menu data; avoid heavy static route definitions

### Backend layering conventions

- **`domain/`** — persistence entities, extend `BaseEntity` (inherits `createTime`, `createBy`, `updateTime`, `updateBy`, `remark`). Use `@TableField(exist = false)` for non-column fields from JOINs.
- **`vo/`** — response/view objects. Annotate with `@ApiModel`/`@ApiModelProperty` (Swagger 2).
- **`dto/`** — request/aggregation DTOs. No `@TableName`/`@TableField` annotations. Use `@Data`.
- **Mapper XML** — custom SQL uses `<sql id="selectXxxVo">` + `<include refid="..."/>` for shared column lists. MyBatis-Plus `BaseMapper` methods only for simple single-table CRUD.

## Repo conventions (from .cursor/rules)

- **UTF-8** encoding for all source/docs files
- After every substantive code change, add a dated record to **`docs/code_review/`** (format: `YYYY-MM-DD_HHMM_<description>.md`), listing changed files, key modifications, impact scope, and verification method
- Do NOT commit: `**/target/**`, IDE detritus, config files containing real credentials
- Do NOT add business controllers to `YiSmartCloud-system` or `YiSmartCloud-admin`
- JWT secret and DB/Redis credentials must not be hardcoded in committed config; replace defaults before production
