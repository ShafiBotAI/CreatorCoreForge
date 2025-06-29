import Foundation

public struct LeadDNAProfile {
    public let commonIndustry: String?
    public let commonRegion: String?
}

/// Builds a DNA profile from high-performing leads.
public struct LeadDNAProfileBuilder {
    public init() {}

    public func build(from leads: [Lead]) -> LeadDNAProfile {
        let industryCounts = Dictionary(grouping: leads, by: { $0.industry })
            .mapValues { $0.count }
        let regionCounts = Dictionary(grouping: leads, by: { $0.region })
            .mapValues { $0.count }
        let topIndustry = industryCounts.max { $0.value < $1.value }?.key
        let topRegion = regionCounts.max { $0.value < $1.value }?.key
        return LeadDNAProfile(commonIndustry: topIndustry, commonRegion: topRegion)
    }
}
