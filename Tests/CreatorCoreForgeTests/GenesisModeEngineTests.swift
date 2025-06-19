import XCTest
@testable import CreatorCoreForge

final class GenesisModeEngineTests: XCTestCase {
    func testVariantCount() {
        let engine = GenesisModeEngine()
        let variants = engine.generateVariants(for: "Idea", count: 2)
        XCTAssertEqual(variants.count, 2)
        XCTAssertEqual(variants.first, "Idea Variant 1")
    }
}
