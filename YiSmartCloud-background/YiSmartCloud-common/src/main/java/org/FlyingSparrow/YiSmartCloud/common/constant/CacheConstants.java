package org.FlyingSparrow.YiSmartCloud.common.constant;

/**
 * 缓存的key 常量
 * 
 * @author ruoyi
 */
public class CacheConstants
{
    /**
     * 登录用户 redis key
     */
    public static final String LOGIN_TOKEN_KEY = "login_tokens:";

    /**
     * 验证码 redis key
     */
    public static final String CAPTCHA_CODE_KEY = "captcha_codes:";

    /**
     * 参数管理 cache key
     */
    public static final String SYS_CONFIG_KEY = "sys_config:";

    /**
     * 字典管理 cache key
     */
    public static final String SYS_DICT_KEY = "sys_dict:";

    /**
     * 防重提交 redis key
     */
    public static final String REPEAT_SUBMIT_KEY = "repeat_submit:";

    /**
     * 限流 redis key
     */
    public static final String RATE_LIMIT_KEY = "rate_limit:";

    /**
     * 登录账户密码错误次数 redis key
     */
    public static final String PWD_ERR_CNT_KEY = "pwd_err_cnt:";

    /**
     * 护理等级「全部启用列表」redis key（冒号分层命名，便于按前缀管理与排查）
     */
    public static final String NURSING_LEVEL_LIST_ALL_KEY = "nursingLevel:all";

    /**
     * 护理计划「全部启用列表」（下拉等）redis key
     */
    public static final String NURSING_PLAN_ALL_KEY = "nursingPlan:all";

    /**
     * 护理项目「全部启用下拉项」redis key（label/value 列表）
     */
    public static final String NURSING_PROJECT_ALL_KEY = "nursingProject:all";
}
