import Foundation

/// Tracks progress and suggests next actions using a simple success/failure heuristic.
public final class EnhancedReasoner {
    private var context: [String] = []
    private var successCount = 0
    private var failureCount = 0

    public init() {}

    /// Record context that influences reasoning decisions.
    public func log(_ item: String) {
        context.append(item)
        let lower = item.lowercased()
        if lower.contains("error") || lower.contains("fail") {
            failureCount += 1
        }
        if lower.contains("success") || lower.contains("completed") || lower.contains("done") {
            successCount += 1
        }
    }

    /// Score progress from 0.0 (all failures) to 1.0 (all successes). 0.5 means neutral.
    public func progressScore() -> Double {
        let total = successCount + failureCount
        guard total > 0 else { return 0.5 }
        return Double(successCount) / Double(total)
    }

    /// Suggest the next action to take toward the goal based on logged context.
    public func nextAction(toward goal: String) -> String {
        if failureCount > successCount {
            return "Debug recent issues before continuing toward \(goal)"
        }
        if successCount >= 3 && context.count >= 5 {
            return "Summarize achievements and plan next steps toward \(goal)"
        }
        return "Proceed with tasks toward \(goal)"
    }

    /// Clear recorded context and counters.
    public func reset() {
        context.removeAll()
        successCount = 0
        failureCount = 0
    }
}
