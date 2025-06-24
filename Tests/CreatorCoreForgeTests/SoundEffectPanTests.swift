import XCTest
@testable import CreatorCoreForge

final class SoundEffectPanTests: XCTestCase {
    func testPlayEffectStoresPan() {
        let manager = SoundEffectManager.shared
        manager.playEffect(named: "wind_gust", pan: 0.5)
        XCTAssertEqual(manager.currentPan(for: "wind_gust"), 0.5)
    }
}
