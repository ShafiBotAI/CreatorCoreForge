import XCTest
@testable import CreatorCoreForge

final class TraitMemoryPersistenceTests: XCTestCase {
    func testTraitRoundTrip() {
        let dir = FileManager.default.temporaryDirectory
        let url = dir.appendingPathComponent("traits_test.json")
        var persistence: TraitMemoryPersistence? = TraitMemoryPersistence(fileURL: url)
        persistence?.setTrait("eye", value: "green", for: "Bob")
        persistence = nil
        let loaded = TraitMemoryPersistence(fileURL: url)
        XCTAssertEqual(loaded.trait("eye", for: "Bob"), "green")
        try? FileManager.default.removeItem(at: url)
    }
}
