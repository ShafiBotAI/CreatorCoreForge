import XCTest
@testable import CreatorCoreForge

final class PluginMarketplaceTests: XCTestCase {
    func testPublishAndRate() {
        var manifest = PluginManifest(name: "Demo", version: "1", inputs: [], outputs: [], permissions: [])
        let market = PluginMarketplace()
        market.publish(manifest)
        market.addRating(for: "Demo", rating: 5)
        XCTAssertEqual(market.manifest(named: "Demo")?.name, "Demo")
        XCTAssertEqual(market.averageRating(for: "Demo"), 5)
        manifest.version = "2"
        market.publish(manifest)
        XCTAssertEqual(market.versionHistory(for: "Demo").count, 2)
    }
}
