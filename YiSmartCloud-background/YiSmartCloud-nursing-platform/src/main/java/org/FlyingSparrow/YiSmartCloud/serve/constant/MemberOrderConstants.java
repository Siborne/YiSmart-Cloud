package org.FlyingSparrow.YiSmartCloud.serve.constant;

public final class MemberOrderConstants {

    private MemberOrderConstants() {
    }

    public static final int STATUS_PENDING_PAY = 0;
    public static final int STATUS_PENDING_SERVICE = 1;
    public static final int STATUS_CANCELLED = 2;
    public static final int STATUS_REFUNDED = 3;
    public static final int STATUS_FINISHED = 4;

    public static final int PAY_STATUS_UNPAID = 0;
    public static final int PAY_STATUS_PAID = 1;
}
