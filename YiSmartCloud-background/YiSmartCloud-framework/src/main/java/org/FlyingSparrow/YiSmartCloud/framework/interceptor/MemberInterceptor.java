package org.FlyingSparrow.YiSmartCloud.framework.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import io.jsonwebtoken.Claims;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.FlyingSparrow.YiSmartCloud.common.constant.Constants;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.model.LoginUser;
import org.FlyingSparrow.YiSmartCloud.common.exception.base.BaseException;
import org.FlyingSparrow.YiSmartCloud.common.utils.StringUtils;
import org.FlyingSparrow.YiSmartCloud.common.utils.UserThreadLocal;
import org.FlyingSparrow.YiSmartCloud.framework.web.service.TokenService;

/**
 * Mini-program member token interceptor.
 */
@Component
public class MemberInterceptor implements HandlerInterceptor
{
    @Autowired
    private TokenService tokenService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
    {
        if (!(handler instanceof HandlerMethod))
        {
            return true;
        }

        String token = request.getHeader(Constants.AUTHORIZATION_LOWER);
        if (StringUtils.isEmpty(token))
        {
            token = request.getHeader(Constants.AUTHORIZATION);
        }
        if (StringUtils.isEmpty(token))
        {
            throw new BaseException("认证失败");
        }
        if (token.startsWith(Constants.TOKEN_PREFIX))
        {
            token = token.replace(Constants.TOKEN_PREFIX, "");
        }

        Long userId = null;
        try
        {
            Claims claims = tokenService.parseToken(token);
            if (claims != null)
            {
                Object claimUserId = claims.get(Constants.JWT_MEMBER_USER_ID);
                if (claimUserId instanceof Number)
                {
                    userId = ((Number) claimUserId).longValue();
                }
            }
        }
        catch (Exception ignored)
        {
            // Fall back to redis-based token parsing for compatibility with issued tokens.
        }

        if (userId == null)
        {
            LoginUser loginUser = tokenService.getLoginUser(request);
            if (loginUser != null)
            {
                userId = loginUser.getUserId();
            }
        }

        if (userId == null)
        {
            throw new BaseException("认证失败");
        }

        UserThreadLocal.set(userId);
        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
    {
        UserThreadLocal.remove();
    }
}
