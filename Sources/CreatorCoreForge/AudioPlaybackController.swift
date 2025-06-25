import Foundation

/// Coordinates playback engine and UI updates for streaming audio.
public final class AudioPlaybackController {
    private let engine: AudioPlaybackEngine
    private let ui: PlaybackUIController

    public init(engine: AudioPlaybackEngine = .init(),
                ui: PlaybackUIController = .init()) {
        self.engine = engine
        self.ui = ui
    }

    /// Load an audio file and begin playback with basic UI updates.
    public func loadAndPlay(url: URL) {
        engine.load(url: url)
        ui.displayChapterTitle(url.deletingPathExtension().lastPathComponent)
        engine.play()
        ui.showPlayButton()
    }

    public func pause() {
        engine.pause()
        ui.showPauseButton()
    }

    public func resume() {
        engine.play()
        ui.showPlayButton()
    }

    public func stop() {
        engine.stop()
        ui.enableControls(false)
    }
}
