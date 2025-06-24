import XCTest
@testable import CreatorCoreForge

final class ExportQueueManagerTests: XCTestCase {
    func testQueueProcessesTasks() {
        let manager = ExportQueueManager()
        var value = 0
        let exp = expectation(description: "task")
        manager.addTask {
            value = 1
            exp.fulfill()
        }
        manager.processNext()
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(value, 1)
    }
}
