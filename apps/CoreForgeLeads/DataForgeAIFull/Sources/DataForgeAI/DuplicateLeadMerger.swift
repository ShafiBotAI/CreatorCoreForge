import Foundation

/// Merges duplicate leads based on a similarity threshold.
public struct DuplicateLeadMerger {
    public init() {}

    public func merge(_ leads: [Lead], threshold: Double) -> [Lead] {
        var unique: [Lead] = []
        for lead in leads {
            if !unique.contains(where: { similarity($0, lead) >= threshold }) {
                unique.append(lead)
            }
        }
        return unique
    }

    private func similarity(_ a: Lead, _ b: Lead) -> Double {
        var score = 0.0
        if a.email.lowercased() == b.email.lowercased() { score += 0.6 }
        if a.company.lowercased() == b.company.lowercased() { score += 0.4 }
        return score
    }
}
