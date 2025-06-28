import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(Combine)
import Combine
#endif

/// Shared library model storing the user's books and playback state.
final class LibraryModel: ObservableObject {
    @Published var books: [Book]
    @Published var currentBook: Book?
    @Published var currentChapter: Chapter?

    private let storeKey = "CF_LibraryBooks"
    private let defaults = UserDefaults.standard

    init() {
        if let data = defaults.data(forKey: storeKey),
           let decoded = try? JSONDecoder().decode([Book].self, from: data) {
            self.books = decoded
        } else {
            self.books = [
                Book(title: "Sample Adventure", author: "A. Author", series: "Demo Saga", chapters: [
                    Chapter(title: "Intro", text: "@Hero begins the journey."),
                    Chapter(title: "Conflict", text: "@Villain appears in town.")
                ])
            ]
        }
    }

    var inProgressBooks: [Book] { books.filter { $0.progress > 0 && $0.progress < 1 } }
    var completedBooks: [Book] { books.filter { $0.progress >= 1 } }
    var favoriteBooks: [Book] { books.filter { $0.isFavorite } }

    func addBook(_ book: Book) {
        books.append(book)
        save()
    }

    func toggleFavorite(book: Book) {
        guard let idx = books.firstIndex(where: { $0.id == book.id }) else { return }
        books[idx].isFavorite.toggle()
        save()
    }

    func select(book: Book, chapter: Chapter? = nil) {
        currentBook = book
        currentChapter = chapter
    }

    func markDownloaded(book: Book) {
        guard let idx = books.firstIndex(where: { $0.id == book.id }) else { return }
        books[idx].isDownloaded = true
        save()
    }

    func removeDownloaded(book: Book) {
        guard let idx = books.firstIndex(where: { $0.id == book.id }) else { return }
        for chapterIndex in books[idx].chapters.indices {
            if let url = books[idx].chapters[chapterIndex].audioURL {
                try? FileManager.default.removeItem(at: url)
                books[idx].chapters[chapterIndex].audioURL = nil
            }
        }
        books[idx].isDownloaded = false
        save()
    }

    private func save() {
        if let data = try? JSONEncoder().encode(books) {
            defaults.set(data, forKey: storeKey)
        }
    }
}
