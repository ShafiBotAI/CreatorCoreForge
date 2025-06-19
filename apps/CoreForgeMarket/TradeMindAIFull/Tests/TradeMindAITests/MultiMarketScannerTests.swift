import XCTest
@testable import TradeMindAI

final class MultiMarketScannerTests: XCTestCase {
    private final class MockSyncManager: MarketPriceFetching {
        func fetchLatestPrice(symbol: String, completion: @escaping (Result<Double, Error>) -> Void) {
            completion(.success(Double(symbol.count)))
        }
    }

    func testFetchPricesAggregatesResults() {
        let scanner = MultiMarketScanner(syncManager: MockSyncManager())
        let exp = expectation(description: "prices")
        scanner.fetchPrices(symbols: ["BTC", "ETH"]) { result in
            XCTAssertEqual(result["BTC"], 3)
            XCTAssertEqual(result["ETH"], 3)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func testSmartMoneyScore() {
        let scanner = MultiMarketScanner(syncManager: MockSyncManager())
        let score = scanner.smartMoneyScore(prices: [1, 2, 3])
        XCTAssertEqual(score, (3 - 1) / 3)
    }
}

