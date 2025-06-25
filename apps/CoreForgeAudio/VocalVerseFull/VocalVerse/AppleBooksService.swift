import Foundation

struct AppleBook: Identifiable {
    let id: UUID = UUID()
    let title: String
    let author: String
}

/// Placeholder service simulating Apple Books integration.
final class AppleBooksService {
    func fetchAvailableBooks() -> [AppleBook] {
        return [
            AppleBook(title: "Apple Sample 1", author: "Author C"),
            AppleBook(title: "Apple Sample 2", author: "Author D")
        ]
    }

    func download(book: AppleBook) -> Book {
        let chapters = [
            Chapter(title: "Chapter 1", text: "Sample text 1"),
            Chapter(title: "Chapter 2", text: "Sample text 2")
        ]
        return Book(title: book.title, author: book.author, chapters: chapters)
    }
}
