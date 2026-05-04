package org.FlyingSparrow.YiSmartCloud.serve.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

/**
 * 百度千帆 OpenAI 兼容对话配置（密钥仅放本地/环境配置，勿提交真实 Key）。
 */
@Data
@Component
@ConfigurationProperties(prefix = "yi.qianfan")
public class QianfanProperties {

    /** API Key，形如 bce-v3/... */
    private String apiKey = "";

    /** 模型名，如 deepseek-r1-distill-qianfan-70b */
    private String model = "deepseek-r1-distill-qianfan-70b";
}
