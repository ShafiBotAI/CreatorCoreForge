import XCTest
@testable import CreatorCoreForge

final class WatchSyncServiceTests: XCTestCase {
    func testUploadAndFetch() {
        let service = WatchSyncService()
        service.upload(["key": "value"], userID: "1") { success in
            XCTAssertTrue(success)
        }
        let expectation = XCTestExpectation(description: "fetch")
        service.fetch(userID: "1") { data in
            XCTAssertEqual(data?["key"] as? String, "value")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
