import Foundation

public struct Lead: Codable {
    public var name: String
    public var email: String
    public var company: String
    public var industry: String
    public var region: String
    public var firmographics: [String: String] = [:]

    public init(name: String, email: String, company: String, industry: String, region: String) {
        self.name = name
        self.email = email
        self.company = company
        self.industry = industry
        self.region = region
    }
}

public final class LeadMiner {
    public init() {}

    /// Analyze the distribution of industries for the given leads
    public func analyzeTargetMarket(_ leads: [Lead]) -> [String: Int] {
        var tally: [String: Int] = [:]
        for lead in leads {
            tally[lead.industry, default: 0] += 1
        }
        return tally
    }

    /// Append basic firmographic details to a lead (mock implementation)
    public func enrichLead(_ lead: Lead) -> Lead {
        var enriched = lead
        enriched.firmographics["size"] = "50-100"
        enriched.firmographics["revenue"] = "$10M"
        return enriched
    }

    /// Insert lead details into an outreach template
    public func autoPersonalizeScript(for lead: Lead, template: String) -> String {
        template
            .replacingOccurrences(of: "{name}", with: lead.name)
            .replacingOccurrences(of: "{company}", with: lead.company)
    }

    /// Summarize firmographic trends for the set of leads
    public func analyzeFirmographicTrends(_ leads: [Lead]) -> [String: Int] {
        var counts: [String: Int] = [:]
        for lead in leads {
            for (key, value) in lead.firmographics {
                let k = "\(key):\(value)"
                counts[k, default: 0] += 1
            }
        }
        return counts
    }
}
