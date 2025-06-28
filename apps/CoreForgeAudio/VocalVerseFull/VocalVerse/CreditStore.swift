import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

/// Simple credit store for in-app purchases and referral rewards.
final class CreditStore: ObservableObject {
    static let shared = CreditStore()

    @Published private(set) var credits: Int
    @Published private(set) var history: [String]
    @Published var lastAdded: Int? = nil

    @AppStorage("creditsEarnedFromReferral") private var referralTotal: Int = 0

    private let creditsKey = "CFACredits"
    private let historyKey = "CFACreditHistory"
    private let defaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.defaults = userDefaults
        self.credits = userDefaults.integer(forKey: creditsKey)
        self.history = userDefaults.stringArray(forKey: historyKey) ?? []
    }

    /// Add credits and record a history entry.
    func addCredits(_ amount: Int, reason: String, referral: Bool = false) {
        credits += amount
        history.append("+\(amount) - \(reason)")
        if referral {
            referralTotal += amount
        }
        lastAdded = amount
        persist()
    }

    private func persist() {
        defaults.set(credits, forKey: creditsKey)
        defaults.set(history, forKey: historyKey)
    }
}
