import XCTest
@testable import VerseForgeAI

final class VocalEngineProTests: XCTestCase {
    func testFilterExplicitLyrics() {
        let engine = VocalEnginePro()
        let result = engine.filterExplicitLyrics("This is explicit content")
        XCTAssertFalse(result.contains("explicit"))
    }
}
