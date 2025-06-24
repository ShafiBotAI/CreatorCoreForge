import XCTest
@testable import CreatorCoreForge

final class DocVideoScannerTests: XCTestCase {
    func testDocumentScanCountsKeywords() {
        let scanner = DocVideoScanner()
        let counts = scanner.scanDocument("hello world hello", keywords: ["hello", "world"])
        XCTAssertEqual(counts["hello"], 2)
        XCTAssertEqual(counts["world"], 1)
    }

    func testVideoScanCountsFrames() {
        let scanner = DocVideoScanner()
        let count = scanner.scanVideoFrames(["cat", "tag:cat", "dog", "tag:cat"], tag: "tag:cat")
        XCTAssertEqual(count, 2)
    }
}
