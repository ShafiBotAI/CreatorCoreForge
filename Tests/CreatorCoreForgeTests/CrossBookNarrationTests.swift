import XCTest
@testable import CreatorCoreForge

final class CrossBookNarrationTests: XCTestCase {
    func testCharacterArcTracker() {
        let tracker = CharacterArcTracker()
        tracker.record(book: "Book1", arc: "Hero")
        XCTAssertEqual(tracker.arcs(for: "Book1"), ["Hero"])
    }

    func testVoiceToneEvolution() {
        let service = VoiceToneEvolutionService()
        service.addTone(for: "Ann", value: 0.5)
        service.addTone(for: "Ann", value: 1.0)
        XCTAssertEqual(service.averageTone(for: "Ann"), 0.75)
    }
}
