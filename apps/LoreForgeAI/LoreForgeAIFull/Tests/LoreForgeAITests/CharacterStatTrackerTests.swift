import XCTest
@testable import LoreForgeAI

final class CharacterStatTrackerTests: XCTestCase {
    func testStatUpdates() {
        let tracker = CharacterStatTracker()
        let initial = CharacterStats(strength: 5, agility: 3, intellect: 4)
        tracker.setStats(for: "Hero", stats: initial)
        tracker.updateStat(for: "Hero", keyPath: \CharacterStats.strength, delta: 2)
        let fetched = tracker.statsForCharacter("Hero")
        XCTAssertEqual(fetched?.strength, 7)
        XCTAssertEqual(fetched?.agility, 3)
    }
}
