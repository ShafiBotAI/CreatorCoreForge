import Foundation

/// Provides instant chat follow-up messages for leads.
public struct InstantChatFollowUp {
    public init() {}

    public func followUp(for lead: Lead) -> String {
        "Hi \(lead.name), just checking in about \(lead.company). Let me know if you have any questions!"
    }
}
