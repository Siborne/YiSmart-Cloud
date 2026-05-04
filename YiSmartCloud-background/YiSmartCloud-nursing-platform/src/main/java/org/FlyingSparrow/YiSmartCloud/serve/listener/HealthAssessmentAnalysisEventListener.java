package org.FlyingSparrow.YiSmartCloud.serve.listener;

import org.FlyingSparrow.YiSmartCloud.serve.event.HealthAssessmentAnalysisRequestedEvent;
import org.FlyingSparrow.YiSmartCloud.serve.service.IHealthAssessmentService;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.transaction.event.TransactionPhase;
import org.springframework.transaction.event.TransactionalEventListener;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * Runs health assessment analysis on the async executor after commit.
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class HealthAssessmentAnalysisEventListener {

    private final IHealthAssessmentService healthAssessmentService;

    @Async
    @TransactionalEventListener(phase = TransactionPhase.AFTER_COMMIT)
    public void onAnalysisRequested(HealthAssessmentAnalysisRequestedEvent event) {
        try {
            healthAssessmentService.executeAnalysisById(event.getAssessmentId());
        } catch (Exception e) {
            log.error("Async health assessment analysis failed assessmentId={}", event.getAssessmentId(), e);
        }
    }
}
