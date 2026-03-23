package org.FlyingSparrow.YiSmartCloud.oss;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

@Data
@Component
@ConfigurationProperties(prefix = "aliyun.oss")
public class AliyunOSSProperties {
    private String endpoint;
    private String bucketName;
    // accessKeyId和accessKeySecret是占位放报错的，实际上是通过获取系统变量读取的
    private String accessKeyId;
    private String accessKeySecret;

    // 添加这个方法，启动时会自动执行
//    @PostConstruct
//    public void init() {
//        System.out.println("=================================");
//        System.out.println("正在检查配置加载情况...");
//        System.out.println("1. endpoint 值: [" + endpoint + "]");
//        System.out.println("2. bucketName 值: [" + bucketName + "]");
//
//        // 强制读取系统属性，看看底层有没有
//        String rawEndpoint = System.getProperty("aliyun.oss.endpoint");
//        System.out.println("3. 系统属性里有没有: [" + rawEndpoint + "]");
//        System.out.println("=================================");
//    }
}
