import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

/// Handles referral code generation and rewards.
final class ReferralManager: ObservableObject {
    @AppStorage("referralCode") var referralCode: String = ""

    static let shared = ReferralManager()

    private let defaults: UserDefaults
    private let rewardsKey = "ReferralRewards"
    private let codeKey = "MyReferralCode"

    @Published var lastReward: Int? = nil

    init(userDefaults: UserDefaults = .standard) {
        self.defaults = userDefaults
    }

    /// Unique code for the current user. Generated once and persisted.
    func myCode() -> String {
        if let existing = defaults.string(forKey: codeKey) {
            return existing
        }
        let code = String(UUID().uuidString.prefix(8))
        defaults.set(code, forKey: codeKey)
        return code
    }

    /// Award credits to the referrer after a paid activation.
    func rewardReferrer(for plan: SubscriptionManager.Plan) {
        guard !referralCode.isEmpty else { return }
        var rewards = defaults.dictionary(forKey: rewardsKey) as? [String: Int] ?? [:]
        let bonus: Int
        switch plan {
        case .creator, .enterprise:
            bonus = 15
        case .author:
            bonus = 30
        default:
            return
        }
        rewards[referralCode, default: 0] += bonus
        defaults.set(rewards, forKey: rewardsKey)
        lastReward = bonus
        CreditStore.shared.addCredits(bonus, reason: "Referral reward", referral: true)
    }

    /// Total credits earned for a specific referral code.
    func credits(for code: String) -> Int {
        let rewards = defaults.dictionary(forKey: rewardsKey) as? [String: Int] ?? [:]
        return rewards[code] ?? 0
    }
}
