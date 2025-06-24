import Foundation

/// Provides a default catalog of high quality voices for all apps.
public struct GlobalVoiceLibrary {
    /// Generate an array of synthetic `VoiceProfile` entries.
    /// - Parameter count: Number of voices to generate (defaults to 200).
    public static func defaultVoices(count: Int = 200) -> [VoiceProfile] {
        (1...count).map { VoiceProfile(name: "Voice\($0)") }
    }
}
