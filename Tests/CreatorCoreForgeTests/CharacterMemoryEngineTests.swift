import XCTest
@testable import CreatorCoreForge

final class CharacterMemoryEngineTests: XCTestCase {
    func testTraitPersistence() {
        let suite = UserDefaults(suiteName: "TestTraits")!
        var engine: CharacterMemoryEngine? = CharacterMemoryEngine(userDefaults: suite)
        engine?.setTrait("hair", value: "blonde", for: "Alice")
        engine = nil
        let loaded = CharacterMemoryEngine(userDefaults: suite)
        XCTAssertEqual(loaded.trait("hair", for: "Alice"), "blonde")
        suite.removePersistentDomain(forName: "TestTraits")
    }
}
