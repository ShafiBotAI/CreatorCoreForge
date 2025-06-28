import XCTest
@testable import CreatorCoreForge

final class ACXComplianceCheckerTests: XCTestCase {
    func testHeaderValidation() {
        let checker = ACXComplianceChecker()
        let good = Data("ACXHDRaudio".utf8)
        let bad = Data("BADHDR".utf8)
        XCTAssertTrue(checker.isCompliant(data: good))
        XCTAssertFalse(checker.isCompliant(data: bad))
    }
}
