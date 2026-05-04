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
import org.FlyingSparrow.YiSmartCloud.serve.dto.MemberAuthRequestDto;
import org.FlyingSparrow.YiSmartCloud.serve.dto.UserLoginRequestDto;
import org.FlyingSparrow.YiSmartCloud.serve.mapper.FamilyMemberMapper;
import org.FlyingSparrow.YiSmartCloud.serve.service.IFamilyMemberService;
import org.FlyingSparrow.YiSmartCloud.serve.service.WechatService;
import org.FlyingSparrow.YiSmartCloud.serve.vo.LoginVo;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

@Service
public class FamilyMemberServiceImpl extends ServiceImpl<FamilyMemberMapper, FamilyMember> implements IFamilyMemberService {

    private static final String DEFAULT_NICK = "WeChat user";
    private static final String DEV_OPENID_PREFIX = "dev_openid_";

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
        String nick = StringUtils.isNotEmpty(dto.getNickName()) ? dto.getNickName().trim() : DEFAULT_NICK;

        FamilyMember member = lambdaQuery().eq(FamilyMember::getOpenId, openid).one();

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

        return buildLoginVo(member, nick);
    }

    @Override
    public LoginVo basicLogin(MemberAuthRequestDto dto) {
        String phone = normalizeAndValidatePhone(dto);
        FamilyMember member = lambdaQuery().eq(FamilyMember::getPhone, phone).one();
        if (member == null) {
            throw new ServiceException("账号不存在，请先注册");
        }
        String fallbackNick = StringUtils.isNotEmpty(member.getName()) ? member.getName() : ("用户" + phone.substring(phone.length() - 4));
        return buildLoginVo(member, fallbackNick);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public LoginVo register(MemberAuthRequestDto dto) {
        String phone = normalizeAndValidatePhone(dto);
        if (lambdaQuery().eq(FamilyMember::getPhone, phone).count() > 0) {
            throw new ServiceException("手机号已注册，请直接登录");
        }
        String nick = resolveNickName(dto, phone);

        FamilyMember member = new FamilyMember();
        member.setOpenId(DEV_OPENID_PREFIX + phone);
        member.setPhone(phone);
        member.setName(nick);
        member.setCreateTime(DateUtils.getNowDate());
        member.setUpdateTime(DateUtils.getNowDate());
        if (!save(member)) {
            throw new ServiceException("注册失败，请稍后重试");
        }
        return buildLoginVo(member, nick);
    }

    private LoginVo buildLoginVo(FamilyMember member, String fallbackNick) {
        String displayNick = StringUtils.isNotEmpty(member.getName()) ? member.getName() : fallbackNick;

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

    private String normalizeAndValidatePhone(MemberAuthRequestDto dto) {
        if (dto == null || StringUtils.isEmpty(dto.getPhone())) {
            throw new ServiceException("phone is required");
        }
        String phone = dto.getPhone().trim();
        if (!phone.matches("^1\\d{10}$")) {
            throw new ServiceException("invalid phone format");
        }
        return phone;
    }

    private String resolveNickName(MemberAuthRequestDto dto, String phone) {
        if (dto != null && StringUtils.isNotEmpty(dto.getNickName())) {
            return dto.getNickName().trim();
        }
        return "用户" + phone.substring(phone.length() - 4);
    }
}
