import Foundation

/// Manages credits for converting books to full videos.
public final class BookToVideoCreditEngine {
    private var credits: Int
    private var purchasedBooks: Set<String> = []

    public init(initialCredits: Int = 0) {
        self.credits = initialCredits
    }

    /// Determines if a given book can be converted based on credits or purchase state.
    public func canConvert(bookID: String) -> Bool {
        return credits > 0 || purchasedBooks.contains(bookID)
    }

    /// Deducts a credit or marks the book as purchased.
    public func consumeCredit(for bookID: String) {
        if credits > 0 {
            credits -= 1
        } else {
            purchasedBooks.insert(bookID)
        }
    }

    /// Adds additional credits (e.g., from a Pro/Creator tier purchase).
    public func addCredits(_ amount: Int) {
        credits += amount
    }
}
