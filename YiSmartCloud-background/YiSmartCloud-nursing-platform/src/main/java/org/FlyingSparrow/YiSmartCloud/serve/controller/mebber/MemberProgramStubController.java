package org.FlyingSparrow.YiSmartCloud.serve.controller.mebber;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.RequiredArgsConstructor;
import org.FlyingSparrow.YiSmartCloud.common.core.controller.BaseController;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.AjaxResult;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;
import org.FlyingSparrow.YiSmartCloud.common.exception.ServiceException;
import org.FlyingSparrow.YiSmartCloud.common.utils.SecurityUtils;
import org.FlyingSparrow.YiSmartCloud.common.utils.StringUtils;
import org.FlyingSparrow.YiSmartCloud.serve.domain.BillDetail;
import org.FlyingSparrow.YiSmartCloud.serve.domain.MemberServiceOrder;
import org.FlyingSparrow.YiSmartCloud.serve.domain.NursingProject;
import org.FlyingSparrow.YiSmartCloud.serve.dto.FamilyElderBindRequestDto;
import org.FlyingSparrow.YiSmartCloud.serve.dto.MemberOrderCreateDto;
import org.FlyingSparrow.YiSmartCloud.serve.service.IFamilyElderBindingService;
import org.FlyingSparrow.YiSmartCloud.serve.service.IMemberServiceOrderService;
import org.FlyingSparrow.YiSmartCloud.serve.service.INursingProjectService;
import org.FlyingSparrow.YiSmartCloud.serve.service.IReservationService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * Member Mini-Program Controller - Handles orders, elderly care bindings, nursing projects, etc.
 * Historical path compatibility endpoints and IoT device queries are provided as placeholders.
 */
@RestController
@Api(tags = "Mini-Program - Member Services")
@RequiredArgsConstructor
public class MemberProgramStubController extends BaseController {

    private final INursingProjectService nursingProjectService;
    private final IFamilyElderBindingService familyElderBindingService;
    private final IMemberServiceOrderService memberServiceOrderService;
    private final IReservationService reservationService;

    @GetMapping("/reservation/countByTime")
    @ApiOperation("Query remaining reservation slots by date (legacy path: /reservation/countByTime)")
    public AjaxResult reservationCountByTimeCompat(
            @ApiParam("Date in yyyy-MM-dd format, defaults to today")
            @RequestParam(value = "date", required = false)
            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date) {
        return success(reservationService.countByTime(date));
    }

    @GetMapping("/member/orders/order/page")
    @ApiOperation("Paginated order list")
    @SuppressWarnings("rawtypes")
    public TableDataInfo orderListPage() {
        startPage();
        List<MemberServiceOrder> list = memberServiceOrderService.listOrders(SecurityUtils.getUserId());
        return getDataTable(list);
    }

    @GetMapping("/member/orders/{id}")
    @ApiOperation("Order details")
    public AjaxResult orderDetail(@PathVariable Long id) {
        return success(memberServiceOrderService.getOrder(SecurityUtils.getUserId(), id));
    }

    @PostMapping("/member/orders/{id}/cancel")
    @ApiOperation("Cancel order")
    public AjaxResult orderCancel(@PathVariable Long id, @RequestParam(required = false) String reason) {
        memberServiceOrderService.cancelOrder(SecurityUtils.getUserId(), id, reason);
        return success();
    }

    @DeleteMapping("/member/orders/{id}")
    @ApiOperation("Delete order")
    public AjaxResult orderDelete(@PathVariable Long id) {
        memberServiceOrderService.deleteOrder(SecurityUtils.getUserId(), id);
        return success();
    }

    @PostMapping("/member/orders/refund")
    @ApiOperation("Apply for refund")
    public AjaxResult orderRefund(@RequestBody Map<String, Object> body) {
        Long orderId = body.get("orderId") == null ? null : Long.valueOf(String.valueOf(body.get("orderId")));
        String reason = body.get("reason") == null ? null : String.valueOf(body.get("reason"));
        memberServiceOrderService.refundOrder(SecurityUtils.getUserId(), orderId, reason);
        return success();
    }

    @PostMapping("/member/orders")
    @ApiOperation("Create order")
    public AjaxResult createOrder(@Valid @RequestBody MemberOrderCreateDto dto) {
        return success(memberServiceOrderService.create(SecurityUtils.getUserId(), dto));
    }

    @PostMapping("/member/orders/check")
    @ApiOperation("Validate order data")
    public AjaxResult checkOrder(@Valid @RequestBody MemberOrderCreateDto dto) {
        return success(memberServiceOrderService.check(SecurityUtils.getUserId(), dto));
    }

    @GetMapping({"/member/bill/page/", "/member/bill/page"})
    @ApiOperation("Paginated bill list")
    @SuppressWarnings("rawtypes")
    public TableDataInfo billPage() {
        startPage();
        List<BillDetail> list = memberServiceOrderService.listBills(SecurityUtils.getUserId());
        return getDataTable(list);
    }

