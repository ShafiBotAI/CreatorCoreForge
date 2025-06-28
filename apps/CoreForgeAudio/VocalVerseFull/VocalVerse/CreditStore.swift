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

    private let creditsKey = "CFACredits"
    private let historyKey = "CFACreditHistory"
    private let defaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.defaults = userDefaults
        self.credits = userDefaults.integer(forKey: creditsKey)
        self.history = userDefaults.stringArray(forKey: historyKey) ?? []
    }

    /// Add credits and record a history entry.
    func addCredits(_ amount: Int, reason: String) {
        credits += amount
        history.append("+\(amount) - \(reason)")
        lastAdded = amount
        persist()
    }

    private func persist() {
        defaults.set(credits, forKey: creditsKey)
        defaults.set(history, forKey: historyKey)
    }
}
