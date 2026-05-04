package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.FlyingSparrow.YiSmartCloud.serve.mapper.ServeDashboardMapper;
import org.FlyingSparrow.YiSmartCloud.serve.service.IServeDashboardService;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardCheckInHourCount;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardDayAmount;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardDayCount;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardDualSeriesVo;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardElderAgeBucketsRow;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardElderAgeVo;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardHourAmount;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardLabelCount;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardPieBundleVo;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardSliceVo;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardVisitItemVo;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.DashboardVisitRowVo;
import org.FlyingSparrow.YiSmartCloud.serve.vo.dashboard.ServeDashboardSummaryVo;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

/**
 * 首页仪表盘统计实现
 */
@Service
@RequiredArgsConstructor
public class ServeDashboardServiceImpl implements IServeDashboardService {

    private static final DateTimeFormatter ISO = DateTimeFormatter.ISO_LOCAL_DATE;
    private static final DateTimeFormatter MD = DateTimeFormatter.ofPattern("MM-dd");

    private final ServeDashboardMapper serveDashboardMapper;

    /**
     * Mapper XML 使用 ASCII 标签键，避免部分环境下 XML 非 UTF-8 解析失败；此处还原为中文展示。
     */
    private static String displayDashboardLabel(String raw) {
        if (raw == null || raw.isEmpty()) {
            return "";
        }
        switch (raw) {
            case "elder_pending":
                return "\u5f85\u5165\u4f4f";
            case "elder_in":
                return "\u5728\u9662";
            case "elder_out":
                return "\u5df2\u9000\u4f4f";
            case "elder_other":
                return "\u5176\u4ed6";
            case "bed_free":
                return "\u7a7a\u95f2";
            case "bed_used":
                return "\u5360\u7528";
            case "bed_maint":
                return "\u7ef4\u4fee\u4e2d";
            case "bed_other":
                return "\u5176\u4ed6";
            case "visit_pending":
                return "\u5f85\u5ba1\u6279\u6765\u8bbf";
            case "visit_done":
                return "\u5df2\u5904\u7406\u6765\u8bbf";
            case "user_ok":
                return "\u8d26\u53f7\u6b63\u5e38";
            case "user_disabled":
                return "\u8d26\u53f7\u505c\u7528";
            case "bill_main":
                return "\u62a4\u7406/\u5e8a\u4f4d/\u9910\u996e";
            case "bill_other":
                return "\u5176\u4ed6\u8d39\u7528";
            case "nursing_uncat":
                return "\u672a\u5206\u7ea7";
            default:
                return raw;
        }
    }

    @Override
    public ServeDashboardSummaryVo loadSummary() {
        ServeDashboardSummaryVo vo = new ServeDashboardSummaryVo();
        vo.setElder(buildPieFromCounts(serveDashboardMapper.countElderByStatus(), false));
        vo.setBed(buildPieFromCounts(serveDashboardMapper.countBedByStatus(), false));
        vo.setService(buildPieFromCounts(serveDashboardMapper.countVisitByApprovalGroup(), false));
        vo.setStaff(buildPieFromCounts(serveDashboardMapper.countSysUserByStatus(), false));
        vo.setMoney(buildPieFromCounts(serveDashboardMapper.sumBillAmountByTypeGroup(), true));

        List<DashboardSliceVo> rank = serveDashboardMapper.countCheckInByNursingLevel().stream()
                .map(r -> new DashboardSliceVo(displayDashboardLabel(r.getLabel()),
                        toDecimal(r).setScale(0, RoundingMode.HALF_UP)))
                .collect(Collectors.toList());
        vo.setElderRank(rank);

        DashboardElderAgeBucketsRow ageRow = serveDashboardMapper.selectElderAgeGenderBuckets();
        DashboardElderAgeVo ageVo = new DashboardElderAgeVo();
        if (ageRow != null) {
            ageVo.setMan(List.of(nz(ageRow.getM0()), nz(ageRow.getM1()), nz(ageRow.getM2()), nz(ageRow.getM3()), nz(ageRow.getM4())));
            ageVo.setWoman(List.of(nz(ageRow.getW0()), nz(ageRow.getW1()), nz(ageRow.getW2()), nz(ageRow.getW3()), nz(ageRow.getW4())));
        } else {
            ageVo.setMan(List.of(0L, 0L, 0L, 0L, 0L));
            ageVo.setWoman(List.of(0L, 0L, 0L, 0L, 0L));
        }
        vo.setElderAge(ageVo);

        LocalDate today = LocalDate.now();
        String todayStr = today.format(ISO);
        LocalDate weekStart = today.with(DayOfWeek.MONDAY);
        LocalDate weekEnd = today.with(DayOfWeek.SUNDAY);
        LocalDate monthStart = today.withDayOfMonth(1);
        LocalDate monthEnd = today.withDayOfMonth(today.lengthOfMonth());

        fillEarningsTrends(vo, todayStr, weekStart, weekEnd, monthStart, monthEnd);
        fillCheckInTrends(vo, todayStr, weekStart, weekEnd, monthStart, monthEnd);
        fillServeTrends(vo, todayStr, weekStart, weekEnd, monthStart, monthEnd);

        vo.setVisitsByDate(buildVisitsMap(today));
        return vo;
    }

