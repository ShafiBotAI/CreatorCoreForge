import XCTest
@testable import CreatorCoreForge

final class SceneGeneratorTests: XCTestCase {
    func testGenerateScenes() {
        let generator = SceneGenerator()
        let scenes = generator.generateScenes(from: "Hello world. How are you? I am fine.", maxScenes: 2)
        XCTAssertEqual(scenes.count, 2)
        XCTAssertTrue(scenes.first?.hasPrefix("Scene: ") ?? false)
    }
}
