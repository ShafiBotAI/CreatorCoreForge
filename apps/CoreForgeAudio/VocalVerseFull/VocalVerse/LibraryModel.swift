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

    /// Books marked as favorites.
    var favoriteBooks: [Book] {
        books.filter { $0.isFavorite }
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

    /// Toggle favorite state for a book.
    func toggleFavorite(book: Book) {
        guard let idx = books.firstIndex(where: { $0.id == book.id }) else { return }
        books[idx].isFavorite.toggle()
    }

    func select(book: Book, chapter: Chapter? = nil) {
        currentBook = book
        currentChapter = chapter
    }

    /// Remove downloaded audio for a book and update library state.
    func removeDownloaded(book: Book) {
        guard let idx = books.firstIndex(where: { $0.id == book.id }) else { return }
        for chapterIndex in books[idx].chapters.indices {
            if let url = books[idx].chapters[chapterIndex].audioURL {
                try? FileManager.default.removeItem(at: url)
                books[idx].chapters[chapterIndex].audioURL = nil
            }
        }
        books[idx].isDownloaded = false
    }
}