    private Map<String, List<DashboardVisitItemVo>> buildVisitsMap(LocalDate today) {
        LocalDate from = today.minusDays(21);
        LocalDate to = today.plusDays(21);
        List<DashboardVisitRowVo> rows =
                serveDashboardMapper.selectVisitItemsBetween(from.format(ISO), to.format(ISO));
        Map<String, List<DashboardVisitItemVo>> map = new LinkedHashMap<>();
        for (DashboardVisitRowVo r : rows) {
            DashboardVisitItemVo it = new DashboardVisitItemVo();
            it.setType(r.getType());
            it.setTime(r.getTime());
            it.setName(r.getName());
            it.setPhone(r.getPhone());
            map.computeIfAbsent(r.getVisitDate(), k -> new ArrayList<>()).add(it);
        }
        return map;
    }

    private void fillEarningsTrends(ServeDashboardSummaryVo vo, String todayStr,
            LocalDate weekStart, LocalDate weekEnd, LocalDate monthStart, LocalDate monthEnd) {
        ServeDashboardSummaryVo.TrendDualGroup g = vo.getTrends().getEarnings();
        g.setToday(buildBillHourDual(todayStr));
        g.setWeek(buildBillDayDual(weekStart, weekEnd));
        g.setMonth(buildBillDayDual(monthStart, monthEnd));
    }

    private void fillCheckInTrends(ServeDashboardSummaryVo vo, String todayStr,
            LocalDate weekStart, LocalDate weekEnd, LocalDate monthStart, LocalDate monthEnd) {
        ServeDashboardSummaryVo.TrendDualGroup g = vo.getTrends().getCheckIn();
        g.setToday(buildCheckInHourDual(todayStr));
        g.setWeek(buildCheckInDayDual(weekStart, weekEnd));
        g.setMonth(buildCheckInDayDual(monthStart, monthEnd));
    }

    private void fillServeTrends(ServeDashboardSummaryVo vo, String todayStr,
            LocalDate weekStart, LocalDate weekEnd, LocalDate monthStart, LocalDate monthEnd) {
        ServeDashboardSummaryVo.TrendLineGroup g = vo.getTrends().getServe();
        g.setTodayTimes(hourLabels());
        g.setToday(hourVisitCounts(todayStr));
        g.setWeekTimes(dayLabels(weekStart, weekEnd));
        g.setWeek(dayVisitCounts(weekStart, weekEnd));
        g.setMonthTimes(IntStream.rangeClosed(1, monthEnd.getDayOfMonth())
                .mapToObj(String::valueOf)
                .collect(Collectors.toList()));
        g.setMonth(dayVisitCounts(monthStart, monthEnd));
    }

    private DashboardDualSeriesVo buildBillHourDual(String day) {
        Map<Integer, BigDecimal> paid = toHourMap(serveDashboardMapper.sumBillPaidHourlyForDay(day));
        Map<Integer, BigDecimal> unpaid = toHourMap(serveDashboardMapper.sumBillUnpaidHourlyForDay(day));
        DashboardDualSeriesVo d = new DashboardDualSeriesVo();
        d.setTimes(hourLabels());
        for (int h = 0; h < 24; h++) {
            d.getIncomeData().add(paid.getOrDefault(h, BigDecimal.ZERO));
            d.getRefundData().add(unpaid.getOrDefault(h, BigDecimal.ZERO));
        }
        return d;
    }

