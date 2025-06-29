import Foundation

/// Automates follow-up sequences across multiple channels.
public final class FollowUpEngine {
    private var queue: [(Lead, Date)] = []

    public init() {}

    /// Schedule a follow-up for a lead at a future date.
    public func schedule(lead: Lead, at date: Date) {
        queue.append((lead, date))
    }

    /// Returns due follow-ups and removes them from the queue.
    public func dueFollowUps(asOf date: Date = Date()) -> [Lead] {
        let (due, remaining) = queue.partition { $0.1 <= date }
        queue = remaining
        return due.map { $0.0 }
    }
}

private extension Array {
    mutating func partition(by predicate: (Element) -> Bool) -> ([Element], [Element]) {
        var matched: [Element] = []
        var unmatched: [Element] = []
        for element in self {
            if predicate(element) { matched.append(element) } else { unmatched.append(element) }
        }
        return (matched, unmatched)
    }
}
