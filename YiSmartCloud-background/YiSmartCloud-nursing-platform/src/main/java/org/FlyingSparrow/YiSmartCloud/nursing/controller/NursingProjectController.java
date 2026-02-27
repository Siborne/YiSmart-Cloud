package org.FlyingSparrow.YiSmartCloud.nursing.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import io.swagger.annotations.*;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.R;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.FlyingSparrow.YiSmartCloud.common.annotation.Log;
import org.FlyingSparrow.YiSmartCloud.common.core.controller.BaseController;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.AjaxResult;
import org.FlyingSparrow.YiSmartCloud.common.enums.BusinessType;
import org.FlyingSparrow.YiSmartCloud.nursing.domain.NursingProject;
import org.FlyingSparrow.YiSmartCloud.nursing.service.INursingProjectService;
import org.FlyingSparrow.YiSmartCloud.common.utils.poi.ExcelUtil;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;

/**
 * 护理项目Controller
 *
 * @author ruoyi
 * @date 2026-02-27
 */
// Swagger API文档注解，描述该Controller的功能
@Api(tags = "护理项目管理", description = "护理项目的增删改查及导出功能")
// 标记该类为RESTful风格的控制器，返回JSON格式数据
@RestController
// 定义该控制器的基础请求路径为"/serve/project"
@RequestMapping("/serve/project")
// 护理项目控制器类，继承BaseController以获得基础的控制器功能
public class NursingProjectController extends BaseController
{
    // 自动注入护理项目服务接口实现类
    @Autowired
    private INursingProjectService nursingProjectService;

    /**
     * 查询护理项目列表
     */
    // Swagger操作注解，描述该API的功能
    @ApiOperation(value = "查询护理项目列表", notes = "根据条件分页查询护理项目信息列表")
    // Swagger响应注解，描述可能的响应结果
    @ApiResponses({
            @ApiResponse(code = 200, message = "查询成功"),
            @ApiResponse(code = 401, message = "未授权"),
            @ApiResponse(code = 403, message = "权限不足")
    })
    // 权限校验注解，检查用户是否具有"serve:project:list"权限
    @PreAuthorize("@ss.hasPermi('serve:project:list')")
    // 映射GET请求到"/list"路径
    @GetMapping("/list")
    // 处理查询护理项目列表的请求，接收NursingProject对象作为查询条件参数
    public TableDataInfo<List<NursingProject>> list(
            @ApiParam(name = "nursingProject", value = "护理项目查询条件", required = false)
            NursingProject nursingProject)
    {
        // 开启分页功能，从ThreadLocal中获取分页参数
        startPage();
        // 调用服务层方法查询护理项目列表数据
        List<NursingProject> list = nursingProjectService.selectNursingProjectList(nursingProject);
        // 将查询结果封装成带分页信息的TableDataInfo对象并返回
        return getDataTable(list);
    }

    /**
     * 导出护理项目列表
     */
    // Swagger操作注解，描述该API的功能
    @ApiOperation(value = "导出护理项目列表", notes = "将护理项目数据导出为Excel文件")
    // Swagger响应注解，描述可能的响应结果
    @ApiResponses({
            @ApiResponse(code = 200, message = "导出成功"),
            @ApiResponse(code = 401, message = "未授权"),
            @ApiResponse(code = 403, message = "权限不足")
    })
    // 权限校验注解，检查用户是否具有"serve:project:export"导出权限
    @PreAuthorize("@ss.hasPermi('serve:project:export')")
    // 日志记录注解，记录操作日志，标题为"护理项目"，业务类型为导出
    @Log(title = "护理项目", businessType = BusinessType.EXPORT)
    // 映射POST请求到"/export"路径
    @PostMapping("/export")
    // 处理导出护理项目列表的请求，接收HttpServletResponse响应对象和查询条件
    public void export(
            @ApiParam(name = "response", value = "HTTP响应对象", required = true)
            HttpServletResponse response,
            @ApiParam(name = "nursingProject", value = "护理项目查询条件", required = false)
            NursingProject nursingProject)
    {
        // 查询需要导出的护理项目数据列表
        List<NursingProject> list = nursingProjectService.selectNursingProjectList(nursingProject);
        // 创建Excel工具类实例，指定处理NursingProject实体类
        ExcelUtil<NursingProject> util = new ExcelUtil<NursingProject>(NursingProject.class);
        // 执行Excel导出操作，将数据写入响应流，文件名为"护理项目数据"
        util.exportExcel(response, list, "护理项目数据");
    }

