import Foundation

/// Utility for combining multiple voice or accent identifiers.
public struct MultilingualVoiceBlend {
    /// Blend two identifiers into a single composite string.
    public static func blend(_ primary: String, with secondary: String) -> String {
        "\(primary)-\(secondary)"
    }

    /// Blend an array of identifiers.
    public static func blend(voices: [String]) -> String {
        voices.joined(separator: "-")
    }
}
