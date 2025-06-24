import XCTest
@testable import CreatorCoreForge

final class BuildMonetizationManagerTests: XCTestCase {
    func testPurchaseCompletionRuns() {
        let manager = BuildMonetizationManager.shared
        let expect = expectation(description: "completion")
        manager.purchase(productId: "com.test.product") { result in
            XCTAssertNotNil(result)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 0.1)
    }
}
