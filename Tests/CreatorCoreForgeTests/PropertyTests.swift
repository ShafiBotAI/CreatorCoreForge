import XCTest
@testable import CreatorCoreForge

final class PropertyTests: XCTestCase {
    func testReversingTwice() {
        for _ in 0..<100 {
            let value = UUID().uuidString
            XCTAssertEqual(String(value.reversed().reversed()), value)
        }
    }
}
