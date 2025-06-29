import XCTest
@testable import TradeMindAI

final class NewsWhispererTests: XCTestCase {
    func testStartCallsHandler() {
        let exp = expectation(description: "whisper")
        let whisperer = NewsWhisperer(interval: 0.1) { headlines in
            if !headlines.isEmpty { exp.fulfill() }
        }
        whisperer.start { ["one", "two"] }
        wait(for: [exp], timeout: 0.5)
        whisperer.stop()
    }
}
