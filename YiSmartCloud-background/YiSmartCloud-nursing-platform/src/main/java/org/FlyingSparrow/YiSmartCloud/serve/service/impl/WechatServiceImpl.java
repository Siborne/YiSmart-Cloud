package org.FlyingSparrow.YiSmartCloud.serve.service.impl;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import java.util.HashMap;
import java.util.Map;
import org.FlyingSparrow.YiSmartCloud.common.exception.ServiceException;
import org.FlyingSparrow.YiSmartCloud.common.utils.StringUtils;
import org.FlyingSparrow.YiSmartCloud.serve.service.WechatService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

@Service
public class WechatServiceImpl implements WechatService {

    private static final String JSCODE2SESSION_URL = "https://api.weixin.qq.com/sns/jscode2session";
    private static final String TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token";
    private static final String PHONE_URL = "https://api.weixin.qq.com/wxa/business/getuserphonenumber";

    private final RestTemplate restTemplate = new RestTemplate();

    @Value("${wechat.appId:}")
    private String appid;

    @Value("${wechat.appSecret:}")
    private String secret;

    @Override
    public String getOpenid(String code) {
        if (StringUtils.isEmpty(appid) || StringUtils.isEmpty(secret)) {
            throw new ServiceException("wechat.appId / wechat.appSecret not configured");
        }
        String url = UriComponentsBuilder.fromHttpUrl(JSCODE2SESSION_URL)
                .queryParam("grant_type", "authorization_code")
                .queryParam("appid", appid)
                .queryParam("secret", secret)
                .queryParam("js_code", code)
                .toUriString();
        String body = restTemplate.getForObject(url, String.class);
        JSONObject json = JSON.parseObject(body);
        Integer errcode = json.getInteger("errcode");
        if (errcode != null && errcode != 0) {
            throw new ServiceException("WeChat login failed: " + json.getString("errmsg"));
        }
        String openid = json.getString("openid");
        if (StringUtils.isEmpty(openid)) {
            throw new ServiceException("WeChat did not return openid");
        }
        return openid;
    }

    @Override
    public String getPhone(String detailCode) {
        String accessToken = getAccessToken();
        String url = PHONE_URL + "?access_token=" + accessToken;
        Map<String, String> param = new HashMap<>(2);
        param.put("code", detailCode);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> entity = new HttpEntity<>(JSON.toJSONString(param), headers);
        ResponseEntity<String> response = restTemplate.postForEntity(url, entity, String.class);
        JSONObject json = JSON.parseObject(response.getBody());
        int errcode = json.getIntValue("errcode");
        if (errcode != 0) {
            throw new ServiceException("getPhoneNumber failed: " + json.getString("errmsg"));
        }
        JSONObject phoneInfo = json.getJSONObject("phone_info");
        if (phoneInfo == null) {
            throw new ServiceException("WeChat did not return phone_info");
        }
        String phoneNumber = phoneInfo.getString("phoneNumber");
        if (StringUtils.isEmpty(phoneNumber)) {
            throw new ServiceException("WeChat did not return phone number");
        }
        return phoneNumber;
    }

    private String getAccessToken() {
        if (StringUtils.isEmpty(appid) || StringUtils.isEmpty(secret)) {
            throw new ServiceException("wechat.appId / wechat.appSecret not configured");
        }
        String url = UriComponentsBuilder.fromHttpUrl(TOKEN_URL)
                .queryParam("grant_type", "client_credential")
                .queryParam("appid", appid)
                .queryParam("secret", secret)
                .toUriString();
        String body = restTemplate.getForObject(url, String.class);
        JSONObject json = JSON.parseObject(body);
        Integer errcode = json.getInteger("errcode");
        if (errcode != null && errcode != 0) {
            throw new ServiceException("access_token failed: " + json.getString("errmsg"));
        }
        String token = json.getString("access_token");
        if (StringUtils.isEmpty(token)) {
            throw new ServiceException("WeChat did not return access_token");
        }
        return token;
    }
}
