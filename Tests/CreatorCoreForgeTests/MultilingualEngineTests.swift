import XCTest
@testable import CreatorCoreForge

final class MultilingualEngineTests: XCTestCase {
    func testDetection() {
        let engine = MultilingualEngine()
        XCTAssertEqual(engine.detectLanguage(of: "Hola amigo"), .spanish)
        XCTAssertEqual(engine.detectLanguage(of: "Bonjour"), .french)
        XCTAssertEqual(engine.detectLanguage(of: "Guten Morgen"), .german)
        XCTAssertEqual(engine.detectLanguage(of: "Ciao"), .italian)
        XCTAssertEqual(engine.detectLanguage(of: "Hello"), .english)
    }

    func testModelForText() {
        let engine = MultilingualEngine()
        XCTAssertEqual(engine.modelForText("¿Cómo estás?"), "LocalVoiceAI-Es")
        XCTAssertEqual(engine.modelForText("Bonjour"), "LocalVoiceAI-Fr")
        XCTAssertEqual(engine.modelForText("Guten Tag"), "LocalVoiceAI-De")
        XCTAssertEqual(engine.modelForText("Ciao"), "LocalVoiceAI-It")
        XCTAssertEqual(engine.modelForText("Hi"), "LocalVoiceAI-En")
    }
}
