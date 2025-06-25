import XCTest
@testable import CreatorCoreForge

final class BuildQueueControllerTests: XCTestCase {
    func testEnqueueAndRun() {
        let controller = BuildQueueController()
        controller.enqueue { "out" }
        XCTAssertEqual(controller.pending, 1)
        XCTAssertEqual(controller.runNext(), "out")
        XCTAssertEqual(controller.pending, 0)
    }

    func testRunAll() {
        let controller = BuildQueueController()
        controller.enqueue { "one" }
        controller.enqueue { "two" }
        let results = controller.runAll()
        XCTAssertEqual(results, ["one", "two"])
        XCTAssertEqual(controller.pending, 0)
    }
}
