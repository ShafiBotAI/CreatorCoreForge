import XCTest
@testable import CreatorCoreForge

final class VoiceDNAVisualizerTests: XCTestCase {
    func testVectorMapGeneration() {
        let engine = LocalAIEnginePro()
        let visualizer = VoiceDNAVisualizer(engine: engine)
        let profile = VoiceProfile(name: "Hero")
        visualizer.addVoice(profile)

        let exp = XCTestExpectation(description: "vector")
        visualizer.vectorVoiceDNAMap { map in
            XCTAssertEqual(map[profile.id]?.count, 128)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
