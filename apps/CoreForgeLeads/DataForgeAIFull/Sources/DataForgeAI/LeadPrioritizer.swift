import Foundation

public enum PipelineStage: Int {
    case cold = 0
    case warm
    case hot
}

public struct PrioritizedLead {
    public let lead: Lead
    public let urgency: Int
    public let stage: PipelineStage
}

/// Provides simple prioritization of leads.
public struct LeadPrioritizer {
    public init() {}

    public func prioritize(_ leads: [PrioritizedLead]) -> [PrioritizedLead] {
        leads.sorted { lhs, rhs in
            if lhs.stage.rawValue == rhs.stage.rawValue {
                return lhs.urgency > rhs.urgency
            }
            return lhs.stage.rawValue > rhs.stage.rawValue
        }
    }
}
