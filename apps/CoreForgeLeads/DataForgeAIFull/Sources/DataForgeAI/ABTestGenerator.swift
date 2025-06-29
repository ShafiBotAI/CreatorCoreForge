import Foundation

/// Produces simple A/B test variants for marketing messages.
public struct ABTestGenerator {
    public init() {}

    public func generateVariants(base: String) -> [String] {
        [base + "!", base.replacingOccurrences(of: "offer", with: "deal")]
    }
}
