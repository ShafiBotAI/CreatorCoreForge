import Foundation

/// Represents a single trading journal entry.
public struct JournalEntry: Codable {
    public let date: Date
    public let text: String
    public let sentiment: Double
}

/// Simple offline-first trading journal that stores entries to disk.
public final class TradingJournal {
    private let fileURL: URL
    private let sentimentDetector: SentimentDetector
    private var entries: [JournalEntry] = []

    public init(directory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first ?? URL(fileURLWithPath: "/tmp"),
                sentimentDetector: SentimentDetector = SentimentDetector()) {
        self.fileURL = directory.appendingPathComponent("journal.json")
        self.sentimentDetector = sentimentDetector
        load()
    }

    public func addEntry(_ text: String) {
        let score = sentimentDetector.sentimentScore(for: text)
        let entry = JournalEntry(date: Date(), text: text, sentiment: score)
        entries.append(entry)
        save()
    }

    public func allEntries() -> [JournalEntry] {
        entries
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let arr = try? JSONDecoder().decode([JournalEntry].self, from: data) else { return }
        entries = arr
    }

    private func save() {
        if let data = try? JSONEncoder().encode(entries) {
            try? data.write(to: fileURL)
        }
    }
}

