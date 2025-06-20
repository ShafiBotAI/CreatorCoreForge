import Foundation

/// Stub UI controller for playback interactions.
/// Provides simple console print statements for demo purposes.
public final class PlaybackUIController {
    public init() {}

    /// Show the play button in the UI.
    public func showPlayButton() {
        print("\u{25B6}\u{FE0F} Show play button")
    }

    /// Show the pause button in the UI.
    public func showPauseButton() {
        print("\u{23F8}\u{FE0F} Show pause button")
    }

    /// Update the playback progress bar to the specified percentage (0.0 - 1.0).
    public func updateProgressBar(to percentage: Float) {
        print("\u{1F4CA} Progress: \(percentage * 100)%")
    }

    /// Display the title of the currently playing chapter.
    public func displayChapterTitle(_ title: String) {
        print("\u{1F4D8} Now playing: \(title)")
    }

    /// Enable or disable playback controls.
    public func enableControls(_ enabled: Bool) {
        print(enabled ? "\u{1F7E2} Controls enabled" : "\u{1F534} Controls disabled")
    }
}
