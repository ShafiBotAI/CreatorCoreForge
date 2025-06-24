import Foundation

/// Schedules narration tasks for later playback.
public final class NarrationScheduler {
    public init() {}

    public func schedule(chapter: Int, at date: Date) -> (Int, Date) {
        (chapter, date)
    }
}
