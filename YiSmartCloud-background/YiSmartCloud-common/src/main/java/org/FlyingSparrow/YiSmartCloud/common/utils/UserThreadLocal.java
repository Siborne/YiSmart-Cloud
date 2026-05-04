package org.FlyingSparrow.YiSmartCloud.common.utils;

/**
 * Store current mini-program member userId in thread scope.
 */
public class UserThreadLocal
{
    private static final ThreadLocal<Long> USER_HOLDER = new ThreadLocal<>();

    private UserThreadLocal()
    {
    }

    public static void set(Long userId)
    {
        USER_HOLDER.set(userId);
    }

    public static Long getUserId()
    {
        return USER_HOLDER.get();
    }

    public static void remove()
    {
        USER_HOLDER.remove();
    }
}
