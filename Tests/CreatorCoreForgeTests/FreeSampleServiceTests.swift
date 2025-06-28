import XCTest
@testable import CreatorCoreForge

final class FreeSampleServiceTests: XCTestCase {
    func testGenerateSampleReturnsAudio() async throws {
        let fm = FileManager.default
        let tmp = fm.temporaryDirectory.appendingPathComponent("sample_book.txt")
        let words = Array(repeating: "word", count: 1000).joined(separator: " ")
        try words.write(to: tmp, atomically: true, encoding: .utf8)

        let profile = VoiceProfile(name: "Test")
        let settings = SampleSettings(voice: profile)
        let service = FreeSampleService()

        let data = try await service.generateSample(from: tmp, settings: settings)
        XCTAssertFalse(data.isEmpty)
    }
}
