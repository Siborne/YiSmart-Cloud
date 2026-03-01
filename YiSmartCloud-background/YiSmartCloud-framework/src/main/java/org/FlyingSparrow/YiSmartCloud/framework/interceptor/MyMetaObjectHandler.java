package org.FlyingSparrow.YiSmartCloud.framework.interceptor;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.model.LoginUser;
import org.FlyingSparrow.YiSmartCloud.common.utils.SecurityUtils;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class MyMetaObjectHandler implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {
        this.strictInsertFill(metaObject, "createTime", Date.class, new Date());
        this.strictInsertFill(metaObject, "createBy", String.class, loadUserId()+"");
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        this.strictUpdateFill(metaObject, "updateTime", Date.class, new Date());
        this.strictUpdateFill(metaObject, "updateBy", String.class, loadUserId()+"");
    }

    /**
     * 获取当前登录人的ID
     * @return
     */
    public static Long loadUserId(){
        //获取当前登录人的id
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if(ObjectUtils.isNotEmpty(loginUser)){
            return loginUser.getUserId();
        }
        return 1L;
    }
}