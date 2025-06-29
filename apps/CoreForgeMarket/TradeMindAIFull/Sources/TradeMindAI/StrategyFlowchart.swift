import Foundation

/// Simple in-memory representation of trade logic steps.
public final class StrategyFlowchart {
    private(set) var steps: [String] = []
    public init() {}

    public func addStep(_ step: String) {
        steps.append(step)
    }
}
