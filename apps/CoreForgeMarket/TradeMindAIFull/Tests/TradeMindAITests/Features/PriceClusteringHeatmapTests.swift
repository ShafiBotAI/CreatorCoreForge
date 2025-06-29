import XCTest
@testable import TradeMindAI

final class PriceClusteringHeatmapTests: XCTestCase {
    func testClusterBuckets() {
        let heatmap = PriceClusteringHeatmap()
        let result = heatmap.cluster(prices: [1,1.4,2.0], bucketSize: 1)
        XCTAssertEqual(result[1], 2)
    }
}
