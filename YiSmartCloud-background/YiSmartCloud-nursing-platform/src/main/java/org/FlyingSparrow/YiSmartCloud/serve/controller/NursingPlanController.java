package org.FlyingSparrow.YiSmartCloud.serve.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import org.FlyingSparrow.YiSmartCloud.common.core.domain.R;
import org.FlyingSparrow.YiSmartCloud.serve.dto.NursingPlanDto;
import org.FlyingSparrow.YiSmartCloud.serve.vo.NursingPlanVo;
import org.springframework.security.access.prepost.PreAuthorize;
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
import org.FlyingSparrow.YiSmartCloud.serve.domain.NursingPlan;
import org.FlyingSparrow.YiSmartCloud.serve.service.INursingPlanService;
import org.FlyingSparrow.YiSmartCloud.common.utils.poi.ExcelUtil;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;

import lombok.RequiredArgsConstructor;

/**
 * 护理计划Controller
 *
 * @author Siborne
 * @date 2026-03-23
 */
@RestController
@RequestMapping("/serve/plan")
@Api(tags = "护理计划相关接口")
@RequiredArgsConstructor
public class NursingPlanController extends BaseController {
    private final INursingPlanService nursingPlanService;

    /**
     * 查询护理计划列表
     */
    @PreAuthorize("@ss.hasPermi('serve:plan:list')")
    @GetMapping("/list")
    @ApiOperation("查询护理计划列表")
    public TableDataInfo list(NursingPlan nursingPlan) {
        startPage();
        List<NursingPlan> list = nursingPlanService.selectNursingPlanList(nursingPlan);
        return getDataTable(list);
    }

    /**
     * 查询所有启用状态的护理计划（护理等级等下拉框）
     */
    @GetMapping("/all")
    @ApiOperation("查询所有启用状态的护理计划")
    public AjaxResult listAll() {
        return success(nursingPlanService.selectNursingPlanAll());
    }

    /**
     * 导出护理计划列表
     */
    @PreAuthorize("@ss.hasPermi('serve:plan:export')")
    @Log(title = "护理计划", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出护理计划列表")
    public void export(HttpServletResponse response, NursingPlan nursingPlan) {
        List<NursingPlan> list = nursingPlanService.selectNursingPlanList(nursingPlan);
        ExcelUtil<NursingPlan> util = new ExcelUtil<NursingPlan>(NursingPlan.class);
        util.exportExcel(response, list, "护理计划数据");
    }

    /**
     * 获取护理计划详细信息
     */
    @PreAuthorize("@ss.hasPermi('serve:plan:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取护理计划详细信息")
    public R<NursingPlanVo> getInfo(@ApiParam(value = "护理计划ID", required = true)
                              @PathVariable("id") Long id) {
        return R.ok(nursingPlanService.selectNursingPlanById(id));
    }

    /**
     * 新增护理计划
     */
    @PreAuthorize("@ss.hasPermi('serve:plan:add')")
    @Log(title = "护理计划", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增护理计划")
    public AjaxResult add(@ApiParam(value = "护理计划实体", required = true) @RequestBody NursingPlanDto dto) {
        return toAjax(nursingPlanService.insertNursingPlan(dto));
    }

    /**
     * 修改护理计划
     */
    @PreAuthorize("@ss.hasPermi('serve:plan:edit')")
    @Log(title = "护理计划", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改护理计划")
    public AjaxResult edit(@ApiParam(value = "护理计划实体", required = true) @RequestBody NursingPlanDto dto) {
        return toAjax(nursingPlanService.updateNursingPlan(dto));
    }

    /**
     * 删除护理计划
     */
    @PreAuthorize("@ss.hasPermi('serve:plan:remove')")
    @Log(title = "护理计划", businessType = BusinessType.DELETE)
    @DeleteMapping("/{id}")
    @ApiOperation("删除护理计划")
    public AjaxResult remove(@PathVariable Long id) {
        return toAjax(nursingPlanService.deleteNursingPlanById(id));
    }
}