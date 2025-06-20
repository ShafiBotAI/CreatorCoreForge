import Foundation

public struct LeadScore {
    public let lead: Lead
    public let score: Int
}

public final class AIAgentScoring {
    public init() {}

    /// Score leads based on simple heuristics
    public func score(leads: [Lead]) -> [LeadScore] {
        leads.map { lead in
            let base = 50
            let industryFactor = lead.industry.lowercased().contains("software") ? 20 : 0
            let regionFactor = lead.region.lowercased().contains("us") ? 10 : 0
            return LeadScore(lead: lead, score: base + industryFactor + regionFactor)
        }
    }

    /// Return the top leads sorted by score
    public func topLeads(from scores: [LeadScore], limit: Int) -> [LeadScore] {
        Array(scores.sorted { $0.score > $1.score }.prefix(limit))
    }

    /// Estimate conversion rate using simple heuristics
    public func predictConversionRate(for lead: Lead) -> Double {
        var rate = 0.5
        if lead.industry.lowercased().contains("software") { rate += 0.3 } else { rate += 0.1 }
        if lead.region.lowercased().contains("us") { rate += 0.1 }
        return min(1.0, rate)
    }
}
