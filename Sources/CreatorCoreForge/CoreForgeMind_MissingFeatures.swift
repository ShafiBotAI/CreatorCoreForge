import Foundation

public final class MoodJournal {
    private var entries: [Date: String] = [:]
    public init() {}
    public func addEntry(_ text: String, date: Date = Date()) {
        entries[date] = text
    }
    public var count: Int { entries.count }

    /// Return a simple emotion breakdown for all journal entries using
    /// `EmotionAnalyzer`. The result maps the recommended tone to the
    /// number of occurrences.
    public func moodBreakdown() -> [String: Int] {
        let analyzer = EmotionAnalyzer()
        var counts: [String: Int] = [:]
        for text in entries.values {
            let tone = analyzer.recommendTone(for: text)
            counts[tone, default: 0] += 1
        }
        return counts
    }
}

public struct GuidedSessions {
    public func play(session: String) -> String {
        "Playing \(session)"
    }
}

public final class PrivateVault {
    private var store: [String: String] = [:]
    public init() {}
    public func save(key: String, value: String) { store[key] = value }
    public func fetch(key: String) -> String? { store[key] }
}

/// Utility access to the shared emotion database for wellness tracking.
public func emotionInfo(for label: String) -> EmotionRecord? {
    EmotionDatabase.shared.record(for: label)
}
