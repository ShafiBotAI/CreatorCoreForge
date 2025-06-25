import Foundation

struct KindleBook: Identifiable {
    let id: UUID = UUID()
    let title: String
    let author: String
}

/// Simple service that lists sample Kindle books and creates demo `Book` models
/// when downloaded. In a real app this would connect to the Kindle API.
final class KindleService {
    func fetchAvailableBooks() -> [KindleBook] {
        return [
            KindleBook(title: "Kindle Sample 1", author: "Author A"),
            KindleBook(title: "Kindle Sample 2", author: "Author B")
        ]
    }

    func download(book: KindleBook) -> Book {
        // Simulate download by generating placeholder chapters
        let chapters = [
            Chapter(title: "Chapter 1", text: "Sample text 1"),
            Chapter(title: "Chapter 2", text: "Sample text 2")
        ]
        return Book(title: book.title, author: book.author, chapters: chapters)
    }
}
