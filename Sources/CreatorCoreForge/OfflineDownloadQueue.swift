#if canImport(Combine)
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Combine

/// Download queue with pause and resume support for offline mode.
public final class OfflineDownloadQueue: ObservableObject {
    @Published public private(set) var queue: [URL] = []
    @Published public private(set) var progress: Double = 0
    @Published public private(set) var isPaused: Bool = false

    private var downloads: [URL: AnyCancellable] = [:]
    private var completions: [URL: (URL) -> Void] = [:]
    private var currentURL: URL?
    private let session: URLSession
    private let destination: URL

    public init(destination: URL? = nil,
                session: URLSession = .shared) {
        self.session = session
        let dir = destination ?? FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.destination = dir.appendingPathComponent("OfflineDownloads", isDirectory: true)
        try? FileManager.default.createDirectory(at: self.destination, withIntermediateDirectories: true)
    }

    public func enqueue(_ url: URL, completion: ((URL) -> Void)? = nil) {
        guard !queue.contains(url) else { return }
        queue.append(url)
        completions[url] = completion ?? { _ in }
    }

    public func start() {
        guard !isPaused else { return }
        progress = 0
        processNext(total: queue.count)
    }

    public func pause() {
        isPaused = true
        if let url = currentURL {
            downloads[url]?.cancel()
        }
    }

    public func resume() {
        guard isPaused else { return }
        isPaused = false
        if currentURL != nil {
            queue.insert(currentURL!, at: 0)
        }
        processNext(total: queue.count)
    }

    public func clearLocalStorage() {
        try? FileManager.default.removeItem(at: destination)
        try? FileManager.default.createDirectory(at: destination, withIntermediateDirectories: true)
    }

    private func processNext(total: Int) {
        guard !queue.isEmpty, !isPaused else { if queue.isEmpty { progress = 1 } ; return }
        let url = queue.removeFirst()
        currentURL = url
        let completion = completions[url] ?? { _ in }
        completions[url] = nil
        let task = session.downloadTaskPublisher(for: url)
            .sink(receiveCompletion: { [weak self] _ in
                guard let self = self else { return }
                self.downloads[url] = nil
                self.currentURL = nil
                self.processNext(total: total)
            }, receiveValue: { [weak self] temp in
                guard let self = self else { return }
                let dest = self.destination.appendingPathComponent(url.lastPathComponent)
                try? FileManager.default.removeItem(at: dest)
                try? FileManager.default.moveItem(at: temp, to: dest)
                let finished = Double(total - self.queue.count)
                DispatchQueue.main.async {
                    self.progress = finished / Double(total)
                    completion(dest)
                }
            })
        downloads[url] = task
    }
}

#if canImport(Combine)
private extension URLSession {
    func downloadTaskPublisher(for url: URL) -> AnyPublisher<URL, URLError> {
        return self.downloadTaskPublisher(for: URLRequest(url: url))
            .map { $0.url }
            .eraseToAnyPublisher()
    }

    func downloadTaskPublisher(for request: URLRequest) -> AnyPublisher<(url: URL, response: URLResponse), URLError> {
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
#endif

#else
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Placeholder implementation when Combine is unavailable.
public final class OfflineDownloadQueue {
    private var queue: [URL] = []
    private var completions: [URL: (URL) -> Void] = [:]
    private var isPaused = false
    private var currentTask: URLSessionTask?
    private let session: URLSession
    private let destination: URL

    public init(destination: URL? = nil, session: URLSession = .shared) {
        self.session = session
        let dir = destination ?? FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.destination = dir.appendingPathComponent("OfflineDownloads", isDirectory: true)
        try? FileManager.default.createDirectory(at: self.destination, withIntermediateDirectories: true)
    }

    public func enqueue(_ url: URL, completion: ((URL) -> Void)? = nil) {
        if !queue.contains(url) {
            queue.append(url)
            completions[url] = completion ?? { _ in }
        }
    }

    public func start() {
        guard currentTask == nil else { return }
        processNext()
    }

    public func pause() {
        isPaused = true
        currentTask?.cancel()
    }

    public func resume() {
        guard isPaused else { return }
        isPaused = false
        if currentTask == nil { processNext() }
    }

    public func clearLocalStorage() {
        try? FileManager.default.removeItem(at: destination)
        try? FileManager.default.createDirectory(at: destination, withIntermediateDirectories: true)
    }

    private func processNext() {
        guard !queue.isEmpty, !isPaused else { return }
        let url = queue.removeFirst()
        currentTask = session.downloadTask(with: url) { [weak self] temp, _, _ in
            guard let self = self else { return }
            defer { self.currentTask = nil; self.processNext() }
            guard let temp = temp else { return }
            let dest = self.destination.appendingPathComponent(url.lastPathComponent)
            try? FileManager.default.removeItem(at: dest)
            try? FileManager.default.moveItem(at: temp, to: dest)
            let completion = self.completions[url] ?? { _ in }
            self.completions[url] = nil
            completion(dest)
        }
        currentTask?.resume()
    }
}
#endif
