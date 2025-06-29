import XCTest
@testable import TradeMindAI

final class NSFWTokenScannerTests: XCTestCase {
    func testDetectsNSFW() {
        let scanner = NSFWTokenScanner(blocked: ["BAD"])
        XCTAssertTrue(scanner.containsNSFW(tokens: ["bad"]))
    }
}
