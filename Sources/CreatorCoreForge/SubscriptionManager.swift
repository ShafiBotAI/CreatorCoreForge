import Foundation

/// Subscription handler that tracks active plan, pricing, and monthly usage.
public final class SubscriptionManager {
    public enum Plan: String {
        case free
        case creator
        case author
        case enterprise
    }

    /// Price and monthly export allowance per plan.
    private struct TierInfo {
        let price: Double
        let monthlyExports: Int
    }

    private static let tierInfo: [Plan: TierInfo] = [
        .free: TierInfo(price: 0, monthlyExports: 5),
        .creator: TierInfo(price: 9.99, monthlyExports: 50),
        .author: TierInfo(price: 14.99, monthlyExports: 100),
        .enterprise: TierInfo(price: 29.99, monthlyExports: 500)
    ]

    public private(set) var activePlan: Plan
    public private(set) var isNSFWUnlocked: Bool
    private var exportsThisMonth: Int
    private let defaults: UserDefaults
    private let monthKey = "SubMgrMonth"
    private let exportKey = "SubMgrExports"
    private let nsfwKey = "SubMgrNSFW"

    public init(plan: Plan = .free, userDefaults: UserDefaults = .standard) {
        self.activePlan = plan
        self.defaults = userDefaults
        self.exportsThisMonth = userDefaults.integer(forKey: exportKey)
        self.isNSFWUnlocked = userDefaults.bool(forKey: nsfwKey)
        if plan == .author || plan == .enterprise {
            self.isNSFWUnlocked = true
            userDefaults.set(true, forKey: nsfwKey)
        }
        resetIfNeeded()
    }

    /// Upgrade the current subscription plan.
    public func upgrade(to plan: Plan) {
        activePlan = plan
        if plan == .author || plan == .enterprise {
            unlockNSFW()
        }
    }

    /// Price for a specific plan.
    public func price(for plan: Plan) -> Double {
        Self.tierInfo[plan]!.price
    }

    /// Remaining export actions for the current month.
    public func remainingExports() -> Int {
        resetIfNeeded()
        let limit = Self.tierInfo[activePlan]!.monthlyExports
        return max(limit - exportsThisMonth, 0)
    }

    /// Record that an export occurred.
    public func recordExport() {
        resetIfNeeded()
        exportsThisMonth += 1
        persist()
    }

    /// Whether another export is allowed this month.
    public func canExport() -> Bool {
        resetIfNeeded()
        return exportsThisMonth < Self.tierInfo[activePlan]!.monthlyExports
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
            persist()
        }
    }

    private func persist() {
        defaults.set(exportsThisMonth, forKey: exportKey)
    }

    private static var currentMonth: String {
        let comps = Calendar.current.dateComponents([.year, .month], from: Date())
        return "\(comps.year!)-\(comps.month!)"
    }
}
