package org.FlyingSparrow.YiSmartCloud.serve.constant;

import java.time.LocalTime;

/**
 * 小程序预约相关常量（类型、状态、时间段规则）
 *
 * @author agent
 */
public final class ReservationConstants {

    private ReservationConstants() {
    }

    /** 参观预约 */
    public static final int TYPE_VISIT = 0;

    /** 探访预约 */
    public static final int TYPE_VISITATION = 1;

    /** 待报道 */
    public static final int STATUS_PENDING = 0;

    /** 已完成 */
    public static final int STATUS_DONE = 1;

    /** 取消 */
    public static final int STATUS_CANCELLED = 2;

    /** 过期 */
    public static final int STATUS_EXPIRED = 3;

    /** 每个时间段最大可预约人数 */
    public static final int SLOT_CAPACITY = 6;

    /** 当天取消次数大于该值则不可再预约（即允许最多 3 次取消，第 4 次起禁止新约） */
    public static final int MAX_DAILY_CANCEL = 3;

    public static final LocalTime SLOT_START = LocalTime.of(8, 0);

    public static final LocalTime SLOT_END = LocalTime.of(17, 30);

    public static final int SLOT_STEP_MINUTES = 30;
}
