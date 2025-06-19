import Foundation

final class MemoryTracker {
    private var history: [String] = []
    private let characterMemory = AdaptiveCharacterMemory()

    func record(_ entry: String, character: String? = nil) {
        history.append(entry)
        if let c = character {
            characterMemory.record(character: c, line: entry)
        }
    }

    func lastEntry() -> String? {
        history.last
    }

    func historyLog() -> [String] {
        history
    }

    func context(last count: Int) -> String {
        let slice = history.suffix(count)
        return slice.joined(separator: "\n")
    }

    func search(_ keyword: String) -> [String] {
        history.filter { $0.localizedCaseInsensitiveContains(keyword) }
    }

    func summarizeContext(last count: Int) -> String {
        let slice = history.suffix(count)
        return slice.joined(separator: " ")
    }

    /// Provide a basic continuity score by checking how many of the last entries
    /// appear in the provided text.
    func continuityScore(for text: String, window: Int = 5) -> Double {
        let recent = history.suffix(window)
        guard !recent.isEmpty else { return 1.0 }
        let lower = text.lowercased()
        let matches = recent.filter { lower.contains($0.lowercased()) }
        return Double(matches.count) / Double(recent.count)
    }

    /// Provide a crude similarity score based on word overlap with recent context.
    func advancedContinuityScore(for text: String, window: Int = 5) -> Double {
        let recentText = history.suffix(window).joined(separator: " ")
        let recentWords = Set(recentText.lowercased().split(separator: " ").map(String.init))
        guard !recentWords.isEmpty else { return 1.0 }
        let words = Set(text.lowercased().split(separator: " ").map(String.init))
        let intersection = recentWords.intersection(words)
        return Double(intersection.count) / Double(recentWords.count)
    }

    /// Suggest the next plot point simply by repeating the last entry.
    func predictNextEntry() -> String? {
        guard let last = history.last else { return nil }
        return "Next: " + last
    }

    func recentLines(for character: String, limit: Int = 5) -> [String] {
        characterMemory.recentLines(for: character, limit: limit)
    }

    func reset() {
        history.removeAll()
    }
}
