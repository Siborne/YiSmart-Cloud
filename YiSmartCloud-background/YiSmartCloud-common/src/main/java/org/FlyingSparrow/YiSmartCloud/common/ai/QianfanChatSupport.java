package org.FlyingSparrow.YiSmartCloud.common.ai;

import com.openai.client.OpenAIClient;
import com.openai.client.okhttp.OpenAIOkHttpClient;
import com.openai.models.ChatCompletion;
import com.openai.models.ChatCompletionCreateParams;

/**
 * 百度千帆 ModelBuilder OpenAI 兼容对话（Chat Completions）。
 *
 * @see <a href="https://cloud.baidu.com/doc/qianfan-docs/s/nm9l6oc8e">Java SDK 调用对话 Chat</a>
 */
public final class QianfanChatSupport {

    /** 千帆 OpenAI 兼容网关（v2） */
    public static final String QIANFAN_OPENAI_COMPAT_BASE_URL = "https://qianfan.baidubce.com/v2/";

    private QianfanChatSupport() {
    }

    public static OpenAIClient createClient(String apiKey) {
        return OpenAIOkHttpClient.builder()
                .apiKey(apiKey)
                .baseUrl(QIANFAN_OPENAI_COMPAT_BASE_URL)
                .build();
    }

    /**
     * 非流式单次对话，返回助手文本（若无正文则返回空串）。
     */
    public static String chat(OpenAIClient client, String model, String userMessage) {
        ChatCompletionCreateParams params = ChatCompletionCreateParams.builder()
                .addUserMessage(userMessage)
                .model(model)
                .build();
        ChatCompletion completion = client.chat().completions().create(params);
        return completion.choices().get(0).message().content().orElse("");
    }
}
