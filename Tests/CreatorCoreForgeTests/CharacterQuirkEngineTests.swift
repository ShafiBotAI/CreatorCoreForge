import XCTest
@testable import CreatorCoreForge

final class CharacterQuirkEngineTests: XCTestCase {
    func testAssignAndTrigger() {
        let engine = CharacterQuirkEngine.shared
        engine.assignQuirks(to: "Tester", quirks: [.sigh, .cough])
        XCTAssertNoThrow(engine.triggerQuirks(for: "Tester"))
        engine.stopAllQuirks()
    }
}
