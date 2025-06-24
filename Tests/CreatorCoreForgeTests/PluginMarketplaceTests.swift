import XCTest
@testable import CreatorCoreForge

final class PluginMarketplaceTests: XCTestCase {
    func testPublishAndRate() {
        var manifest = PluginManifest(name: "Demo", version: "1", inputs: [], outputs: [], permissions: [], premium: false)
        let market = PluginMarketplace()
        market.publish(manifest)
        market.addRating(for: "Demo", rating: 5)
        XCTAssertEqual(market.manifest(named: "Demo")?.name, "Demo")
        XCTAssertEqual(market.averageRating(for: "Demo"), 5)
        market.addReview(for: "Demo", review: "Great")
        market.recordUsage(for: "Demo")
        XCTAssertEqual(market.reviews(for: "Demo").count, 1)
        XCTAssertEqual(market.usageCount(for: "Demo"), 1)
        manifest.version = "2"
        market.publish(manifest)
        XCTAssertEqual(market.versionHistory(for: "Demo").count, 2)
        XCTAssertTrue(market.rollback(name: "Demo", toVersion: 0))
        XCTAssertEqual(market.manifest(named: "Demo")?.version, "1")
    }
}
