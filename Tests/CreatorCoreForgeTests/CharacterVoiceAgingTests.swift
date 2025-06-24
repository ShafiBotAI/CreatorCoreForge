import XCTest
@testable import CreatorCoreForge

final class CharacterVoiceAgingTests: XCTestCase {
    func testPitchMultiplier() {
        let aging = CharacterVoiceAging()
        XCTAssertEqual(aging.pitchMultiplier(for: 10), 1.0)
        XCTAssertLessThan(aging.pitchMultiplier(for: 70), 1.0)
    }
}
