import Foundation

/// Tracks both monthly generation credits and purchased credits.
/// Credits automatically reset each month to the configured limit.
final class CreditEngine {
    static let shared = CreditEngine()

    private(set) var monthlyCredits: Int
    private(set) var purchasedCredits: Int
    private let maxMonthlyCredits: Int
    private let monthlyKey = "LF_MonthlyCredits"
    private let purchasedKey = "LF_PurchasedCredits"
    private let resetKey = "LF_LastCreditReset"

    init(monthlyLimit: Int = 100) {
        self.maxMonthlyCredits = monthlyLimit

        let savedMonthly = UserDefaults.standard.integer(forKey: monthlyKey)
        let savedPurchased = UserDefaults.standard.integer(forKey: purchasedKey)
        self.monthlyCredits = savedMonthly > 0 ? savedMonthly : monthlyLimit
        self.purchasedCredits = savedPurchased

        resetIfNeeded()
    }

    /// Adds credits purchased via in-app purchases.
    func addPurchasedCredits(_ amount: Int) {
        purchasedCredits += amount
        persist()
    }

    /// Consume credits, prioritizing monthly allotment then purchased pool.
    func charge(_ cost: Int) -> Bool {
        resetIfNeeded()
        if monthlyCredits >= cost {
            monthlyCredits -= cost
        } else if (monthlyCredits + purchasedCredits) >= cost {
            let remaining = cost - monthlyCredits
            monthlyCredits = 0
            purchasedCredits -= remaining
        } else {
            return false
        }
        persist()
        return true
    }

    /// Total credits available across both pools.
    func totalCredits() -> Int {
        resetIfNeeded()
        return monthlyCredits + purchasedCredits
    }

    func canAfford(_ cost: Int) -> Bool {
        totalCredits() >= cost
    }

    // MARK: - Persistence

    private func resetIfNeeded() {
        let now = Date()
        let last = UserDefaults.standard.object(forKey: resetKey) as? Date ?? .distantPast
        if !Calendar.current.isDate(last, equalTo: now, toGranularity: .month) {
            monthlyCredits = maxMonthlyCredits
            UserDefaults.standard.set(now, forKey: resetKey)
            persist()
        }
    }

    private func persist() {
        UserDefaults.standard.set(monthlyCredits, forKey: monthlyKey)
        UserDefaults.standard.set(purchasedCredits, forKey: purchasedKey)
    }
}
