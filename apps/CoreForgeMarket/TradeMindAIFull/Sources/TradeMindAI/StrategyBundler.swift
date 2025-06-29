import Foundation

/// Bundles a list of strategy names into a course kit.
public struct StrategyBundle {
    public let title: String
    public let strategies: [String]
}

public struct StrategyBundler {
    public init() {}

    public func bundle(strategies: [String], title: String = "My Course") -> StrategyBundle {
        return StrategyBundle(title: title, strategies: strategies)
    }
}
