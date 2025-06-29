import XCTest
@testable import CreatorCoreForge

final class ProtocolConformanceValidatorTests: XCTestCase {
    func testValidateReturnsTrueForNonEmptyValue() {
        let validator = ProtocolConformanceValidator(value: "test")
        XCTAssertTrue(validator.validate())
    }

    func testValidateReturnsFalseForEmptyValue() {
        let validator = ProtocolConformanceValidator(value: "")
        XCTAssertFalse(validator.validate())
    }
}
