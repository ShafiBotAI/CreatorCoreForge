import XCTest
@testable import CreatorCoreForge

final class PhaseElevenFeatureTests: XCTestCase {
    func testBrandingConsistency() {
        let toolkit = AdvancedAuthorBrandingToolkit()
        let score = toolkit.consistencyScore(taglines: ["Hello", "hello", "HELLO"])
        XCTAssertEqual(score, 1.0)
    }

    func testVoiceDictationReturnsAmbient() {
        let engine = EmotionVoiceDictationEngine()
        let result = engine.transcribe(audio: Data(repeating: 0, count: 3))
        XCTAssertGreaterThanOrEqual(result.ambient, 0)
    }

    func testReaderPollAverage() {
        let poll = ReaderPollDashboard()
        poll.createPoll(sceneID: "1")
        poll.vote(sceneID: "1", score: 4)
        poll.vote(sceneID: "1", score: 6)
        XCTAssertEqual(poll.average(for: "1"), 5.0)
    }

    func testChoicePathTraversal() {
        let engine = InteractiveChoicePathEngine(rootText: "Start")
        let next = engine.addChoice(from: engine.root, text: "Next")
        XCTAssertEqual(engine.traverse(from: engine.root, choice: 0)?.id, next.id)
    }

    func testStyleRewriteEngine() {
        let engine = StyleRewriteEngine()
        let result = engine.rewrite("I cannot go", to: .youngAdult)
        XCTAssertTrue(result.contains("can't"))
    }
}
