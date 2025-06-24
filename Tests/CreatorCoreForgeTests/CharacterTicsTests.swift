import XCTest
@testable import CreatorCoreForge

final class CharacterTicsTests: XCTestCase {
    func testApplyTics() {
        var tics = CharacterTics()
        tics.setTics(["uh"], for: "Bob")
        let result = tics.applyTics(to: "I am fine", for: "Bob")
        XCTAssertTrue(result.contains("uh"))
    }
}
