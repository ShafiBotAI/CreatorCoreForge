import Foundation
import SwiftUI
#if canImport(AVFoundation)
import AVFoundation
#endif

/// Shared library model storing user's books and current playback selection.
final class LibraryModel: ObservableObject {
    @Published var books: [Book]
    @Published var currentBook: Book?
    @Published var currentChapter: Chapter?

    /// Cached list of books the user has started but not finished.
    var inProgressBooks: [Book] {
        books.filter { $0.progress > 0 && $0.progress < 1 }
    }

    /// Cached list of fully listened books.
    var completedBooks: [Book] {
        books.filter { $0.progress >= 1 }
    }

    init() {
        // Basic demo book used when the library is empty
        self.books = [
            Book(title: "Sample Adventure", author: "A. Author", chapters: [
                Chapter(title: "Intro", text: "@Hero begins the journey."),
                Chapter(title: "Conflict", text: "@Villain appears in town.")
            ])
        ]
    }

    func addBook(_ book: Book) {
        books.append(book)
    }

    func select(book: Book, chapter: Chapter? = nil) {
        currentBook = book
        currentChapter = chapter
    }
}
