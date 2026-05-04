package org.FlyingSparrow.YiSmartCloud.serve.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardCheckInHourCount;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardDayAmount;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardDayCount;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardElderAgeBucketsRow;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardHourAmount;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardLabelCount;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardVisitItemVo;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardVisitRowVo;

/**
 * 管理端首页仪表盘统计
 */
@Mapper
public interface ServeDashboardMapper {

    List<DashboardLabelCount> countElderByStatus();

    List<DashboardLabelCount> countBedByStatus();

    List<DashboardLabelCount> countVisitByApprovalGroup();

    List<DashboardLabelCount> countSysUserByStatus();

    List<DashboardLabelCount> sumBillAmountByTypeGroup();

    List<DashboardLabelCount> countCheckInByNursingLevel();

    DashboardElderAgeBucketsRow selectElderAgeGenderBuckets();

    List<DashboardVisitItemVo> selectVisitItemsByDate(@Param("day") String day);

    List<DashboardVisitRowVo> selectVisitItemsBetween(@Param("start") String start, @Param("end") String end);

    List<DashboardHourAmount> sumBillPaidHourlyForDay(@Param("day") String day);

    List<DashboardHourAmount> sumBillUnpaidHourlyForDay(@Param("day") String day);

    List<DashboardDayAmount> sumBillPaidDailyBetween(@Param("start") String start, @Param("end") String end);

    List<DashboardDayAmount> sumBillUnpaidDailyBetween(@Param("start") String start, @Param("end") String end);

    List<DashboardDayCount> countCheckInStartsDailyBetween(@Param("start") String start, @Param("end") String end);

    List<DashboardDayCount> countCheckOutsDailyBetween(@Param("start") String start, @Param("end") String end);

    List<DashboardDayCount> countVisitsDailyBetween(@Param("start") String start, @Param("end") String end);

    List<DashboardCheckInHourCount> countCheckInStartsHourlyForDay(@Param("day") String day);

    List<DashboardCheckInHourCount> countCheckOutsHourlyForDay(@Param("day") String day);
}
