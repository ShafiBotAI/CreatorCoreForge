import Foundation

/// Automatically formats raw dialogue lines into a normalized script style.
public struct AutoFormatDialogue {
    public init() {}

    /// Format a block of text so that consecutive lines from the same speaker
    /// are grouped under the speaker name.
    public func format(text: String) -> String {
        var result = ""
        var currentSpeaker: String?
        for rawLine in text.split(separator: "\n") {
            let line = String(rawLine).trimmingCharacters(in: .whitespaces)
            guard let range = line.range(of: ":") else {
                result += line + "\n"
                continue
            }
            let speaker = String(line[..<range.lowerBound]).trimmingCharacters(in: .whitespaces)
            let utterance = String(line[range.upperBound...]).trimmingCharacters(in: .whitespaces)
            if speaker != currentSpeaker {
                if !result.isEmpty { result += "\n" }
                result += "\(speaker):\n"
                currentSpeaker = speaker
            }
            result += "  \(utterance)\n"
        }
        return result.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
