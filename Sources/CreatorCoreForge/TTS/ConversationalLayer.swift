import Foundation

/// Injects informal interjections and cadence adjustments.
public final class ConversationalLayer {
    public init() {}

    public func apply(to sentence: String) -> String {
        var line = sentence
        if Int.random(in: 0..<10) == 0 {
            let options = ["uh...", "hmm...", "I mean—"]
            line = "\(options.randomElement()!) " + line
        }
        if line.split(separator: " ").count > 8 {
            line = "<speed=0.9> " + line + " <speed=0.8>"
        }
        return line
    }
}
