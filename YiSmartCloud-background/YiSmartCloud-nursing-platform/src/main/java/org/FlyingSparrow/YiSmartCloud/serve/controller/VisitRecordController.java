package org.FlyingSparrow.YiSmartCloud.serve.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
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
import org.FlyingSparrow.YiSmartCloud.serve.domain.VisitRecord;
import org.FlyingSparrow.YiSmartCloud.serve.service.IVisitRecordService;
import org.FlyingSparrow.YiSmartCloud.common.utils.poi.ExcelUtil;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;

/**
 * 访客预约记录Controller
 *
 * @author Siborne
 * @date 2026-04-27
 */
@RestController
@RequestMapping("/serve/visitRecord")
@Api(tags =  "访客预约记录相关接口")
public class VisitRecordController extends BaseController
{
    @Autowired
    private IVisitRecordService visitRecordService;

/**
 * 查询访客预约记录列表
 */
@PreAuthorize("@ss.hasPermi('serve:visitRecord:list')")
@GetMapping("/list")
@ApiOperation("查询访客预约记录列表")
public TableDataInfo list(VisitRecord visitRecord) {
    startPage();
    List<VisitRecord> list = visitRecordService.selectVisitRecordList(visitRecord);
    return getDataTable(list);
}

    /**
     * 导出访客预约记录列表
     */
    @PreAuthorize("@ss.hasPermi('serve:visitRecord:export')")
    @Log(title = "访客预约记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出访客预约记录列表")
    public void export(HttpServletResponse response, VisitRecord visitRecord)
    {
        List<VisitRecord> list = visitRecordService.selectVisitRecordList(visitRecord);
        ExcelUtil<VisitRecord> util = new ExcelUtil<VisitRecord>(VisitRecord.class);
        util.exportExcel(response, list, "访客预约记录数据");
    }

    /**
     * 获取访客预约记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('serve:visitRecord:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取访客预约记录详细信息")
    public AjaxResult getInfo(@ApiParam(value = "访客预约记录ID", required = true)
                              @PathVariable("id") Long id)
    {
        return success(visitRecordService.selectVisitRecordById(id));
    }

    /**
     * 新增访客预约记录
     */
    @PreAuthorize("@ss.hasPermi('serve:visitRecord:add')")
    @Log(title = "访客预约记录", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增访客预约记录")
    public AjaxResult add(@ApiParam(value = "访客预约记录实体", required = true) @RequestBody VisitRecord visitRecord)
    {
        return toAjax(visitRecordService.insertVisitRecord(visitRecord));
    }

    /**
     * 修改访客预约记录
     */
    @PreAuthorize("@ss.hasPermi('serve:visitRecord:edit')")
    @Log(title = "访客预约记录", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改访客预约记录")
    public AjaxResult edit(@ApiParam(value = "访客预约记录实体", required = true)  @RequestBody VisitRecord visitRecord)
    {
        return toAjax(visitRecordService.updateVisitRecord(visitRecord));
    }

    /**
     * 删除访客预约记录
     */
    @PreAuthorize("@ss.hasPermi('serve:visitRecord:remove')")
    @Log(title = "访客预约记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @ApiOperation("删除访客预约记录")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(visitRecordService.deleteVisitRecordByIds(ids));
    }
}