    /**
     * 获取护理项目详细信息
     */
    // Swagger操作注解，描述该API的功能
    @ApiOperation(value = "获取护理项目详细信息", notes = "根据ID查询护理项目的详细信息")
    // Swagger响应注解，描述可能的响应结果
    @ApiResponses({
            @ApiResponse(code = 200, message = "查询成功"),
            @ApiResponse(code = 401, message = "未授权"),
            @ApiResponse(code = 403, message = "权限不足"),
            @ApiResponse(code = 404, message = "数据不存在")
    })
    // 权限校验注解，检查用户是否具有"serve:project:query"查询权限
    @PreAuthorize("@ss.hasPermi('serve:project:query')")
    // 映射GET请求到"/{id}"路径，其中{id}是路径变量
    @GetMapping(value = "/{id}")
    // 处理根据ID获取护理项目详情的请求，@PathVariable将路径中的id绑定到方法参数
    public R<NursingProject> getInfo(
            @ApiParam(name = "id", value = "护理项目ID", required = true, example = "1")
            @PathVariable("id") Long id)
    {
        // 调用服务层方法根据ID查询护理项目，并返回成功的Ajax响应结果
        NursingProject nursingProject = nursingProjectService.selectNursingProjectById(id);
        return R.ok(nursingProject);
    }

    /**
     * 新增护理项目
     */
    // Swagger操作注解，描述该API的功能
    @ApiOperation(value = "新增护理项目", notes = "创建新的护理项目信息")
    // Swagger响应注解，描述可能的响应结果
    @ApiResponses({
            @ApiResponse(code = 200, message = "新增成功"),
            @ApiResponse(code = 400, message = "请求参数错误"),
            @ApiResponse(code = 401, message = "未授权"),
            @ApiResponse(code = 403, message = "权限不足")
    })
    // 权限校验注解，检查用户是否具有"serve:project:add"新增权限
    @PreAuthorize("@ss.hasPermi('serve:project:add')")
    // 日志记录注解，记录操作日志，标题为"护理项目"，业务类型为插入
    @Log(title = "护理项目", businessType = BusinessType.INSERT)
    // 映射POST请求到基础路径"/serve/project"
    @PostMapping
    // 处理新增护理项目的请求，@RequestBody将请求体中的JSON数据绑定到NursingProject对象
    public AjaxResult add(
            @ApiParam(name = "nursingProject", value = "护理项目信息", required = true)
            @RequestBody NursingProject nursingProject)
    {
        // 调用服务层方法插入护理项目数据，并将影响行数转换为Ajax响应结果
        return toAjax(nursingProjectService.insertNursingProject(nursingProject));
    }

    /**
     * 修改护理项目
     */
    // Swagger操作注解，描述该API的功能
    @ApiOperation(value = "修改护理项目", notes = "更新已存在的护理项目信息")
    // Swagger响应注解，描述可能的响应结果
    @ApiResponses({
            @ApiResponse(code = 200, message = "修改成功"),
            @ApiResponse(code = 400, message = "请求参数错误"),
            @ApiResponse(code = 401, message = "未授权"),
            @ApiResponse(code = 403, message = "权限不足"),
            @ApiResponse(code = 404, message = "数据不存在")
    })
    // 权限校验注解，检查用户是否具有"serve:project:edit"编辑权限
    @PreAuthorize("@ss.hasPermi('serve:project:edit')")
    // 日志记录注解，记录操作日志，标题为"护理项目"，业务类型为更新
    @Log(title = "护理项目", businessType = BusinessType.UPDATE)
    // 映射PUT请求到基础路径"/serve/project"
    @PutMapping
    // 处理修改护理项目的请求，@RequestBody将请求体中的JSON数据绑定到NursingProject对象
    public AjaxResult edit(
            @ApiParam(name = "nursingProject", value = "护理项目信息", required = true)
            @RequestBody NursingProject nursingProject)
    {
        // 调用服务层方法更新护理项目数据，并将影响行数转换为Ajax响应结果
        return toAjax(nursingProjectService.updateNursingProject(nursingProject));
    }

    /**
     * 删除护理项目
     */
    // Swagger操作注解，描述该API的功能
    @ApiOperation(value = "删除护理项目", notes = "根据ID批量删除护理项目信息")
    // Swagger响应注解，描述可能的响应结果
    @ApiResponses({
            @ApiResponse(code = 200, message = "删除成功"),
            @ApiResponse(code = 401, message = "未授权"),
            @ApiResponse(code = 403, message = "权限不足"),
            @ApiResponse(code = 404, message = "数据不存在")
    })
    // 权限校验注解，检查用户是否具有"serve:project:remove"删除权限
    @PreAuthorize("@ss.hasPermi('serve:project:remove')")
    // 日志记录注解，记录操作日志，标题为"护理项目"，业务类型为删除
    @Log(title = "护理项目", businessType = BusinessType.DELETE)
    // 映射DELETE请求到"/{ids}"路径，支持批量删除
    @DeleteMapping("/{ids}")
    // 处理删除护理项目的请求，@PathVariable将路径中的ids数组绑定到方法参数
    public AjaxResult remove(
            @ApiParam(name = "ids", value = "护理项目ID数组", required = true, example = "[1,2,3]")
            @PathVariable Long[] ids)
    {
        // 调用服务层方法批量删除护理项目数据，并将影响行数转换为Ajax响应结果
        return toAjax(nursingProjectService.deleteNursingProjectByIds(ids));
    }
}
