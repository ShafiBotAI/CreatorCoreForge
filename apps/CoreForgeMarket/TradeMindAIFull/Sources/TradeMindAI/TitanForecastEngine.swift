import Foundation

/// Provides predictive heatmap calculations for market data.
public final class TitanForecastEngine {
    private var data: [Double] = []

    public init() {}

    /// Log a new market data point.
    public func log(_ value: Double) {
        data.append(value)
    }

    /// Generate a simple heatmap by normalizing recent values.
    public func generateHeatmap(window: Int = 10) -> [Double] {
        let slice = data.suffix(window)
        guard let min = slice.min(), let max = slice.max(), max > min else {
            return Array(slice)
        }
        return slice.map { ($0 - min) / (max - min) }
    }
}

public extension TitanForecastEngine {
    /// Generate the latest heatmap value per sector.
    func generateSectorHeatmap(data: [String: [Double]], window: Int = 10) -> [String: Double] {
        var result: [String: Double] = [:]
        for (sector, values) in data {
            let slice = values.suffix(window)
            guard let min = slice.min(), let max = slice.max(), max > min else {
                result[sector] = slice.last ?? 0
                continue
            }
            let norm = (slice.last! - min) / (max - min)
            result[sector] = norm
        }
        return result
    }
}
