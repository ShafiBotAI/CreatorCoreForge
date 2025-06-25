import Foundation

/// Controls a queue of build tasks across multiple platforms.
public final class BuildQueueController {
    private var queue: [() -> String] = []
    private let lock = DispatchQueue(label: "BuildQueueController")

    public init() {}

    /// Add a build step returning a build path.
    public func enqueue(_ block: @escaping () -> String) {
        lock.async { self.queue.append(block) }
    }

    /// Run the next build step if any and return its output.
    @discardableResult
    public func runNext() -> String? {
        var task: (() -> String)?
        lock.sync {
            if !self.queue.isEmpty { task = self.queue.removeFirst() }
        }
        return task?()
    }

    /// Cancel all pending tasks.
    public func cancelAll() {
        lock.async { self.queue.removeAll() }
    }

    /// Number of pending build steps.
    public var pending: Int { lock.sync { queue.count } }
}
