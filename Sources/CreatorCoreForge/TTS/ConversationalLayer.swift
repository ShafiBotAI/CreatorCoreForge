import Foundation

/// Injects informal interjections and cadence adjustments.
public final class ConversationalLayer {
    public init() {}

    public func apply(to sentence: String) -> String {
        if sentence.contains("\"") {
            return "uh... " + sentence
        }
        return sentence
    }
}
