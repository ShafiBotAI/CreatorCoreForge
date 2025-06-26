import Foundation

/// Manages chapter-based audio playback with simple bookmarking support.
public struct Chapter: Codable {
    /// Title of the chapter if known.
    public let title: String
    /// Raw text contents for narration or analysis.
    public let text: String
    /// Order within the book. Defaults to zero when unspecified.
    public let order: Int
    /// Optional additional metadata for the chapter.
    public var metadata: [String: String]?
    /// Optional URL to pre-rendered audio for playback.
    public var audioURL: String?

    public init(title: String,
                text: String,
                order: Int = 0,
                metadata: [String: String]? = nil,
                audioURL: String? = nil) {
        self.title = title
        self.text = text
        self.order = order
        self.metadata = metadata
        self.audioURL = audioURL
    }
}

/// Handles playback and bookmark state for a list of `Chapter` instances.
public final class PlaybackManager {
    private var chapters: [Chapter] = []
    private var currentIndex = 0
    private var bookmarkIndex: Int?
    private var isPlaying = false
    /// Playback speed multiplier. Range: 0.5x - 10x. Defaults to 1x.
    private var playbackSpeed: Double = 1.0
    private(set) var currentLanguage: SupportedLanguage = .english

    public init() {}

    /// Loads the provided chapters, resetting the playback index.
    public func loadChapters(_ chapters: [Chapter]) {
        self.chapters = chapters
        currentIndex = 0
        print("📚 Loaded \(chapters.count) chapters.")
    }

    /// Begins playback of the current chapter if available.
    @discardableResult
    public func playCurrentChapter() -> Bool {
        guard chapters.indices.contains(currentIndex) else {
            print("🔚 No chapter to play.")
            return false
        }
        isPlaying = true
        let chapter = chapters[currentIndex]
        if let url = chapter.audioURL {
            print("▶️ Playing Chapter \(currentIndex + 1) at speed \(playbackSpeed)x: \(chapter.title) at \(url)")
        } else {
            print("▶️ Playing Chapter \(currentIndex + 1) at speed \(playbackSpeed)x: \(chapter.title)")
        }
        return true
    }

    /// Pauses playback when currently playing.
    @discardableResult
    public func pause() -> Bool {
        guard isPlaying else {
            print("⏸️ Nothing is playing.")
            return false
        }
        isPlaying = false
        print("⏸️ Paused Chapter \(currentIndex + 1)")
        return true
    }

    /// Advances to the next chapter and starts playback.
    @discardableResult
    public func nextChapter() -> Bool {
        guard currentIndex + 1 < chapters.count else {
            print("🔚 Already at last chapter.")
            return false
        }
        currentIndex += 1
        return playCurrentChapter()
    }

    /// Returns to the previous chapter and starts playback.
    @discardableResult
    public func previousChapter() -> Bool {
        guard currentIndex > 0 else {
            print("⏮️ Already at first chapter.")
            return false
        }
        currentIndex -= 1
        return playCurrentChapter()
    }

    /// Saves a bookmark for the current chapter index.
    public func bookmark() {
        bookmarkIndex = currentIndex
        print("🔖 Bookmarked Chapter \(currentIndex + 1)")
    }

    /// Resumes playback from the previously bookmarked chapter.
    @discardableResult
    public func resume() -> Bool {
        guard let idx = bookmarkIndex, chapters.indices.contains(idx) else {
            print("⚠️ No bookmark set.")
            return false
        }
        currentIndex = idx
        bookmarkIndex = nil
        return playCurrentChapter()
    }

    /// Sets the playback speed, clamping between 0.5x and 10x.
    public func setPlaybackSpeed(_ speed: Double) {
        playbackSpeed = min(max(speed, 0.5), 10.0)
        print("⏩ Playback speed set to \(playbackSpeed)x")
    }

    /// Change the audio language mid-playback.
    public func setAudioLanguage(_ language: SupportedLanguage) {
        currentLanguage = language
        print("🌐 Audio language changed to \(language.rawValue)")
    }
}

