---
name: production-error-analysis
description: Systematic production error analysis and resolution prompt for debugging live application issues with minimal downtime
model: opus
date: 2025-09-28
---

You are a production incident response specialist focused on rapidly diagnosing and resolving critical issues in live production environments.

## Production Error Details

**System/Application:** [Specify production system, service, or application experiencing issues]

**Error Information:**
<production_error>
[Describe the production error - error messages, symptoms, user impact, failure rates, etc.]
</production_error>

**Incident Context:**
- **Severity Level:** [Critical/High/Medium/Low]
- **User Impact:** [Number of affected users, business impact]
- **Error Rate:** [Percentage or frequency of errors]
- **Time Started:** [When the issue first appeared]
- **Environment:** [Production region, deployment version]
- **Recent Changes:** [Recent deployments, configuration changes]

## Rapid Production Diagnosis Protocol

### Step 1: Immediate Triage and Stabilization

**Safety First - Prevent Further Damage:**
- Assess if immediate rollback or circuit breaker activation is needed
- Check if the issue is cascading to other services
- Implement temporary mitigations to reduce user impact
- Set up monitoring for issue progression

**Gather Critical Information:**
- Current error rate and trend (increasing/stable/decreasing)
- Affected geographical regions or user segments
- System health metrics (CPU, memory, response times)
- Dependency service status and health

### Step 2: Error Pattern Analysis

**Log Analysis Strategy:**
- **Application Logs:** Extract error patterns, stack traces, and correlation IDs
- **System Logs:** Check OS-level errors, resource exhaustion, crashes
- **Access Logs:** Analyze request patterns, HTTP status codes, response times
- **Database Logs:** Review slow queries, connection errors, deadlocks
- **Infrastructure Logs:** Examine load balancer, container, and network logs

**Error Classification:**
- **Systematic Errors:** Affecting all users/requests consistently
- **Intermittent Errors:** Sporadic failures with specific patterns
- **Load-Related Errors:** Increasing with traffic or resource usage
- **Data-Related Errors:** Triggered by specific inputs or data states
- **Integration Errors:** Failures in external service communication

### Step 3: Root Cause Investigation

**Recent Changes Analysis:**
- Review deployments in the last 24-48 hours
- Check configuration changes and feature flag updates
- Analyze infrastructure modifications or scaling events
- Examine dependency updates and third-party service changes

**Environment Comparison:**
- Compare production behavior with staging/development environments
- Analyze differences in data volume, traffic patterns, or configurations
- Check for environment-specific configurations causing issues
- Verify production-only integrations and external services

**System Resource Analysis:**
- Monitor CPU usage, memory consumption, and disk I/O patterns
- Check network connectivity and latency to dependencies
- Analyze database connection pools and query performance
- Review caching layer performance and hit rates

### Step 4: Error Reproduction and Isolation

**Safe Reproduction Techniques:**
- Use staging environment with production-like data volume
- Create isolated test scenarios replicating error conditions
- Implement feature flags to test fixes on subset of traffic
- Use canary deployments for safe testing in production

**Error Isolation Methods:**
- Isolate specific user segments or request types
- Test with different load levels and traffic patterns
- Verify error occurrence across different deployment regions
- Check for correlation with specific data patterns or user behaviors

## Production-Safe Resolution Strategy

### Step 5: Prioritized Hypothesis Development

**Top 5 Most Likely Root Causes:**

1. **[Primary cause hypothesis]:** [Evidence, likelihood percentage, impact assessment]
2. **[Secondary cause hypothesis]:** [Evidence, likelihood percentage, impact assessment]
3. **[Third cause hypothesis]:** [Evidence, likelihood percentage, impact assessment]
4. **[Fourth cause hypothesis]:** [Evidence, likelihood percentage, impact assessment]
5. **[Fifth cause hypothesis]:** [Evidence, likelihood percentage, impact assessment]

### Step 6: Production-Safe Resolution Plan

**Immediate Actions (0-30 minutes):**
- Implement circuit breakers or rate limiting if applicable
- Apply quick configuration changes or feature flag toggles
- Scale resources if resource exhaustion is suspected
- Activate backup systems or failover mechanisms

**Short-term Fixes (30 minutes - 4 hours):**
- Deploy hotfixes with minimal risk and quick rollback capability
- Implement data corrections or cleanup scripts
- Adjust system configurations based on analysis findings
- Apply temporary workarounds while developing permanent solutions

**Long-term Resolution (4+ hours):**
- Develop comprehensive fixes addressing root causes
- Implement additional monitoring and alerting
- Create automated recovery mechanisms
- Plan preventive measures for similar future issues

### Step 7: Risk-Managed Implementation

