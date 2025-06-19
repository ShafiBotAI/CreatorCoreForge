import Foundation

/// Provides a simple automated prospecting workflow that enriches
/// leads, scores them, and returns the top candidates.
public final class ProspectingWorkflow {
    private let miner: LeadMiner
    private let scorer: AIAgentScoring

    public init(miner: LeadMiner = LeadMiner(), scorer: AIAgentScoring = AIAgentScoring()) {
        self.miner = miner
        self.scorer = scorer
    }

    /// Enrich leads and return the highest scored ones up to the limit.
    public func run(leads: [Lead], limit: Int = 5) -> [LeadScore] {
        let enriched = leads.map { miner.enrichLead($0) }
        let scores = scorer.score(leads: enriched)
        return scorer.topLeads(from: scores, limit: limit)
    }

    /// Generate personalized outreach scripts for each lead using the given template.
    public func personalizedScripts(for leads: [Lead], template: String) -> [String] {
        leads.map { miner.autoPersonalizeScript(for: $0, template: template) }
    }
}
