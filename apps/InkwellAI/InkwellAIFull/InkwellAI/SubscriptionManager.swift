import Foundation

/// Manages subscription credits and purchase plans.
final class SubscriptionManager {
    static let shared = SubscriptionManager()
    private let key = "IW_Credits"
    private(set) var credits: Int

    private init() {
        credits = UserDefaults.standard.integer(forKey: key)
    }

    func addCredits(_ amount: Int) {
        credits += amount
        persist()
    }

    func consume(_ amount: Int) -> Bool {
        guard credits >= amount else { return false }
        credits -= amount
        persist()
        return true
    }

    private func persist() {
        UserDefaults.standard.set(credits, forKey: key)
    }
}
