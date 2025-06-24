import XCTest
@testable import CreatorCoreForge

final class OfflineVideoManagerTests: XCTestCase {
    func testQueueVideoFile() {
        let manager = OfflineVideoManager()
        manager.queueVideoFile("test.mp4")
        // Expect asynchronous download to complete quickly
        let exp = expectation(description: "download")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.2) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 2)
    }
}
