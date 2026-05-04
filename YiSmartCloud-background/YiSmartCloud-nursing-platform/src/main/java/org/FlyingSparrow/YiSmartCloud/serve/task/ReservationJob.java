package org.FlyingSparrow.YiSmartCloud.serve.task;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.FlyingSparrow.YiSmartCloud.serve.service.IReservationService;
import org.springframework.stereotype.Component;

@Slf4j
@Component("reservationJob")
@RequiredArgsConstructor
public class ReservationJob {

    private final IReservationService reservationService;

    public void expirePendingReservations() {
        int updated = reservationService.expirePending();
        if (updated > 0) {
            log.info("预约过期任务执行完成，更新 {} 条记录", updated);
        }
    }
}
