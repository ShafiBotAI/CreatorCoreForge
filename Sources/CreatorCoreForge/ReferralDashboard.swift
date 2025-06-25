import Foundation

/// Displays metrics for the referral program.
public struct ReferralDashboard {
    public init() {}

    /// Formats referral statistics and current terms for display. If `app` is provided,
    /// the app-specific terms are included.
    public func summary(for program: ReferralProgram, app: String? = nil) -> String {
        let terms = program.currentInfo(forApp: app).terms
        let stats = program.allStats()
            .map { "\($0.key): \($0.value)" }
            .sorted()
            .joined(separator: "\n")
        return "Terms: \(terms)\n" + stats
    }
}