    private DashboardDualSeriesVo buildBillDayDual(LocalDate start, LocalDate end) {
        List<LocalDate> days = enumerateDays(start, end);
        Map<String, BigDecimal> paid =
                toDayAmountMap(serveDashboardMapper.sumBillPaidDailyBetween(start.format(ISO), end.format(ISO)));
        Map<String, BigDecimal> unpaid =
                toDayAmountMap(serveDashboardMapper.sumBillUnpaidDailyBetween(start.format(ISO), end.format(ISO)));
        DashboardDualSeriesVo d = new DashboardDualSeriesVo();
        for (LocalDate x : days) {
            String key = x.format(ISO);
            d.getTimes().add(x.format(MD));
            d.getIncomeData().add(paid.getOrDefault(key, BigDecimal.ZERO));
            d.getRefundData().add(unpaid.getOrDefault(key, BigDecimal.ZERO));
        }
        return d;
    }

    private DashboardDualSeriesVo buildCheckInHourDual(String day) {
        DashboardDualSeriesVo d = new DashboardDualSeriesVo();
        d.setTimes(hourLabels());
        Map<Integer, Long> inMap = toHourCountMap(serveDashboardMapper.countCheckInStartsHourlyForDay(day));
        Map<Integer, Long> outMap = toHourCountMap(serveDashboardMapper.countCheckOutsHourlyForDay(day));
        for (int h = 0; h < 24; h++) {
            d.getIncomeData().add(BigDecimal.valueOf(inMap.getOrDefault(h, 0L)));
            d.getRefundData().add(BigDecimal.valueOf(outMap.getOrDefault(h, 0L)));
        }
        return d;
    }

    private DashboardDualSeriesVo buildCheckInDayDual(LocalDate start, LocalDate end) {
        List<LocalDate> days = enumerateDays(start, end);
        Map<String, Long> inMap =
                toDayCountMap(serveDashboardMapper.countCheckInStartsDailyBetween(start.format(ISO), end.format(ISO)));
        Map<String, Long> outMap =
                toDayCountMap(serveDashboardMapper.countCheckOutsDailyBetween(start.format(ISO), end.format(ISO)));
        DashboardDualSeriesVo d = new DashboardDualSeriesVo();
        for (LocalDate x : days) {
            String key = x.format(ISO);
            d.getTimes().add(x.format(MD));
            d.getIncomeData().add(BigDecimal.valueOf(inMap.getOrDefault(key, 0L)));
            d.getRefundData().add(BigDecimal.valueOf(outMap.getOrDefault(key, 0L)));
        }
        return d;
    }

    private List<BigDecimal> hourVisitCounts(String day) {
        Map<Integer, BigDecimal> m = new HashMap<>();
        for (int h = 0; h < 24; h++) {
            m.put(h, BigDecimal.ZERO);
        }
        List<DashboardVisitRowVo> visits = serveDashboardMapper.selectVisitItemsBetween(day, day);
        for (DashboardVisitRowVo v : visits) {
            if (v.getTime() == null || !v.getTime().contains(":")) {
                continue;
            }
            int h = Integer.parseInt(v.getTime().split(":")[0].trim());
            if (h >= 0 && h < 24) {
                m.put(h, m.get(h).add(BigDecimal.ONE));
            }
        }
        List<BigDecimal> list = new ArrayList<>();
        for (int h = 0; h < 24; h++) {
            list.add(m.get(h));
        }
        return list;
    }

    private List<BigDecimal> dayVisitCounts(LocalDate start, LocalDate end) {
        Map<String, BigDecimal> map =
                toDayAmountMapFromCounts(serveDashboardMapper.countVisitsDailyBetween(start.format(ISO), end.format(ISO)));
        List<BigDecimal> list = new ArrayList<>();
        for (LocalDate x : enumerateDays(start, end)) {
            list.add(map.getOrDefault(x.format(ISO), BigDecimal.ZERO));
        }
        return list;
    }

