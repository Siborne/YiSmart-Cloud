package org.FlyingSparrow.YiSmartCloud.serve.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.FlyingSparrow.YiSmartCloud.serve.domain.Reservation;
import org.FlyingSparrow.YiSmartCloud.serve.dto.ReservationCreateDto;
import org.FlyingSparrow.YiSmartCloud.serve.vo.TimeSlotCountVo;

import java.time.LocalDate;
import java.util.List;

/**
 * 预约信息 Service
 *
 * @author agent
 */
public interface IReservationService extends IService<Reservation> {

    /**
     * 当前登录家属当日已取消预约次数
     */
    int countCancelledToday();

    /**
     * 查询指定日期各已占用时间段的剩余可约次数（仅返回已有预约的时间段）
     */
    List<TimeSlotCountVo> countByTime(LocalDate date);

    /**
     * 新增预约
     */
    void create(ReservationCreateDto dto);

    /**
     * 分页：当前家属的预约列表（调用前需 {@code startPage()}）
     */
    List<Reservation> selectMemberReservationList(Reservation query);

    /**
     * 取消预约（仅待报道且本人创建）
     */
    void cancel(Long id);

    /**
     * 将已过期的待报道预约批量置为过期
     *
     * @return 更新行数
     */
    int expirePending();
}
