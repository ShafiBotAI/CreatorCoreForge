import Foundation

public struct PortfolioPosition {
    public let symbol: String
    public let quantity: Double
    public let currentPrice: Double
}

/// Generates a basic risk summary for a set of portfolio positions using OpenAI.
public final class PortfolioRiskSimulator {
    private let service: OpenAIService

    init(service: OpenAIService) {
        self.service = service
    }

    public func simulate(positions: [PortfolioPosition], completion: @escaping (String) -> Void) {
        let totalValue = positions.reduce(0.0) { $0 + $1.quantity * $1.currentPrice }
        let summary = positions.map { "\($0.symbol):\($0.quantity)" }.joined(separator: ", ")
        let prompt = "Provide a brief risk analysis for a portfolio valued at \(totalValue) with holdings: \(summary)."
        service.sendPrompt(prompt) { result in
            switch result {
            case .success(let text): completion(text)
            case .failure: completion("Unable to generate risk summary")
            }
        }
    }
}
