import Foundation

/// Tracks transitions between detected emotions during narration.
public final class EmotionShiftTracker {
    /// Represents a change from one emotion to another.
    public struct Shift: Codable, Equatable {
        public let from: String
        public let to: String
        public let delta: Float
    }

    private(set) var shifts: [Shift] = []
    private var lastEmotion: String?
    private var lastIntensity: Float = 0.0

    public init() {}

    /// Log a new emotion observation. If a previous emotion exists, a shift is recorded.
    public func log(emotion: String, intensity: Float) {
        if let previous = lastEmotion {
            let shift = Shift(from: previous, to: emotion, delta: intensity - lastIntensity)
            shifts.append(shift)
        }
        lastEmotion = emotion
        lastIntensity = intensity
    }

    /// Reset the tracker and remove all recorded shifts.
    public func reset() {
        shifts.removeAll()
        lastEmotion = nil
        lastIntensity = 0.0
    }
}
