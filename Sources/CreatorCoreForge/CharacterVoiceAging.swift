import Foundation

/// Provides basic pitch adjustment based on character age.
public struct CharacterVoiceAging {
    public init() {}

    /// Pitch multiplier for the given age. Ages above 60 sound deeper.
    public func pitchMultiplier(for age: Int) -> Float {
        switch age {
        case ..<20: return 1.0
        case 20..<40: return 0.95
        case 40..<60: return 0.9
        default: return 0.85
        }
    }
}
