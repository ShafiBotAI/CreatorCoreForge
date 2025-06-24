import Foundation

/// Applies inline emotion cues to narration segments.
public final class InlineEmotionEngine {
    public init() {}
    /// Return the emotion code for a phrase within a segment.
    public func emotion(for phrase: String) -> String {
        if phrase.contains("!") { return "excited" }
        if phrase.contains("?") { return "question" }
        return "neutral"
    }
}
