import Foundation

/// Handles application-wide promo codes.
public final class PromoCodeManager {
    public static let shared = PromoCodeManager()

    private let key = "RedeemedPromoCodes"
    private var redeemed: Set<String> = []

    private init() {
        if let saved = UserDefaults.standard.array(forKey: key) as? [String] {
            redeemed = Set(saved)
        }
    }

    /// Attempt to redeem a promo code. Returns true if the code is recognized and not already used.
    @discardableResult
    public func redeem(_ code: String) -> Bool {
        let upper = code.uppercased()
        guard PromoCode.allValues.contains(upper) else { return false }
        guard !redeemed.contains(upper) else { return false }
        redeemed.insert(upper)
        persist()
        return true
    }

    public var hasCreatorAccess: Bool { redeemed.contains(PromoCode.creatorAccess.rawValue) }
    public var hasVisionBeta: Bool { redeemed.contains(PromoCode.visionBeta.rawValue) }
    public var nsfwUnlocked: Bool { redeemed.contains(PromoCode.nsfw.rawValue) }

    private func persist() {
        UserDefaults.standard.set(Array(redeemed), forKey: key)
    }

    public enum PromoCode: String, CaseIterable {
        case creatorAccess = "CREATORACCESS"
        case visionBeta = "VISIONBETA"
        case nsfw = "NSFW"

        static var allValues: [String] { PromoCode.allCases.map { $0.rawValue } }
    }
}
