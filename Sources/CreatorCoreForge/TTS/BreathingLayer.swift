import Foundation

/// Inserts breath markers before long sentences.
public final class BreathingLayer {
    public init() {}

    /// Returns sentences with optional breath tokens inserted.
    public func process(sentences: [String]) -> [String] {
        return sentences.map { sentence in
            let wordCount = sentence.split(separator: " ").count
            if wordCount > 12 {
                let delay = String(format: "<breath=%.2f>", Double.random(in: 0.15...0.35))
                return "\(delay) \(sentence)"
            }
            return sentence
        }
    }
}
