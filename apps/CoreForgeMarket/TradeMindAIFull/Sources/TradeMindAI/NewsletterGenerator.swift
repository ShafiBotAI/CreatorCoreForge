import Foundation

/// Generates a simple text newsletter summarizing portfolio strategy.
public struct NewsletterGenerator {
    public init() {}

    public func generate(portfolio: [String: Double]) -> String {
        let total = portfolio.values.reduce(0, +)
        let top = portfolio.sorted { $0.value > $1.value }.prefix(3)
        let headline = "Top holdings: " + top.map { "\($0.key) \(String(format: "%.1f%%", $0.value / total * 100))" }.joined(separator: ", ")
        return "Strategy Update:\n" + headline
    }
}
