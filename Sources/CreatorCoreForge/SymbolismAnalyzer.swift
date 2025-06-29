import Foundation

/// Analyzes text for occurrences of symbolic keywords.
public struct SymbolismAnalyzer {
    public init() {}

    public func analyze(text: String, symbols: [String]) -> [String: Int] {
        var counts: [String: Int] = [:]
        let lower = text.lowercased()
        for sym in symbols {
            let pattern = sym.lowercased()
            let c = lower.components(separatedBy: pattern).count - 1
            if c > 0 {
                counts[sym] = c
            }
        }
        return counts
    }
}
