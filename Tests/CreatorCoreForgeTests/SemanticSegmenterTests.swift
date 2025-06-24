import XCTest
@testable import CreatorCoreForge

final class SemanticSegmenterTests: XCTestCase {
    func testSegments() {
        let text = "Hello there. General Kenobi! This is a test: new section. Another sentence."
        let segments = SemanticSegmenter().segments(from: text)
        XCTAssertGreaterThanOrEqual(segments.count, 1)
    }
}
