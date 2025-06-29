import XCTest
@testable import TradeMindAI

final class TradingJournalExporterTests: XCTestCase {
    func testReportContainsEntry() {
        let base = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString)
        try? FileManager.default.createDirectory(at: base, withIntermediateDirectories: true)
        let journal = TradingJournal(directory: base, sentimentDetector: SentimentDetector())
        journal.addEntry("Test")
        let report = journal.generateReport()
        XCTAssertTrue(report.contains("Test"))
    }
}
