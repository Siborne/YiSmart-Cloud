package org.FlyingSparrow.YiSmartCloud.serve.controller.mebber;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.RequiredArgsConstructor;
import org.FlyingSparrow.YiSmartCloud.common.core.controller.BaseController;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.AjaxResult;
import org.FlyingSparrow.YiSmartCloud.serve.domain.Room;
import org.FlyingSparrow.YiSmartCloud.serve.service.IRoomService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/member/roomTypes")
@Api(tags = "客户房型管理")
@RequiredArgsConstructor
public class MemberRoomTypeController extends BaseController {

    private final IRoomService roomService;

    /** C 端家属 JWT 无若依菜单权限，不在此接口使用方法级权限注解；GET 匿名策略见 SecurityConfig。 */
    @GetMapping
    @ApiOperation("根据状态查询房型")
    public AjaxResult findRoomTypeListByStatus(
            @ApiParam(value = "状态: 0-停用, 1-启用；不传则返回全部未删除房间", required = false)
            @RequestParam(value = "status", required = false) Integer status) {

        List<Room> roomTypeVoList = roomService.findRoomTypeListByStatus(status);
        return success(roomTypeVoList);
    }

}
