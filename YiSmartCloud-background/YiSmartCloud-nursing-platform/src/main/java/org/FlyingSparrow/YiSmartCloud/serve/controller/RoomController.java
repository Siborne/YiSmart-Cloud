package org.FlyingSparrow.YiSmartCloud.serve.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import org.FlyingSparrow.YiSmartCloud.common.core.domain.R;
import org.FlyingSparrow.YiSmartCloud.serve.vo.RoomVo;
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
import org.FlyingSparrow.YiSmartCloud.serve.domain.Room;
import org.FlyingSparrow.YiSmartCloud.serve.service.IRoomService;
import org.FlyingSparrow.YiSmartCloud.common.utils.poi.ExcelUtil;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;

/**
 * 房间信息Controller
 *
 * @author Siborne
 * @date 2026-04-27
 */
@RestController
@RequestMapping("/serve/room")
@Api(tags = "房间信息相关接口")
public class RoomController extends BaseController {
    @Autowired
    private IRoomService roomService;

    /**
     * 查询房间信息列表
     */
    @PreAuthorize("@ss.hasPermi('serve:room:list')")
    @GetMapping("/list")
    @ApiOperation("查询房间信息列表")
    public TableDataInfo list(Room room) {
        startPage();
        List<Room> list = roomService.selectRoomList(room);
        return getDataTable(list);
    }

    /**
     * 导出房间信息列表
     */
    @PreAuthorize("@ss.hasPermi('serve:room:export')")
    @Log(title = "房间信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出房间信息列表")
    public void export(HttpServletResponse response, Room room) {
        List<Room> list = roomService.selectRoomList(room);
        ExcelUtil<Room> util = new ExcelUtil<Room>(Room.class);
        util.exportExcel(response, list, "房间信息数据");
    }

    /**
     * 获取房间信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('serve:room:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取房间信息详细信息")
    public AjaxResult getInfo(@ApiParam(value = "房间信息ID", required = true)
                              @PathVariable("id") Long id) {
        return success(roomService.selectRoomById(id));
    }

    /**
     * 新增房间信息
     */
    @PreAuthorize("@ss.hasPermi('serve:room:add')")
    @Log(title = "房间信息", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增房间信息")
    public AjaxResult add(@ApiParam(value = "房间信息实体", required = true) @RequestBody Room room) {
        return toAjax(roomService.insertRoom(room));
    }

    /**
     * 修改房间信息
     */
    @PreAuthorize("@ss.hasPermi('serve:room:edit')")
    @Log(title = "房间信息", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改房间信息")
    public AjaxResult edit(@ApiParam(value = "房间信息实体", required = true) @RequestBody Room room) {
        return toAjax(roomService.updateRoom(room));
    }

    /**
     * 删除房间信息
     */
    @PreAuthorize("@ss.hasPermi('serve:room:remove')")
    @Log(title = "房间信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @ApiOperation("删除房间信息")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(roomService.deleteRoomByIds(ids));
    }

    @GetMapping("/one/{id}")
    @ApiOperation("按照房间id查询楼层、房间、价格")
    public R<RoomVo> getRoomById(@ApiParam(value = "房间ID", required = true) @PathVariable("id") Long id){
        RoomVo roomVo = roomService.getRoomById(id);
        return R.ok(roomVo);
    }

}