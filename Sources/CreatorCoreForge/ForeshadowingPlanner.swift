import Foundation

/// Generates foreshadowing hints for upcoming events.
public struct ForeshadowingPlanner {
    public init() {}

    /// Create short hint strings for each event description.
    public func generateSeeds(from events: [String]) -> [String] {
        events.map { event in
            let words = event.split(separator: " ")
            let hint = words.prefix(3).joined(separator: " ")
            return "Hint: \(hint)..."
        }
    }
}
