import XCTest
@testable import LoreForgeAI

final class VisualMemoryManagerTests: XCTestCase {
    func testShiftTimeline() {
        let manager = VisualMemoryManager()
        manager.shiftTimeline(for: "Book1", by: 2)
        XCTAssertEqual(manager.timelineShift["Book1"], 2)
    }

    func testSyncCharacterTone() {
        let manager = VisualMemoryManager()
        manager.sync(character: "Hero", voiceTone: "gruff")
        XCTAssertEqual(manager.characterVoiceTone["Hero"], "gruff")
    }

    func testStoreFXHistory() {
        let manager = VisualMemoryManager()
        let key = SceneKey(book: "Book1", index: 1)
        manager.storeFX("rain", for: key)
        XCTAssertEqual(manager.fxHistory[key], ["rain"])
    }

    func testCheckInconsistency() {
        let current = CharacterVisualState(hairstyle: "short", outfit: "armor", mood: "happy")
        let previous = CharacterVisualState(hairstyle: "long", outfit: "armor", mood: "sad")
        let manager = VisualMemoryManager()
        let issues = manager.checkInconsistency(current, previous)
        XCTAssertTrue(issues.contains("hairstyle"))
        XCTAssertTrue(issues.contains("mood"))
        XCTAssertFalse(issues.contains("outfit"))
    }

    func testNarratorVoiceStorage() {
        let manager = VisualMemoryManager()
        manager.setNarratorVoice("Calm")
        XCTAssertEqual(manager.getNarratorVoice(), "Calm")
    }
}

