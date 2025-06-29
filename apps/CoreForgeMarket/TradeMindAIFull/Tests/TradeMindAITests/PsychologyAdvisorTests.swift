import XCTest
@testable import TradeMindAI

final class PsychologyAdvisorTests: XCTestCase {
    func testTrackingCounts() {
        let advisor = PsychologyAdvisor()
        advisor.track(emotion: "fear")
        advisor.track(emotion: "fear")
        XCTAssertTrue(advisor.summary().contains("fear: 2"))
    }
}
