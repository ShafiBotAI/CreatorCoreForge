import Foundation

/// Represents a single emotion intensity measurement.
public struct EmotionGraphPoint: Codable, Equatable {
    public let timestamp: Date
    public let emotion: String
    public let intensity: Double
}

/// Stores emotion changes over time and allows export/import.
public final class EmotionGraph {
    private(set) var points: [EmotionGraphPoint] = []

    public init() {}

    /// Record an emotion with a given intensity at the provided time.
    public func record(emotion: String, intensity: Double, at date: Date = Date()) {
        let point = EmotionGraphPoint(timestamp: date, emotion: emotion, intensity: intensity)
        points.append(point)
    }

    /// Calculate the average intensity for the specified emotion.
    public func averageIntensity(for emotion: String) -> Double? {
        let filtered = points.filter { $0.emotion == emotion }
        guard !filtered.isEmpty else { return nil }
        let total = filtered.reduce(0.0) { $0 + $1.intensity }
        return total / Double(filtered.count)
    }

    /// Export all recorded points as JSON data.
    public func export() -> Data? {
        return try? JSONEncoder().encode(points)
    }

    /// Import points from JSON data. Existing points are kept.
    public func `import`(data: Data) {
        if let decoded = try? JSONDecoder().decode([EmotionGraphPoint].self, from: data) {
            points.append(contentsOf: decoded)
        }
    }
}
