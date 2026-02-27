package org.FlyingSparrow.YiSmartCloud;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * 启动程序
 * 
 * @author ruoyi
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class YiSmartCloudApplication
{
    public static void main(String[] args)
    {
        // System.setProperty("spring.devtools.restart.enabled", "false");
        SpringApplication.run(YiSmartCloudApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  颐智云启动成功   ლ(´ڡ`ლ)ﾞ  \n" +
                " __   ___    ____                       _       ____            _     _ \n" +
                " \\ \\ / (_)  / ___| _ __ ___   __ _ _ __| |_    / ___|___  _   _| | __| |\n" +
                "  \\ V /| |  \\___ \\| '_ ` _ \\ / _` | '__| __|  | |   / _ \\| | | | |/ _` |\n" +
                "   | | | |   ___) | | | | | | (_| | |  | |_   | |__| (_) | |_| | | (_| |\n" +
                "   |_| |_|  |____/|_| |_| |_|\\__,_|_|   \\__|   \\____\\___/ \\__,_|_|\\__,_|\n" +
                "                                                                        \n");
    }
}
