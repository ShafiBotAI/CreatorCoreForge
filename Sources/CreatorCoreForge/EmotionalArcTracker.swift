#if canImport(Combine)
import Foundation
import Combine

/// Tracks emotional changes for characters over time.
public final class EmotionalArcTracker: ObservableObject {
    /// Shared singleton instance.
    public static let shared = EmotionalArcTracker()

    /// A single emotion data point.
    public struct ArcPoint: Identifiable, Codable {
        public var id: UUID = UUID()
        public var timestamp: Date
        public var characterName: String
        public var emotion: String
        public var intensity: Float // 0.0 – 1.0
    }

    /// Stored emotion points.
    @Published public var arcs: [ArcPoint] = []

    private init() {}

    /// Log a new emotion state for the specified character.
    public func logEmotion(character: String, emotion: String, intensity: Float) {
        let point = ArcPoint(timestamp: Date(),
                             characterName: character,
                             emotion: emotion,
                             intensity: intensity)
        arcs.append(point)
    }

    /// Retrieve all emotion points for a given character.
    public func getArc(for character: String) -> [ArcPoint] {
        return arcs.filter { $0.characterName.lowercased() == character.lowercased() }
    }

    /// Clear logged emotions for a character, or all characters if none provided.
    public func clearArcs(for character: String? = nil) {
        if let name = character {
            arcs.removeAll { $0.characterName.lowercased() == name.lowercased() }
        } else {
            arcs.removeAll()
        }
    }

    /// Average intensity for the specified character across all logged points.
    public func averageEmotionIntensity(for character: String) -> Float {
        let arcPoints = getArc(for: character)
        let total = arcPoints.reduce(0.0) { $0 + $1.intensity }
        return arcPoints.isEmpty ? 0.0 : total / Float(arcPoints.count)
    }
}
#else
import Foundation

/// Tracks emotional changes for characters over time.
public final class EmotionalArcTracker {
    public static let shared = EmotionalArcTracker()

    public struct ArcPoint: Identifiable, Codable {
        public var id: UUID = UUID()
        public var timestamp: Date
        public var characterName: String
        public var emotion: String
        public var intensity: Float  // 0.0 – 1.0
    }

    public private(set) var arcs: [ArcPoint] = []

    private init() {}

    public func logEmotion(character: String, emotion: String, intensity: Float) {
        let point = ArcPoint(timestamp: Date(),
                             characterName: character,
                             emotion: emotion,
                             intensity: intensity)
        arcs.append(point)
    }

    public func getArc(for character: String) -> [ArcPoint] {
        return arcs.filter { $0.characterName.lowercased() == character.lowercased() }
    }

    public func clearArcs(for character: String? = nil) {
        if let name = character {
            arcs.removeAll { $0.characterName.lowercased() == name.lowercased() }
        } else {
            arcs.removeAll()
        }
    }

    public func averageEmotionIntensity(for character: String) -> Float {
        let arcPoints = getArc(for: character)
        let total = arcPoints.reduce(0.0) { $0 + $1.intensity }
        return arcPoints.isEmpty ? 0.0 : total / Float(arcPoints.count)
    }
}
#endif

// Example:
// EmotionalArcTracker.shared.logEmotion(character: "Zara", emotion: "sadness", intensity: 0.8)
