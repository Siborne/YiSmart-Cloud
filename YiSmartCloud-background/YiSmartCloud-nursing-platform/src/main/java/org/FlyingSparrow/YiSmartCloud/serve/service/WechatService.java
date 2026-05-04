package org.FlyingSparrow.YiSmartCloud.serve.service;

/**
 * WeChat mini-program HTTP API wrapper.
 */
public interface WechatService {

    /**
     * Exchange wx.login {@code code} for {@code openid}.
     */
    String getOpenid(String code);

    /**
     * Exchange getPhoneNumber {@code code} for phone number.
     */
    String getPhone(String detailCode);
}
