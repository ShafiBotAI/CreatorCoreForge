import XCTest
@testable import CreatorCoreForge

final class ConversationalLayerTests: XCTestCase {
    func testApplyAddsSpeed() {
        let layer = ConversationalLayer()
        let text = layer.apply(to: "This is a very long sentence that should be slowed down slightly")
        XCTAssertTrue(text.contains("<speed=0.9>") || text.contains("<speed=0.8>"))
    }
}
