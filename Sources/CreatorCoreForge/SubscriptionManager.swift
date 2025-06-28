import Foundation

/// Subscription handler that tracks active plan, pricing, and monthly usage.
public final class SubscriptionManager {
    public enum Plan: String {
        case free
        case creator
        case author
        case enterprise
    }

    /// Billing cycle for subscription pricing.
    public enum BillingCycle: String {
        case monthly
        case annual
    }

    /// Pricing and credit info per plan.
    private struct TierInfo {
        let monthlyPrice: Double
        let annualPrice: Double
        let monthlyCredits: Int
        let nsfwIncluded: Bool
    }

    private static let tierInfo: [Plan: TierInfo] = [
        .free: TierInfo(monthlyPrice: 0,
                        annualPrice: 0,
                        monthlyCredits: 20_000,
                        nsfwIncluded: false),
        .creator: TierInfo(monthlyPrice: 19.99,
                           annualPrice: 179.91,
                           monthlyCredits: 150_000,
                           nsfwIncluded: false),
        .enterprise: TierInfo(monthlyPrice: 49.99,
                              annualPrice: 449.91,
                              monthlyCredits: 600_000,
                              nsfwIncluded: true),
        .author: TierInfo(monthlyPrice: 99.99,
                          annualPrice: 899.91,
                          monthlyCredits: 2_000_000,
                          nsfwIncluded: true)
    ]

    public private(set) var activePlan: Plan
    public private(set) var billingCycle: BillingCycle
    public private(set) var creditsRemaining: Int
    public private(set) var isNSFWUnlocked: Bool
    private var exportsThisMonth: Int
    private let defaults: UserDefaults
    private let monthKey = "SubMgrMonth"
    private let exportKey = "SubMgrExports"
    private let nsfwKey = "SubMgrNSFW"
    private let cycleKey = "SubMgrCycle"
    private let planKey = "SubMgrPlan"
    private let creditKey = "SubMgrCredits"

    public init(plan: Plan = .free,
                cycle: BillingCycle = .monthly,
                userDefaults: UserDefaults = .standard) {
        self.defaults = userDefaults
        let storedPlan = Plan(rawValue: userDefaults.string(forKey: planKey) ?? "") ?? plan
        let storedCycle = BillingCycle(rawValue: userDefaults.string(forKey: cycleKey) ?? "") ?? cycle
        self.activePlan = storedPlan
        self.billingCycle = storedCycle
        self.exportsThisMonth = userDefaults.integer(forKey: exportKey)
        self.isNSFWUnlocked = userDefaults.bool(forKey: nsfwKey)
        self.creditsRemaining = userDefaults.integer(forKey: creditKey)
        if self.creditsRemaining == 0 {
            self.creditsRemaining = Self.tierInfo[storedPlan]!.monthlyCredits
        }
        if storedPlan == .author || storedPlan == .enterprise {
            self.isNSFWUnlocked = true
            userDefaults.set(true, forKey: nsfwKey)
        }
        resetIfNeeded()
    }

    /// Upgrade the current subscription plan.
    public func upgrade(to plan: Plan, cycle: BillingCycle? = nil) {
        activePlan = plan
        if let cycle = cycle { billingCycle = cycle }
        creditsRemaining = Self.tierInfo[plan]!.monthlyCredits
        defaults.set(plan.rawValue, forKey: planKey)
        defaults.set(billingCycle.rawValue, forKey: cycleKey)
        defaults.set(creditsRemaining, forKey: creditKey)
        if plan == .author || plan == .enterprise {
            unlockNSFW()
        }
    }

    /// Price for a specific plan.
    public func price(for plan: Plan, cycle: BillingCycle = .monthly) -> Double {
        let info = Self.tierInfo[plan]!
        return cycle == .monthly ? info.monthlyPrice : info.annualPrice
    }

    /// Remaining export actions for the current month.
    public func remainingExports() -> Int {
        resetIfNeeded()
        let limit = Self.tierInfo[activePlan]!.monthlyCredits
        return max(limit - exportsThisMonth, 0)
    }

    /// Record that an export occurred.
    public func recordExport() {
        resetIfNeeded()
        exportsThisMonth += 1
        creditsRemaining = max(0, creditsRemaining - 1)
        persist()
    }

    /// Consume a number of word credits, if available.
    @discardableResult
    public func consumeCredits(_ amount: Int) -> Bool {
        resetIfNeeded()
        guard creditsRemaining >= amount else { return false }
        creditsRemaining -= amount
        persist()
        return true
    }

    /// Whether another export is allowed this month.
    public func canExport() -> Bool {
        resetIfNeeded()
        return exportsThisMonth < Self.tierInfo[activePlan]!.monthlyCredits
    }

    /// Manually unlock NSFW access for the current user.
    public func unlockNSFW() {
        isNSFWUnlocked = true
        defaults.set(true, forKey: nsfwKey)
    }

    private func resetIfNeeded() {
        let current = Self.currentMonth
        if defaults.string(forKey: monthKey) != current {
            defaults.set(current, forKey: monthKey)
            exportsThisMonth = 0
            creditsRemaining = Self.tierInfo[activePlan]!.monthlyCredits
            persist()
        }
    }

    private func persist() {
        defaults.set(exportsThisMonth, forKey: exportKey)
        defaults.set(activePlan.rawValue, forKey: planKey)
        defaults.set(billingCycle.rawValue, forKey: cycleKey)
        defaults.set(creditsRemaining, forKey: creditKey)
    }

    private static var currentMonth: String {
        let comps = Calendar.current.dateComponents([.year, .month], from: Date())
        return "\(comps.year!)-\(comps.month!)"
    }
}
