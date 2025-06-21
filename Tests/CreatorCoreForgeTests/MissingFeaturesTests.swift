import XCTest
@testable import CreatorCoreForge

final class MissingFeaturesTests: XCTestCase {
    func testSetupOfflineAudioQueue() {
        let features = CoreForgeAudioFeatures()
        let queue = features.setupOfflineAudioQueue()
        #if canImport(Combine)
        XCTAssertTrue(queue.queue.isEmpty)
        #else
        XCTAssertNotNil(queue)
        #endif
    }

    func testConvertEbookToAudio() {
        let expectation = XCTestExpectation(description: "convert")
        let text = "Chapter 1 Hello world. Chapter 2 Goodbye."
        let features = CoreForgeAudioFeatures()
        let profile = VoiceProfile(name: "Test")
        features.convertEbookToAudio(text: text, profile: profile) { urls in
            XCTAssertGreaterThanOrEqual(urls.count, 2)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }

    func testActivateStealthVault() {
        let dir = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        let vault = StealthModeVaultManager(directory: dir)
        let features = CoreForgeAudioFeatures()
        features.activateStealthVault(vault)
        XCTAssertTrue(vault.stealthMode)
    }

    func testRecommendVoiceTone() {
        let features = CoreForgeAudioFeatures()
        let profile = features.recommendVoiceTone(for: "This is viral content!")
        XCTAssertEqual(profile.emotion, "excited")
    }

    func testVerifyAgeAndEnableNSFW() {
        let suite = UserDefaults(suiteName: "VisualTest")!
        CommunityFilter.shared.disableNSFW()
        let features = CoreForgeVisualFeatures()
        var comps = DateComponents(); comps.year = 1990; comps.month = 1; comps.day = 1
        let birth = Calendar.current.date(from: comps)!
        let result = features.verifyAgeAndEnableNSFW(birthdate: birth, pin: "1234")
        XCTAssertTrue(result)
        suite.removePersistentDomain(forName: "VisualTest")
    }

    func testVerifyAgeIDAndEnableNSFW() {
        let suite = UserDefaults(suiteName: "VisualTest2")!
        CommunityFilter.shared.disableNSFW()
        UserDefaults.standard.removeObject(forKey: "CF_PIN")
        UserDefaults.standard.removeObject(forKey: "CF_REGION")
        CommunityFilter.shared.setRegion("US")
        var comps = DateComponents(); comps.year = 1990; comps.month = 1; comps.day = 1
        let birth = Calendar.current.date(from: comps)!
        let verifier = AgeIDVerifier()
        XCTAssertTrue(verifier.verify(birthdate: birth, idNumber: "987654"))
        XCTAssertTrue(CommunityFilter.shared.enableNSFW(pin: "1234"))
        suite.removePersistentDomain(forName: "VisualTest2")
    }

    func testGenerateSceneVideo() {
        let features = CoreForgeVisualFeatures()
        let url = features.generateSceneVideo(from: "A hero rises.")
        XCTAssertTrue(FileManager.default.fileExists(atPath: url.path))
    }

    func testRenderWithStyle() {
        let features = CoreForgeVisualFeatures()
        let input = FileManager.default.temporaryDirectory.appendingPathComponent("vid.mp4")
        try? "data".data(using: .utf8)?.write(to: input)
        let out = features.renderWithStyle(input, style: "Anime")
        XCTAssertTrue(FileManager.default.fileExists(atPath: out.path))
    }

    func testUploadToPlatform() {
        let features = CoreForgeVisualFeatures()
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("video.mp4")
        try? Data().write(to: url)
        let status = features.uploadToPlatform(url, platform: "YouTube")
        XCTAssertTrue(status.contains("YouTube"))
    }
}
