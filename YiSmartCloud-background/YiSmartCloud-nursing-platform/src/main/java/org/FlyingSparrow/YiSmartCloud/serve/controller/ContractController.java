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
import org.FlyingSparrow.YiSmartCloud.serve.domain.Contract;
import org.FlyingSparrow.YiSmartCloud.serve.service.IContractService;
import org.FlyingSparrow.YiSmartCloud.common.utils.poi.ExcelUtil;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;

import lombok.RequiredArgsConstructor;

/**
 * 合同Controller
 *
 * @author Siborne
 * @date 2026-04-29
 */
@RestController
@RequestMapping("/serve/contract")
@Api(tags =  "合同相关接口")
@RequiredArgsConstructor
public class ContractController extends BaseController
{
    private final IContractService contractService;

/**
 * 查询合同列表
 */
@PreAuthorize("@ss.hasPermi('serve:contract:list')")
@GetMapping("/list")
@ApiOperation("查询合同列表")
public TableDataInfo list(Contract contract) {
    startPage();
    List<Contract> list = contractService.selectContractList(contract);
    return getDataTable(list);
}

    /**
     * 导出合同列表
     */
    @PreAuthorize("@ss.hasPermi('serve:contract:export')")
    @Log(title = "合同", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出合同列表")
    public void export(HttpServletResponse response, Contract contract)
    {
        List<Contract> list = contractService.selectContractList(contract);
        ExcelUtil<Contract> util = new ExcelUtil<Contract>(Contract.class);
        util.exportExcel(response, list, "合同数据");
    }

    /**
     * 获取合同详细信息
     */
    @PreAuthorize("@ss.hasPermi('serve:contract:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取合同详细信息")
    public AjaxResult getInfo(@ApiParam(value = "合同ID", required = true)
                              @PathVariable("id") Long id)
    {
        return success(contractService.selectContractById(id));
    }

    /**
     * 新增合同
     */
    @PreAuthorize("@ss.hasPermi('serve:contract:add')")
    @Log(title = "合同", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增合同")
    public AjaxResult add(@ApiParam(value = "合同实体", required = true) @RequestBody Contract contract)
    {
        return toAjax(contractService.insertContract(contract));
    }

    /**
     * 修改合同
     */
    @PreAuthorize("@ss.hasPermi('serve:contract:edit')")
    @Log(title = "合同", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改合同")
    public AjaxResult edit(@ApiParam(value = "合同实体", required = true)  @RequestBody Contract contract)
    {
        return toAjax(contractService.updateContract(contract));
    }

    /**
     * 删除合同
     */
    @PreAuthorize("@ss.hasPermi('serve:contract:remove')")
    @Log(title = "合同", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @ApiOperation("删除合同")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(contractService.deleteContractByIds(ids));
    }
}