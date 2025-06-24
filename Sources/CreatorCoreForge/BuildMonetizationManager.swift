import Foundation
#if canImport(SwiftyStoreKit)
import SwiftyStoreKit
#endif

/// Handles in-app purchase flow for CoreForge Build.
/// Adapted from SwiftyStoreKit example (MIT License).
public final class BuildMonetizationManager {
    public static let shared = BuildMonetizationManager()
    private init() {}

    public func setupPurchases() {
        #if canImport(SwiftyStoreKit)
        SwiftyStoreKit.completeTransactions { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                default: break
                }
            }
        }
        #endif
    }

    public func purchase(productId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        #if canImport(SwiftyStoreKit)
        SwiftyStoreKit.purchaseProduct(productId, quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                SwiftyStoreKit.finishTransaction(purchase.transaction)
                completion(.success(()))
            case .error(let error):
                completion(.failure(error))
            }
        }
        #else
        completion(.failure(NSError(domain: "StoreKitUnavailable", code: -1)))
        #endif
    }
}
