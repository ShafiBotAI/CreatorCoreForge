import Foundation

/// Determine default voice tone for a given cultural style.
public struct VoiceToneMatcher {
    public init() {}

    public func tone(for language: SupportedLanguage) -> String {
        switch language {
        case .japanese, .korean:
            return "reserved"
        case .spanish, .italian:
            return "expressive"
        default:
            return "neutral"
        }
    }
}
