import XCTest
@testable import CreatorCoreForge

final class AppFavoriteVoiceServiceTests: XCTestCase {
    func testDailyTopUpdates() {
        let suite = UserDefaults(suiteName: "AppFavVoiceTest")!
        suite.removePersistentDomain(forName: "AppFavVoiceTest")
        let service = AppFavoriteVoiceService(store: suite)
        service.recordUsage(voiceID: "v1")
        service.recordUsage(voiceID: "v1")
        service.recordUsage(voiceID: "v2")

        // simulate next day
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        _ = service.updateIfNeeded(for: tomorrow)

        XCTAssertEqual(service.dailyTopVoiceIDs.first, "v1")
        XCTAssertEqual(service.dailyTopVoiceIDs.count, 2)
    }

    func testTopListLimitedToTen() {
        let suite = UserDefaults(suiteName: "AppFavLimitTest")!
        suite.removePersistentDomain(forName: "AppFavLimitTest")
        let service = AppFavoriteVoiceService(store: suite)
        for i in 0..<15 {
            for _ in 0...i {
                service.recordUsage(voiceID: "v\(i)")
            }
        }
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        _ = service.updateIfNeeded(for: tomorrow)
        XCTAssertEqual(service.dailyTopVoiceIDs.count, 10)
        XCTAssertEqual(service.dailyTopVoiceIDs.first, "v14")
    }
}
