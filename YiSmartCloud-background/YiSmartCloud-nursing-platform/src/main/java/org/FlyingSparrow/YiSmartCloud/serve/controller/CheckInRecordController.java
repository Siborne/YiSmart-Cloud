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
import org.FlyingSparrow.YiSmartCloud.serve.domain.CheckInRecord;
import org.FlyingSparrow.YiSmartCloud.serve.service.ICheckInRecordService;
import org.FlyingSparrow.YiSmartCloud.common.utils.poi.ExcelUtil;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;

import lombok.RequiredArgsConstructor;

/**
 * 老人入住记录Controller
 *
 * @author Siborne
 * @date 2026-04-27
 */
@RestController
@RequestMapping("/serve/checkInRecord")
@Api(tags = "老人入住记录相关接口")
@RequiredArgsConstructor
public class CheckInRecordController extends BaseController {
    private final ICheckInRecordService checkInRecordService;

    /**
     * 查询老人入住记录列表
     */
    @PreAuthorize("@ss.hasPermi('serve:checkInRecord:list')")
    @GetMapping("/list")
    @ApiOperation("查询老人入住记录列表")
    public TableDataInfo list(CheckInRecord checkInRecord) {
        startPage();
        List<CheckInRecord> list = checkInRecordService.selectCheckInRecordList(checkInRecord);
        return getDataTable(list);
    }

    /**
     * 导出老人入住记录列表
     */
    @PreAuthorize("@ss.hasPermi('serve:checkInRecord:export')")
    @Log(title = "老人入住记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出老人入住记录列表")
    public void export(HttpServletResponse response, CheckInRecord checkInRecord) {
        List<CheckInRecord> list = checkInRecordService.selectCheckInRecordList(checkInRecord);
        ExcelUtil<CheckInRecord> util = new ExcelUtil<CheckInRecord>(CheckInRecord.class);
        util.exportExcel(response, list, "老人入住记录数据");
    }

    /**
     * 获取老人入住记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('serve:checkInRecord:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取老人入住记录详细信息")
    public AjaxResult getInfo(@ApiParam(value = "老人入住记录ID", required = true)
                              @PathVariable("id") Long id) {
        return success(checkInRecordService.selectCheckInRecordById(id));
    }

    /**
     * 新增老人入住记录
     */
    @PreAuthorize("@ss.hasPermi('serve:checkInRecord:add')")
    @Log(title = "老人入住记录", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增老人入住记录")
    public AjaxResult add(@ApiParam(value = "老人入住记录实体", required = true) @RequestBody CheckInRecord checkInRecord) {
        return toAjax(checkInRecordService.insertCheckInRecord(checkInRecord));
    }

    /**
     * 修改老人入住记录
     */
    @PreAuthorize("@ss.hasPermi('serve:checkInRecord:edit')")
    @Log(title = "老人入住记录", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改老人入住记录")
    public AjaxResult edit(@ApiParam(value = "老人入住记录实体", required = true) @RequestBody CheckInRecord checkInRecord) {
        return toAjax(checkInRecordService.updateCheckInRecord(checkInRecord));
    }

    /**
     * 删除老人入住记录
     */
    @PreAuthorize("@ss.hasPermi('serve:checkInRecord:remove')")
    @Log(title = "老人入住记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @ApiOperation("删除老人入住记录")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(checkInRecordService.deleteCheckInRecordByIds(ids));
    }
}