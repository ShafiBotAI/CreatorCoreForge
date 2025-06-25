import XCTest
@testable import CreatorCoreForge

final class AudioPlaybackControllerTests: XCTestCase {
    func testPlaybackFlow() {
        let tmp = FileManager.default.temporaryDirectory.appendingPathComponent("sample.wav")
        try? Data().write(to: tmp)
        let controller = AudioPlaybackController()
        controller.loadAndPlay(url: tmp)
        controller.pause()
        controller.resume()
        controller.stop()
    }
}
