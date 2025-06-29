import Foundation

/// Combines sentiment score with a technical indicator value.
public struct SentimentTAOverlay {
    public init() {}

    /// Weighted overlay result.
    public func overlay(sentiment: Double, indicator: Double) -> Double {
        return (sentiment + indicator) / 2
    }
}
