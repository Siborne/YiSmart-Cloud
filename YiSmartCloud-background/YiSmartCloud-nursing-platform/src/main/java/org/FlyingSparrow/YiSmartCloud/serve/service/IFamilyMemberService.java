package org.FlyingSparrow.YiSmartCloud.serve.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.FlyingSparrow.YiSmartCloud.serve.domain.FamilyMember;
import org.FlyingSparrow.YiSmartCloud.serve.dto.MemberAuthRequestDto;
import org.FlyingSparrow.YiSmartCloud.serve.dto.UserLoginRequestDto;
import org.FlyingSparrow.YiSmartCloud.serve.vo.LoginVo;

/**
 * Family member service (mini-program C-end).
 */
public interface IFamilyMemberService extends IService<FamilyMember> {

    /**
     * Mini-program login: openid + phone, upsert {@link FamilyMember}, issue JWT.
     */
    LoginVo login(UserLoginRequestDto dto);

    /**
     * Basic phone login for member app.
     */
    LoginVo basicLogin(MemberAuthRequestDto dto);

    /**
     * Basic phone register for member app.
     */
    LoginVo register(MemberAuthRequestDto dto);
}
