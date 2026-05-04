package org.FlyingSparrow.YiSmartCloud.framework.interceptor;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.model.LoginUser;
import org.FlyingSparrow.YiSmartCloud.common.utils.SecurityUtils;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.util.Date;

import static org.FlyingSparrow.YiSmartCloud.framework.datasource.DynamicDataSourceContextHolder.log;

@Component
public class MyMetaObjectHandler implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {
        this.strictInsertFill(metaObject, "createTime", Date.class, new Date());
        Long userId = loadUserId();
        if (userId != null) {
            this.strictInsertFill(metaObject, "createBy", String.class, userId + "");
        }
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        this.strictUpdateFill(metaObject, "updateTime", Date.class, new Date());
        Long userId = loadUserId();
        if (userId != null) {
            this.strictUpdateFill(metaObject, "updateBy", String.class, userId + "");
        }
    }

    /**
     * 获取当前登录人的ID
     *
     * @return
     */
    public static Long loadUserId() {
        //获取当前登录人的id
        try {
            LoginUser loginUser = SecurityUtils.getLoginUser();
            if (ObjectUtils.isNotEmpty(loginUser)) {
                return loginUser.getUserId();
            }
            return null;
        } catch (Exception e) {
            log.error("获取当前登录人的ID异常！,异常信息：{}", e);
            return null;
        }
    }
}