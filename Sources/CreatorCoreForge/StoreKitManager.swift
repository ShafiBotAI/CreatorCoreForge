import Foundation
#if canImport(SwiftyStoreKit)
import SwiftyStoreKit
#endif

/// Lightweight wrapper around StoreKit used for internal purchases.
public final class StoreKitManager {
    public static let shared = StoreKitManager()
    private init() {}

    public func purchase(productId: String, completion: @escaping (Bool) -> Void) {
#if canImport(SwiftyStoreKit)
        SwiftyStoreKit.purchaseProduct(productId, quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                SwiftyStoreKit.finishTransaction(purchase.transaction)
                completion(true)
            case .error:
                completion(false)
            }
        }
#else
        completion(true)
#endif
    }

    public func restore(completion: @escaping () -> Void) {
#if canImport(SwiftyStoreKit)
        SwiftyStoreKit.restorePurchases { _ in
            completion()
        }
#else
        completion()
#endif
    }
}
