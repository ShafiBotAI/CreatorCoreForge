import Foundation

/// Manages a simple FIFO queue of export tasks.
public final class ExportQueueManager {
    private var tasks: [() -> Void] = []
    private let queue = DispatchQueue(label: "ExportQueue")

    public init() {}

    /// Add a new export task to the queue.
    public func addTask(_ task: @escaping () -> Void) {
        queue.async { self.tasks.append(task) }
    }

    /// Process the next task in the queue, if any.
    public func processNext() {
        queue.async {
            guard !self.tasks.isEmpty else { return }
            let task = self.tasks.removeFirst()
            task()
        }
    }

    /// Number of pending tasks.
    public var pendingCount: Int { queue.sync { tasks.count } }
}