    @GetMapping("/member/bill/{id}")
    @ApiOperation("Bill details")
    public AjaxResult billDetail(@PathVariable Long id) {
        return success(memberServiceOrderService.getBill(SecurityUtils.getUserId(), id));
    }

    @GetMapping("/bill/{id}")
    @ApiOperation("Bill details (legacy path compatibility)")
    public AjaxResult billDetailCompat(@PathVariable Long id) {
        return billDetail(id);
    }

    @PutMapping("/member/bill")
    @ApiOperation("Pay bill")
    public AjaxResult billPay(@RequestBody Map<String, Object> body) {
        Long id = body.get("id") == null ? null : Long.valueOf(String.valueOf(body.get("id")));
        memberServiceOrderService.payBill(SecurityUtils.getUserId(), id);
        return success();
    }

    @GetMapping("/member/contract/list")
    @ApiOperation("Contract list (placeholder)")
    @SuppressWarnings("rawtypes")
    public TableDataInfo contractList() {
        startPage();
        return getDataTable(Collections.emptyList());
    }

    @GetMapping("/member/user/list-by-page")
    @ApiOperation("Paginated list of bound elderly members")
    @SuppressWarnings("rawtypes")
    public TableDataInfo userListByPage(@RequestParam(value = "name", required = false) String name) {
        startPage();
        return getDataTable(familyElderBindingService.listBoundElders(SecurityUtils.getUserId(), StringUtils.trim(name)));
    }

    @GetMapping("/member/user/my")
    @ApiOperation("My elderly members")
    @SuppressWarnings("rawtypes")
    public TableDataInfo userMy() {
        startPage();
        return getDataTable(familyElderBindingService.listBoundElders(SecurityUtils.getUserId(), null));
    }

    @GetMapping("/user/my")
    @ApiOperation("My elderly members (legacy path compatibility)")
    @SuppressWarnings("rawtypes")
    public TableDataInfo userMyCompat() {
        return userMy();
    }

    @PostMapping("/member/user/add")
    @ApiOperation("Bind elderly member")
    public AjaxResult userAdd(@Valid @RequestBody FamilyElderBindRequestDto dto) {
        familyElderBindingService.bind(SecurityUtils.getUserId(), dto);
        return success();
    }

    @PostMapping("/user/add")
    @ApiOperation("Add elderly member (legacy path compatibility)")
    public AjaxResult userAddCompat(@Valid @RequestBody FamilyElderBindRequestDto dto) {
        return userAdd(dto);
    }

    @DeleteMapping("/member/user/deleteById")
    @ApiOperation("Unbind elderly member")
    public AjaxResult userDelete(@RequestParam("id") Long id) {
        familyElderBindingService.unbind(SecurityUtils.getUserId(), id);
        return success();
    }

    @GetMapping("/member/orders/project/page")
    @ApiOperation("Paginated nursing project list")
    @SuppressWarnings("rawtypes")
    public TableDataInfo projectPage(@RequestParam(value = "name", required = false) String name) {
        startPage();
        NursingProject query = new NursingProject();
        query.setStatus(1);
        query.setName(StringUtils.trim(name));
        List<NursingProject> list = nursingProjectService.selectNursingProjectList(query);
        return getDataTable(list);
    }

    @GetMapping("/member/orders/project/{id}")
    @ApiOperation("Nursing project details")
    public AjaxResult projectDetail(@PathVariable("id") Long id) {
        NursingProject project = validateProject(id);
        return success(project);
    }

    @GetMapping("/member/user/queryServiceProperties/{iotId}")
    @ApiOperation("IoT device properties (placeholder)")
    @SuppressWarnings("unused")
    public AjaxResult queryServiceProperties(@PathVariable String iotId) {
        return success(Collections.emptyMap());
    }

    @GetMapping("/member/user/queryDeviceDataListByDay")
    @ApiOperation("Device daily data (placeholder)")
    public AjaxResult deviceDataByDay() {
        return success(Collections.emptyList());
    }

    @GetMapping("/user/queryDeviceDataListByDay")
    @ApiOperation("Device daily data (legacy path compatibility placeholder)")
    public AjaxResult deviceDataByDayCompat() {
        return deviceDataByDay();
    }

    @GetMapping("/member/user/queryDeviceDataListByWeek")
    @ApiOperation("Device weekly data (placeholder)")
    public AjaxResult deviceDataByWeek() {
        return success(Collections.emptyList());
    }

    private NursingProject validateProject(Long projectId) {
        if (projectId == null) {
            throw new ServiceException("Nursing project ID cannot be empty");
        }
        NursingProject project = nursingProjectService.selectNursingProjectById(projectId);
        if (project == null || project.getStatus() == null || project.getStatus() != 1) {
            throw new ServiceException("Nursing project does not exist or is disabled");
        }
        return project;
    }
}
