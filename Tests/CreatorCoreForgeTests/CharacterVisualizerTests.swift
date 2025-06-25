import XCTest
@testable import CreatorCoreForge

final class CharacterVisualizerTests: XCTestCase {
    func testRenderAvatar() {
        let visualizer = CharacterVisualizer()
        let avatar = visualizer.renderAvatar(for: "Hero", emotion: "happy")
        XCTAssertEqual(avatar, "Hero_avatar_happy")
    }

    func testLayerEmotion() {
        let visualizer = CharacterVisualizer()
        let result = visualizer.layerEmotion("sad", on: "Hero_avatar")
        XCTAssertEqual(result, "Hero_avatar_sad")
    }
}
