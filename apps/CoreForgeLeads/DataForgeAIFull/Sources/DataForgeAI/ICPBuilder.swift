import Foundation

/// Builds ideal customer profiles from lead datasets using simple heuristics.
public struct ICP {
    public let industry: String
    public let region: String
}

public final class ICPBuilder {
    public init() {}

    /// Build an ICP from a set of leads with optional filters.
    public func buildICP(from leads: [Lead],
                         industryFilter: String? = nil,
                         regionFilter: String? = nil) -> ICP? {
        let filtered = leads.filter { lead in
            (industryFilter == nil || lead.industry == industryFilter!) &&
            (regionFilter == nil || lead.region == regionFilter!)
        }
        guard !filtered.isEmpty else { return nil }
        let industry = filtered.map { $0.industry }
            .reduce(into: [:]) { counts, ind in counts[ind, default: 0] += 1 }
            .max { $0.value < $1.value }?.key ?? "Unknown"
        let region = filtered.map { $0.region }
            .reduce(into: [:]) { counts, reg in counts[reg, default: 0] += 1 }
            .max { $0.value < $1.value }?.key ?? "Global"
        return ICP(industry: industry, region: region)
    }
}
