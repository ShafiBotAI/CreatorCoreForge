import Foundation

public struct Persona {
    public let industry: String
    public let region: String
    public var description: String {
        "\(industry) buyers in \(region)"
    }
}

public final class PersonaRecommender {
    public init() {}

    /// Recommend personas by grouping leads by industry and region
    public func recommend(from leads: [Lead], top: Int) -> [Persona] {
        var counts: [String: Int] = [:]
        for lead in leads {
            let key = "\(lead.industry)|\(lead.region)"
            counts[key, default: 0] += 1
        }
        let sorted = counts.sorted { $0.value > $1.value }
        return Array(sorted.prefix(top)).map { entry in
            let parts = entry.key.split(separator: "|", maxSplits: 1).map(String.init)
            return Persona(industry: parts[0], region: parts[1])
        }
    }
}
