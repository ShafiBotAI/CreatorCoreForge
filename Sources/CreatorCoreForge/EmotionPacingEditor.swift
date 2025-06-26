import Foundation

/// Adjusts pacing based on emotional intensity.
public final class EmotionPacingEditor {
    public init() {}

    public func pace(text: String, intensity: Float) -> String {
        if intensity > 0.8 {
            return text.uppercased()
        } else if intensity < 0.3 {
            return text.split(separator: " ").map { "\($0)..." }.joined(separator: " ")
        }
        return text
    }
}