    private Map<Integer, Long> toHourCountMap(List<DashboardCheckInHourCount> rows) {
        Map<Integer, Long> m = new HashMap<>();
        if (rows != null) {
            for (DashboardCheckInHourCount r : rows) {
                if (r.getHr() != null) {
                    m.put(r.getHr(), r.getCnt() == null ? 0L : r.getCnt());
                }
            }
        }
        return m;
    }

    private Map<String, BigDecimal> toDayAmountMapFromCounts(List<DashboardDayCount> rows) {
        Map<String, BigDecimal> m = new HashMap<>();
        if (rows != null) {
            for (DashboardDayCount r : rows) {
                if (r.getStatDate() != null) {
                    m.put(r.getStatDate(), BigDecimal.valueOf(r.getCnt() == null ? 0L : r.getCnt()));
                }
            }
        }
        return m;
    }

    private Map<String, Long> toDayCountMap(List<DashboardDayCount> rows) {
        Map<String, Long> m = new HashMap<>();
        if (rows != null) {
            for (DashboardDayCount r : rows) {
                if (r.getStatDate() != null) {
                    m.put(r.getStatDate(), r.getCnt() == null ? 0L : r.getCnt());
                }
            }
        }
        return m;
    }

    private Map<String, BigDecimal> toDayAmountMap(List<DashboardDayAmount> rows) {
        Map<String, BigDecimal> m = new HashMap<>();
        if (rows != null) {
            for (DashboardDayAmount r : rows) {
                if (r.getStatDate() != null) {
                    m.put(r.getStatDate(), r.getAmt() == null ? BigDecimal.ZERO : r.getAmt());
                }
            }
        }
        return m;
    }

    private Map<Integer, BigDecimal> toHourMap(List<DashboardHourAmount> rows) {
        Map<Integer, BigDecimal> m = new HashMap<>();
        if (rows != null) {
            for (DashboardHourAmount r : rows) {
                if (r.getHr() != null) {
                    m.put(r.getHr(), r.getAmt() == null ? BigDecimal.ZERO : r.getAmt());
                }
            }
        }
        return m;
    }

    private List<String> hourLabels() {
        List<String> t = new ArrayList<>();
        for (int h = 0; h < 24; h++) {
            t.add(h + ":00");
        }
        return t;
    }

    private List<String> dayLabels(LocalDate start, LocalDate end) {
        return enumerateDays(start, end).stream().map(d -> d.format(MD)).collect(Collectors.toList());
    }

    private List<LocalDate> enumerateDays(LocalDate start, LocalDate end) {
        List<LocalDate> list = new ArrayList<>();
        LocalDate x = start;
        while (!x.isAfter(end)) {
            list.add(x);
            x = x.plusDays(1);
        }
        return list;
    }

    private DashboardPieBundleVo buildPieFromCounts(List<DashboardLabelCount> rows, boolean useAmount) {
        DashboardPieBundleVo pie = new DashboardPieBundleVo();
        if (rows == null || rows.isEmpty()) {
            pie.setTotal(BigDecimal.ZERO);
            return pie;
        }
        BigDecimal total = BigDecimal.ZERO;
        List<DashboardSliceVo> data = new ArrayList<>();
        for (DashboardLabelCount r : rows) {
            BigDecimal v = useAmount ? (r.getAmount() == null ? BigDecimal.ZERO : r.getAmount())
                    : BigDecimal.valueOf(r.getCnt() == null ? 0L : r.getCnt());
            total = total.add(v);
            data.add(new DashboardSliceVo(displayDashboardLabel(r.getLabel()), v.setScale(2, RoundingMode.HALF_UP)));
        }
        pie.setTotal(total.setScale(2, RoundingMode.HALF_UP));
        pie.setData(data);
        return pie;
    }

    private BigDecimal toDecimal(DashboardLabelCount r) {
        if (r.getAmount() != null) {
            return r.getAmount();
        }
        return BigDecimal.valueOf(r.getCnt() == null ? 0L : r.getCnt());
    }

    private long nz(Long v) {
        return v == null ? 0L : v;
    }
}
