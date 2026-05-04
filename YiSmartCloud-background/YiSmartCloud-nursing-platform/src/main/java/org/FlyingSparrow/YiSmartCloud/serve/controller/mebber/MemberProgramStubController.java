package org.FlyingSparrow.YiSmartCloud.serve.controller.mebber;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.FlyingSparrow.YiSmartCloud.common.core.controller.BaseController;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.AjaxResult;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;
import org.FlyingSparrow.YiSmartCloud.common.exception.ServiceException;
import org.FlyingSparrow.YiSmartCloud.common.utils.SecurityUtils;
import org.FlyingSparrow.YiSmartCloud.serve.domain.FamilyMember;
import org.FlyingSparrow.YiSmartCloud.serve.domain.NursingProject;
import org.FlyingSparrow.YiSmartCloud.serve.dto.MemberOrderCreateDto;
import org.FlyingSparrow.YiSmartCloud.serve.service.IFamilyMemberService;
import org.FlyingSparrow.YiSmartCloud.serve.service.INursingProjectService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.math.BigDecimal;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 小程序历史路径占位：返回空列表或空成功，避免 404；后续用真实业务替换。
 */
@RestController
@Api(tags = "小程序-占位接口")
@RequiredArgsConstructor
public class MemberProgramStubController extends BaseController {

    private final IFamilyMemberService familyMemberService;
    private final INursingProjectService nursingProjectService;

    @GetMapping("/reservation/countByTime")
    @ApiOperation("预约统计(历史路径占位)")
    public AjaxResult reservationCountByTimeCompat() {
        return success(Collections.emptyList());
    }


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
    public AjaxResult createOrder(@Valid @RequestBody MemberOrderCreateDto dto) {
        NursingProject project = validateProject(dto.getProjectId());
        FamilyMember member = validateFamilyMember(dto.getFamilyMemberId());
        int count = normalizeCount(dto.getCount());

        Map<String, Object> result = new HashMap<>(8);
        result.put("orderNo", "M" + System.currentTimeMillis());
        result.put("projectId", project.getId());
        result.put("projectName", project.getName());
        result.put("familyMemberId", member.getId());
        result.put("familyMemberName", member.getName());
        result.put("count", count);
        result.put("unit", project.getUnit());
        result.put("totalAmount", calculateTotal(project.getPrice(), count));
        result.put("expectedServiceTime", dto.getExpectedServiceTime());
        return success(result);
    }

    @PostMapping("/member/orders/check")
    @ApiOperation("校验订单(占位)")
    public AjaxResult checkOrder(@Valid @RequestBody MemberOrderCreateDto dto) {
        NursingProject project = validateProject(dto.getProjectId());
        FamilyMember member = validateFamilyMember(dto.getFamilyMemberId());
        int count = normalizeCount(dto.getCount());

        Map<String, Object> result = new HashMap<>(8);
        result.put("projectId", project.getId());
        result.put("projectName", project.getName());
        result.put("familyMemberId", member.getId());
        result.put("familyMemberName", member.getName());
        result.put("count", count);
        result.put("unitPrice", project.getPrice());
        result.put("unit", project.getUnit());
        result.put("totalAmount", calculateTotal(project.getPrice(), count));
        result.put("expectedServiceTime", dto.getExpectedServiceTime());
        return success(result);
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

    @GetMapping("/bill/{id}")
    @ApiOperation("账单详情(历史路径占位)")
    public AjaxResult billDetailCompat(@PathVariable Long id) {
        return billDetail(id);
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
        return getDataTable(getCurrentMemberList());
    }

    @GetMapping("/member/user/my")
    @ApiOperation("我的老人(占位)")
    @SuppressWarnings("rawtypes")
    public TableDataInfo userMy() {
        startPage();
        return getDataTable(getCurrentMemberList());
    }

    @GetMapping("/user/my")
    @ApiOperation("我的老人(历史路径占位)")
    @SuppressWarnings("rawtypes")
    public TableDataInfo userMyCompat() {
        return userMy();
    }

    @PostMapping("/member/user/add")
    @ApiOperation("绑定老人(占位)")
    public AjaxResult userAdd() {
        return success();
    }

    @PostMapping("/user/add")
    @ApiOperation("绑定老人(历史路径占位)")
    public AjaxResult userAddCompat() {
        return userAdd();
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

    @GetMapping("/user/queryDeviceDataListByDay")
    @ApiOperation("设备按日数据(历史路径占位)")
    public AjaxResult deviceDataByDayCompat() {
        return deviceDataByDay();
    }

    @GetMapping("/member/user/queryDeviceDataListByWeek")
    @ApiOperation("设备按周数据(占位)")
    public AjaxResult deviceDataByWeek() {
        return success(Collections.emptyList());
    }

    private NursingProject validateProject(Long projectId) {
        if (projectId == null) {
            throw new ServiceException("服务项目不能为空");
        }
        NursingProject project = nursingProjectService.selectNursingProjectById(projectId);
        if (project == null || project.getStatus() == null || project.getStatus() != 1) {
            throw new ServiceException("服务项目不存在或已下线");
        }
        return project;
    }

    private FamilyMember validateFamilyMember(Long familyMemberId) {
        Long currentUserId = SecurityUtils.getUserId();
        FamilyMember current = familyMemberService.getById(currentUserId);
        if (current == null) {
            throw new ServiceException("服务家人不存在");
        }
        if (familyMemberId == null || !familyMemberId.equals(current.getId())) {
            throw new ServiceException("当前仅支持为本人下单");
        }
        return current;
    }

    private int normalizeCount(Integer count) {
        return count == null || count <= 0 ? 1 : count;
    }

    private BigDecimal calculateTotal(BigDecimal price, int count) {
        BigDecimal unitPrice = price == null ? BigDecimal.ZERO : price;
        return unitPrice.multiply(BigDecimal.valueOf(count));
    }

    private List<FamilyMember> getCurrentMemberList() {
        Long currentUserId = SecurityUtils.getUserId();
        FamilyMember current = familyMemberService.getById(currentUserId);
        if (current == null) {
            return Collections.emptyList();
        }
        return Collections.singletonList(current);
    }
}
