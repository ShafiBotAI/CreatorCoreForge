import Foundation

struct KindleBook: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let downloadURL: URL?
}

/// Simple placeholder service that would normally fetch and download public domain books.
final class KindleService {
    func fetchAvailableBooks(completion: @escaping ([KindleBook]) -> Void) {
        completion([])
    }

    func download(book: KindleBook, completion: @escaping (Book?) -> Void) {
        completion(nil)
    }
}
