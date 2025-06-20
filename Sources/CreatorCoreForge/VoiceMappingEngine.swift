import Foundation

/// Maps book characters or roles to specific voice profiles.
public final class VoiceMappingEngine {
    private var mapping: [String: VoiceProfile] = [:]

    public init() {}

    public func assign(_ profile: VoiceProfile, to identifier: String) {
        mapping[identifier] = profile
    }

    public func voice(for identifier: String) -> VoiceProfile? {
        mapping[identifier]
    }
}
