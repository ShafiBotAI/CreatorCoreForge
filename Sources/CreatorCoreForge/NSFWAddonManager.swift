import Foundation
#if canImport(SwiftyStoreKit)
import SwiftyStoreKit
#endif

/// Manages the NSFW monthly add-on purchase for Free and Creator tiers.
public final class NSFWAddonManager {
    public static let shared = NSFWAddonManager()
    private let defaults: UserDefaults

    public init(userDefaults: UserDefaults = .standard) {
        self.defaults = userDefaults
    }

    private let productId = "nsfw_addon"
    private let unlockKey = "SubMgrNSFW"

    public var isUnlocked: Bool {
        defaults.bool(forKey: unlockKey)
    }

    /// Purchase the NSFW add-on. Success sets the unlock flag.
    public func purchase(completion: @escaping (Bool) -> Void) {
#if canImport(SwiftyStoreKit)
        SwiftyStoreKit.purchaseProduct(productId, quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                SwiftyStoreKit.finishTransaction(purchase.transaction)
                self.defaults.set(true, forKey: self.unlockKey)
                completion(true)
            case .error:
                completion(false)
            }
        }
#else
        defaults.set(true, forKey: unlockKey)
        completion(true)
#endif
    }

    /// Restore purchases and update the unlock flag.
    public func restore(completion: @escaping (Bool) -> Void) {
#if canImport(SwiftyStoreKit)
        SwiftyStoreKit.restorePurchases { results in
            let success = !results.restoreFailedPurchases.isEmpty || !results.restoredPurchases.isEmpty
            if success { self.defaults.set(true, forKey: self.unlockKey) }
            completion(success)
        }
#else
        completion(isUnlocked)
#endif
    }
}
