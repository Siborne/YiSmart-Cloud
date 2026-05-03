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
import org.FlyingSparrow.YiSmartCloud.serve.domain.Bed;
import org.FlyingSparrow.YiSmartCloud.serve.service.IBedService;
import org.FlyingSparrow.YiSmartCloud.common.utils.poi.ExcelUtil;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;

import lombok.RequiredArgsConstructor;

/**
 * 床位信息Controller
 *
 * @author Siborne
 * @date 2026-04-27
 */
@RestController
@RequestMapping("/serve/bed")
@Api(tags =  "床位信息相关接口")
@RequiredArgsConstructor
public class BedController extends BaseController
{
    private final IBedService bedService;

/**
 * 查询床位信息列表
 */
@PreAuthorize("@ss.hasPermi('serve:bed:list')")
@GetMapping("/list")
@ApiOperation("查询床位信息列表")
public TableDataInfo list(Bed bed) {
    startPage();
    List<Bed> list = bedService.selectBedList(bed);
    return getDataTable(list);
}

    /**
     * 导出床位信息列表
     */
    @PreAuthorize("@ss.hasPermi('serve:bed:export')")
    @Log(title = "床位信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出床位信息列表")
    public void export(HttpServletResponse response, Bed bed)
    {
        List<Bed> list = bedService.selectBedList(bed);
        ExcelUtil<Bed> util = new ExcelUtil<Bed>(Bed.class);
        util.exportExcel(response, list, "床位信息数据");
    }

    /**
     * 获取床位信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('serve:bed:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取床位信息详细信息")
    public AjaxResult getInfo(@ApiParam(value = "床位信息ID", required = true)
                              @PathVariable("id") Long id)
    {
        return success(bedService.selectBedById(id));
    }

    /**
     * 新增床位信息
     */
    @PreAuthorize("@ss.hasPermi('serve:bed:add')")
    @Log(title = "床位信息", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增床位信息")
    public AjaxResult add(@ApiParam(value = "床位信息实体", required = true) @RequestBody Bed bed)
    {
        return toAjax(bedService.insertBed(bed));
    }

    /**
     * 修改床位信息
     */
    @PreAuthorize("@ss.hasPermi('serve:bed:edit')")
    @Log(title = "床位信息", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改床位信息")
    public AjaxResult edit(@ApiParam(value = "床位信息实体", required = true)  @RequestBody Bed bed)
    {
        return toAjax(bedService.updateBed(bed));
    }

    /**
     * 删除床位信息
     */
    @PreAuthorize("@ss.hasPermi('serve:bed:remove')")
    @Log(title = "床位信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @ApiOperation("删除床位信息")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(bedService.deleteBedByIds(ids));
    }
}