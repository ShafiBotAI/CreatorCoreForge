import XCTest
@testable import CreatorCoreForge

final class SceneIndexGeneratorTests: XCTestCase {
    func testIndexScenes() {
        let chapter = Chapter(title: "C1", text: "Scene 1\nSomething\nScene 2\nMore", order: 1)
        let result = SceneIndexGenerator().indexScenes(in: [chapter])
        XCTAssertEqual(result["C1"], [0,2])
    }
}
