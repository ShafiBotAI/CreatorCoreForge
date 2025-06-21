import Foundation

/// Generates a normalized heatmap from logged NSFW intensity levels.
public final class NSFWMoodHeatmap {
    private var log: [NSFWContentManager.NSFWIntensity] = []

    public init() {}

    /// Log an intensity level for later analysis.
    public func log(intensity: NSFWContentManager.NSFWIntensity) {
        log.append(intensity)
    }

    /// Normalize the most recent intensity levels in the range 0-1.
    /// - Parameter window: Number of latest entries to include.
    public func generateHeatmap(window: Int = 10) -> [Double] {
        let slice = log.suffix(window)
        let values = slice.map { level -> Double in
            let index = NSFWContentManager.NSFWIntensity.allCases.firstIndex(of: level) ?? 0
            return Double(index) / Double(NSFWContentManager.NSFWIntensity.allCases.count - 1)
        }
        guard let min = values.min(), let max = values.max(), max > min else {
            return Array(values)
        }
        return values.map { ($0 - min) / (max - min) }
    }
}
