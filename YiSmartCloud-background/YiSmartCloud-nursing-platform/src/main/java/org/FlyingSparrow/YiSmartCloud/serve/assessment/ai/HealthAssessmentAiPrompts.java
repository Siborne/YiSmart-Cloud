package org.FlyingSparrow.YiSmartCloud.serve.assessment.ai;

/**
 * User message template for health-report analysis (output must be JSON only).
 */
public final class HealthAssessmentAiPrompts {

    private HealthAssessmentAiPrompts() {
    }

    public static String buildUserMessage(String reportPlainText) {
        return ""
                + "\u8bf7\u4ee5\u4e00\u4e2a\u4e13\u4e1a\u533b\u751f\u7684\u89c6\u89d2\u6765\u5206\u6790\u8fd9\u4efd\u4f53\u68c0\u62a5\u544a\uff0c\u62a5\u544a\u4e2d\u5305\u542b\u4e86\u4e00\u4e9b\u5f02\u5e38\u6570\u636e\uff0c\u6211\u9700\u8981\u60a8\u5bf9\u8fd9\u4e9b\u6570\u636e\u8fdb\u884c\u89e3\u8bfb\uff0c\u5e76\u7ed9\u51fa\u76f8\u5e94\u7684\u5065\u5eb7\u5efa\u8bae\u3002\n"
                + "\u4f53\u68c0\u5185\u5bb9\u5982\u4e0b\uff1a\n"
                + reportPlainText
                + "\n\n"
                + "\u8981\u6c42\uff1a\n"
                + "1. \u63d0\u53d6\u4f53\u68c0\u62a5\u544a\u4e2d\u7684\u300c\u603b\u68c0\u65e5\u671f\u300d\uff1b\n"
                + "2. \u901a\u8fc7\u4e34\u5e8a\u533b\u5b66\u3001\u75be\u75c5\u98ce\u9669\u8bc4\u4f30\u6a21\u578b\u548c\u6570\u636e\u667a\u80fd\u5206\u6790\uff0c\u7ed9\u8be5\u7528\u6237\u7684\u98ce\u9669\u7b49\u7ea7\u548c\u5065\u5eb7\u6307\u6570\u7ed9\u51fa\u7ed3\u679c\u3002"
                + "\u98ce\u9669\u7b49\u7ea7\u5206\u4e3a\uff1a\u5065\u5eb7\u3001\u63d0\u793a\u3001\u98ce\u9669\u3001\u5371\u9669\u3001\u4e25\u91cd\u5371\u9669\uff08\u8f93\u51fa\u82f1\u6587\u679a\u4e3e\uff1ahealthy\u3001caution\u3001risk\u3001danger\u3001severeDanger\uff09\u3002"
                + "\u5065\u5eb7\u6307\u6570\u8303\u56f4\u4e3a0\u81f3100\u5206\uff1b\n"
                + "3. \u6839\u636e\u7528\u6237\u8eab\u4f53\u5404\u9879\u6307\u6807\u6570\u636e\uff0c\u8be6\u7ec6\u8bf4\u660e\u8be5\u7528\u6237\u5404\u9879\u98ce\u9669\u7b49\u7ea7\u7684\u5360\u6bd4\u662f\u591a\u5c11\uff0c\u6700\u591a\u4fdd\u7559\u4e24\u4f4d\u5c0f\u6570\uff1b\n"
                + "4. \u5bf9\u4e8e\u4f53\u68c0\u62a5\u544a\u6709\u5f02\u5e38\u6570\u636e\uff0c\u8bf7\u5217\u51fa\uff08\u5f02\u5e38\u6570\u636e\u7684\u7ed3\u8bba\u3001\u4f53\u68c0\u9879\u76ee\u540d\u79f0\u3001\u68c0\u67e5\u7ed3\u679c\u3001\u53c2\u8003\u503c\u3001\u5355\u4f4d\u3001\u5f02\u5e38\u89e3\u8bfb\u3001\u5efa\u8bae\uff09\u7b49\u5b57\u6bb5\uff1b\n"
                + "5. \u6839\u636e\u8fd9\u4e2a\u4f53\u68c0\u62a5\u544a\u7684\u5185\u5bb9\uff0c\u5206\u522b\u7ed9\u4eba\u4f53\u76848\u5927\u7cfb\u7edf\u6253\u5206\uff0c\u6bcf\u9879\u6ee1\u5206\u4e3a100\u5206\uff0c8\u5927\u7cfb\u7edf\u5206\u522b\u4e3a\uff1a"
                + "\u547c\u5438\u7cfb\u7edf\u3001\u6d88\u5316\u7cfb\u7edf\u3001\u5185\u5206\u6ccc\u7cfb\u7edf\u3001\u514d\u75ab\u7cfb\u7edf\u3001\u5faa\u73af\u7cfb\u7edf\u3001\u6ccc\u5c3f\u7cfb\u7edf\u3001\u8fd0\u52a8\u7cfb\u7edf\u3001\u611f\u5b98\u7cfb\u7edf\uff1b\n"
                + "6. \u7ed9\u4f53\u68c0\u62a5\u544a\u505a\u4e00\u4e2a\u603b\u7ed3\u3002\n\n"
                + "\u8f93\u51fa\u8981\u6c42\uff1a\n"
                + "\u6700\u540e\uff0c\u5c06\u4ee5\u4e0a\u7ed3\u679c\u8f93\u51fa\u4e3aJSON\u683c\u5f0f\uff0c\u4e0d\u8981\u5305\u542b\u5176\u4ed6\u7684\u6587\u5b57\u8bf4\u660e\uff0c\u6240\u6709\u7684\u8fd4\u56de\u7ed3\u679c\u90fd\u662fjson\uff0c\u8be6\u7ec6\u683c\u5f0f\u5982\u4e0b\uff1a\n"
                + "{\n"
                + "  \"totalCheckDate\": \"YYYY-MM-DD\",\n"
                + "  \"healthAssessment\": {\n"
                + "    \"riskLevel\": \"healthy/caution/risk/danger/severeDanger\",\n"
                + "    \"healthIndex\": XX.XX\n"
                + "  },\n"
                + "  \"riskDistribution\": {\n"
                + "    \"healthy\": XX.XX,\n"
                + "    \"caution\": XX.XX,\n"
                + "    \"risk\": XX.XX,\n"
                + "    \"danger\": XX.XX,\n"
                + "    \"severeDanger\": XX.XX\n"
                + "  },\n"
                + "  \"abnormalData\": [\n"
                + "    {\n"
                + "      \"conclusion\": \"\u5f02\u5e38\u6570\u636e\u7684\u7ed3\u8bba\",\n"
                + "      \"examinationItem\": \"\u4f53\u68c0\u9879\u76ee\u540d\u79f0\",\n"
                + "      \"result\": \"\u68c0\u67e5\u7ed3\u679c\",\n"
                + "      \"referenceValue\": \"\u53c2\u8003\u503c\",\n"
                + "      \"unit\": \"\u5355\u4f4d\",\n"
                + "      \"interpret\":\"\u5bf9\u4e8e\u5f02\u5e38\u7684\u7ed3\u8bba\u8fdb\u4e00\u6b65\u8be6\u7ec6\u7684\u8bf4\u660e\",\n"
                + "      \"advice\":\"\u9488\u5bf9\u4e8e\u8fd9\u4e00\u9879\u7684\u5f02\u5e38\uff0c\u7ed9\u51fa\u4e00\u4e9b\u5065\u5eb7\u7684\u5efa\u8bae\"\n"
                + "    }\n"
                + "  ],\n"
                + "  \"systemScore\": {\n"
                + "    \"breathingSystem\": XX,\n"
                + "    \"digestiveSystem\": XX,\n"
                + "    \"endocrineSystem\": XX,\n"
                + "    \"immuneSystem\": XX,\n"
                + "    \"circulatorySystem\": XX,\n"
                + "    \"urinarySystem\": XX,\n"
                + "    \"motionSystem\": XX,\n"
                + "    \"senseSystem\": XX\n"
                + "  },\n"
                + "  \"summarize\": \"\u4f53\u68c0\u62a5\u544a\u7684\u603b\u7ed3\"\n"
                + "}\n";
    }
}
