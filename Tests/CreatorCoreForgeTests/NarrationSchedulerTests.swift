import XCTest
@testable import CreatorCoreForge

final class NarrationSchedulerTests: XCTestCase {
    func testScheduleExecutes() {
        let scheduler = NarrationScheduler()
        let expectation = XCTestExpectation(description: "run")
        scheduler.schedule(at: Date().addingTimeInterval(0.1)) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(scheduler.pendingCount, 0)
    }
}
