import XCTest
@testable import CreatorCoreForge

final class NSFWSoundFXEngineTests: XCTestCase {
    func testVolumeMapping() {
        #if canImport(AVFoundation)
        let engine = NSFWSoundFXEngine.shared
        XCTAssertEqual(engine.isNSFWPlaying(), false)
        #else
        XCTAssertFalse(NSFWSoundFXEngine.shared.isNSFWPlaying())
        #endif
    }
}
