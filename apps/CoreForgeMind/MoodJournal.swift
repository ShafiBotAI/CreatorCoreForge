import Foundation

/// Basic mood journal entry with AI sentiment placeholder.
public struct MoodEntry {
    public var text: String
    public var date: Date
}

public class MoodJournal {
    private var entries: [MoodEntry] = []

    public init() {}

    public func addEntry(_ text: String) {
        entries.append(MoodEntry(text: text, date: Date()))
    }

    public var allEntries: [MoodEntry] { entries }
}
