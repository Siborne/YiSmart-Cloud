package org.FlyingSparrow.YiSmartCloud.serve.constant;

/**
 * AI analysis status codes for async health assessment jobs.
 */
public final class HealthAssessmentAnalysisStatuses {

    private HealthAssessmentAnalysisStatuses() {
    }

    /** Analysis in progress */
    public static final int PENDING = 0;
    /** Analysis completed */
    public static final int COMPLETED = 1;
    /** Analysis failed */
    public static final int FAILED = 2;
}
