import Foundation

/// Converts prose text into simple dialogue lines rotating speakers.
public struct ProseToDialogueConverter {
    public init() {}

    /// Convert prose into dialogue using provided speaker list.
    public func convert(text: String, speakers: [String]) -> [String] {
        guard !speakers.isEmpty else { return [] }
        let sentences = text.split(separator: ".")
        var result: [String] = []
        for (index, sentence) in sentences.enumerated() {
            let trimmed = sentence.trimmingCharacters(in: .whitespaces)
            if trimmed.isEmpty { continue }
            let speaker = speakers[index % speakers.count]
            result.append("\(speaker): \(trimmed).")
        }
        return result
    }
}
