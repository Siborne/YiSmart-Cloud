import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.common.auth.CredentialsProviderFactory;
import com.aliyun.oss.common.auth.EnvironmentVariableCredentialsProvider;
import com.aliyun.oss.model.BucketInfo;

public class OssTest {

    // ⚠️ 请替换为你真实的 Endpoint (例如：oss-cn-guangzhou.aliyuncs.com)
    // 注意：这里不要带 http:// 或 https://，除非你的 SDK 版本很老，通常只填域名
    private static final String ENDPOINT = "oss-cn-beijing.aliyuncs.com";

    // ⚠️ 请替换为你真实的 Bucket 名称
    private static final String BUCKET_NAME = "yismart-could";

    public static void main(String[] args) {
        String homeDir = System.getenv("OSS_ACCESS_KEY_ID");
        String homeDir2 = System.getenv("OSS_ACCESS_KEY_SECRET");
        System.out.println(homeDir);
        System.out.println(homeDir2);

    }

    public static void test1(String[] args) {
        System.out.println("=== 开始测试环境变量读取 ===");

        try {
            // 1. 尝试创建凭证提供者
            // 这一步通常不会报错，因为它只是初始化对象，还没去读变量
            EnvironmentVariableCredentialsProvider provider =
                    CredentialsProviderFactory.newEnvironmentVariableCredentialsProvider();

            System.out.println("✅ CredentialsProvider 对象创建成功: " + provider.getClass().getSimpleName());

            // 2. 【关键步骤】尝试构建 OSS 客户端
            // build() 方法内部会调用 provider.getCredentials()，如果环境变量为空，这里会直接抛异常！
            System.out.println("⏳ 正在尝试构建 OSS 客户端 (这将触发环境变量读取)...");
            OSS ossClient = new OSSClientBuilder().build(ENDPOINT, provider);

            System.out.println("✅ OSS 客户端构建成功！说明环境变量 [OSS_ACCESS_KEY_ID] 和 [OSS_ACCESS_KEY_SECRET] 已正确读取。");

            // 3. 【双重保险】尝试做一个极轻量的请求 (获取 Bucket 信息)
            // 如果 Key 是假的或者权限不对，这里会报 SignatureDoesNotMatch 或 AccessDenied
            System.out.println("⏳ 正在尝试连接阿里云 OSS 获取 Bucket 信息...");
            BucketInfo info = ossClient.getBucketInfo(BUCKET_NAME);

            System.out.println("🎉 测试完全成功！");
            System.out.println("   - Bucket: " + info.getBucket().getName());
            System.out.println("   - Location: " + info.getBucket().getLocation());
            System.out.println("   - CreationDate: " + info.getBucket().getCreationDate());

            // 关闭客户端
            ossClient.shutdown();

        } catch (IllegalArgumentException e) {
            // 捕获特定的“密钥为空”异常
            System.err.println("❌ 失败原因：环境变量未找到或为空！");
            System.err.println("   错误详情：" + e.getMessage());
            System.err.println("   请检查系统环境变量中是否存在：");
            System.err.println("   1. OSS_ACCESS_KEY_ID");
            System.err.println("   2. OSS_ACCESS_KEY_SECRET");
            e.printStackTrace();
        } catch (Exception e) {
            // 其他异常（如网络错误、签名错误、Bucket 不存在）
            System.err.println("❌ 发生其他错误（可能是 Key 错了，或者网络问题）：");
            e.printStackTrace();
        }
    }

}
