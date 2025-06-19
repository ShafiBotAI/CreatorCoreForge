import XCTest
@testable import DataForgeAI

final class ViralityScannerTests: XCTestCase {
    func testTopSignals() {
        let scanner = ViralityScanner()
        scanner.ingest(["AI", "ML", "AI", "VR"])
        let top = scanner.topSignals(limit: 1)
        XCTAssertEqual(top, ["AI"])
    }
}
