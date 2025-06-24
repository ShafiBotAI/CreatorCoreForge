import Foundation

/// Simple wrapper for downloading MP3 files for offline use.
public final class OfflineMP3Downloader {
    private let queue = OfflineDownloadQueue()

    public init() {}

    /// Queue an MP3 url for offline download.
    public func enqueue(_ url: URL, completion: ((URL) -> Void)? = nil) {
        queue.enqueue(url, completion: completion)
    }

    /// Start processing queued downloads.
    public func start() {
        queue.start()
    }
}
