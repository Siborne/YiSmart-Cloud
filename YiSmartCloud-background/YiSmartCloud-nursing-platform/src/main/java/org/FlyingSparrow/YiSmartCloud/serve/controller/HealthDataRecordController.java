package org.FlyingSparrow.YiSmartCloud.serve.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

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
import org.FlyingSparrow.YiSmartCloud.serve.domain.HealthDataRecord;
import org.FlyingSparrow.YiSmartCloud.serve.service.IHealthDataRecordService;
import org.FlyingSparrow.YiSmartCloud.common.utils.poi.ExcelUtil;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;

import lombok.RequiredArgsConstructor;

/**
 * 健康监测数据Controller
 *
 * @author Siborne
 * @date 2026-04-27
 */
@RestController
@RequestMapping("/serve/healthDataRecord")
@Api(tags = "健康监测数据相关接口")
@RequiredArgsConstructor
public class HealthDataRecordController extends BaseController {
    private final IHealthDataRecordService healthDataRecordService;

    /**
     * 查询健康监测数据列表
     */
    @PreAuthorize("@ss.hasPermi('serve:healthDataRecord:list')")
    @GetMapping("/list")
    @ApiOperation("查询健康监测数据列表")
    public TableDataInfo list(HealthDataRecord healthDataRecord) {
        startPage();
        List<HealthDataRecord> list = healthDataRecordService.selectHealthDataRecordList(healthDataRecord);
        return getDataTable(list);
    }

    /**
     * 导出健康监测数据列表
     */
    @PreAuthorize("@ss.hasPermi('serve:healthDataRecord:export')")
    @Log(title = "健康监测数据", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出健康监测数据列表")
    public void export(HttpServletResponse response, HealthDataRecord healthDataRecord) {
        List<HealthDataRecord> list = healthDataRecordService.selectHealthDataRecordList(healthDataRecord);
        ExcelUtil<HealthDataRecord> util = new ExcelUtil<HealthDataRecord>(HealthDataRecord.class);
        util.exportExcel(response, list, "健康监测数据数据");
    }

    /**
     * 获取健康监测数据详细信息
     */
    @PreAuthorize("@ss.hasPermi('serve:healthDataRecord:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取健康监测数据详细信息")
    public AjaxResult getInfo(@ApiParam(value = "健康监测数据ID", required = true)
                              @PathVariable("id") Long id) {
        return success(healthDataRecordService.selectHealthDataRecordById(id));
    }

    /**
     * 新增健康监测数据
     */
    @PreAuthorize("@ss.hasPermi('serve:healthDataRecord:add')")
    @Log(title = "健康监测数据", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增健康监测数据")
    public AjaxResult add(@ApiParam(value = "健康监测数据实体", required = true) @RequestBody HealthDataRecord healthDataRecord) {
        return toAjax(healthDataRecordService.insertHealthDataRecord(healthDataRecord));
    }

    /**
     * 修改健康监测数据
     */
    @PreAuthorize("@ss.hasPermi('serve:healthDataRecord:edit')")
    @Log(title = "健康监测数据", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改健康监测数据")
    public AjaxResult edit(@ApiParam(value = "健康监测数据实体", required = true) @RequestBody HealthDataRecord healthDataRecord) {
        return toAjax(healthDataRecordService.updateHealthDataRecord(healthDataRecord));
    }

    /**
     * 删除健康监测数据
     */
    @PreAuthorize("@ss.hasPermi('serve:healthDataRecord:remove')")
    @Log(title = "健康监测数据", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @ApiOperation("删除健康监测数据")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(healthDataRecordService.deleteHealthDataRecordByIds(ids));
    }
}