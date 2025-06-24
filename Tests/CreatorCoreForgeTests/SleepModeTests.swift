import XCTest
@testable import CreatorCoreForge

final class SleepModeTests: XCTestCase {
    func testSleepCompletes() {
        let mode = SleepMode()
        let expectation = XCTestExpectation(description: "sleep")
        mode.start(duration: 0.3) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(mode.isActive)
    }

    func testCancel() {
        let mode = SleepMode()
        mode.start(duration: 1) {}
        mode.cancel()
        XCTAssertFalse(mode.isActive)
    }
}
