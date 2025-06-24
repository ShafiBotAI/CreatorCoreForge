import XCTest
@testable import CreatorCoreForge

final class VisualDescriptionExtractorTests: XCTestCase {
    func testExtractDescriptions() {
        let extractor = VisualDescriptionExtractor()
        let text = "The dark room was cold. He walked outside. Bright sun lit the forest.";
        let result = extractor.extract(from: text)
        XCTAssertGreaterThanOrEqual(result.count, 1)
        XCTAssertTrue(result[0].contains("dark room"))
    }
}
