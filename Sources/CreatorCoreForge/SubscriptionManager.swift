import Foundation

/// Simple subscription handler that tracks active plans.
public final class SubscriptionManager {
    public enum Plan: String {
        case free
        case creator
        case enterprise
    }

    public private(set) var activePlan: Plan

    public init(plan: Plan = .free) {
        self.activePlan = plan
    }

    public func upgrade(to plan: Plan) {
        activePlan = plan
    }
}
