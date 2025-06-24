import XCTest
@testable import CreatorCoreForge

final class AgeIDVerifierTests: XCTestCase {
    func testVerifyAndPersist() {
        let suite = UserDefaults(suiteName: "AgeIDTest")!
        suite.removePersistentDomain(forName: "AgeIDTest")
        var comps = DateComponents(); comps.year = 1990; comps.month = 1; comps.day = 1
        let birth = Calendar.current.date(from: comps)!
        let verifier = AgeIDVerifier(store: suite)
        XCTAssertTrue(verifier.verify(birthdate: birth, idNumber: "123456"))
        XCTAssertTrue(verifier.isVerified)
        suite.removePersistentDomain(forName: "AgeIDTest")
    }

    func testInvalidID() {
        var comps = DateComponents(); comps.year = 1990; comps.month = 1; comps.day = 1
        let birth = Calendar.current.date(from: comps)!
        let verifier = AgeIDVerifier(store: UserDefaults(suiteName: "AgeIDTest2")!)
        XCTAssertFalse(verifier.verify(birthdate: birth, idNumber: "12"))
    }
}
