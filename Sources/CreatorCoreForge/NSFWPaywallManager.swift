import Foundation
#if canImport(StoreKit)
import StoreKit
#endif

/// Handles premium unlocks, paywall checks, and tip jar tracking for NSFW content.
public final class NSFWPaywallManager {
    public static let shared = NSFWPaywallManager()

    private var premiumUnlocked = false
    private(set) var tips: [Decimal] = []

    private init() {}

    /// Unlock premium NSFW features via an in-app purchase.
    @discardableResult
    public func purchasePremium() -> Bool {
#if canImport(StoreKit)
        // Placeholder purchase flow; integrate real StoreKit logic in the app.
        premiumUnlocked = true
        return true
#else
        // Simulate success when StoreKit is unavailable to keep unit tests
        // platform-agnostic. Real apps should require StoreKit.
        premiumUnlocked = true
        return true
#endif
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

