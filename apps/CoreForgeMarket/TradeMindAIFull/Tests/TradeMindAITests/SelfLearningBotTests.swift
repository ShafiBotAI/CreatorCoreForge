import XCTest
@testable import TradeMindAI

final class SelfLearningBotTests: XCTestCase {
    func testUpdateIncreasesWeight() {
        var bot = SelfLearningBot(weight: 0.4)
        let newWeight = bot.update(reward: 1)
        XCTAssertGreaterThan(newWeight, 0.4)
    }
}
