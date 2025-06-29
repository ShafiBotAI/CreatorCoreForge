import Foundation

/// Filters leads by allowed industries.
public struct IndustryDataFilter {
    public init() {}

    public func filter(leads: [Lead], allowedIndustries: [String]) -> [Lead] {
        let keys = allowedIndustries.map { $0.lowercased() }
        return leads.filter { keys.contains($0.industry.lowercased()) }
    }
}
