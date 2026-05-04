package org.FlyingSparrow.YiSmartCloud.serve.service;

/**
 * 千帆分析体检报告的用户消息模板（输出须为纯 JSON）。
 */
public final class HealthAssessmentAiPrompts {

    private HealthAssessmentAiPrompts() {
    }

    public static String buildUserMessage(String reportPlainText) {
        return ""
                + "请以一个专业医生的视角来分析这份体检报告，报告中包含了一些异常数据，我需要您对这些数据进行解读，并给出相应的健康建议。\n"
                + "体检内容如下：\n"
                + reportPlainText
                + "\n\n"
                + "要求：\n"
                + "1. 提取体检报告中的「总检日期」；\n"
                + "2. 通过临床医学、疾病风险评估模型和数据智能分析，给该用户的风险等级和健康指数给出结果。"
                + "风险等级分为：健康、提示、风险、危险、严重危险（输出英文枚举：healthy、caution、risk、danger、severeDanger）。"
                + "健康指数范围为0至100分；\n"
                + "3. 根据用户身体各项指标数据，详细说明该用户各项风险等级的占比是多少，最多保留两位小数；\n"
                + "4. 对于体检报告有异常数据，请列出（异常数据的结论、体检项目名称、检查结果、参考值、单位、异常解读、建议）等字段；\n"
                + "5. 根据这个体检报告的内容，分别给人体的8大系统打分，每项满分为100分，8大系统分别为："
                + "呼吸系统、消化系统、内分泌系统、免疫系统、循环系统、泌尿系统、运动系统、感官系统；\n"
                + "6. 给体检报告做一个总结。\n\n"
                + "输出要求：\n"
                + "最后，将以上结果输出为JSON格式，不要包含其他的文字说明，所有的返回结果都是json，详细格式如下：\n"
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
                + "      \"conclusion\": \"异常数据的结论\",\n"
                + "      \"examinationItem\": \"体检项目名称\",\n"
                + "      \"result\": \"检查结果\",\n"
                + "      \"referenceValue\": \"参考值\",\n"
                + "      \"unit\": \"单位\",\n"
                + "      \"interpret\":\"对于异常的结论进一步详细的说明\",\n"
                + "      \"advice\":\"针对于这一项的异常，给出一些健康的建议\"\n"
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
                + "  \"summarize\": \"体检报告的总结\"\n"
                + "}\n";
    }
}
