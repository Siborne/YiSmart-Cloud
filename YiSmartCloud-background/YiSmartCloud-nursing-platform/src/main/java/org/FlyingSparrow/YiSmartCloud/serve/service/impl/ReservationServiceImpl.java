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
 * 预约业务实现
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
            throw new ServiceException("预约类型不合法");
        }
        if (countCancelledToday() > ReservationConstants.MAX_DAILY_CANCEL) {
            throw new ServiceException("当日取消预约次数已达上限，暂时无法预约");
        }

        LocalDateTime slot = dto.getTime().withNano(0);
        validateSlot(slot);

        int occupied = reservationMapper.countActiveAtSlot(slot);
        if (occupied >= ReservationConstants.SLOT_CAPACITY) {
            throw new ServiceException("该时间段已约满");
        }

        Reservation entity = new Reservation();
        entity.setName(dto.getName());
        entity.setMobile(dto.getMobile());
        entity.setVisitor(dto.getVisitor());
        entity.setType(dto.getType());
        entity.setStatus(ReservationConstants.STATUS_PENDING);
        entity.setTime(slot);

        try {
            reservationMapper.insert(entity);
        } catch (DuplicateKeyException e) {
            log.warn("预约唯一约束冲突: mobile={}, time={}", dto.getMobile(), slot, e);
            throw new ServiceException("该手机号在此时间段已有预约");
        } catch (DataIntegrityViolationException e) {
            if (e.getCause() instanceof java.sql.SQLIntegrityConstraintViolationException
                    || (e.getMessage() != null && e.getMessage().contains("Duplicate"))) {
                log.warn("预约唯一约束冲突: mobile={}, time={}", dto.getMobile(), slot, e);
                throw new ServiceException("该手机号在此时间段已有预约");
            }
            throw e;
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
            throw new ServiceException("预约主键不能为空");
        }
        Reservation row = reservationMapper.selectById(id);
        if (row == null) {
            throw new ServiceException("预约不存在");
        }
        Long memberId = SecurityUtils.getUserId();
        if (!String.valueOf(memberId).equals(row.getCreateBy())) {
            throw new ServiceException("无权操作该预约");
        }
        if (!Integer.valueOf(ReservationConstants.STATUS_PENDING).equals(row.getStatus())) {
            throw new ServiceException("当前状态不可取消");
        }
        row.setStatus(ReservationConstants.STATUS_CANCELLED);
        reservationMapper.updateById(row);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int expirePending() {
        int n = reservationMapper.expirePending(LocalDateTime.now());
        if (n > 0) {
            log.info("[Reservation] 自动过期待报道预约 {} 条", n);
        }
        return n;
    }

    /**
     * 校验预约时间落在可选档内，且未早于当前时刻（当日）
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
            throw new ServiceException("预约时间必须晚于当前时间");
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
