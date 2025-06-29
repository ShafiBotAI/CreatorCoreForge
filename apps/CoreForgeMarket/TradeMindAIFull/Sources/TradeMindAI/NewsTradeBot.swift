import Foundation

/// Generates basic trade ideas from news headline keywords.
public struct NewsTradeBot {
    public init() {}

    public func idea(from headline: String) -> String {
        let lower = headline.lowercased()
        if lower.contains("earnings") { return "consider buy" }
        if lower.contains("lawsuit") { return "consider sell" }
        return "hold"
    }
}
