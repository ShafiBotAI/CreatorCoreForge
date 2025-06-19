import XCTest
@testable import TradeMindAI

final class TradingJournalTests: XCTestCase {
    func testAddEntryPersistsInMemory() {
        let base = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString)
        try? FileManager.default.createDirectory(at: base, withIntermediateDirectories: true)
        let journal = TradingJournal(directory: base, sentimentDetector: SentimentDetector())
        journal.addEntry("Very bullish setup")
        let entries = journal.allEntries()
        XCTAssertEqual(entries.count, 1)
        XCTAssertGreaterThan(entries.first?.sentiment ?? 0, 0)
    }
}
