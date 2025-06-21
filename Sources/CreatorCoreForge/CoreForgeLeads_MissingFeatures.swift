import Foundation

public final class CreditLedger {
    private(set) var credits: Int = 0
    public init() {}
    public func add(_ amount: Int) { credits += amount }
    public func bill(_ amount: Int) -> Bool {
        guard credits >= amount else { return false }
        credits -= amount
        return true
    }
}

public struct GlobalExchange {
    public func trade(id: String, for credit: Int) -> String {
        "Traded \(id) for \(credit)"
    }
}

public struct ScoringEngine {
    public func score(leads: [Int]) -> Double {
        guard !leads.isEmpty else { return 0 }
        let total = leads.reduce(0, +)
        return Double(total) / Double(leads.count)
    }
}
