import XCTest
@testable import CreatorCoreForge

final class ParentReportManagerTests: XCTestCase {
    func testRecordAndExport() {
        let manager = ParentReportManager.shared
        manager.clear()
        manager.record("Event1")
        manager.record("Event2")
        let report = manager.exportReport()
        XCTAssertTrue(report.contains("Event1"))
        XCTAssertTrue(report.contains("Event2"))
    }
}
