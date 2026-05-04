package org.FlyingSparrow.YiSmartCloud.serve.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.FlyingSparrow.YiSmartCloud.common.core.controller.BaseController;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.AjaxResult;
import org.FlyingSparrow.YiSmartCloud.serve.service.IServeDashboardService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * �������ҳ�Ǳ���
 */
@RestController
@RequestMapping("/serve/dashboard")
@Api(tags = "��ҳ�Ǳ���")
@RequiredArgsConstructor
public class ServeDashboardController extends BaseController {

    private final IServeDashboardService serveDashboardService;

    /**
     * ��ҳ���ܣ�������ͼ�����ơ�������������ʵ���ݣ�
     */
    @GetMapping("/summary")
    @ApiOperation("��ҳ��������")
    public AjaxResult summary() {
        return success(serveDashboardService.loadSummary());
    }
}
