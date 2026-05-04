package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import java.util.Collections;
import javax.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.entity.SysUser;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.model.LoginUser;
import org.FlyingSparrow.YiSmartCloud.common.exception.ServiceException;
import org.FlyingSparrow.YiSmartCloud.common.utils.DateUtils;
import org.FlyingSparrow.YiSmartCloud.common.utils.StringUtils;
import org.FlyingSparrow.YiSmartCloud.framework.web.service.TokenService;
import org.FlyingSparrow.YiSmartCloud.serve.domain.FamilyMember;
import org.FlyingSparrow.YiSmartCloud.serve.dto.UserLoginRequestDto;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.FamilyMemberMapper;
import org.FlyingSparrow.YiSmartCloud.serve.service.IFamilyMemberService;
import org.FlyingSparrow.YiSmartCloud.serve.service.WechatService;
import org.FlyingSparrow.YiSmartCloud.serve.vo.LoginVo;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

@Service
public class FamilyMemberServiceImpl extends ServiceImpl<FamilyMemberMapper, FamilyMember> implements IFamilyMemberService {

    private static final String DEFAULT_NICK = "WeChat user";

    @Autowired
    private WechatService wechatService;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    /** Placeholder password for synthetic {@link SysUser}; not used for password login. */
    private String memberPlaceholderPassword;

    @PostConstruct
    public void initPlaceholderPassword() {
        this.memberPlaceholderPassword = passwordEncoder.encode("MINIPROGRAM_MEMBER_PLACEHOLDER");
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public LoginVo login(UserLoginRequestDto dto) {
        if (dto == null || StringUtils.isEmpty(dto.getCode())) {
            throw new ServiceException("login code is required");
        }
        if (StringUtils.isEmpty(dto.getPhoneCode())) {
            throw new ServiceException("phoneCode is required");
        }

        String openid = wechatService.getOpenid(dto.getCode().trim());
        String phone = wechatService.getPhone(dto.getPhoneCode().trim());

        FamilyMember member = lambdaQuery().eq(FamilyMember::getOpenId, openid).one();
        String nick = StringUtils.isNotEmpty(dto.getNickName()) ? dto.getNickName().trim() : DEFAULT_NICK;

        if (member == null) {
            member = new FamilyMember();
            member.setOpenId(openid);
            member.setPhone(phone);
            member.setName(nick);
            member.setCreateTime(DateUtils.getNowDate());
            member.setUpdateTime(DateUtils.getNowDate());
            if (!save(member)) {
                throw new ServiceException("failed to create family member");
            }
        } else {
            member.setPhone(phone);
            if (StringUtils.isNotEmpty(dto.getNickName())) {
                member.setName(nick);
            }
            member.setUpdateTime(DateUtils.getNowDate());
            if (!updateById(member)) {
                throw new ServiceException("failed to update family member");
            }
        }

        String displayNick = StringUtils.isNotEmpty(member.getName()) ? member.getName() : nick;

        SysUser sysUser = new SysUser();
        sysUser.setUserId(member.getId());
        sysUser.setDeptId(0L);
        sysUser.setUserName("wx_member_" + member.getId());
        sysUser.setNickName(displayNick);
        sysUser.setPhonenumber(member.getPhone());
        sysUser.setPassword(memberPlaceholderPassword);

        LoginUser loginUser = new LoginUser(member.getId(), 0L, sysUser, Collections.emptySet());
        String jwt = tokenService.createToken(loginUser);

        LoginVo vo = new LoginVo();
        vo.setToken(jwt);
        vo.setNickName(displayNick);
        return vo;
    }
}
