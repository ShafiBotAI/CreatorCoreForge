import XCTest
@testable import CreatorCoreForge

final class VisualFXEngineTests: XCTestCase {
    func testFXLightingForDarkTone() {
        let node = SceneNode(text: "", tone: .negative, characters: [], timestamp: 0)
        let engine = VisualFXEngine()
        let fx = engine.fx(for: node)
        XCTAssertEqual(fx.lighting, "night")
    }
}
