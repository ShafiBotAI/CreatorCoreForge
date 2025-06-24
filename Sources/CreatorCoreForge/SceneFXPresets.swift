import Foundation

/// Provides predefined ambient FX preset collections.
public struct SceneFXPresets {
    private static let presets: [String: [String]] = [
        "Haunted Mansion": ["door_creak", "wind_gust", "footstep_gravel"],
        "Rainy Battlefield": ["battle_ambience", "rain_loop"],
    ]

    /// Return FX names for a preset scene.
    public static func preset(named name: String) -> [String] {
        presets[name] ?? []
    }
}
