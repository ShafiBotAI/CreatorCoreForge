import XCTest
@testable import TradeMindAI

final class TaxLossHarvesterTests: XCTestCase {
    func testHarvestableCount() {
        let harvester = TaxLossHarvester()
        let count = harvester.harvestablePositions(prices: [8,9], costBasis: [10,9], threshold: 1)
        XCTAssertEqual(count, 1)
    }
}
