import Foundation

/// Simple autonomous agent that nurtures a single lead.
public final class AutonomousLeadAgent {
    private var lead: Lead

    public init(lead: Lead) {
        self.lead = lead
    }

    public func qualify() -> Bool {
        return !lead.company.isEmpty && !lead.email.isEmpty
    }
}
