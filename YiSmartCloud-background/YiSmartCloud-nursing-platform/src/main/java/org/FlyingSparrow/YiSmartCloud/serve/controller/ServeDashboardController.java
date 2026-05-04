package org.FlyingSparrow.YiSmartCloud.serve.controller;

import org.FlyingSparrow.YiSmartCloud.common.core.controller.BaseController;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.AjaxResult;
import org.FlyingSparrow.YiSmartCloud.serve.service.IServeDashboardService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;

/**
 * 管理端首页仪表盘
 */
@RestController
@RequestMapping("/serve/dashboard")
@Api(tags = "首页仪表盘")
@RequiredArgsConstructor
public class ServeDashboardController extends BaseController {

    private final IServeDashboardService serveDashboardService;

    /**
     * 首页汇总（概览饼图、趋势、来访日历等真实数据）
     */
    @GetMapping("/summary")
    @ApiOperation("首页汇总数据")
    public AjaxResult summary() {
        return success(serveDashboardService.loadSummary());
    }
}
