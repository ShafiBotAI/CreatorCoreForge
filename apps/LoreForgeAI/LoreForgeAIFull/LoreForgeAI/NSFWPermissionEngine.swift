import Foundation

/// Controls NSFW rendering permissions based on user age and subscription tier.
final class NSFWPermissionEngine {
    enum Tier {
        case free
        case premium
    }

    private var age: Int
    private var tier: Tier
    private var isEnabled: Bool

    init(age: Int, tier: Tier, enabled: Bool = false) {
        self.age = age
        self.tier = tier
        self.isEnabled = enabled
    }

    func updateAge(_ newAge: Int) {
        age = newAge
    }

    func updateTier(_ newTier: Tier) {
        tier = newTier
    }

    func toggle(_ enabled: Bool) {
        isEnabled = enabled
    }

    func canRender() -> Bool {
        return age >= 18 && tier == .premium && isEnabled
    }
}
