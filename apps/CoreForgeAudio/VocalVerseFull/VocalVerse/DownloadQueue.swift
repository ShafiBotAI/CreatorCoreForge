import Foundation
#if canImport(Combine)
import Combine
#endif

/// Manages queued downloads for offline content retrieval. When a
/// `StealthVaultManager` is provided, downloaded files are stored in the
/// vault so they can be hidden from the user when stealth mode is enabled.
final class DownloadQueue: ObservableObject {
    @Published private(set) var queue: [URL] = []
    @Published private(set) var progress: Double = 0

    private var downloads: [URL: AnyCancellable] = [:]
    private var completions: [URL: (URL) -> Void] = [:]
    private var priorities: [URL: Int] = [:]
    private let session: URLSession
    private let fileManager: FileManager
    private let destination: URL
    private let vault: StealthVaultManager?

    init(session: URLSession = .shared,
         fileManager: FileManager = .default,
         destination: URL? = nil,
         vault: StealthVaultManager? = nil) {
        self.session = session
        self.fileManager = fileManager
        self.vault = vault
        let dir = destination ?? fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.destination = dir.appendingPathComponent("Downloads", isDirectory: true)
        try? fileManager.createDirectory(at: self.destination, withIntermediateDirectories: true)
    }

    /// Add a remote file URL to the download queue. When a voice is provided,
    /// the queue is prioritized based on the user's historical usage of that voice.
    func enqueue(_ url: URL, voice: String? = nil, completion: ((URL) -> Void)? = nil) {
        guard !queue.contains(url) else { return }
        if let voice = voice {
            priorities[url] = VoiceHistory.shared.usageScore(for: voice)
        }
        queue.append(url)
        completions[url] = completion ?? { _ in }
        sortQueue()
    }

    private func sortQueue() {
        queue.sort { (a, b) in
            (priorities[a] ?? 0) > (priorities[b] ?? 0)
        }
    }

    /// Start downloading all queued items sequentially.
    func startDownloads() {
        progress = 0
        processNext(total: queue.count)
    }

    /// Cancel all downloads and clear the queue.
    func cancel() {
        downloads.values.forEach { $0.cancel() }
        downloads.removeAll()
        queue.removeAll()
        progress = 0
    }

    private func processNext(total: Int) {
        guard !queue.isEmpty else { progress = 1; return }
        let url = queue.removeFirst()
        let completion = completions[url] ?? { _ in }
        completions[url] = nil
        let task = session.downloadTaskPublisher(for: url)
            .sink(receiveCompletion: { [weak self] _ in
                self?.downloads[url] = nil
                self?.processNext(total: total)
            }, receiveValue: { [weak self] tempURL in
                guard let self = self else { return }
                if let vault = self.vault {
                    try? vault.store(url: tempURL, named: url.lastPathComponent)
                } else {
                    let dest = self.destination.appendingPathComponent(url.lastPathComponent)
                    try? self.fileManager.removeItem(at: dest)
                    try? self.fileManager.moveItem(at: tempURL, to: dest)
                }
                let finished = Double(total - self.queue.count)
                DispatchQueue.main.async {
                    self.progress = finished / Double(total)
                    completion(tempURL)
                }
            })
        downloads[url] = task
    }
}

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URLSession {
    /// Helper publisher for a simple file download.
    fileprivate func downloadTaskPublisher(for url: URL) -> AnyPublisher<URL, URLError> {
        return self.downloadTaskPublisher(for: URLRequest(url: url))
            .map { $0.url }
            .eraseToAnyPublisher()
    }

    private func downloadTaskPublisher(for request: URLRequest) -> AnyPublisher<(url: URL, response: URLResponse), URLError> {
        let subject = PassthroughSubject<(url: URL, response: URLResponse), URLError>()
        let task = downloadTask(with: request) { url, response, error in
            if let error = error as? URLError {
                subject.send(completion: .failure(error))
            } else if let url = url, let response = response {
                subject.send((url, response))
                subject.send(completion: .finished)
            }
        }
        task.resume()
        return subject.handleEvents(receiveCancel: { task.cancel() }).eraseToAnyPublisher()
    }
}
