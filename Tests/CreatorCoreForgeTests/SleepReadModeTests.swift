import XCTest
@testable import CreatorCoreForge

final class SleepReadModeTests: XCTestCase {
    func testSleepCompletes() {
        let mode = SleepReadMode()
        let expectation = XCTestExpectation(description: "sleep")
        mode.start(duration: 0.5, fadeDuration: 0.2, fade: { _ in }) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(mode.isActive)
    }

    func testCancelStopsTimer() {
        let mode = SleepReadMode()
        mode.start(duration: 1, fadeDuration: 0.5, fade: { _ in }) {}
        mode.cancel()
        XCTAssertFalse(mode.isActive)
    }
}
