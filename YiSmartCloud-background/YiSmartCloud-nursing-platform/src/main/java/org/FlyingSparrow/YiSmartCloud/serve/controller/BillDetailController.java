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
import org.FlyingSparrow.YiSmartCloud.serve.domain.BillDetail;
import org.FlyingSparrow.YiSmartCloud.serve.service.IBillDetailService;
import org.FlyingSparrow.YiSmartCloud.common.utils.poi.ExcelUtil;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;

import lombok.RequiredArgsConstructor;

/**
 * 费用账单明细Controller
 *
 * @author Siborne
 * @date 2026-04-27
 */
@RestController
@RequestMapping("/serve/detail")
@Api(tags =  "费用账单明细相关接口")
@RequiredArgsConstructor
public class BillDetailController extends BaseController
{
    private final IBillDetailService billDetailService;

/**
 * 查询费用账单明细列表
 */
@PreAuthorize("@ss.hasPermi('serve:detail:list')")
@GetMapping("/list")
@ApiOperation("查询费用账单明细列表")
public TableDataInfo list(BillDetail billDetail) {
    startPage();
    List<BillDetail> list = billDetailService.selectBillDetailList(billDetail);
    return getDataTable(list);
}

    /**
     * 导出费用账单明细列表
     */
    @PreAuthorize("@ss.hasPermi('serve:detail:export')")
    @Log(title = "费用账单明细", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出费用账单明细列表")
    public void export(HttpServletResponse response, BillDetail billDetail)
    {
        List<BillDetail> list = billDetailService.selectBillDetailList(billDetail);
        ExcelUtil<BillDetail> util = new ExcelUtil<BillDetail>(BillDetail.class);
        util.exportExcel(response, list, "费用账单明细数据");
    }

    /**
     * 获取费用账单明细详细信息
     */
    @PreAuthorize("@ss.hasPermi('serve:detail:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取费用账单明细详细信息")
    public AjaxResult getInfo(@ApiParam(value = "费用账单明细ID", required = true)
                              @PathVariable("id") Long id)
    {
        return success(billDetailService.selectBillDetailById(id));
    }

    /**
     * 新增费用账单明细
     */
    @PreAuthorize("@ss.hasPermi('serve:detail:add')")
    @Log(title = "费用账单明细", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增费用账单明细")
    public AjaxResult add(@ApiParam(value = "费用账单明细实体", required = true) @RequestBody BillDetail billDetail)
    {
        return toAjax(billDetailService.insertBillDetail(billDetail));
    }

    /**
     * 修改费用账单明细
     */
    @PreAuthorize("@ss.hasPermi('serve:detail:edit')")
    @Log(title = "费用账单明细", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改费用账单明细")
    public AjaxResult edit(@ApiParam(value = "费用账单明细实体", required = true)  @RequestBody BillDetail billDetail)
    {
        return toAjax(billDetailService.updateBillDetail(billDetail));
    }

    /**
     * 删除费用账单明细
     */
    @PreAuthorize("@ss.hasPermi('serve:detail:remove')")
    @Log(title = "费用账单明细", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @ApiOperation("删除费用账单明细")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(billDetailService.deleteBillDetailByIds(ids));
    }
}