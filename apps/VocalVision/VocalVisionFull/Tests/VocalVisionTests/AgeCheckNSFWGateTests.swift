import XCTest
@testable import VocalVision

final class AgeCheckNSFWGateTests: XCTestCase {
    func testAccessAllowedWhenOldEnoughAndNSFWEnabled() {
        let gate = AgeCheckNSFWGate()
        let date = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
        XCTAssertTrue(gate.isAccessAllowed(nsfwEnabled: true, birthDate: date))
    }

    func testAccessDeniedWhenUnderage() {
        let gate = AgeCheckNSFWGate()
        let date = Calendar.current.date(byAdding: .year, value: -10, to: Date())!
        XCTAssertFalse(gate.isAccessAllowed(nsfwEnabled: true, birthDate: date))
    }

    func testAccessDeniedWhenNSFWDisabled() {
        let gate = AgeCheckNSFWGate()
        let date = Calendar.current.date(byAdding: .year, value: -25, to: Date())!
        XCTAssertFalse(gate.isAccessAllowed(nsfwEnabled: false, birthDate: date))
    }
}
