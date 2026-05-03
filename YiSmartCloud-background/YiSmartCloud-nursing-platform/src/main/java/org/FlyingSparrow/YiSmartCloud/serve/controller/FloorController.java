package org.FlyingSparrow.YiSmartCloud.serve.controller;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.AllArgsConstructor;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.R;
import org.FlyingSparrow.YiSmartCloud.serve.service.IFloorService;
import org.FlyingSparrow.YiSmartCloud.serve.vo.TreeVo;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/serve/floor")
@AllArgsConstructor
public class FloorController {

    private final IFloorService floorService;

    @GetMapping("/getRoomAndBedByBedStatus/{status}")
    @ApiOperation("按照状态查询楼层房间床位-树形结构")
    public R<List<TreeVo>> getRoomAndBedByBedStatus(@ApiParam(value = "床位状态(未入住0, 已入住1)", required = true) @PathVariable("status") Integer status){
        List<TreeVo> list = floorService.getRoomAndBedByBedStatus(status);
        return R.ok(list);
    }
}
