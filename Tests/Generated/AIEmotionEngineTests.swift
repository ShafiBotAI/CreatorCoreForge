import XCTest
@testable import CreatorCoreForge

final class AIEmotionEngineTests: XCTestCase {
    func testAnalyzeReturnsRegisteredEmotion() {
        let engine = AIEmotionEngine.shared
        engine.clearCues()
        engine.registerCue(trigger: "wow", emotion: .happy, intensity: 1)
        XCTAssertEqual(engine.analyze(text: "wow"), .happy)
    }
}
