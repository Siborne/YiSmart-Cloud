package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.FlyingSparrow.YiSmartCloud.common.exception.ServiceException;
import org.FlyingSparrow.YiSmartCloud.common.utils.SecurityUtils;
import org.FlyingSparrow.YiSmartCloud.serve.constant.ReservationConstants;
import org.FlyingSparrow.YiSmartCloud.serve.domain.Reservation;
import org.FlyingSparrow.YiSmartCloud.serve.dto.ReservationCreateDto;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.ReservationMapper;
import org.FlyingSparrow.YiSmartCloud.serve.service.IReservationService;
import org.FlyingSparrow.YiSmartCloud.serve.vo.ReservationSlotOccupancyRow;
import org.FlyingSparrow.YiSmartCloud.serve.vo.TimeSlotCountVo;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * 预约服务实现类 - 处理参观和探视预约业务
 *
 * @author agent
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ReservationServiceImpl extends ServiceImpl<ReservationMapper, Reservation> implements IReservationService {

    private static final DateTimeFormatter TIME_FMT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    private final ReservationMapper reservationMapper;

    @Override
    public int countCancelledToday() {
        Long memberId = SecurityUtils.getUserId();
        return reservationMapper.countCancelledTodayByMember(memberId, LocalDate.now());
    }

    @Override
    public List<TimeSlotCountVo> countByTime(LocalDate date) {
        LocalDate d = date != null ? date : LocalDate.now();
        List<ReservationSlotOccupancyRow> rows = reservationMapper.selectOccupiedCountsByDate(d);
        List<TimeSlotCountVo> result = new ArrayList<>();
        for (ReservationSlotOccupancyRow row : rows) {
            if (row.getSlotTime() == null) {
                continue;
            }
            int booked = row.getBookedCount() == null ? 0 : row.getBookedCount();
            if (booked <= 0) {
                continue;
            }
            int remain = Math.max(0, ReservationConstants.SLOT_CAPACITY - booked);
            result.add(new TimeSlotCountVo(row.getSlotTime().format(TIME_FMT), remain));
        }
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void create(ReservationCreateDto dto) {
        if (dto.getType() == null
                || (dto.getType() != ReservationConstants.TYPE_VISIT && dto.getType() != ReservationConstants.TYPE_VISITATION)) {
            throw new ServiceException("预约类型不正确");
        }
        if (countCancelledToday() > ReservationConstants.MAX_DAILY_CANCEL) {
            throw new ServiceException("今日取消次数过多，请稍后再试");
        }

        LocalDateTime slot = dto.getTime().withNano(0);
        validateSlot(slot);
        String lockKey = "reservation_slot_" + slot.format(DateTimeFormatter.ofPattern("yyyyMMddHHmm"));
        Integer lock = reservationMapper.acquireSlotLock(lockKey, 3);
        if (!Integer.valueOf(1).equals(lock)) {
            throw new ServiceException("系统繁忙，请稍后重试");
        }

        Reservation entity = new Reservation();
        entity.setName(dto.getName());
        entity.setMobile(dto.getMobile());
        entity.setVisitor(dto.getVisitor());
        entity.setType(dto.getType());
        entity.setStatus(ReservationConstants.STATUS_PENDING);
        entity.setTime(slot);
        entity.setRemark(dto.getRemark());

        try {
            int occupied = reservationMapper.countActiveAtSlot(slot);
            if (occupied >= ReservationConstants.SLOT_CAPACITY) {
                throw new ServiceException("该时段已满");
            }
            try {
                reservationMapper.insert(entity);
            } catch (DuplicateKeyException e) {
                log.warn("预约重复提交: mobile={}, time={}", dto.getMobile(), slot, e);
                throw new ServiceException("请勿重复提交预约");
            } catch (DataIntegrityViolationException e) {
                if (e.getCause() instanceof java.sql.SQLIntegrityConstraintViolationException
                        || (e.getMessage() != null && e.getMessage().contains("Duplicate"))) {
                    log.warn("预约数据冲突: mobile={}, time={}", dto.getMobile(), slot, e);
                    throw new ServiceException("请勿重复提交预约");
                }
                throw e;
            }
        } finally {
            reservationMapper.releaseSlotLock(lockKey);
        }
    }

    @Override
    public List<Reservation> selectMemberReservationList(Reservation query) {
        Long memberId = SecurityUtils.getUserId();
        if (query == null) {
            query = new Reservation();
        }
        return reservationMapper.selectMemberReservationList(memberId, query);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void cancel(Long id) {
        if (id == null) {
            throw new ServiceException("预约ID不能为空");
        }
        Reservation row = reservationMapper.selectById(id);
        if (row == null) {
            throw new ServiceException("预约不存在");
        }
        Long memberId = SecurityUtils.getUserId();
        if (!String.valueOf(memberId).equals(row.getCreateBy())) {
            throw new ServiceException("无权操作此预约");
        }
        if (!Integer.valueOf(ReservationConstants.STATUS_PENDING).equals(row.getStatus())) {
            throw new ServiceException("只能取消待确认的预约");
        }
        row.setStatus(ReservationConstants.STATUS_CANCELLED);
        reservationMapper.updateById(row);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int expirePending() {
        int n = reservationMapper.expirePending(LocalDateTime.now());
        if (n > 0) {
            log.info("[Reservation] 过期 {} 条待确认预约记录", n);
        }
        return n;
    }

    /**
     * 验证预约时间段是否合法（日期、时间格式、是否已过等）
     */
    private void validateSlot(LocalDateTime slot) {
        LocalDate date = slot.toLocalDate();
        LocalDate today = LocalDate.now();
        if (date.isBefore(today)) {
            throw new ServiceException("不能预约过去的日期");
        }
        List<LocalDateTime> legalSlots = buildSlotsForDate(date);
        boolean match = legalSlots.stream().anyMatch(s -> s.equals(slot));
        if (!match) {
            throw new ServiceException("预约时间不在可选时间段内");
        }
        LocalDateTime now = LocalDateTime.now();
        if (!date.isAfter(today) && !slot.isAfter(now)) {
            throw new ServiceException("不能预约已经过去的时间");
        }
    }

    private static List<LocalDateTime> buildSlotsForDate(LocalDate date) {
        List<LocalDateTime> list = new ArrayList<>();
        LocalDateTime cur = date.atTime(ReservationConstants.SLOT_START);
        LocalDateTime end = date.atTime(ReservationConstants.SLOT_END);
        while (!cur.isAfter(end)) {
            list.add(cur);
            cur = cur.plusMinutes(ReservationConstants.SLOT_STEP_MINUTES);
        }
        return list;
    }
}
