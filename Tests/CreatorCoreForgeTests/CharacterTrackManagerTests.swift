import XCTest
@testable import CreatorCoreForge

final class CharacterTrackManagerTests: XCTestCase {
    func testAppendAndRetrieve() {
        let data = Data([1, 2, 3])
        let manager = CharacterTrackManager()
        manager.append(data, for: "Alice")
        XCTAssertEqual(manager.allCharacters, ["Alice"])
        XCTAssertEqual(manager.track(for: "Alice"), [data])
    }
}
