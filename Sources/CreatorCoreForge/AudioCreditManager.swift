import Foundation

/// Credit system for CoreForge Audio users.
public enum UserPlan: String {
    case free, pro, creator
}

public final class CreditManager {
    private var credits: Int
    private let plan: UserPlan
    private let maxFreeCredits = 10

    public init(plan: UserPlan) {
        self.plan = plan
        self.credits = plan == .free ? maxFreeCredits : .max
    }

    public func hasCredits() -> Bool {
        return plan != .free || credits > 0
    }

    @discardableResult
    public func useCredit() -> Bool {
        guard hasCredits() else {
            print("\u{26A0}\u{FE0F} Not enough credits. Please upgrade your plan.")
            return false
        }
        if plan == .free {
            credits -= 1
            print("\u{2705} Used 1 credit. Remaining: \(credits)")
        }
        return true
    }

    public func getRemainingCredits() -> Int {
        return plan == .free ? credits : -1
    }

    public func rechargeFreeCredits() {
        if plan == .free {
            credits = maxFreeCredits
            print("\u{1F501} Free credits recharged to \(credits).")
        }
    }

    public func getPlanName() -> String {
        return plan.rawValue.capitalized
    }

    public func isCreatorPromo(code: String) -> Bool {
        return code == "CREATORACCESS"
    }
}
