import Foundation

/// Scans multiple blockchains for basic flipping opportunities.
public struct CrossChainScanner {
    public init() {}

    /// Returns symbols that show price gaps across chains.
    public func scan(chains: [String: [String: Double]]) -> [String] {
        var opportunities: [String] = []
        for (token, chainPrices) in chains {
            let values = Array(chainPrices.values)
            guard let min = values.min(), let max = values.max(), max - min > 0 else { continue }
            if max - min > (min * 0.05) { // simple threshold
                opportunities.append(token)
            }
        }
        return opportunities
    }
}
