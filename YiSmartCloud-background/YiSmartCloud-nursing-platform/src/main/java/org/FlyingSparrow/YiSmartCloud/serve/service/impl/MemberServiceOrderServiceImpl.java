package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import org.FlyingSparrow.YiSmartCloud.common.exception.ServiceException;
import org.FlyingSparrow.YiSmartCloud.common.utils.DateUtils;
import org.FlyingSparrow.YiSmartCloud.common.utils.StringUtils;
import org.FlyingSparrow.YiSmartCloud.serve.constant.MemberOrderConstants;
import org.FlyingSparrow.YiSmartCloud.serve.domain.BillDetail;
import org.FlyingSparrow.YiSmartCloud.serve.domain.ElderInfo;
import org.FlyingSparrow.YiSmartCloud.serve.domain.MemberServiceOrder;
import org.FlyingSparrow.YiSmartCloud.serve.domain.NursingProject;
import org.FlyingSparrow.YiSmartCloud.serve.dto.MemberOrderCreateDto;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.MemberServiceOrderMapper;
import org.FlyingSparrow.YiSmartCloud.serve.service.IBillDetailService;
import org.FlyingSparrow.YiSmartCloud.serve.service.IElderInfoService;
import org.FlyingSparrow.YiSmartCloud.serve.service.IFamilyElderBindingService;
import org.FlyingSparrow.YiSmartCloud.serve.service.IMemberServiceOrderService;
import org.FlyingSparrow.YiSmartCloud.serve.service.INursingProjectService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MemberServiceOrderServiceImpl implements IMemberServiceOrderService {

    private static final DateTimeFormatter BILL_MONTH_FMT = DateTimeFormatter.ofPattern("yyyy-MM");

    private final INursingProjectService nursingProjectService;
    private final IElderInfoService elderInfoService;
    private final IFamilyElderBindingService familyElderBindingService;
    private final IBillDetailService billDetailService;
    private final MemberServiceOrderMapper memberServiceOrderMapper;

    @Override
    public Map<String, Object> check(Long memberId, MemberOrderCreateDto dto) {
        NursingProject project = requireProject(dto.getProjectId());
        ElderInfo elder = requireBoundElder(memberId, resolveElderId(memberId, dto));
        int count = normalizeCount(dto.getCount());
        return buildOrderPreview(project.getId(), elder.getId(), count, dto.getExpectedServiceTime(),
                project.getPrice(), project.getName(), elder.getName());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Map<String, Object> create(Long memberId, MemberOrderCreateDto dto) {
        NursingProject project = requireProject(dto.getProjectId());
        ElderInfo elder = requireBoundElder(memberId, resolveElderId(memberId, dto));
        int count = normalizeCount(dto.getCount());
        BigDecimal unitPrice = project.getPrice() == null ? BigDecimal.ZERO : project.getPrice();
        BigDecimal total = unitPrice.multiply(BigDecimal.valueOf(count));

        BillDetail bill = new BillDetail();
        bill.setElderId(elder.getId());
        bill.setBillMonth(LocalDateTime.now().format(BILL_MONTH_FMT));
        bill.setBillType(4);
        bill.setAmount(total);
        bill.setPayStatus(MemberOrderConstants.PAY_STATUS_UNPAID);
        bill.setCreateTime(DateUtils.getNowDate());
        billDetailService.save(bill);

        MemberServiceOrder order = new MemberServiceOrder();
        order.setOrderNo("MO" + System.currentTimeMillis());
        order.setFamilyMemberId(memberId);
        order.setElderId(elder.getId());
        order.setProjectId(project.getId());
        order.setCount(count);
        order.setUnitPrice(unitPrice);
        order.setTotalAmount(total);
        order.setExpectedServiceTime(dto.getExpectedServiceTime());
        order.setStatus(MemberOrderConstants.STATUS_PENDING_PAY);
        order.setPayStatus(MemberOrderConstants.PAY_STATUS_UNPAID);
        order.setBillId(bill.getId());
        order.setRemark(StringUtils.trim(dto.getRemark()));
        order.setCreateTime(DateUtils.getNowDate());
        order.setUpdateTime(DateUtils.getNowDate());
        memberServiceOrderMapper.insert(order);

        return buildOrderPreview(project.getId(), elder.getId(), count, dto.getExpectedServiceTime(),
                unitPrice, project.getName(), elder.getName(), order.getOrderNo(), bill.getId(), total);
    }

    @Override
    public List<MemberServiceOrder> listOrders(Long memberId) {
        return memberServiceOrderMapper.selectMemberOrderList(memberId);
    }

    @Override
    public MemberServiceOrder getOrder(Long memberId, Long id) {
        MemberServiceOrder order = memberServiceOrderMapper.selectMemberOrderById(id, memberId);
        if (order == null) {
            throw new ServiceException("订单不存在");
        }
        return order;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void cancelOrder(Long memberId, Long id, String reason) {
        MemberServiceOrder order = getOrder(memberId, id);
        if (!Objects.equals(order.getStatus(), MemberOrderConstants.STATUS_PENDING_PAY)) {
            throw new ServiceException("当前状态不可取消");
        }
        order.setStatus(MemberOrderConstants.STATUS_CANCELLED);
        order.setCancelReason(StringUtils.trim(reason));
        order.setUpdateTime(DateUtils.getNowDate());
        memberServiceOrderMapper.updateById(order);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteOrder(Long memberId, Long id) {
        int rows = memberServiceOrderMapper.softDeleteOrder(id, memberId);
        if (rows <= 0) {
            throw new ServiceException("订单不存在或已删除");
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void refundOrder(Long memberId, Long orderId, String reason) {
        MemberServiceOrder order = getOrder(memberId, orderId);
        if (!Objects.equals(order.getPayStatus(), MemberOrderConstants.PAY_STATUS_PAID)) {
            throw new ServiceException("未支付订单不能退款");
        }
        order.setStatus(MemberOrderConstants.STATUS_REFUNDED);
        order.setRefundReason(StringUtils.trim(reason));
        order.setUpdateTime(DateUtils.getNowDate());
        memberServiceOrderMapper.updateById(order);
    }

    @Override
    public List<BillDetail> listBills(Long memberId) {
        List<ElderInfo> elders = familyElderBindingService.listBoundElders(memberId, null);
        if (elders.isEmpty()) {
            return List.of();
        }
        List<Long> elderIds = elders.stream().map(ElderInfo::getId).collect(Collectors.toList());
        return billDetailService.list(Wrappers.<BillDetail>lambdaQuery()
                .in(BillDetail::getElderId, elderIds)
                .orderByDesc(BillDetail::getCreateTime));
    }

    @Override
    public BillDetail getBill(Long memberId, Long billId) {
        BillDetail bill = billDetailService.getById(billId);
        if (bill == null) {
            throw new ServiceException("账单不存在");
        }
        requireBoundElder(memberId, bill.getElderId());
        return bill;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void payBill(Long memberId, Long billId) {
        BillDetail bill = getBill(memberId, billId);
        if (Objects.equals(bill.getPayStatus(), MemberOrderConstants.PAY_STATUS_PAID)) {
            return;
        }
        bill.setPayStatus(MemberOrderConstants.PAY_STATUS_PAID);
        bill.setPayTime(LocalDateTime.now());
        bill.setUpdateTime(DateUtils.getNowDate());
        billDetailService.updateById(bill);

        MemberServiceOrder order = memberServiceOrderMapper.selectByBillId(billId, memberId);
        if (order != null) {
            order.setPayStatus(MemberOrderConstants.PAY_STATUS_PAID);
            order.setStatus(MemberOrderConstants.STATUS_PENDING_SERVICE);
            order.setUpdateTime(DateUtils.getNowDate());
            memberServiceOrderMapper.updateById(order);
        }
    }

    @Override
    public Map<String, Object> buildOrderPreview(Long projectId, Long elderId, Integer count,
            LocalDateTime expectedServiceTime, BigDecimal unitPrice, String projectName, String elderName) {
        BigDecimal total = (unitPrice == null ? BigDecimal.ZERO : unitPrice).multiply(BigDecimal.valueOf(count));
        return buildOrderPreview(projectId, elderId, count, expectedServiceTime, unitPrice, projectName, elderName,
                null, null, total);
    }

    private Map<String, Object> buildOrderPreview(Long projectId, Long elderId, Integer count,
            LocalDateTime expectedServiceTime, BigDecimal unitPrice, String projectName, String elderName,
            String orderNo, Long billId, BigDecimal total) {
        Map<String, Object> result = new HashMap<>(12);
        result.put("orderNo", orderNo);
        result.put("billId", billId);
        result.put("projectId", projectId);
        result.put("projectName", projectName);
        result.put("elderId", elderId);
        result.put("elderName", elderName);
        result.put("count", count);
        result.put("unitPrice", unitPrice == null ? BigDecimal.ZERO : unitPrice);
        result.put("totalAmount", total);
        result.put("expectedServiceTime", expectedServiceTime);
        return result;
    }

    private NursingProject requireProject(Long projectId) {
        if (projectId == null) {
            throw new ServiceException("服务项目不能为空");
        }
        NursingProject project = nursingProjectService.selectNursingProjectById(projectId);
        if (project == null || !Objects.equals(project.getStatus(), 1)) {
            throw new ServiceException("服务项目不存在或已下线");
        }
        return project;
    }

    private ElderInfo requireBoundElder(Long memberId, Long elderId) {
        if (elderId == null) {
            throw new ServiceException("请先绑定服务家人");
        }
        List<ElderInfo> elders = familyElderBindingService.listBoundElders(memberId, null);
        boolean bound = elders.stream().anyMatch(e -> Objects.equals(e.getId(), elderId));
        if (!bound) {
            throw new ServiceException("该老人未绑定到当前账号");
        }
        ElderInfo elder = elderInfoService.selectElderInfoById(elderId);
        if (elder == null) {
            throw new ServiceException("老人档案不存在");
        }
        return elder;
    }

    private Long resolveElderId(Long memberId, MemberOrderCreateDto dto) {
        if (dto.getElderId() != null) {
            return dto.getElderId();
        }
        if (dto.getFamilyMemberId() != null && !Objects.equals(dto.getFamilyMemberId(), memberId)) {
            return dto.getFamilyMemberId();
        }
        Long elderId = familyElderBindingService.resolveAnyBoundElderId(memberId);
        if (elderId != null) {
            return elderId;
        }
        return dto.getFamilyMemberId();
    }

    private int normalizeCount(Integer count) {
        return count == null || count <= 0 ? 1 : count;
    }
}
