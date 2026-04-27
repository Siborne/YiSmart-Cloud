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
import org.FlyingSparrow.YiSmartCloud.serve.domain.ElderInfo;
import org.FlyingSparrow.YiSmartCloud.serve.service.IElderInfoService;
import org.FlyingSparrow.YiSmartCloud.common.utils.poi.ExcelUtil;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;

/**
 * 老人档案Controller
 *
 * @author Siborne
 * @date 2026-04-27
 */
@RestController
@RequestMapping("/serve/info")
@Api(tags =  "老人档案相关接口")
public class ElderInfoController extends BaseController
{
    @Autowired
    private IElderInfoService elderInfoService;

/**
 * 查询老人档案列表
 */
@PreAuthorize("@ss.hasPermi('serve:info:list')")
@GetMapping("/list")
@ApiOperation("查询老人档案列表")
public TableDataInfo list(ElderInfo elderInfo) {
    startPage();
    List<ElderInfo> list = elderInfoService.selectElderInfoList(elderInfo);
    return getDataTable(list);
}

    /**
     * 导出老人档案列表
     */
    @PreAuthorize("@ss.hasPermi('serve:info:export')")
    @Log(title = "老人档案", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出老人档案列表")
    public void export(HttpServletResponse response, ElderInfo elderInfo)
    {
        List<ElderInfo> list = elderInfoService.selectElderInfoList(elderInfo);
        ExcelUtil<ElderInfo> util = new ExcelUtil<ElderInfo>(ElderInfo.class);
        util.exportExcel(response, list, "老人档案数据");
    }

    /**
     * 获取老人档案详细信息
     */
    @PreAuthorize("@ss.hasPermi('serve:info:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取老人档案详细信息")
    public AjaxResult getInfo(@ApiParam(value = "老人档案ID", required = true)
                              @PathVariable("id") Long id)
    {
        return success(elderInfoService.selectElderInfoById(id));
    }

    /**
     * 新增老人档案
     */
    @PreAuthorize("@ss.hasPermi('serve:info:add')")
    @Log(title = "老人档案", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增老人档案")
    public AjaxResult add(@ApiParam(value = "老人档案实体", required = true) @RequestBody ElderInfo elderInfo)
    {
        return toAjax(elderInfoService.insertElderInfo(elderInfo));
    }

    /**
     * 修改老人档案
     */
    @PreAuthorize("@ss.hasPermi('serve:info:edit')")
    @Log(title = "老人档案", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改老人档案")
    public AjaxResult edit(@ApiParam(value = "老人档案实体", required = true)  @RequestBody ElderInfo elderInfo)
    {
        return toAjax(elderInfoService.updateElderInfo(elderInfo));
    }

    /**
     * 删除老人档案
     */
    @PreAuthorize("@ss.hasPermi('serve:info:remove')")
    @Log(title = "老人档案", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @ApiOperation("删除老人档案")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(elderInfoService.deleteElderInfoByIds(ids));
    }
}