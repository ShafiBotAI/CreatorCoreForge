import Foundation

public extension TradingJournal {
    func generateReport() -> String {
        allEntries().map { "\($0.date): \($0.text) (\($0.sentiment))" }.joined(separator: "\n")
    }
}
