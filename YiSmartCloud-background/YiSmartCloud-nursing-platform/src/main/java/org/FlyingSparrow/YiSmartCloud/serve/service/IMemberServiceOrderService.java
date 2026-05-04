package org.FlyingSparrow.YiSmartCloud.serve.service;

import org.FlyingSparrow.YiSmartCloud.serve.domain.BillDetail;
import org.FlyingSparrow.YiSmartCloud.serve.domain.MemberServiceOrder;
import org.FlyingSparrow.YiSmartCloud.serve.dto.MemberOrderCreateDto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

public interface IMemberServiceOrderService {

    Map<String, Object> check(Long memberId, MemberOrderCreateDto dto);

    Map<String, Object> create(Long memberId, MemberOrderCreateDto dto);

    List<MemberServiceOrder> listOrders(Long memberId);

    MemberServiceOrder getOrder(Long memberId, Long id);

    void cancelOrder(Long memberId, Long id, String reason);

    void deleteOrder(Long memberId, Long id);

    void refundOrder(Long memberId, Long orderId, String reason);

    List<BillDetail> listBills(Long memberId);

    BillDetail getBill(Long memberId, Long billId);

    void payBill(Long memberId, Long billId);

    Map<String, Object> buildOrderPreview(Long projectId, Long elderId, Integer count, LocalDateTime expectedServiceTime, BigDecimal unitPrice, String projectName, String elderName);
}
