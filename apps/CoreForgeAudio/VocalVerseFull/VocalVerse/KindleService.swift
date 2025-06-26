import Foundation

struct KindleBook: Identifiable {
    let id: UUID = UUID()
    let title: String
    let author: String
    let downloadURL: URL?
}

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
            return Book(title: book.title, author: book.author, chapters: chapters)
        }
        return Book(title: book.title,
                    author: book.author,
                    chapters: [Chapter(title: "Chapter 1", text: "Unable to download")])
    }
}
