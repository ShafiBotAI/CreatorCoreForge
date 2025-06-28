import XCTest
@testable import CreatorCoreForge

final class TTSHumanizerTests: XCTestCase {
    func testHumanizeReturnsAnnotatedText() {
        let humanizer = TTSHumanizer()
        let text = humanizer.humanize("Hello world")
        XCTAssertTrue(text.contains("<curve="))
    }

    func testAddImperfectionsReturnsData() {
        let humanizer = TTSHumanizer()
        let data = humanizer.addImperfections(to: Data([1,2,3]))
        XCTAssertFalse(data.isEmpty)
    }
}
