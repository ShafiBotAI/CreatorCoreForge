import Foundation

/// Simple forecasting engine placeholder.
public final class TitanEngine {
    private var history: [Double] = []

    public init() {}

    public func log(price: Double) {
        history.append(price)
    }

    /// Return a naive forecast based on average change.
    public func forecastNext() -> Double? {
        guard history.count > 1 else { return history.last }
        let deltas = zip(history.dropFirst(), history).map(-)
        let avg = deltas.reduce(0, +) / Double(deltas.count)
        return history.last.map { $0 + avg }
    }
}
