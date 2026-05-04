package org.FlyingSparrow.YiSmartCloud.serve.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.FlyingSparrow.YiSmartCloud.serve.domain.MemberServiceOrder;

import java.util.List;

@Mapper
public interface MemberServiceOrderMapper extends BaseMapper<MemberServiceOrder> {

    List<MemberServiceOrder> selectMemberOrderList(@Param("memberId") Long memberId);

    MemberServiceOrder selectMemberOrderById(@Param("id") Long id, @Param("memberId") Long memberId);

    MemberServiceOrder selectByBillId(@Param("billId") Long billId, @Param("memberId") Long memberId);

    int softDeleteOrder(@Param("id") Long id, @Param("memberId") Long memberId);
}
