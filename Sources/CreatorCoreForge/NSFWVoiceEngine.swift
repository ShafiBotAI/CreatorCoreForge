import Foundation

/// Engine for generating NSFW voice effects.
public final class NSFWVoiceEngine {
    public init() {}
    public func applyEffects(to text: String) -> String {
        "NSFW:" + text
    }
}
