package org.FlyingSparrow.YiSmartCloud.serve.service;

import org.FlyingSparrow.YiSmartCloud.common.utils.StringUtils;

/**
 * 从大模型返回文本中提取 JSON 对象字符串。
 */
public final class HealthAssessmentAiJsonExtractor {

    private HealthAssessmentAiJsonExtractor() {
    }

    public static String extractJsonObject(String raw) {
        if (StringUtils.isEmpty(raw)) {
            return null;
        }
        String s = raw.trim();
        if (s.startsWith("```")) {
            int nl = s.indexOf('\n');
            if (nl > 0) {
                s = s.substring(nl + 1);
            }
            int fence = s.lastIndexOf("```");
            if (fence >= 0) {
                s = s.substring(0, fence).trim();
            }
        }
        int a = s.indexOf('{');
        int b = s.lastIndexOf('}');
        if (a >= 0 && b > a) {
            return s.substring(a, b + 1);
        }
        return s;
    }
}
