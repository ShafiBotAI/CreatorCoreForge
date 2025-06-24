import Foundation

/// Curated set of premium voice profiles shared across apps.
public struct HighQualityVoiceLibrary {
    /// Generate a selection of premium voices.
    /// - Parameter count: how many voices to return (default 50).
    public static func premiumVoices(count: Int = 50) -> [VoiceProfile] {
        GlobalVoiceLibrary.defaultVoices(count: count)
    }
}
