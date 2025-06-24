import XCTest
@testable import CreatorCoreForge

final class HighQualityVoiceLibraryTests: XCTestCase {
    func testPremiumVoicesCount() {
        let voices = HighQualityVoiceLibrary.premiumVoices()
        XCTAssertEqual(voices.count, 50)
    }
}
