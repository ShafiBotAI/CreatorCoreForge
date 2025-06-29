import Foundation

/// Filters job seeker leads for recruiter outreach.
public struct RecruiterMode {
    public init() {}

    public func target(leads: [Lead], field: String) -> [Lead] {
        leads.filter { $0.industry.lowercased().contains(field.lowercased()) }
    }
}
