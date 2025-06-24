import Foundation

/// Naive profanity filter that censors banned words.
public struct ProfanityFilter {
    private var banned: Set<String>
    public init(words: [String] = ["badword"]) {
        self.banned = Set(words)
    }

    public func clean(_ text: String) -> String {
        var output = text
        for word in banned {
            output = output.replacingOccurrences(of: word, with: "***")
        }
        return output
    }
}
