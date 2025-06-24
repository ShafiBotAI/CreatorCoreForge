import Foundation

/// Offline-first queue manager for sequential video downloads.
public final class OfflineVideoManager {
    private var downloadQueue: [String] = []
    private var isDownloading = false

    public init() {}

    /// Add a video file URL string to the queue and start processing.
    public func queueVideoFile(_ url: String) {
        downloadQueue.append(url)
        processQueue()
    }

    private func processQueue() {
        guard !isDownloading, let next = downloadQueue.first else { return }
        isDownloading = true
        downloadVideo(url: next) { [weak self] success in
            guard let self = self else { return }
            self.isDownloading = false
            if success {
                print("Downloaded video: \(next)")
            }
            self.downloadQueue.removeFirst()
            self.processQueue()
        }
    }

    private func downloadVideo(url: String, completion: @escaping (Bool) -> Void) {
        // Simulated async download for offline mode.
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            completion(true)
        }
    }
}
