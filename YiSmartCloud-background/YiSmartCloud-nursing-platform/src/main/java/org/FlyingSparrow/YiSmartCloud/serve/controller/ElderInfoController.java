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
import org.FlyingSparrow.YiSmartCloud.serve.domain.ElderInfo;
import org.FlyingSparrow.YiSmartCloud.serve.service.IElderInfoService;
import org.FlyingSparrow.YiSmartCloud.common.utils.poi.ExcelUtil;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;

import lombok.RequiredArgsConstructor;

/**
 * 在院老人主数据：与入住办理联动，承载床位与护理等级分配后的在院状态；
 * 护工 / 责任护理员排班与派工可在后续「照护排班」能力中对接本主键。
 *
 * @author Siborne
 * @date 2026-04-27
 */
@RestController
@RequestMapping("/serve/info")
@Api(tags = "老人入住与在院信息")
@RequiredArgsConstructor
public class ElderInfoController extends BaseController {
    private final IElderInfoService elderInfoService;

    /**
     * 查询在院老人信息列表
     */
    @PreAuthorize("@ss.hasPermi('serve:info:list')")
    @GetMapping("/list")
    @ApiOperation("查询在院老人信息列表")
    public TableDataInfo list(ElderInfo elderInfo) {
        startPage();
        List<ElderInfo> list = elderInfoService.selectElderInfoList(elderInfo);
        return getDataTable(list);
    }

    /**
     * 导出在院老人信息列表
     */
    @PreAuthorize("@ss.hasPermi('serve:info:export')")
    @Log(title = "在院老人信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出在院老人信息列表")
    public void export(HttpServletResponse response, ElderInfo elderInfo) {
        List<ElderInfo> list = elderInfoService.selectElderInfoList(elderInfo);
        ExcelUtil<ElderInfo> util = new ExcelUtil<ElderInfo>(ElderInfo.class);
        util.exportExcel(response, list, "在院老人信息");
    }

    /**
     * 获取在院老人详细信息
     */
    @PreAuthorize("@ss.hasPermi('serve:info:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取在院老人详细信息")
    public AjaxResult getInfo(@ApiParam(value = "老人主键ID", required = true)
                              @PathVariable("id") Long id) {
        return success(elderInfoService.selectElderInfoById(id));
    }

    /**
     * 新增在院老人信息（一般随入住办理写入；此处保留手工补录）
     */
    @PreAuthorize("@ss.hasPermi('serve:info:add')")
    @Log(title = "在院老人信息", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增在院老人信息")
    public AjaxResult add(@ApiParam(value = "在院老人实体", required = true) @RequestBody ElderInfo elderInfo) {
        return toAjax(elderInfoService.insertElderInfo(elderInfo));
    }

    /**
     * 修改在院老人信息
     */
    @PreAuthorize("@ss.hasPermi('serve:info:edit')")
    @Log(title = "在院老人信息", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改在院老人信息")
    public AjaxResult edit(@ApiParam(value = "在院老人实体", required = true) @RequestBody ElderInfo elderInfo) {
        return toAjax(elderInfoService.updateElderInfo(elderInfo));
    }

    /**
     * 删除在院老人信息
     */
    @PreAuthorize("@ss.hasPermi('serve:info:remove')")
    @Log(title = "在院老人信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @ApiOperation("删除在院老人信息")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(elderInfoService.deleteElderInfoByIds(ids));
    }
}