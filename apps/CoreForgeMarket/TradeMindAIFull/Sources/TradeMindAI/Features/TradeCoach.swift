import Foundation

public struct TradeDecision {
    public let entry: Double
    public let exit: Double

    public init(entry: Double, exit: Double) {
        self.entry = entry
        self.exit = exit
    }
}

public struct TradeCoach {
    public init() {}

    public func grade(decision: TradeDecision) -> String {
        let profit = decision.exit - decision.entry
        switch profit {
        case ..<0:
            return "Poor"
        case 0..<1:
            return "Average"
        default:
            return "Good"
        }
    }
}
