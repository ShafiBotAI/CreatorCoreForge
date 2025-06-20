import XCTest
@testable import CreatorCoreForge

final class AIEmotionEngineTests: XCTestCase {
    func testAnalyzeReturnsCueEmotion() {
        let engine = AIEmotionEngine.shared
        engine.clearCues()
        engine.registerCue(trigger: "sobbed", emotion: .sad, intensity: 0.9)
        XCTAssertEqual(engine.analyze(text: "He sobbed loudly."), .sad)
    }

    #if canImport(AVFoundation)
    func testApplyEmotionModifiesUtterance() {
        let engine = AIEmotionEngine.shared
        let utterance = AVSpeechUtterance(string: "test")
        engine.applyEmotion(to: utterance, emotion: .happy, intensity: 1.0)
        XCTAssertEqual(utterance.pitchMultiplier, 1.2, accuracy: 0.001)
        XCTAssertEqual(utterance.rate, AVSpeechUtteranceDefaultSpeechRate + 0.05, accuracy: 0.001)
    }
    #endif
}
