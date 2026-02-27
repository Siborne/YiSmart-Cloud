package org.FlyingSparrow.YiSmartCloud.nursing.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
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
import org.FlyingSparrow.YiSmartCloud.nursing.domain.NursingPlan;
import org.FlyingSparrow.YiSmartCloud.nursing.service.INursingPlanService;
import org.FlyingSparrow.YiSmartCloud.common.utils.poi.ExcelUtil;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;

/**
 * 护理计划Controller
 * 
 * @author Siborne
 * @date 2026-02-28
 */
@Api(tags = "护理计划管理", description = "护理计划的增删改查及导出功能")
@RestController
@RequestMapping("/serve/plan")
public class NursingPlanController extends BaseController
{
    @Autowired
    private INursingPlanService nursingPlanService;

    /**
     * 查询护理计划列表
     */
    @ApiOperation(value = "查询护理计划列表", notes = "根据条件分页查询护理计划信息列表")
    @ApiResponses({
            @ApiResponse(code = 200, message = "查询成功"),
            @ApiResponse(code = 401, message = "未授权"),
            @ApiResponse(code = 403, message = "权限不足")
    })
    @PreAuthorize("@ss.hasPermi('serve:plan:list')")
    @GetMapping("/list")
    public TableDataInfo list(
            @ApiParam(name = "nursingPlan", value = "护理计划查询条件", required = false)
            NursingPlan nursingPlan)
    {
        startPage();
        List<NursingPlan> list = nursingPlanService.selectNursingPlanList(nursingPlan);
        return getDataTable(list);
    }

    /**
     * 导出护理计划列表
     */
    @ApiOperation(value = "导出护理计划列表", notes = "将护理计划数据导出为Excel文件")
    @ApiResponses({
            @ApiResponse(code = 200, message = "导出成功"),
            @ApiResponse(code = 401, message = "未授权"),
            @ApiResponse(code = 403, message = "权限不足")
    })
    @PreAuthorize("@ss.hasPermi('serve:plan:export')")
    @Log(title = "护理计划", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(
            @ApiParam(name = "response", value = "HTTP响应对象", required = true)
            HttpServletResponse response,
            @ApiParam(name = "nursingPlan", value = "护理计划查询条件", required = false)
            NursingPlan nursingPlan)
    {
        List<NursingPlan> list = nursingPlanService.selectNursingPlanList(nursingPlan);
        ExcelUtil<NursingPlan> util = new ExcelUtil<NursingPlan>(NursingPlan.class);
        util.exportExcel(response, list, "护理计划数据");
    }

    /**
     * 获取护理计划详细信息
     */
    @ApiOperation(value = "获取护理计划详细信息", notes = "根据ID查询护理计划的详细信息")
    @ApiResponses({
            @ApiResponse(code = 200, message = "查询成功"),
            @ApiResponse(code = 401, message = "未授权"),
            @ApiResponse(code = 403, message = "权限不足"),
            @ApiResponse(code = 404, message = "数据不存在")
    })
    @PreAuthorize("@ss.hasPermi('serve:plan:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(
            @ApiParam(name = "id", value = "护理计划ID", required = true, example = "1")
            @PathVariable("id") Long id)
    {
        return success(nursingPlanService.selectNursingPlanById(id));
    }

    /**
     * 新增护理计划
     */
    @ApiOperation(value = "新增护理计划", notes = "创建新的护理计划信息")
    @ApiResponses({
            @ApiResponse(code = 200, message = "新增成功"),
            @ApiResponse(code = 400, message = "请求参数错误"),
            @ApiResponse(code = 401, message = "未授权"),
            @ApiResponse(code = 403, message = "权限不足")
    })
    @PreAuthorize("@ss.hasPermi('serve:plan:add')")
    @Log(title = "护理计划", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(
            @ApiParam(name = "nursingPlan", value = "护理计划信息", required = true)
            @RequestBody NursingPlan nursingPlan)
    {
        return toAjax(nursingPlanService.insertNursingPlan(nursingPlan));
    }

    /**
     * 修改护理计划
     */
    @ApiOperation(value = "修改护理计划", notes = "更新已存在的护理计划信息")
    @ApiResponses({
            @ApiResponse(code = 200, message = "修改成功"),
            @ApiResponse(code = 400, message = "请求参数错误"),
            @ApiResponse(code = 401, message = "未授权"),
            @ApiResponse(code = 403, message = "权限不足"),
            @ApiResponse(code = 404, message = "数据不存在")
    })
    @PreAuthorize("@ss.hasPermi('serve:plan:edit')")
    @Log(title = "护理计划", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(
            @ApiParam(name = "nursingPlan", value = "护理计划信息", required = true)
            @RequestBody NursingPlan nursingPlan)
    {
        return toAjax(nursingPlanService.updateNursingPlan(nursingPlan));
    }

    /**
     * 删除护理计划
     */
    @ApiOperation(value = "删除护理计划", notes = "根据ID批量删除护理计划信息")
    @ApiResponses({
            @ApiResponse(code = 200, message = "删除成功"),
            @ApiResponse(code = 401, message = "未授权"),
            @ApiResponse(code = 403, message = "权限不足"),
            @ApiResponse(code = 404, message = "数据不存在")
    })
    @PreAuthorize("@ss.hasPermi('serve:plan:remove')")
    @Log(title = "护理计划", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(
            @ApiParam(name = "ids", value = "护理计划ID数组", required = true, example = "[1,2,3]")
            @PathVariable Long[] ids)
    {
        return toAjax(nursingPlanService.deleteNursingPlanByIds(ids));
    }
}
