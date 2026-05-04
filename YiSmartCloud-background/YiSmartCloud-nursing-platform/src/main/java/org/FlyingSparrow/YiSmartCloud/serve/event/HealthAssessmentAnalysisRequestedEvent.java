package org.FlyingSparrow.YiSmartCloud.serve.event;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * Published after transaction commit to trigger async Qianfan analysis.
 */
@Getter
@RequiredArgsConstructor
public class HealthAssessmentAnalysisRequestedEvent {

    private final Long assessmentId;
}
