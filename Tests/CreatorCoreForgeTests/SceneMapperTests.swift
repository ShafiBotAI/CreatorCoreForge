import XCTest
@testable import CreatorCoreForge

final class SceneMapperTests: XCTestCase {
    func testMapScenesSplitsParagraphsAndDetectsTone() {
        let chapters = [Chapter(title: "C1", text: "Good day.\n\nBad night.", order: 0)]
        let mapper = SceneMapper()
        let scenes = mapper.mapScenes(from: chapters)
        XCTAssertEqual(scenes.count, 2)
        XCTAssertEqual(scenes[0].tone, .positive)
        XCTAssertEqual(scenes[1].tone, .negative)
    }
}
