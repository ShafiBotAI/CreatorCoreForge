import Foundation

/// Adapts narration text with the current emotional context in real time.
public final class RealTimeEmotionAdapter {
    private var emotion: String = "neutral"
    public init() {}

    /// Update the active emotion label.
    public func updateEmotion(_ emotion: String) {
        self.emotion = emotion
    }

    /// Prefix the text with the active emotion tag.
    public func adapt(_ text: String) -> String {
        "[\(emotion)] " + text
    }
}
