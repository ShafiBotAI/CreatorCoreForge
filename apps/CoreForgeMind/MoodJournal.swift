import Foundation

/// Represents a journal entry and a simple sentiment score derived
/// from the text. Positive words increment the score while negative
/// words decrement it.
public struct MoodEntry: Codable {
    public var text: String
    public var date: Date
    public var sentiment: Int
}

public final class MoodJournal {
    private var entries: [MoodEntry] = []

    public init() {}

    private let positive = ["happy", "joy", "excited", "great", "love"]
    private let negative = ["sad", "angry", "tired", "bad", "hate"]

    private func score(for text: String) -> Int {
        let words = text.lowercased().split(separator: " ")
        var score = 0
        for word in words {
            if positive.contains(String(word)) { score += 1 }
            if negative.contains(String(word)) { score -= 1 }
        }
        return score
    }

    /// Add a new entry and compute a sentiment score.
    public func addEntry(_ text: String) {
        let s = score(for: text)
        entries.append(MoodEntry(text: text, date: Date(), sentiment: s))
    }

    /// Average sentiment score for all entries.
    public var averageSentiment: Double {
        guard !entries.isEmpty else { return 0 }
        return Double(entries.map { $0.sentiment }.reduce(0, +)) / Double(entries.count)
    }

    public var allEntries: [MoodEntry] { entries }
}
