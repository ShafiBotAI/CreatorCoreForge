import Foundation

/// File-safe async task queue used for offline TTS processing.
public final class OfflineQueue {
    private var tasks: [() async -> Void] = []
    private var isProcessing = false
    private var currentTask: Task<Void, Never>?

    public init() {}

    /// Add a task to the queue and start processing if needed.
    public func add(_ task: @escaping () async -> Void) {
        tasks.append(task)
        process()
    }

    /// Cancel all pending tasks without executing them.
    public func cancelAll() {
        tasks.removeAll()
        currentTask?.cancel()
        currentTask = nil
        isProcessing = false
    }

    private func process() {
        guard !isProcessing, !tasks.isEmpty else { return }
        isProcessing = true
        let task = tasks.removeFirst()
        currentTask = Task {
            await task()
            await MainActor.run {
                self.isProcessing = false
                self.currentTask = nil
                self.process()
            }
        }
    }
}
