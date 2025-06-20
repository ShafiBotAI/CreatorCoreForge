import XCTest
@testable import CreatorCoreForge

final class VoiceTrainerTests: XCTestCase {
    func testUploadAndTrain() {
        let trainer = VoiceTrainer()
        trainer.uploadSample(for: "Hero", filePath: "/path/sample.wav")
        XCTAssertTrue(trainer.trainVoice(for: "Hero"))
    }

    func testTestVoiceOutputsMessage() {
        let trainer = VoiceTrainer()
        trainer.uploadSample(for: "Hero", filePath: "/path/sample.wav")
        trainer.trainVoice(for: "Hero")
        // Should not throw or produce nil output; verify via standard output.
        trainer.testVoice(character: "Hero", testLine: "Hello")
    }
}
