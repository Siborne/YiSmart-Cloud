package org.FlyingSparrow.YiSmartCloud.serve.controller.mebber;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.FlyingSparrow.YiSmartCloud.common.core.controller.BaseController;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.AjaxResult;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;

/**
 * 小程序历史路径占位：返回空列表或空成功，避免 404；后续用真实业务替换。
 */
@RestController
@Api(tags = "小程序-占位接口")
public class MemberProgramStubController extends BaseController {

    @GetMapping("/member/orders/order/page")
    @ApiOperation("订单分页(占位)")
    @SuppressWarnings("rawtypes")
    public TableDataInfo orderListPage() {
        startPage();
        return getDataTable(Collections.emptyList());
    }

    @GetMapping("/member/orders/{id}")
    @ApiOperation("订单详情(占位)")
    public AjaxResult orderDetail(@PathVariable Long id) {
        return success();
    }

    @PostMapping("/member/orders/{id}/cancel")
    @ApiOperation("取消订单(占位)")
    public AjaxResult orderCancel(@PathVariable Long id, @RequestParam(required = false) String reason) {
        return success();
    }

    @DeleteMapping("/member/orders/{id}")
    @ApiOperation("删除订单(占位)")
    public AjaxResult orderDelete(@PathVariable Long id) {
        return success();
    }

    @PostMapping("/member/orders/refund")
    @ApiOperation("退款(占位)")
    public AjaxResult orderRefund() {
        return success();
    }

    @PostMapping("/member/orders")
    @ApiOperation("创建订单(占位)")
    public AjaxResult createOrder() {
        return success();
    }

    @PostMapping("/member/orders/check")
    @ApiOperation("校验订单(占位)")
    public AjaxResult checkOrder() {
        return success();
    }

    @GetMapping({"/member/bill/page/", "/member/bill/page"})
    @ApiOperation("账单分页(占位)")
    @SuppressWarnings("rawtypes")
    public TableDataInfo billPage() {
        startPage();
        return getDataTable(Collections.emptyList());
    }

    @GetMapping("/member/bill/{id}")
    @ApiOperation("账单详情(占位)")
    public AjaxResult billDetail(@PathVariable Long id) {
        return success();
    }

    @PutMapping("/member/bill")
    @ApiOperation("账单支付(占位)")
    public AjaxResult billPay() {
        return success();
    }

    @GetMapping("/member/contract/list")
    @ApiOperation("合同列表(占位)")
    @SuppressWarnings("rawtypes")
    public TableDataInfo contractList() {
        startPage();
        return getDataTable(Collections.emptyList());
    }

    @GetMapping("/member/user/list-by-page")
    @ApiOperation("老人分页(占位)")
    @SuppressWarnings("rawtypes")
    public TableDataInfo userListByPage() {
        startPage();
        return getDataTable(Collections.emptyList());
    }

    @GetMapping("/member/user/my")
    @ApiOperation("我的老人(占位)")
    @SuppressWarnings("rawtypes")
    public TableDataInfo userMy() {
        startPage();
        return getDataTable(Collections.emptyList());
    }

    @PostMapping("/member/user/add")
    @ApiOperation("绑定老人(占位)")
    public AjaxResult userAdd() {
        return success();
    }

    @DeleteMapping("/member/user/deleteById")
    @ApiOperation("解绑(占位)")
    public AjaxResult userDelete(@RequestParam("id") Long id) {
        return success();
    }

    @GetMapping("/member/user/queryServiceProperties/{iotId}")
    @ApiOperation("IoT 属性(占位)")
    public AjaxResult queryServiceProperties(@PathVariable String iotId) {
        return success(Collections.emptyMap());
    }

    @GetMapping("/member/user/queryDeviceDataListByDay")
    @ApiOperation("设备按日数据(占位)")
    public AjaxResult deviceDataByDay() {
        return success(Collections.emptyList());
    }

    @GetMapping("/member/user/queryDeviceDataListByWeek")
    @ApiOperation("设备按周数据(占位)")
    public AjaxResult deviceDataByWeek() {
        return success(Collections.emptyList());
    }
}
