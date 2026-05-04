package org.FlyingSparrow.YiSmartCloud.serve.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import org.FlyingSparrow.YiSmartCloud.common.core.domain.R;
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
import org.FlyingSparrow.YiSmartCloud.serve.domain.NursingLevel;
import org.FlyingSparrow.YiSmartCloud.serve.service.INursingLevelService;
import org.FlyingSparrow.YiSmartCloud.common.utils.poi.ExcelUtil;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;

import lombok.RequiredArgsConstructor;

/**
 * 护理等级Controller
 *
 * @author Siborne
 * @date 2026-03-23
 */
@RestController
@RequestMapping("/serve/level")
@Api(tags = "护理等级相关接口")
@RequiredArgsConstructor
public class NursingLevelController extends BaseController {
    private final INursingLevelService nursingLevelService;

    /**
     * 查询护理等级列表
     */
    @PreAuthorize("@ss.hasPermi('serve:level:list')")
    @GetMapping("/list")
    @ApiOperation("查询护理等级列表")
    public TableDataInfo list(NursingLevel nursingLevel) {
        startPage();
        List<NursingLevel> list = nursingLevelService.selectNursingLevelList(nursingLevel);
        return getDataTable(list);
    }

    /**
     * 导出护理等级列表
     */
    @PreAuthorize("@ss.hasPermi('serve:level:export')")
    @Log(title = "护理等级", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出护理等级列表")
    public void export(HttpServletResponse response, NursingLevel nursingLevel) {
        List<NursingLevel> list = nursingLevelService.selectNursingLevelList(nursingLevel);
        ExcelUtil<NursingLevel> util = new ExcelUtil<NursingLevel>(NursingLevel.class);
        util.exportExcel(response, list, "护理等级数据");
    }

    /**
     * 获取护理等级详细信息
     */
    @PreAuthorize("@ss.hasPermi('serve:level:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取护理等级详细信息")
    public AjaxResult getInfo(@ApiParam(value = "护理等级ID", required = true)
                              @PathVariable("id") Long id) {
        NursingLevel nursingLevel = nursingLevelService.selectNursingLevelById(id);
        // 详情走 XML JOIN，若无记录则明确提示（避免前端拿到空对象误判）
        return nursingLevel == null ? AjaxResult.error("护理等级不存在或已删除") : success(nursingLevel);
    }

    /**
     * 新增护理等级
     */
    @PreAuthorize("@ss.hasPermi('serve:level:add')")
    @Log(title = "护理等级", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增护理等级")
    public AjaxResult add(@ApiParam(value = "护理等级实体", required = true) @RequestBody NursingLevel nursingLevel) {
        return toAjax(nursingLevelService.insertNursingLevel(nursingLevel));
    }

    /**
     * 修改护理等级
     */
    @PreAuthorize("@ss.hasPermi('serve:level:edit')")
    @Log(title = "护理等级", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改护理等级")
    public AjaxResult edit(@ApiParam(value = "护理等级实体", required = true) @RequestBody NursingLevel nursingLevel) {
        return toAjax(nursingLevelService.updateNursingLevel(nursingLevel));
    }

    /**
     * 删除护理等级
     */
    @PreAuthorize("@ss.hasPermi('serve:level:remove')")
    @Log(title = "护理等级", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @ApiOperation("删除护理等级")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(nursingLevelService.deleteNursingLevelByIds(ids));
    }

    /**
     * 查询所有的护理等级
     *
     * @return
     */
    @GetMapping("/listAll")
    public R<List<NursingLevel>> listAll() {
        return R.ok(nursingLevelService.listAll());
    }
}