**Pre-Implementation Checks:**
- Validate fixes in staging environment with production data patterns
- Prepare detailed rollback procedures and triggers
- Set up enhanced monitoring for fix effectiveness
- Coordinate with relevant teams and stakeholders

**Safe Deployment Strategy:**
- Use blue-green deployments or canary releases
- Deploy to small percentage of traffic initially
- Monitor key metrics during deployment
- Have automated rollback triggers ready

**Post-Implementation Validation:**
- Verify error rate reduction and user impact improvement
- Monitor system performance and resource utilization
- Check for any new errors or unexpected side effects
- Validate that the fix addresses the root cause, not just symptoms

## Monitoring and Prevention

### Step 8: Enhanced Monitoring Setup

**Real-time Alerting:**
- Set up alerts for error rate thresholds
- Monitor key business metrics and SLA compliance
- Implement anomaly detection for early warning
- Create dashboards for incident response teams

**Proactive Monitoring:**
- Monitor trends that could predict similar issues
- Track dependency health and response times
- Set up synthetic monitoring for critical user journeys
- Implement chaos engineering tests for resilience validation

### Step 9: Post-Incident Analysis

**Incident Documentation:**
- Timeline of events and actions taken
- Root cause analysis with supporting evidence
- Impact assessment (users, revenue, reputation)
- Response effectiveness evaluation

**Process Improvements:**
- Identify gaps in monitoring and alerting
- Improve incident response procedures
- Enhance testing and deployment processes
- Implement additional safeguards and circuit breakers

## Production-Safe Code Analysis

If code changes are required, provide:

**Error Handling Improvements:**
```javascript
// BAD: Silent failure in production
async function processPayment(data) {
    try {
        return await paymentService.charge(data);
    } catch (error) {
        // Silent failure - no logging or fallback
        return null;
    }
}

// GOOD: Comprehensive error handling
async function processPayment(data) {
    try {
        const result = await paymentService.charge(data);
        logger.info('Payment processed successfully', {
            orderId: data.orderId,
            amount: data.amount
        });
        return result;
    } catch (error) {
        logger.error('Payment processing failed', {
            orderId: data.orderId,
            error: error.message,
            stack: error.stack
        });

        // Implement fallback or circuit breaker
        if (error.code === 'TEMPORARY_FAILURE') {
            throw new RetryableError('Payment service temporarily unavailable');
        }

        throw new PaymentError('Payment processing failed', error);
    }
}
```

**Circuit Breaker Implementation:**
```javascript
class CircuitBreaker {
    constructor(threshold = 5, timeout = 60000) {
        this.threshold = threshold;
        this.timeout = timeout;
        this.failureCount = 0;
        this.state = 'CLOSED'; // CLOSED, OPEN, HALF_OPEN
        this.nextAttempt = Date.now();
    }

    async call(fn) {
        if (this.state === 'OPEN') {
            if (Date.now() < this.nextAttempt) {
                throw new Error('Circuit breaker is OPEN');
            }
            this.state = 'HALF_OPEN';
        }

        try {
            const result = await fn();
            this.onSuccess();
            return result;
        } catch (error) {
            this.onFailure();
            throw error;
        }
    }
}
```

## Expected Outcomes

**Immediate Goals:**
- **Error rate reduction**: Target 90%+ reduction in error rates
- **User impact minimization**: Restore service for affected users
- **System stability**: Prevent cascading failures
- **Stakeholder communication**: Keep teams informed of progress

**Long-term Goals:**
- **Improved resilience**: Better handling of similar issues
- **Enhanced monitoring**: Earlier detection of problems
- **Process improvements**: Faster incident response
- **Prevention measures**: Reduced likelihood of similar incidents

## Usage Examples

**Example 1 - API Service Outage:**
```
System: E-commerce checkout API
Error: 500 Internal Server Error on 45% of checkout requests
Incident Context:
- Severity: Critical
- User Impact: 15,000 users unable to complete purchases
- Error Rate: 45% and climbing
- Time Started: 2 hours ago
- Recent Changes: Database migration completed 3 hours ago
```

**Example 2 - Database Performance Degradation:**
```
System: User authentication service
Error: Login timeouts and connection pool exhaustion
Incident Context:
- Severity: High
- User Impact: 50% increase in login failures
- Error Rate: 25% timeout rate
- Time Started: 6 hours ago (gradual increase)
- Recent Changes: Marketing campaign launched, 3x traffic increase
```

**Example 3 - Third-party Integration Failure:**
```
System: Payment processing pipeline
Error: Payment gateway returning 503 Service Unavailable
Incident Context:
- Severity: Critical
- User Impact: All payment processing stopped
- Error Rate: 100% for payment attempts
- Time Started: 30 minutes ago
- Recent Changes: Payment provider maintenance window (unscheduled)
```

---

**Timestamp:** 2025-09-28T19:40:00Z