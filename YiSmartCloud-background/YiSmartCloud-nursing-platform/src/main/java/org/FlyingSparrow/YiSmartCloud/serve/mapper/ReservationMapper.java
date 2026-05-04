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
 * ԤԼ��Ϣ Mapper
 *
 * @author agent
 */
@Mapper
public interface ReservationMapper extends BaseMapper<Reservation> {

    /**
     * ͳ��ĳ�ո�ʱ�����ռ��������������������ɣ�
     */
    List<ReservationSlotOccupancyRow> selectOccupiedCountsByDate(@Param("date") LocalDate date);

    /**
     * ��ǰ�������ȡ��ԤԼ�������� update_time ������Ȼ�գ�
     */
    int countCancelledTodayByMember(@Param("memberId") Long memberId, @Param("date") LocalDate date);

    /**
     * ĳʱ����ڴ�����/�����ԤԼ����
     */
    int countActiveAtSlot(@Param("slot") LocalDateTime slot);

    /**
     * ��ȡĳ��ԤԼʱ�ε����ݿ�������
     */
    Integer acquireSlotLock(@Param("lockKey") String lockKey, @Param("timeoutSeconds") Integer timeoutSeconds);

    /**
     * �ͷ�ԤԼʱ��������
     */
    Integer releaseSlotLock(@Param("lockKey") String lockKey);

    /**
     * �����ҳ�б�������˴�����
     */
    List<Reservation> selectMemberReservationList(@Param("memberId") Long memberId, @Param("query") Reservation query);

    /**
     * ���ѹ���δ�����Ĵ�����ԤԼ��Ϊ����
     *
     * @return Ӱ������
     */
    int expirePending(@Param("now") LocalDateTime now);
}
