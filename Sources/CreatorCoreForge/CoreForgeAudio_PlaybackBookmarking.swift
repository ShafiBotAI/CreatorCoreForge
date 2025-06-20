import Foundation

/// Manages chapter-based audio playback with simple bookmarking support.
public struct Chapter {
    public let title: String
    public let audioURL: String
    public init(title: String, audioURL: String) {
        self.title = title
        self.audioURL = audioURL
    }
}

/// Handles playback and bookmark state for a list of `Chapter` instances.
public final class PlaybackManager {
    private var chapters: [Chapter] = []
    private var currentIndex = 0
    private var bookmarkIndex: Int?
    private var isPlaying = false

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
        print("▶️ Playing Chapter \(currentIndex + 1): \(chapter.title) at \(chapter.audioURL)")
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
}

