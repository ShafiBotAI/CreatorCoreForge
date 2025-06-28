import Foundation

struct AppleBook: Identifiable {
    let id: UUID = UUID()
    let title: String
    let author: String
    let description: String
}

/// Service that queries the iTunes Search API for eBooks and builds `Book`
/// models from the provided metadata.
final class AppleBooksService {
    private struct SearchResponse: Decodable {
        struct Result: Decodable {
            let trackName: String
            let artistName: String
            let description: String
        }
        let results: [Result]
    }

    /// Fetch a list of available eBooks from iTunes.
    func fetchAvailableBooks() -> [AppleBook] {
        guard let url = URL(string: "https://itunes.apple.com/search?media=ebook&term=fiction&limit=10") else {
            return []
        }
        var books: [AppleBook] = []
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: url) { data, _, _ in
            defer { semaphore.signal() }
            guard let data = data,
                  let response = try? JSONDecoder().decode(SearchResponse.self, from: data) else { return }
            books = response.results.map {
                AppleBook(title: $0.trackName,
                          author: $0.artistName,
                          description: $0.description)
            }
        }.resume()
        _ = semaphore.wait(timeout: .now() + 10)
        return books
    }

    /// Convert the selected book description into placeholder chapters.
    func download(book: AppleBook) -> Book {
        let paragraphs = book.description
            .replacingOccurrences(of: "<[^>]+>", with: " ", options: .regularExpression)
            .components(separatedBy: ". ")
            .prefix(10)
        let chapters = paragraphs.enumerated().map { idx, str in
            Chapter(title: "Part \(idx + 1)", text: str.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        return Book(title: book.title, author: book.author, series: nil, chapters: chapters)
    }
}
