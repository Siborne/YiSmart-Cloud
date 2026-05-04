package org.FlyingSparrow.YiSmartCloud.serve.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import org.FlyingSparrow.YiSmartCloud.serve.dto.CheckInApplyDto;
import org.FlyingSparrow.YiSmartCloud.serve.vo.CheckInDetailVo;
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
import org.FlyingSparrow.YiSmartCloud.serve.domain.CheckIn;
import org.FlyingSparrow.YiSmartCloud.serve.service.ICheckInService;
import org.FlyingSparrow.YiSmartCloud.common.utils.poi.ExcelUtil;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;

import lombok.RequiredArgsConstructor;

/**
 * 入住登记：老人模块的入口流程，完成床位与护理等级等配置后写入在院主数据（{@code /serve/info}）。
 * 护工 / 照护人员具体派工与排班由运营侧后续能力扩展，可与护理计划、员工主数据对接。
 *
 * @author Siborne
 * @date 2026-04-29
 */
@RestController
@RequestMapping("/serve/checkIn")
@Api(tags = "入住登记相关接口")
@RequiredArgsConstructor
public class CheckInController extends BaseController {
    private final ICheckInService checkInService;

    /**
     * 查询入住登记列表
     */
    @PreAuthorize("@ss.hasPermi('serve:checkIn:list')")
    @GetMapping("/list")
    @ApiOperation("查询入住登记列表")
    public TableDataInfo list(CheckIn checkIn) {
        startPage();
        List<CheckIn> list = checkInService.selectCheckInList(checkIn);
        return getDataTable(list);
    }

    /**
     * 导出入住登记列表
     */
    @PreAuthorize("@ss.hasPermi('serve:checkIn:export')")
    @Log(title = "入住登记", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出入住登记列表")
    public void export(HttpServletResponse response, CheckIn checkIn) {
        List<CheckIn> list = checkInService.selectCheckInList(checkIn);
        ExcelUtil<CheckIn> util = new ExcelUtil<CheckIn>(CheckIn.class);
        util.exportExcel(response, list, "入住登记数据");
    }

    /**
     * 获取入住登记详细信息
     */
    @PreAuthorize("@ss.hasPermi('serve:checkIn:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取入住登记详细信息")
    public AjaxResult getInfo(@ApiParam(value = "入住登记ID", required = true)
                              @PathVariable("id") Long id) {
        return success(checkInService.selectCheckInById(id));
    }

    /**
     * 新增入住登记
     */
    @PreAuthorize("@ss.hasPermi('serve:checkIn:add')")
    @Log(title = "入住登记", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增入住登记")
    public AjaxResult add(@ApiParam(value = "入住登记实体", required = true) @RequestBody CheckIn checkIn) {
        return toAjax(checkInService.insertCheckIn(checkIn));
    }

    /**
     * 修改入住登记
     */
    @PreAuthorize("@ss.hasPermi('serve:checkIn:edit')")
    @Log(title = "入住登记", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改入住登记")
    public AjaxResult edit(@ApiParam(value = "入住登记实体", required = true) @RequestBody CheckIn checkIn) {
        return toAjax(checkInService.updateCheckIn(checkIn));
    }

    /**
     * 删除入住登记
     */
    @PreAuthorize("@ss.hasPermi('serve:checkIn:remove')")
    @Log(title = "入住登记", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @ApiOperation("删除入住登记")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(checkInService.deleteCheckInByIds(ids));
    }

    @PreAuthorize("@ss.hasPermi('serve:checkIn:add')")
    @Log(title = "入住登记", businessType = BusinessType.INSERT)
    @PostMapping("/apply")
    @ApiOperation("申请入住")
    public AjaxResult apply(@RequestBody CheckInApplyDto dto) {
        checkInService.apply(dto);
        return AjaxResult.success();
    }

    @PreAuthorize("@ss.hasPermi('serve:checkIn:query')")
    @GetMapping("/detail/{id}")
    @ApiOperation("查询入住详情（含申请页同款聚合信息）")
    public AjaxResult detail(@PathVariable("id") Long id) {
        CheckInDetailVo checkInDetailVo = checkInService.detail(id);
        return success(checkInDetailVo);
    }
}