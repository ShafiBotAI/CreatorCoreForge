import Foundation

/// Automates follow-up sequences across multiple channels.
public enum FollowUpChannel {
    case email, sms, phone
}

public final class FollowUpEngine {
    private var queue: [(Lead, FollowUpChannel, Date)] = []

    public init() {}

    /// Schedule a follow-up for a lead at a future date on a specific channel.
    public func schedule(lead: Lead, channel: FollowUpChannel = .email, at date: Date) {
        queue.append((lead, channel, date))
    }

    /// Returns due follow-ups and removes them from the queue.
    public func dueFollowUps(asOf date: Date = Date()) -> [(Lead, FollowUpChannel)] {
        let (due, remaining) = queue.partition { $0.2 <= date }
        queue = remaining
        return due.map { ($0.0, $0.1) }
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
