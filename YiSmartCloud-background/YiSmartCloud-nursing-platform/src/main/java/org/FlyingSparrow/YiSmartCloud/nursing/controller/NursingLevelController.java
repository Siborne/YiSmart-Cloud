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
import org.FlyingSparrow.YiSmartCloud.nursing.domain.NursingLevel;
import org.FlyingSparrow.YiSmartCloud.nursing.service.INursingLevelService;
import org.FlyingSparrow.YiSmartCloud.common.utils.poi.ExcelUtil;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;

/**
 * 护理等级Controller
 * 
 * @author Siborne
 * @date 2026-02-28
 */
@Api(tags = "护理等级管理", description = "护理等级的增删改查及导出功能")
@RestController
@RequestMapping("/serve/level")
public class NursingLevelController extends BaseController
{
    @Autowired
    private INursingLevelService nursingLevelService;

    /**
     * 查询护理等级列表
     */
    @ApiOperation(value = "查询护理等级列表", notes = "根据条件分页查询护理等级信息列表")
    @ApiResponses({
            @ApiResponse(code = 200, message = "查询成功"),
            @ApiResponse(code = 401, message = "未授权"),
            @ApiResponse(code = 403, message = "权限不足")
    })
    @PreAuthorize("@ss.hasPermi('serve:level:list')")
    @GetMapping("/list")
    public TableDataInfo list(
            @ApiParam(name = "nursingLevel", value = "护理等级查询条件", required = false)
            NursingLevel nursingLevel)
    {
        startPage();
        List<NursingLevel> list = nursingLevelService.selectNursingLevelList(nursingLevel);
        return getDataTable(list);
    }

    /**
     * 导出护理等级列表
     */
    @ApiOperation(value = "导出护理等级列表", notes = "将护理等级数据导出为Excel文件")
    @ApiResponses({
            @ApiResponse(code = 200, message = "导出成功"),
            @ApiResponse(code = 401, message = "未授权"),
            @ApiResponse(code = 403, message = "权限不足")
    })
    @PreAuthorize("@ss.hasPermi('serve:level:export')")
    @Log(title = "护理等级", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(
            @ApiParam(name = "response", value = "HTTP响应对象", required = true)
            HttpServletResponse response,
            @ApiParam(name = "nursingLevel", value = "护理等级查询条件", required = false)
            NursingLevel nursingLevel)
    {
        List<NursingLevel> list = nursingLevelService.selectNursingLevelList(nursingLevel);
        ExcelUtil<NursingLevel> util = new ExcelUtil<NursingLevel>(NursingLevel.class);
        util.exportExcel(response, list, "护理等级数据");
    }

    /**
     * 获取护理等级详细信息
     */
    @ApiOperation(value = "获取护理等级详细信息", notes = "根据ID查询护理等级的详细信息")
    @ApiResponses({
            @ApiResponse(code = 200, message = "查询成功"),
            @ApiResponse(code = 401, message = "未授权"),
            @ApiResponse(code = 403, message = "权限不足"),
            @ApiResponse(code = 404, message = "数据不存在")
    })
    @PreAuthorize("@ss.hasPermi('serve:level:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(
            @ApiParam(name = "id", value = "护理等级ID", required = true, example = "1")
            @PathVariable("id") Long id)
    {
        return success(nursingLevelService.selectNursingLevelById(id));
    }

    /**
     * 新增护理等级
     */
    @ApiOperation(value = "新增护理等级", notes = "创建新的护理等级信息")
    @ApiResponses({
            @ApiResponse(code = 200, message = "新增成功"),
            @ApiResponse(code = 400, message = "请求参数错误"),
            @ApiResponse(code = 401, message = "未授权"),
            @ApiResponse(code = 403, message = "权限不足")
    })
    @PreAuthorize("@ss.hasPermi('serve:level:add')")
    @Log(title = "护理等级", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(
            @ApiParam(name = "nursingLevel", value = "护理等级信息", required = true)
            @RequestBody NursingLevel nursingLevel)
    {
        return toAjax(nursingLevelService.insertNursingLevel(nursingLevel));
    }

    /**
     * 修改护理等级
     */
    @ApiOperation(value = "修改护理等级", notes = "更新已存在的护理等级信息")
    @ApiResponses({
            @ApiResponse(code = 200, message = "修改成功"),
            @ApiResponse(code = 400, message = "请求参数错误"),
            @ApiResponse(code = 401, message = "未授权"),
            @ApiResponse(code = 403, message = "权限不足"),
            @ApiResponse(code = 404, message = "数据不存在")
    })
    @PreAuthorize("@ss.hasPermi('serve:level:edit')")
    @Log(title = "护理等级", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(
            @ApiParam(name = "nursingLevel", value = "护理等级信息", required = true)
            @RequestBody NursingLevel nursingLevel)
    {
        return toAjax(nursingLevelService.updateNursingLevel(nursingLevel));
    }

    /**
     * 删除护理等级
     */
    @ApiOperation(value = "删除护理等级", notes = "根据ID批量删除护理等级信息")
    @ApiResponses({
            @ApiResponse(code = 200, message = "删除成功"),
            @ApiResponse(code = 401, message = "未授权"),
            @ApiResponse(code = 403, message = "权限不足"),
            @ApiResponse(code = 404, message = "数据不存在")
    })
    @PreAuthorize("@ss.hasPermi('serve:level:remove')")
    @Log(title = "护理等级", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(
            @ApiParam(name = "ids", value = "护理等级ID数组", required = true, example = "[1,2,3]")
            @PathVariable Long[] ids)
    {
        return toAjax(nursingLevelService.deleteNursingLevelByIds(ids));
    }
}
