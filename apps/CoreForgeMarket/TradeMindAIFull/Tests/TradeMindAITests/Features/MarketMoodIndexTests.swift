import XCTest
@testable import TradeMindAI

final class MarketMoodIndexTests: XCTestCase {
    func testMoodScoreAverage() {
        let service = RealTimeSentimentService(detector: SentimentDetector()) { _ in "good" }
        let index = MarketMoodIndex(sentimentService: service)
        let exp = expectation(description: "score")
        index.moodScore(for: "AAPL", macroIndex: 0.5) { score in
            XCTAssertGreaterThan(score, 0)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.1)
    }
}
