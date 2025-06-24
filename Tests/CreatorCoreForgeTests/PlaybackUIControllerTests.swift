import XCTest
@testable import CreatorCoreForge

final class PlaybackUIControllerTests: XCTestCase {
    func testUIControlsSequence() {
        let ui = PlaybackUIController()
        ui.showPlayButton()
        ui.showPauseButton()
        ui.updateProgressBar(to: 0.25)
        ui.displayChapterTitle("Intro")
        ui.enableControls(true)
    }
}
