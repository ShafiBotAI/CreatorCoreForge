import Foundation

/// Tracks the lifecycle stage of a lead.
public final class LeadLifecycleTracker {
    public enum Stage: String { case cold, engaged, qualified, closed }

    private var stages: [String: Stage] = [:]

    public init() {}

    public func update(lead: Lead, to stage: Stage) {
        stages[lead.email] = stage
    }

    public func stage(for lead: Lead) -> Stage? {
        stages[lead.email]
    }
}
