import XCTest
@testable import CreatorCoreForge

final class QuantumRealitySwitcherTests: XCTestCase {
    func testSwitchReality() {
        let switcher = QuantumRealitySwitcher()
        XCTAssertEqual(switcher.currentReality, "Base")
        switcher.switchReality(to: "Alt")
        XCTAssertEqual(switcher.currentReality, "Alt")
    }
}
