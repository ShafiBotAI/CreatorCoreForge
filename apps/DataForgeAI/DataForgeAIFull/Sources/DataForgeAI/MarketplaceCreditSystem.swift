import Foundation

/// Simple credit system for purchasing leads in the marketplace.
public final class MarketplaceCreditSystem {
    private var credits: Int
    private let queue = DispatchQueue(label: "credits")

    public init(initialCredits: Int = 0) {
        self.credits = initialCredits
    }

    /// Add credits to the user's balance.
    public func addCredits(_ amount: Int) {
        queue.sync { credits += amount }
    }

    /// Attempt to spend credits when buying a lead. Returns true if
    /// the purchase succeeds.
    @discardableResult
    public func consumeCredits(_ amount: Int) -> Bool {
        return queue.sync {
            guard credits >= amount else { return false }
            credits -= amount
            return true
        }
    }

    /// Retrieve the current credit balance.
    public var balance: Int { queue.sync { credits } }
}
