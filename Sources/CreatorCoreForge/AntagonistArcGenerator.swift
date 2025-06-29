import Foundation

public struct AntagonistArc {
    public let steps: [String]
    public let redeemability: Double
}

/// Generates a simple antagonist arc with redeemability scoring.
public struct AntagonistArcGenerator {
    public init() {}

    public func generate(from trait: String) -> AntagonistArc {
        let steps = [
            "Introduce \(trait)",
            "Escalation",
            "Confrontation",
            "Resolution"
        ]
        let redeemability = trait.count % 5 == 0 ? 0.8 : 0.4
        return AntagonistArc(steps: steps, redeemability: redeemability)
    }
}
