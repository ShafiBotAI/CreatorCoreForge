import Foundation

/// Errors that can occur when forecasting prices.
public enum TitanError: Error {
    case noData
}

/// Adaptive forecasting engine using an exponential moving average.
public final class TitanEngine {
    public enum Algorithm {
        case ema
        case sma
    }

    private var history: [Double] = []
    private let smoothing: Double
    private let maxHistory: Int
    private let algorithm: Algorithm
    private let queue = DispatchQueue(label: "TradeMindAI.TitanEngine")

    public init(smoothing: Double = 0.3, maxHistory: Int = 100, algorithm: Algorithm = .ema) {
        self.smoothing = smoothing
        self.maxHistory = maxHistory
        self.algorithm = algorithm
    }

    /// Record a new price entry and keep history within bounds.
    public func log(price: Double) {
        queue.sync {
            history.append(price)
            if history.count > maxHistory {
                history.removeFirst(history.count - maxHistory)
            }
        }
    }

    /// Clear all recorded prices.
    public func reset() {
        queue.sync { history.removeAll() }
    }

    /// Returns the next predicted value using the selected algorithm.
    public func forecastNext() -> Double? {
        queue.sync {
            guard !history.isEmpty else { return nil }
            switch algorithm {
            case .ema:
                var ema = history[0]
                for value in history.dropFirst() {
                    ema = smoothing * value + (1 - smoothing) * ema
                }
                return ema
            case .sma:
                let sum = history.reduce(0, +)
                return sum / Double(history.count)
            }
        }
    }

    /// Asynchronously compute the next forecast.
    public func forecastAsync(completion: @escaping (Result<Double, Error>) -> Void) {
        queue.async {
            if let value = self.forecastNext() {
                completion(.success(value))
            } else {
                completion(.failure(TitanError.noData))
            }
        }
    }
}
