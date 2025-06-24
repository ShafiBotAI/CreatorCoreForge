import Foundation

/// Allows exporting a voice profile for sharing.
public final class VoiceCloneShare {
    public init() {}

    public func export(profile: VoiceProfile) -> Data? {
        try? JSONEncoder().encode(profile)
    }
}
