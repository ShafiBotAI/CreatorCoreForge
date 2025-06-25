import Foundation

/// Coordinates playback engine and UI updates for streaming audio.
public final class AudioPlaybackController {
    private let engine: AudioPlaybackEngine
    private let ui: PlaybackUIController
    private var queue: [URL] = []
    private var isPlaying = false

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
        isPlaying = true
        ui.showPlayButton()
    }

    public func pause() {
        engine.pause()
        ui.showPauseButton()
    }

    public func resume() {
        engine.play()
        isPlaying = true
        ui.showPlayButton()
    }

    public func stop() {
        engine.stop()
        isPlaying = false
        ui.enableControls(false)
    }

    /// Queue multiple audio files for sequential playback.
    public func queue(_ urls: [URL]) {
        queue.append(contentsOf: urls)
        if !isPlaying {
            playNext()
        }
    }

    private func playNext() {
        guard !queue.isEmpty else { return }
        let next = queue.removeFirst()
        loadAndPlay(url: next)
    }
}
