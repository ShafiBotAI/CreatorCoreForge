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
            let sections = text.components(separatedBy: "\n\n").prefix(10)
            let chapters = sections.enumerated().map { idx, str in
                Chapter(title: "Section \(idx + 1)", text: str)
            }
            let book = Book(title: book.title, author: book.author, chapters: chapters)
            completion(book)
        }.resume()
    }
}
