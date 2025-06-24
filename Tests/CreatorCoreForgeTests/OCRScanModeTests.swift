import XCTest
@testable import CreatorCoreForge

final class OCRScanModeTests: XCTestCase {
    func testExtractTextReturnsString() {
        let ocr = OCRScanMode()
        let data = "Sample".data(using: .utf8)!
        XCTAssertEqual(ocr.extractText(from: data), "Sample")
    }
}
