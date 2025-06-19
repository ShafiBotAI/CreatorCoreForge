import Foundation

/// Detects character names and pronouns from raw text.
public struct CharacterDetectionEngine {
    public init() {}

    /// Returns a set of unique character names detected in the text.
    /// Heuristics look for capitalized words that are not at the start of a sentence
    /// and treat them as potential names.
    public func detectNames(in text: String) -> Set<String> {
        var names = Set<String>()
        let sentences = text.split(separator: ".")
        let nameRegex = try? NSRegularExpression(pattern: "\\b[A-Z][a-zA-Z]+\\b")
        for sentence in sentences {
            let str = String(sentence)
            let range = NSRange(str.startIndex..<str.endIndex, in: str)
            if let matches = nameRegex?.matches(in: str, range: range) {
                for match in matches {
                    if let range = Range(match.range, in: str) {
                        let name = str[range]
                        // Skip the first word of the sentence
                        if str.startIndex != range.lowerBound {
                            names.insert(String(name))
                        }
                    }
                }
            }
        }
        return names
    }

    /// Detects simple pronoun usage (he/she/they) within the text.
    public func detectPronouns(in text: String) -> Set<String> {
        let pronouns = ["he", "she", "they", "him", "her", "them"]
        var found = Set<String>()
        let words = text.lowercased().split { !$0.isLetter }
        for word in words {
            if pronouns.contains(String(word)) {
                found.insert(String(word))
            }
        }
        return found
    }
}
