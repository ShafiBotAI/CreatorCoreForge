import XCTest
@testable import CreatorCoreForge

final class FusionEngineFeatureTests: XCTestCase {
    func testSceneGenerationThroughEngine() {
        let engine = FusionEngine(mode: .local)
        let scenes = engine.generateScenes(from: "A. B. C.", maxScenes: 2)
        XCTAssertEqual(scenes.count, 2)
        XCTAssertTrue(scenes.first?.hasPrefix("Scene:") ?? false)
    }

    func testVoiceMemoryAssignmentThroughEngine() {
        let engine = FusionEngine(mode: .local)
        engine.assignVoice("V1", to: "Hero", in: "Series")
        XCTAssertEqual(engine.voiceID(for: "Hero", in: "Series"), "V1")
    }

    func testStudioPrefixApplied() {
        let engine = FusionEngine(mode: .local)
        engine.toggleStudioMode()
        let exp = expectation(description: "studio")
        engine.sendPromptWithMemory("Test") { result in
            if case .success(let text) = result {
                XCTAssertTrue(text.hasSuffix("]oidutS["))
            } else {
                XCTFail("No result")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
