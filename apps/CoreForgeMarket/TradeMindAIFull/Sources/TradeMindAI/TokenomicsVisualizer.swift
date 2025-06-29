import Foundation

public struct Tokenomics {
    public let circulatingSupply: Double
    public let maxSupply: Double
    public let marketCap: Double
    public let volume24h: Double

    public init(circulatingSupply: Double, maxSupply: Double, marketCap: Double, volume24h: Double) {
        self.circulatingSupply = circulatingSupply
        self.maxSupply = maxSupply
        self.marketCap = marketCap
        self.volume24h = volume24h
    }
}

/// Provides simple tokenomics metrics for visualization.
public struct TokenomicsVisualizer {
    public init() {}

    public func summary(for token: Tokenomics) -> String {
        let supplyRatio = token.circulatingSupply / token.maxSupply
        let turnover = token.volume24h / max(token.marketCap, 1)
        return String(format: "Supply %.2f%%, Turnover %.2f%%", supplyRatio * 100, turnover * 100)
    }
}
