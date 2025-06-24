import XCTest
@testable import CreatorCoreForge

final class SoundEffectsDatabaseTests: XCTestCase {
    func testDefaultRecordsLoaded() {
        let records = SoundEffectsDatabase.shared.list(includeNSFW: true)
        XCTAssertGreaterThan(records.count, 10)
    }

    func testNSFWFiltering() {
        let safeRecords = SoundEffectsDatabase.shared.list()
        XCTAssertFalse(safeRecords.contains { $0.isNSFW })
    }
}
