import Foundation

/// Lightweight forecasting engine using an exponential moving average.
public final class TitanEngine {
    private var history: [Double] = []
    private let smoothing: Double

    public init(smoothing: Double = 0.3) {
        self.smoothing = smoothing
    }

    public func log(price: Double) {
        history.append(price)
    }

    /// Returns the next predicted value using EMA of the logged prices.
    public func forecastNext() -> Double? {
        guard !history.isEmpty else { return nil }
        var ema = history[0]
        for value in history.dropFirst() {
            ema = smoothing * value + (1 - smoothing) * ema
        }
        return ema
    }
}
