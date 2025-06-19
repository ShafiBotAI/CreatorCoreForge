import XCTest
@testable import CreatorCoreForge

final class AIStudioModeTests: XCTestCase {
    func testToggleAndApply() {
        let studio = AIStudioMode()
        let plain = studio.apply(to: "hello")
        XCTAssertEqual(plain, "hello")
        studio.toggle()
        let modified = studio.apply(to: "hello")
        XCTAssertEqual(modified, "[Studio] hello")
    }
}
