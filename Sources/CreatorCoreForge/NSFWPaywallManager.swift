import Foundation

/// Handles premium unlocks, paywall checks, and tip jar tracking for NSFW content.
public final class NSFWPaywallManager {
    public static let shared = NSFWPaywallManager()

    private var premiumUnlocked = false
    private(set) var tips: [Decimal] = []

    private init() {}

    /// Unlock premium NSFW features with a provided code.
    @discardableResult
    public func unlockPremium(code: String) -> Bool {
        guard code == "UNLOCK-NSFW" else { return false }
        premiumUnlocked = true
        return true
    }

    /// Returns whether premium features are unlocked.
    public func isPremiumUnlocked() -> Bool { premiumUnlocked }

    /// Record a tip amount from a user.
    public func addTip(_ amount: Decimal) {
        tips.append(amount)
    }

    /// Total amount of tips received.
    public var totalTips: Decimal {
        tips.reduce(0, +)
    }
}

