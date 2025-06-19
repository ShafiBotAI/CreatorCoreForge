import Foundation

final class AccessManager {
    static let shared = AccessManager()

    private let codesKey = "PromoCodes"
    private let expKey = "PromoExpirations"
    private var promoCodes: [String: Int] = ["BETA": 1, "LAUNCH": 1]
    private var expiration: [String: Date] = [:]

    private init() {
        if let saved = UserDefaults.standard.dictionary(forKey: codesKey) as? [String: Int] {
            promoCodes = saved
        }
        if let savedExp = UserDefaults.standard.dictionary(forKey: expKey) as? [String: Double] {
            expiration = savedExp.mapValues { Date(timeIntervalSince1970: $0) }
        }
    }

    /// Unlock app features with a promo code. Returns `true` if the code was
    /// valid and was consumed.
    func unlock(code: String) -> Bool {
        let key = code.uppercased()
        guard let remaining = promoCodes[key], remaining > 0 else {
            return false
        }
        if let exp = expiration[key], exp < Date() {
            promoCodes.removeValue(forKey: key)
            expiration.removeValue(forKey: key)
            return false
        }
        promoCodes[key] = remaining - 1
        persist()
        return true
    }

    /// Verify a promo code with the publishing dashboard before unlocking.
    func unlock(code: String, via bridge: PublishBridge, completion: @escaping (Bool) -> Void) {
        bridge.checkStatus(id: code) { [weak self] success in
            guard success else {
                completion(false)
                return
            }
            let result = self?.unlock(code: code) ?? false
            completion(result)
        }
    }

    func addPromoCode(_ code: String, uses: Int = 1) {
        promoCodes[code.uppercased()] = uses
        persist()
    }

    func addPromoCode(_ code: String, uses: Int = 1, expires: Date) {
        promoCodes[code.uppercased()] = uses
        expiration[code.uppercased()] = expires
        persist()
    }

    func remainingUses(for code: String) -> Int {
        promoCodes[code.uppercased()] ?? 0
    }

    func isPromoValid(_ code: String) -> Bool {
        let key = code.uppercased()
        guard let remaining = promoCodes[key], remaining > 0 else {
            return false
        }
        if let exp = expiration[key], exp < Date() {
            return false
        }
        return true
    }

    private func persist() {
        UserDefaults.standard.set(promoCodes, forKey: codesKey)
        let times = expiration.mapValues { $0.timeIntervalSince1970 }
        UserDefaults.standard.set(times, forKey: expKey)
    }
}
