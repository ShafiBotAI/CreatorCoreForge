import Foundation

/// Schedules narration tasks to run at specified times.
public final class NarrationScheduler {
    private var tasks: [Date: () -> Void] = [:]
    private let queue = DispatchQueue(label: "narration.scheduler")

    public init() {}

    /// Schedule an action to execute at the given date.
    public func schedule(at date: Date, action: @escaping () -> Void) {
        queue.sync { tasks[date] = action }
        let delay = max(0, date.timeIntervalSinceNow)
        queue.asyncAfter(deadline: .now() + delay) { [weak self] in
            action()
            self?.queue.sync { self?.tasks.removeValue(forKey: date) }
        }
    }

    /// Number of scheduled tasks.
    public var pendingCount: Int { queue.sync { tasks.count } }

    /// Cancel all scheduled tasks.
    public func cancelAll() { queue.sync { tasks.removeAll() } }
}
