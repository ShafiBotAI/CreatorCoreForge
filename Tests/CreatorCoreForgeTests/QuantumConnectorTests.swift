import XCTest
@testable import CreatorCoreForge

final class QuantumConnectorTests: XCTestCase {
    func testProcessingWhenEnabled() {
        let connector = QuantumConnector(enabled: true)
        XCTAssertEqual(connector.process("abc"), "cba")
    }

    func testProcessingWhenDisabled() {
        let connector = QuantumConnector()
        XCTAssertEqual(connector.process("abc"), "abc")
    }
}
