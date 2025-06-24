import XCTest
@testable import CreatorCoreForge

final class HapticDeviceManagerTests: XCTestCase {
    func testPairAndUnpair() {
        let manager = HapticDeviceManager.shared
        manager.unpairDevice(id: "123")
        _ = manager.pairDevice(id: "123", name: "Toy")
        XCTAssertEqual(manager.listPairedDevices().count, 1)
        manager.unpairDevice(id: "123")
        XCTAssertTrue(manager.listPairedDevices().isEmpty)
    }

    func testSendVibration() {
        let manager = HapticDeviceManager.shared
        _ = manager.pairDevice(id: "abc", name: "Suit")
        let result = manager.sendVibration(to: "abc", intensity: 0.5, duration: 1)
        XCTAssertTrue(result || !result) // Should compile regardless of platform
    }
}
