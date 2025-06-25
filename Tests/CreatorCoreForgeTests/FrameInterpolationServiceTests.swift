import XCTest
@testable import CreatorCoreForge

final class FrameInterpolationServiceTests: XCTestCase {
    func testInterpolateInsertsFrames() {
        let service = FrameInterpolationService()
        let result = service.interpolate(frames: ["a", "b"], factor: 3)
        XCTAssertEqual(result, ["a", "a->b#1", "a->b#2", "b"])
    }
}
