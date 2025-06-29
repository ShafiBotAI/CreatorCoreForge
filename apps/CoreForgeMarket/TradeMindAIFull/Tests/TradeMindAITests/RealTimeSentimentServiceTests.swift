import XCTest
@testable import TradeMindAI

final class RealTimeSentimentServiceTests: XCTestCase {
    func testCombinedSentimentAverage() {
        let fetcher: (URL) -> String? = { url in
            if url.host?.contains("twitter") == true { return "bull" }
            if url.host?.contains("reddit") == true { return "panic" }
            return "optimistic"
        }
        let service = RealTimeSentimentService(fetcher: fetcher)
        let exp = expectation(description: "sentiment")
        service.combinedSentiment(for: "AAPL") { score in
            // bull -> +1, panic -> -1, optimistic -> +1 => average 0.33...
            XCTAssert(abs(score - 0.3333) < 0.1)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
