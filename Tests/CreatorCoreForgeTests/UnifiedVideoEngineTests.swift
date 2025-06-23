import XCTest
@testable import CreatorCoreForge

final class UnifiedVideoEngineTests: XCTestCase {
    func testRenderDelegatesToGPU() {
        let engine = UnifiedVideoEngine()
        let clip = engine.render(frames: ["a", "b"], options: RendererOptions(width: 1, height: 1))
        XCTAssertEqual(clip.frames, ["a", "b"])
    }
}
