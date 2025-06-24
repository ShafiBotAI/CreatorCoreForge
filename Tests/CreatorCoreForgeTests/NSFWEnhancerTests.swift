import XCTest
@testable import CreatorCoreForge

final class NSFWEnhancerTests: XCTestCase {
    func testEnhanceSceneAddsFlags() {
        let enhancer = NSFWEnhancer()
        let result = enhancer.enhance(scene: "Scene", whisper: true, breathing: true, cameraPace: 0.75)
        XCTAssertTrue(result.contains("[whisper]"))
        XCTAssertTrue(result.contains("[breath]"))
        XCTAssertTrue(result.contains("[pace:0.75]"))
    }
}
