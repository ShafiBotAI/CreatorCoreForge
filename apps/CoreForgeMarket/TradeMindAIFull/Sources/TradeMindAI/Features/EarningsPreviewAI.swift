import Foundation

/// Provides a naive earnings forecast based on past EPS.
public struct EarningsPreviewAI {
    public init() {}

    public func forecast(previousEPS: [Double]) -> Double {
        guard !previousEPS.isEmpty else { return 0 }
        return previousEPS.reduce(0, +) / Double(previousEPS.count)
    }
}
