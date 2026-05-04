package org.FlyingSparrow.YiSmartCloud.serve.assessment.ai;

import org.FlyingSparrow.YiSmartCloud.common.utils.StringUtils;

/**
 * Extract a JSON object substring from LLM raw text.
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
