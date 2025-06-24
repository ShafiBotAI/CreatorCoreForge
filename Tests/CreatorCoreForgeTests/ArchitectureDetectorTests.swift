import XCTest
@testable import CreatorCoreForge

final class ArchitectureDetectorTests: XCTestCase {
    func testDetection() {
        let detector = ArchitectureDetector()
        XCTAssertEqual(detector.detect(in: "This is a SPA app"), .spa)
        XCTAssertEqual(detector.detect(in: "Built with MVC"), .mvc)
        XCTAssertEqual(detector.detect(in: "Uses MVVM pattern"), .mvvm)
        XCTAssertEqual(detector.detect(in: "unknown"), .unknown)
    }
}
