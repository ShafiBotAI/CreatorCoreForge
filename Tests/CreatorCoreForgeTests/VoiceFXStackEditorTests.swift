import XCTest
@testable import CreatorCoreForge

final class VoiceFXStackEditorTests: XCTestCase {
    func testStackUpdateAndClear() {
        let editor = VoiceFXStackEditor.shared
        editor.updateStack([.pitchUp, .echo])
        XCTAssertEqual(editor.getCurrentStack(), [.pitchUp, .echo])
        editor.clearStack()
        XCTAssertTrue(editor.getCurrentStack().isEmpty)
    }

    #if canImport(AVFoundation)
    func testApplyStackChangesUtterance() {
        let editor = VoiceFXStackEditor.shared
        editor.updateStack([.pitchUp, .asmr])
        let utterance = AVSpeechUtterance(string: "Test")
        editor.applyStack(to: utterance)
        XCTAssertEqual(utterance.pitchMultiplier, 1.2, accuracy: 0.001)
        XCTAssertEqual(utterance.volume, 0.4, accuracy: 0.001)
    }
    #endif
}
