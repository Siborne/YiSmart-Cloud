package org.FlyingSparrow.YiSmartCloud.ai;

import com.openai.client.OpenAIClient;
import org.FlyingSparrow.YiSmartCloud.common.ai.QianfanChatSupport;
import org.junit.jupiter.api.Assumptions;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertFalse;

/**
 * Integration test for Baidu Qianfan OpenAI-compatible Chat API (needs outbound HTTPS).
 * Doc: https://cloud.baidu.com/doc/qianfan-docs/s/nm9l6oc8e
 * <p>
 * Set {@link #API_KEY} to your real key for a live call; rotate the key after testing. Do not commit secrets.
 */
class QianfanChatIntegrationTest {

    private static final String API_KEY = "your_APIKey";

    private static final String MODEL = "deepseek-r1-distill-qianfan-70b";

    @Test
    void qianfanNonStreamingChat_returnsAssistantText() {
        Assumptions.assumeFalse(
                API_KEY == null
                        || API_KEY.isBlank()
                        || "your_APIKey".equals(API_KEY),
                "Set API_KEY in QianfanChatIntegrationTest to a real key before running this test.");

        OpenAIClient client = QianfanChatSupport.createClient(API_KEY);
        String reply = QianfanChatSupport.chat(client, MODEL, "Say hello in one short sentence.");

        assertFalse(reply.isBlank(), "expected non-empty model reply");
    }
}
