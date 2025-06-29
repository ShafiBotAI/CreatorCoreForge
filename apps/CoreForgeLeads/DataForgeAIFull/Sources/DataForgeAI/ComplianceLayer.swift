import Foundation

/// Performs basic regional compliance checks for leads.
public struct ComplianceLayer {
    public init() {}

    /// Returns true if the lead is allowed for outreach based on region rules.
    public func isCompliant(lead: Lead, allowedRegions: [String]) -> Bool {
        let key = lead.region.lowercased()
        return allowedRegions.contains { key.contains($0.lowercased()) }
    }
}
