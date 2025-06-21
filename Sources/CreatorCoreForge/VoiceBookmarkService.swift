import Foundation

/// Stores bookmarks and notes for audio playback.
public final class VoiceBookmarkService {
    private var notes: [URL: [Bookmark]] = [:]
    public init() {}

    /// Represents a note at a time offset in seconds.
    public struct Bookmark: Equatable {
        public let time: TimeInterval
        public let note: String
        public init(time: TimeInterval, note: String) {
            self.time = time
            self.note = note
        }
    }

    /// Add a bookmark for the given file URL.
    public func addBookmark(for url: URL, time: TimeInterval, note: String) {
        let bookmark = Bookmark(time: time, note: note)
        notes[url, default: []].append(bookmark)
    }

    /// Retrieve bookmarks for the given file URL.
    public func bookmarks(for url: URL) -> [Bookmark] {
        notes[url] ?? []
    }

    /// Remove all bookmarks for the given file URL.
    public func clearBookmarks(for url: URL) {
        notes[url] = nil
    }
}
