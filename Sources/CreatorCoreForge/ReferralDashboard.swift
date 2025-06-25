import Foundation

/// Displays metrics for the referral program.
public struct ReferralDashboard {
    public init() {}

    /// Formats referral statistics for display.
    public func summary(for program: ReferralProgram) -> String {
        program.allStats()
            .map { "\($0.key): \($0.value)" }
            .sorted()
            .joined(separator: "\n")
    }
}
