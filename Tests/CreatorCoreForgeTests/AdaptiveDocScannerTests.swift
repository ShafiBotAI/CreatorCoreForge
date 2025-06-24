import XCTest
@testable import CreatorCoreForge

final class AdaptiveDocScannerTests: XCTestCase {
    func testScanAndLearn() {
        let scanner = AdaptiveDocScanner()
        scanner.reset()
        _ = scanner.scan(text: "Budget plan", keywords: ["plan", "budget"])
        _ = scanner.scan(text: "Budget plan", keywords: ["plan", "budget"])
        XCTAssertEqual(Set(scanner.learnedKeywords(minCount: 2)), ["plan", "budget"])
    }
}
