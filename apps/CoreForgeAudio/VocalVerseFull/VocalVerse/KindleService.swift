import Foundation

struct KindleBook: Identifiable {
    let id: UUID = UUID()
    let title: String
    let author: String
    let downloadURL: URL?
}

/// Simple service that lists sample Kindle books and creates demo `Book` models
/// when downloaded. In a real app this would connect to the Kindle API.
final class KindleService {
    func fetchAvailableBooks() -> [KindleBook] {
        return [
            KindleBook(title: "Alice in Wonderland", author: "Lewis Carroll",
                       downloadURL: URL(string: "https://www.gutenberg.org/cache/epub/11/pg11.txt")),
            KindleBook(title: "Pride and Prejudice", author: "Jane Austen",
                       downloadURL: URL(string: "https://www.gutenberg.org/files/1342/1342-0.txt"))
        ]
    }

    func download(book: KindleBook) -> Book {
        if let url = book.downloadURL,
           let text = try? String(contentsOf: url) {
            let sections = text.components(separatedBy: "\n\n").prefix(10)
            let chapters = sections.enumerated().map { idx, str in
                Chapter(title: "Section \(idx + 1)", text: str)
            }
            return Book(title: book.title, author: book.author, chapters: chapters)
        }
        let chapters = [
            Chapter(title: "Chapter 1", text: "Sample text 1"),
            Chapter(title: "Chapter 2", text: "Sample text 2")
        ]
        return Book(title: book.title, author: book.author, chapters: chapters)
    }
}
