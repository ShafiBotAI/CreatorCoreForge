import XCTest
@testable import CreatorCoreForge

final class PropertyTests: XCTestCase {
    func testReversingTwice() {
        let values = ["", "hello", "123", "swift"]
        for value in values {
            XCTAssertEqual(String(value.reversed().reversed()), value)
        }
    }
}
