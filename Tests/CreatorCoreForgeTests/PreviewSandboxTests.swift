import XCTest
@testable import CreatorCoreForge

final class PreviewSandboxTests: XCTestCase {
    func testPreviewReturnsFPS() {
        let sandbox = PreviewSandbox()
        let node = SceneNode(text: "", tone: .neutral, characters: [], timestamp: 0)
        let fps = sandbox.preview(scenes: [node])
        XCTAssertEqual(fps, 60.0)
    }
}
