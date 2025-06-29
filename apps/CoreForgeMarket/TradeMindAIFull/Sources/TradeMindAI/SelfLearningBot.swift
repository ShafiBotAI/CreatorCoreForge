import Foundation

/// Basic reinforcement learning style bot that updates a simple weight.
public final class SelfLearningBot {
    private var weight: Double
    public init(weight: Double = 0.5) { self.weight = weight }

    /// Update internal weight using reward feedback and return new weight.
    public func update(reward: Double) -> Double {
        weight += 0.1 * reward
        weight = min(max(weight, 0), 1)
        return weight
    }

    /// Generate a trivial trade signal based on current weight.
    public func tradeSignal() -> String {
        return weight > 0.5 ? "buy" : "hold"
    }
}
