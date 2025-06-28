import XCTest
@testable import CreatorCoreForge

final class BreathingLayerPauseTests: XCTestCase {
    func testPauseInsertion() {
        let layer = BreathingLayer()
        let processed = layer.process(sentences: ["Hello, world"])
        XCTAssertTrue(processed.first?.contains("<pause=") ?? false)
    }
}
