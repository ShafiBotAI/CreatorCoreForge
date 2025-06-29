import Foundation

/// Simple gamification tool to encourage lead opt-ins.
public struct GamifiedLeadTool {
    public let prizes: [String]
    public init(prizes: [String] = ["Free eBook", "Discount", "Bonus Credits"]) {
        self.prizes = prizes
    }

    /// Returns a random prize from the list.
    public func spinWheel() -> String {
        prizes.randomElement() ?? "Try again"
    }
}
