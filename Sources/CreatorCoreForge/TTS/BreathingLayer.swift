import Foundation

/// Inserts breath markers and pause hints before and within sentences.
public final class BreathingLayer {
    public init() {}

    /// Returns sentences with breath and pause tokens inserted.
    public func process(sentences: [String]) -> [String] {
        return sentences.map { sentence in
            var line = insertPauses(in: sentence)
            let wordCount = sentence.split(separator: " ").count
            if wordCount > 12 {
                let delay = String(format: "<breath=%.2f>", Double.random(in: 0.15...0.35))
                line = "\(delay) \(line)"
            }
            return line
        }
    }

    private func insertPauses(in sentence: String) -> String {
        var output = ""
        for ch in sentence {
            output.append(ch)
            switch ch {
            case ",":
                output.append("<pause=\(String(format: "%.2f", Double.random(in: 0.1...0.2)))>")
            case ".":
                output.append("<pause=\(String(format: "%.2f", Double.random(in: 0.25...0.4)))>")
            case "-":
                output.append("<pause=\(String(format: "%.2f", Double.random(in: 0.2...0.35)))>")
            default:
                break
            }
        }
        return output
    }
}
