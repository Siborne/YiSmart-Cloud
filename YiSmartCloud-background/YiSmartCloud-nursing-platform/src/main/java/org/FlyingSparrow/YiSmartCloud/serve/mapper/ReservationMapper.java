package org.FlyingSparrow.YiSmartCloud.serve.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.FlyingSparrow.YiSmartCloud.serve.domain.Reservation;
import org.FlyingSparrow.YiSmartCloud.serve.vo.ReservationSlotOccupancyRow;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 预约信息 Mapper
 *
 * @author agent
 */
@Mapper
public interface ReservationMapper extends BaseMapper<Reservation> {

    /**
     * 统计某日各时间段已占用数量（待报道、已完成）
     */
    List<ReservationSlotOccupancyRow> selectOccupiedCountsByDate(@Param("date") LocalDate date);

    /**
     * 当前家属当日取消预约次数（按 update_time 归属自然日）
     */
    int countCancelledTodayByMember(@Param("memberId") Long memberId, @Param("date") LocalDate date);

    /**
     * 某时间段内待报道/已完成预约数量
     */
    int countActiveAtSlot(@Param("slot") LocalDateTime slot);

    /**
     * 家属分页列表（仅本人创建）
     */
    List<Reservation> selectMemberReservationList(@Param("memberId") Long memberId, @Param("query") Reservation query);

    /**
     * 将已过期未到场的待报道预约置为过期
     *
     * @return 影响行数
     */
    int expirePending(@Param("now") LocalDateTime now);
}
