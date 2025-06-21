import Foundation

/// Basic scheduler for uploading videos to various platforms.
final class UploadScheduler {
    enum Platform {
        case youtube
        case tiktok
        case instagram

        var endpoint: URL {
            switch self {
            case .youtube: return URL(string: "https://example.com/youtube/upload")!
            case .tiktok: return URL(string: "https://example.com/tiktok/upload")!
            case .instagram: return URL(string: "https://example.com/instagram/upload")!
            }
        }
    }

    private var queue: [(url: URL, platform: Platform, date: Date)] = []
    private var timer: Timer?

    func scheduleUpload(url: URL, platform: Platform, at date: Date) {
        queue.append((url, platform, date))
        queue.sort { $0.date < $1.date }
        startTimerIfNeeded()
    }

    private func startTimerIfNeeded() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.processQueue()
        }
    }

    private func processQueue() {
        let now = Date()
        while let next = queue.first, next.date <= now {
            queue.removeFirst()
            performUpload(url: next.url, to: next.platform)
        }
        if queue.isEmpty { timer?.invalidate(); timer = nil }
    }

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    private func performUpload(url: URL, to platform: Platform) {
        var request = URLRequest(url: platform.endpoint)
        request.httpMethod = "POST"
        let task = session.uploadTask(with: request, fromFile: url) { data, _, error in
            if let error = error {
                print("Upload failed: \(error.localizedDescription)")
            } else {
                print("Uploaded \(url.lastPathComponent) to \(platform)")
            }
        }
        task.resume()
    }
}
