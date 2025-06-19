import XCTest
@testable import VerseForgeAI

final class BeatMarketplaceTests: XCTestCase {
    func testLoadsDefaultBeats() {
        let marketplace = BeatMarketplace()
        XCTAssertFalse(marketplace.listBeats().isEmpty)
        XCTAssertNotNil(marketplace.urlForBeat("Trap Loop"))
    }
}

