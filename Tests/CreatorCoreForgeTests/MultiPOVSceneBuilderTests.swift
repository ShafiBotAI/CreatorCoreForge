import XCTest
@testable import CreatorCoreForge

final class MultiPOVSceneBuilderTests: XCTestCase {
    func testBuildScene() {
        let builder = MultiPOVSceneBuilder()
        builder.addSegment(character: "Alice", text: "Hello")
        builder.addSegment(character: "Bob", text: "Hi")
        let scene = builder.buildScene()
        XCTAssertTrue(scene.contains("Alice: Hello"))
        XCTAssertTrue(scene.contains("Bob: Hi"))
    }
}
