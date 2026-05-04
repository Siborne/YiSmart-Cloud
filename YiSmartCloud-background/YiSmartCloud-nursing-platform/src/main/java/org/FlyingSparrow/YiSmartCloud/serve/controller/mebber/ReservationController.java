package org.FlyingSparrow.YiSmartCloud.serve.controller.mebber;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.RequiredArgsConstructor;
import org.FlyingSparrow.YiSmartCloud.common.core.controller.BaseController;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.AjaxResult;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;
import org.FlyingSparrow.YiSmartCloud.serve.domain.Reservation;
import org.FlyingSparrow.YiSmartCloud.serve.dto.ReservationCreateDto;
import org.FlyingSparrow.YiSmartCloud.serve.service.IReservationService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.time.LocalDate;
import java.util.List;

/**
 * 小程序端预约接口
 *
 * @author agent
 */
@RestController
@RequestMapping("/member/reservation")
@Api(tags = "小程序-预约")
@RequiredArgsConstructor
public class ReservationController extends BaseController {

    private final IReservationService reservationService;

    @GetMapping("/cancelled-count")
    @ApiOperation("查询当天取消预约次数")
    public AjaxResult cancelledCount() {
        return success(reservationService.countCancelledToday());
    }

    @GetMapping("/countByTime")
    @ApiOperation("查询每个时间段剩余预约次数")
    public AjaxResult countByTime(
            @ApiParam("日期，格式 yyyy-MM-dd，默认当天")
            @RequestParam(value = "date", required = false)
            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date) {
        return success(reservationService.countByTime(date));
    }

    @PostMapping
    @ApiOperation("新增预约")
    public AjaxResult create(@Valid @RequestBody ReservationCreateDto dto) {
        reservationService.create(dto);
        return success();
    }

    @GetMapping("/page")
    @ApiOperation("分页查询当前家属的预约")
    @SuppressWarnings("rawtypes")
    public TableDataInfo page(Reservation query) {
        startPage();
        List<Reservation> list = reservationService.selectMemberReservationList(query);
        return getDataTable(list);
    }

    @PutMapping("/{id}/cancel")
    @ApiOperation("取消预约")
    public AjaxResult cancel(@ApiParam(value = "预约ID", required = true) @PathVariable("id") Long id) {
        reservationService.cancel(id);
        return success();
    }
}
