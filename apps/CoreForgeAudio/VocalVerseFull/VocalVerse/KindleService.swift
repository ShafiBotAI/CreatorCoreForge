import Foundation

struct KindleBook: Identifiable {
    let id: UUID = UUID()
    let title: String
    let author: String
    let downloadURL: URL?
}

/// Service that fetches books from Open Library and downloads their text.
final class KindleService {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchAvailableBooks(query: String = "bestseller",
                             completion: @escaping ([KindleBook]) -> Void) {
        let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "https://openlibrary.org/search.json?q=\(encoded)&limit=10") else {
            completion([])
            return
        }
        session.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let docs = obj["docs"] as? [[String: Any]] else {
                completion([])
                return
            }
            let books: [KindleBook] = docs.compactMap { doc in
                guard let title = doc["title"] as? String,
                      let author = (doc["author_name"] as? [String])?.first else { return nil }
                let key = (doc["edition_key"] as? [String])?.first ?? (doc["key"] as? String)
                let textURL = key.flatMap { URL(string: "https://openlibrary.org/\($0).txt") }
                return KindleBook(title: title, author: author, downloadURL: textURL)
            }
            completion(books)
        }.resume()
    }

    func download(book: KindleBook, completion: @escaping (Book?) -> Void) {
        guard let url = book.downloadURL else {
            completion(nil)
            return
        }
        session.dataTask(with: url) { data, _, _ in
            guard let data = data, let text = String(data: data, encoding: .utf8) else {
                completion(nil)
                return
            }
=======

/// Service that fetches public domain books from Project Gutenberg via the
/// Gutendex API and converts them into `Book` models.
final class KindleService {
    private struct GutenbergResponse: Decodable {
        struct Result: Decodable {
            struct Author: Decodable { let name: String }
            let title: String
            let authors: [Author]
            let formats: [String: String]
        }
        let results: [Result]
    }

    /// Fetch a list of available public domain books.
    func fetchAvailableBooks() -> [KindleBook] {
        guard let url = URL(string: "https://gutendex.com/books/?mime_type=text/plain&languages=en&copyright=false") else {
            return []
        }
        var books: [KindleBook] = []
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: url) { data, _, _ in
            defer { semaphore.signal() }
            guard let data = data,
                  let response = try? JSONDecoder().decode(GutenbergResponse.self, from: data) else { return }
            books = response.results.prefix(10).compactMap { result in
                let author = result.authors.first?.name ?? "Unknown"
                let urlString = result.formats["text/plain; charset=utf-8"] ?? result.formats["text/plain"]
                return KindleBook(title: result.title,
                                  author: author,
                                  downloadURL: urlString.flatMap(URL.init))
            }
        }.resume()
        _ = semaphore.wait(timeout: .now() + 10)
        return books
    }

    /// Download the selected book text and split it into simple chapters.
    func download(book: KindleBook) -> Book {
        if let url = book.downloadURL,
           let text = try? String(contentsOf: url) {

            let sections = text.components(separatedBy: "\n\n").prefix(10)
            let chapters = sections.enumerated().map { idx, str in
                Chapter(title: "Section \(idx + 1)", text: str)
            }

            let book = Book(title: book.title, author: book.author, chapters: chapters)
            completion(book)
        }.resume()
=======
            return Book(title: book.title, author: book.author, chapters: chapters)
        }
        return Book(title: book.title,
                    author: book.author,
                    chapters: [Chapter(title: "Chapter 1", text: "Unable to download")])

    }
}
