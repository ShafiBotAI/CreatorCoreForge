import Foundation

/// Simple heuristic engine for adaptive reasoning.
public final class AdaptiveReasoner {
    private var recentContext: [String] = []

    public init() {}

    /// Record context that influences reasoning decisions.
    public func log(_ item: String) {
        recentContext.append(item)
    }

    /// Produce a basic next action suggestion based on the context and goal.
    public func nextAction(toward goal: String) -> String {
        let context = recentContext.joined(separator: " ").lowercased()
        if context.contains("error") || context.contains("issue") {
            return "Investigate problems before continuing toward \(goal)"
        } else if recentContext.count > 5 {
            return "Summarize progress and refine plan for \(goal)"
        } else {
            return "Continue with current approach toward \(goal)"
        }
    }

    /// Clear all recorded context.
    public func reset() {
        recentContext.removeAll()
    }
}
