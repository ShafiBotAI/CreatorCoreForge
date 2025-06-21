import Foundation

/// Collects simple playback analytics per chapter.
public final class ChapterAnalyticsService {
    private var plays: [Int: Int] = [:]
    public init() {}

    /// Record a playback event for a chapter.
    public func recordPlay(chapter: Int) {
        plays[chapter, default: 0] += 1
    }

    /// Retrieve the play count for a chapter.
    public func playCount(for chapter: Int) -> Int {
        plays[chapter] ?? 0
    }
}
