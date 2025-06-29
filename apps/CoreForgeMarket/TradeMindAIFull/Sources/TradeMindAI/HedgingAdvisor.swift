import Foundation

/// Provides basic hedging recommendations based on volatility.
public struct HedgingAdvisor {
    public init() {}

    public func suggestHedge(volatility: Double) -> String {
        switch volatility {
        case ..<0.2:
            return "No hedge needed"
        case ..<0.5:
            return "Consider protective puts"
        default:
            return "Strong hedge recommended"
        }
    }
}
