import XCTest
@testable import CreatorCoreForge

final class CharacterProfileManagerTests: XCTestCase {
    func testProfilePersistenceAndToken() {
        let suite = UserDefaults(suiteName: "ProfileTest")!
        var manager: CharacterProfileManager? = CharacterProfileManager(store: suite)
        manager?.addVoiceUsage(character: "Hero", voiceID: "Voice1", bookID: "BookA")
        manager?.addMemoryToken(character: "Hero", type: .milestone, description: "Saved the kingdom")
        manager = nil

        manager = CharacterProfileManager(store: suite)
        let profile = manager?.profile(for: "hero")
        XCTAssertEqual(profile?.voiceUsage["BookA"], "Voice1")
        XCTAssertEqual(profile?.tokens.first?.description, "Saved the kingdom")
        suite.removePersistentDomain(forName: "ProfileTest")
    }

    func testIncrementAgeAndLock() {
        let suite = UserDefaults(suiteName: "ProfileAgeTest")!
        let manager = CharacterProfileManager(store: suite)
        manager.incrementAge(character: "Hero", years: 5)
        manager.lockMemory(character: "Hero", locked: true)
        let profile = manager.profile(for: "hero")
        XCTAssertEqual(profile?.age, 5)
        XCTAssertTrue(profile?.memoryLocked ?? false)
        suite.removePersistentDomain(forName: "ProfileAgeTest")
    }
}
