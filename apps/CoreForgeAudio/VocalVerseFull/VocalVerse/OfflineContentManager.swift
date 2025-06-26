import Foundation
#if canImport(Combine)
import Combine
#endif

/// Handles queued downloads and marks books as available offline.
final class OfflineContentManager: ObservableObject {
    @Published private(set) var downloaded: [URL] = []
    private let queue: DownloadQueue
    private let library: LibraryModel

    init(queue: DownloadQueue = DownloadQueue(), library: LibraryModel) {
        self.queue = queue
        self.library = library
    }

    /// Enqueue a chapter or audio file for offline use.
    func add(_ url: URL, for book: Book) {
        queue.enqueue(url) { [weak self] file in
            DispatchQueue.main.async {
                self?.downloaded.append(file)
                self?.library.markDownloaded(book: book)
            }
        }
        queue.startDownloads()
    }
}
