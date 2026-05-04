package org.FlyingSparrow.YiSmartCloud.serve.task;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.FlyingSparrow.YiSmartCloud.serve.service.IReservationService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * 预约自动过期：每小时第 1、31 分钟检查待报道且已过预约时间的记录
 *
 * @author agent
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class ReservationExpireTask {

    private final IReservationService reservationService;

    @Scheduled(cron = "0 1,31 * * * ?")
    public void expire() {
        int n = reservationService.expirePending();
        if (n > 0) {
            log.info("[ReservationExpireTask] 已过期更新 {} 条", n);
        }
    }
}
