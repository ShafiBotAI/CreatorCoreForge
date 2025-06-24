import XCTest
@testable import CreatorCoreForge

final class NSFWGateTests: XCTestCase {
    func testFilterSegmentsWithPin() {
        let verifier = AgeIDVerifier()
        _ = verifier.verify(birthdate: Date(timeIntervalSince1970: 0), idNumber: "123456")
        let vault = StealthModeVaultManager(directory: FileManager.default.temporaryDirectory)
        vault.setPIN("0000")
        let gate = NSFWGate(verifier: verifier, vault: vault)
        let segments = [Segment(text: "Hello")]
        let filtered = gate.filterSegments(segments, pin: "0000")
        XCTAssertEqual(filtered.count, 1)
    }

    func testFilterSegmentsWithoutVerification() {
        let suite = UserDefaults(suiteName: "GateTests")!
        suite.removePersistentDomain(forName: "GateTests")
        let verifier = AgeIDVerifier(store: suite)
        let gate = NSFWGate(verifier: verifier, vault: StealthModeVaultManager(directory: FileManager.default.temporaryDirectory))
        let segments = [Segment(text: "Hello")]
        let filtered = gate.filterSegments(segments, pin: nil)
        XCTAssertTrue(filtered.isEmpty)
    }
}
