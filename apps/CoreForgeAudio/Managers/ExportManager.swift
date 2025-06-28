import Foundation

/// Handles credit-gated exports for audio projects.
struct ExportManager {
    static func export(usingCredits credits: Int = 1) -> Bool {
        let sub = SubscriptionManager.shared
        guard sub.consume(credits) else { return false }
        // Placeholder export logic
        return true
    }
}
