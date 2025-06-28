#if canImport(SwiftUI)
import SwiftUI
#endif
import Foundation

/// Tracks the active subscription tier, remaining credits and billing cycle.
final class SubscriptionManager: ObservableObject {
    static let shared = SubscriptionManager()

    /// Subscription tiers available in the app.
    enum Plan: String, CaseIterable {
        case free
        case creator
        case enterprise
        case authorPro

        var displayName: String {
            switch self {
            case .free: return "Free"
            case .creator: return "Creator"
            case .enterprise: return "Enterprise"
            case .authorPro: return "Author Pro"
            }
        }
    }

    /// Billing cycle for recurring subscriptions.
    enum BillingCycle: String, CaseIterable {
        case monthly
        case annual

        var displayName: String { rawValue.capitalized }
    }

    /// Info for each plan including pricing and credits.
    struct PlanInfo {
        let monthlyPrice: Double
        let credits: Int
        let nsfwIncluded: Bool
    }

    /// Pricing table with 3 months free on annual plans.
    private let planInfo: [Plan: PlanInfo] = [
        .free: PlanInfo(monthlyPrice: 0, credits: 20_000, nsfwIncluded: false),
        .creator: PlanInfo(monthlyPrice: 19.99, credits: 150_000, nsfwIncluded: false),
        .enterprise: PlanInfo(monthlyPrice: 49.99, credits: 600_000, nsfwIncluded: true),
        .authorPro: PlanInfo(monthlyPrice: 99.99, credits: 2_000_000, nsfwIncluded: true)
    ]

    // Stored properties
    @AppStorage("userTier") private var tierRaw: String = Plan.free.rawValue
    @AppStorage("billingCycle") private var cycleRaw: String = BillingCycle.monthly.rawValue
    @AppStorage("creditsRemaining") public var creditsRemaining: Int = 20_000

    private init() {}

    /// Currently active tier.
    var tier: Plan { Plan(rawValue: tierRaw) ?? .free }

    /// Current billing cycle.
    var cycle: BillingCycle { BillingCycle(rawValue: cycleRaw) ?? .monthly }

    /// Price for a given plan and cycle.
    func price(for plan: Plan, cycle: BillingCycle) -> Double {
        let monthly = planInfo[plan]?.monthlyPrice ?? 0
        return cycle == .monthly ? monthly : monthly * 9 // 3 months free for annual
    }

    /// Credits included for a given plan.
    func credits(for plan: Plan) -> Int { planInfo[plan]?.credits ?? 0 }

    /// Whether NSFW features are included in the given plan.
    func nsfwIncluded(in plan: Plan) -> Bool { planInfo[plan]?.nsfwIncluded ?? false }

    /// Select a new plan and billing cycle.
    func select(plan: Plan, cycle: BillingCycle) {
        tierRaw = plan.rawValue
        cycleRaw = cycle.rawValue
        creditsRemaining = credits(for: plan)
    }

    /// Consume some credits if available.
    @discardableResult
    func consume(_ amount: Int) -> Bool {
        guard creditsRemaining >= amount else { return false }
        creditsRemaining -= amount
        return true
    }

    /// Placeholder to refresh subscription status from StoreKit.
    func refreshFromReceipt() {
        // Actual StoreKit validation would go here.
    }
}
