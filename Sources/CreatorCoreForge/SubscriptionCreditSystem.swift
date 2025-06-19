import Foundation

/// Handles monthly book/page limits with optional credit add-ons.
public final class SubscriptionCreditSystem {
    private let defaults: UserDefaults
    private let pageKey = "SCS_Pages"
    private let bookKey = "SCS_Books"
    private let monthKey = "SCS_Month"

    public var monthlyPageLimit: Int
    public var monthlyBookLimit: Int
    private(set) var remainingPages: Int
    private(set) var remainingBooks: Int

    public init(monthlyPages: Int = 500, monthlyBooks: Int = 5, userDefaults: UserDefaults = .standard) {
        self.defaults = userDefaults
        self.monthlyPageLimit = monthlyPages
        self.monthlyBookLimit = monthlyBooks
        let month = Self.currentMonth
        if userDefaults.string(forKey: monthKey) != month {
            userDefaults.set(month, forKey: monthKey)
            userDefaults.set(monthlyPages, forKey: pageKey)
            userDefaults.set(monthlyBooks, forKey: bookKey)
        }
        self.remainingPages = userDefaults.integer(forKey: pageKey)
        self.remainingBooks = userDefaults.integer(forKey: bookKey)
    }

    public func consumePages(_ pages: Int) -> Bool {
        resetIfNeeded()
        guard remainingPages >= pages else { return false }
        remainingPages -= pages
        persist()
        return true
    }

    public func consumeBook() -> Bool {
        resetIfNeeded()
        guard remainingBooks > 0 else { return false }
        remainingBooks -= 1
        persist()
        return true
    }

    public func addPageCredits(_ amount: Int) {
        remainingPages += amount
        persist()
    }

    public func addBookCredits(_ amount: Int) {
        remainingBooks += amount
        persist()
    }

    private func resetIfNeeded() {
        let month = Self.currentMonth
        if defaults.string(forKey: monthKey) != month {
            defaults.set(month, forKey: monthKey)
            remainingPages = monthlyPageLimit
            remainingBooks = monthlyBookLimit
            persist()
        }
    }

    private func persist() {
        defaults.set(remainingPages, forKey: pageKey)
        defaults.set(remainingBooks, forKey: bookKey)
    }

    private static var currentMonth: String {
        let comps = Calendar.current.dateComponents([.year, .month], from: Date())
        return "\(comps.year!)-\(comps.month!)"
    }
}
