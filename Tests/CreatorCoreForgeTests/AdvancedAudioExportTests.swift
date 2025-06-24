import XCTest
@testable import CreatorCoreForge

final class AdvancedAudioExportTests: XCTestCase {
    func testTemplateManager() {
        let manager = ExportTemplateManager()
        let tpl = ExportTemplate(name: "Audible", settings: ["bitrate": "64k"])
        manager.add(tpl)
        XCTAssertEqual(manager.template(named: "Audible")?.settings["bitrate"], "64k")
    }

    func testDownloadResumeManager() {
        let url = URL(string: "https://example.com/book")!
        let mgr = DownloadResumeManager()
        mgr.record(url: url, bytes: 100)
        XCTAssertEqual(mgr.resumePoint(for: url), 100)
    }

    func testSubscriptionBenefits() {
        let manager = FeatureSubscriptionManager(tier: .creator)
        XCTAssertTrue(manager.hasPermission(for: "basic"))
        XCTAssertFalse(manager.hasPermission(for: "enterprise"))
        XCTAssertEqual(manager.benefits.contains("Cloud sync"), true)
    }

    func testCreditUsageTracker() {
        let tracker = CreditUsageTracker(credits: 10)
        tracker.consume(3)
        tracker.addBundle(5)
        XCTAssertEqual(tracker.credits, 12)
    }
}
