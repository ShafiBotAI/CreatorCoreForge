import XCTest
@testable import CreatorCoreForge

final class FavoriteVoiceServiceTests: XCTestCase {
    func testToggleAndPersistence() {
        let suite = UserDefaults(suiteName: "FavoriteVoiceTest")!
        suite.removePersistentDomain(forName: "FavoriteVoiceTest")
        var service = FavoriteVoiceService(store: suite)
        service.toggle(voiceID: "narrator")
        XCTAssertTrue(service.isFavorite("narrator"))
        // create new instance to verify persistence
        service = FavoriteVoiceService(store: suite)
        XCTAssertTrue(service.isFavorite("narrator"))
        service.toggle(voiceID: "narrator")
        XCTAssertFalse(service.isFavorite("narrator"))
    }
}
