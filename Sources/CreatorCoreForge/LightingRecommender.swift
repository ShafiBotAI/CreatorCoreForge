import Foundation

/// Suggests lighting presets based on mood keywords.
public struct LightingRecommender {
    private let presets: [String: String] = [
        "happy": "bright_warm",
        "sad": "cool_dim",
        "action": "high_contrast",
        "romantic": "soft_glow"
    ]

    public init() {}

    /// Returns the lighting preset string for a given mood.
    public func recommend(for mood: String) -> String {
        presets[mood.lowercased()] ?? "neutral"
    }
}
