package org.FlyingSparrow.YiSmartCloud.serve.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.FlyingSparrow.YiSmartCloud.common.annotation.Log;
import org.FlyingSparrow.YiSmartCloud.common.core.controller.BaseController;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.AjaxResult;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.R;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;
import org.FlyingSparrow.YiSmartCloud.common.enums.BusinessType;
import org.FlyingSparrow.YiSmartCloud.common.utils.poi.ExcelUtil;
import org.FlyingSparrow.YiSmartCloud.serve.domain.Floor;
import org.FlyingSparrow.YiSmartCloud.serve.service.IFloorService;
import org.FlyingSparrow.YiSmartCloud.serve.vo.TreeVo;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/serve/floor")
@Api(tags = "楼层信息相关接口")
@RequiredArgsConstructor
public class FloorController extends BaseController {

    private final IFloorService floorService;

    /**
     * 查询楼层信息列表
     */
    @PreAuthorize("@ss.hasPermi('serve:room:list')")
    @GetMapping("/list")
    @ApiOperation("查询楼层信息列表")
    public TableDataInfo list(Floor floor) {
        startPage();
        List<Floor> list = floorService.selectFloorList(floor);
        return getDataTable(list);
    }

    /**
     * 导出楼层信息列表
     */
    @PreAuthorize("@ss.hasPermi('serve:room:export')")
    @Log(title = "楼层信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出楼层信息列表")
    public void export(HttpServletResponse response, Floor floor) {
        List<Floor> list = floorService.selectFloorList(floor);
        ExcelUtil<Floor> util = new ExcelUtil<Floor>(Floor.class);
        util.exportExcel(response, list, "楼层信息数据");
    }

    /**
     * 查询楼层下拉数据
     */
    @PreAuthorize("@ss.hasPermi('serve:room:list')")
    @GetMapping("/options")
    @ApiOperation("查询楼层下拉数据")
    public AjaxResult options() {
        List<Floor> list = floorService.selectFloorList(new Floor());
        return success(list);
    }

    /**
     * 获取楼层信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('serve:room:query')")
    @GetMapping("/{id}")
    @ApiOperation("获取楼层信息详细信息")
    public AjaxResult getInfo(@ApiParam(value = "楼层ID", required = true) @PathVariable("id") Long id) {
        return success(floorService.selectFloorById(id));
    }

    /**
     * 新增楼层信息
     */
    @PreAuthorize("@ss.hasPermi('serve:room:add')")
    @Log(title = "楼层信息", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增楼层信息")
    public AjaxResult add(@ApiParam(value = "楼层实体", required = true) @RequestBody Floor floor) {
        return toAjax(floorService.insertFloor(floor));
    }

    /**
     * 修改楼层信息
     */
    @PreAuthorize("@ss.hasPermi('serve:room:edit')")
    @Log(title = "楼层信息", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改楼层信息")
    public AjaxResult edit(@ApiParam(value = "楼层实体", required = true) @RequestBody Floor floor) {
        return toAjax(floorService.updateFloor(floor));
    }

    /**
     * 删除楼层信息
     */
    @PreAuthorize("@ss.hasPermi('serve:room:remove')")
    @Log(title = "楼层信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @ApiOperation("删除楼层信息")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(floorService.deleteFloorByIds(ids));
    }

    @GetMapping("/getRoomAndBedByBedStatus/{status}")
    @ApiOperation("按照状态查询楼层房间床位-树形结构")
    public R<List<TreeVo>> getRoomAndBedByBedStatus(@ApiParam(value = "床位状态(未入住0, 已入住1)", required = true) @PathVariable("status") Integer status) {
        List<TreeVo> list = floorService.getRoomAndBedByBedStatus(status);
        return R.ok(list);
    }
}
